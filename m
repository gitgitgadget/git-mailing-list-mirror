From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Sat, 04 Feb 2006 14:02:24 -0800
Message-ID: <7vacd6wznz.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
	<7vr76kcggx.fsf@assigned-by-dhcp.cox.net>
	<slrndu8utr.2i8.mdw@metalzone.distorted.org.uk>
	<7v8xsrz49e.fsf@assigned-by-dhcp.cox.net>
	<slrndu9v7h.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 23:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5VUf-0001vw-Fb
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 23:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWBDWC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 17:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWBDWC2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 17:02:28 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38311 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932369AbWBDWC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 17:02:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204215940.MTYM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 16:59:40 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndu9v7h.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Sat, 4 Feb 2006 19:13:53 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15603>

Mark Wooding <mdw@distorted.org.uk> writes:

> OK, then: how about putting the user_path logic into enter_repo?  Like
> this, perhaps:

I'd like to *REALLY* leave enter_repo alone unless necessary.
The last round to finalize enter_repo() was painful enough to
think its security implications through.  And this particular
"public_html" insertion change can be done without touching it.

I think the attached patch would essentially do the same thing.
Only lightly tested, but tested nevertheless ;-).  This comes on
top of what I have in 'pu'.

One thing I have not done yet but I consider bould be a good
change is to perhaps change the whitelist logic in path_ok()
after enter_repo() says what canonicalized path it decided to
use, so that it allows any user-relative paths without checking
the whitelist when user_path is in effect (and perhaps not
empty, so giving --user-path="public_git" would allow everybody
while giving --user-path alone or --user-path="" would not).
Otherwise, as the code currently stands (regardless of any of
the patches in the discussion in this thread) I think you need
to list all users on the whitelist line.  I think --user-path is
about giving all users ability to export their stuff.  What do
you think?

-- >8 --
diff --git a/daemon.c b/daemon.c
index dab8c2c..a1ccda3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -18,7 +18,8 @@ static int reuseaddr;
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [--reuseaddr] [directory...]";
+"           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--reuseaddr] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -30,6 +31,12 @@ static int export_all_trees = 0;
 /* Take all paths relative to this one if non-NULL */
 static char *base_path = NULL;
 
+/* If defined, ~user notation is allowed and the string is inserted
+ * after ~user/.  E.g. a request to git://host/~alice/frotz would
+ * go to /home/alice/pub_git/frotz with --user-path=pub_git.
+ */
+static char *user_path = NULL;
+
 /* Timeout, and initial timeout */
 static unsigned int timeout = 0;
 static unsigned int init_timeout = 0;
@@ -137,6 +144,7 @@ static int avoid_alias(char *p)
 
 static char *path_ok(char *dir)
 {
+	static char rpath[PATH_MAX];
 	char *path;
 
 	if (avoid_alias(dir)) {
@@ -144,12 +152,31 @@ static char *path_ok(char *dir)
 		return NULL;
 	}
 
-	if (base_path) {
-		static char rpath[PATH_MAX];
-		if (!strict_paths && *dir == '~')
-			; /* allow user relative paths */
-		else if (*dir != '/') {
-			/* otherwise allow only absolute */
+	if (*dir == '~') {
+		if (!user_path) {
+			logerror("'%s': User-path not allowed", dir);
+			return NULL;
+		}
+		if (*user_path) {
+			/* Got either "~alice" or "~alice/foo";
+			 * rewrite them to "~alice/%s" or
+			 * "~alice/%s/foo".
+			 */
+			int namlen, restlen = strlen(dir);
+			char *slash = strchr(dir, '/');
+			if (!slash)
+				slash = dir + restlen;
+			namlen = slash - dir;
+			restlen -= namlen;
+			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
+			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
+				 namlen, dir, user_path, restlen, slash);
+			dir = rpath;
+		}
+	}
+	else if (base_path) {
+		if (*dir != '/') {
+			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
@@ -688,6 +715,14 @@ int main(int argc, char **argv)
 			reuseaddr = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--user-path")) {
+			user_path = "";
+			continue;
+		}
+		if (!strncmp(arg, "--user-path=", 12)) {
+			user_path = arg + 12;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
