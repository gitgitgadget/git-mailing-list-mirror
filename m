From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] --base-path-relaxed option
Date: Fri, 27 Jul 2007 14:00:29 -0700
Message-ID: <7vy7h1woia.fsf@assigned-by-dhcp.cox.net>
References: <20070727083814.GE32258@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Axboe <jens.axboe@oracle.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 23:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWvR-0004Fg-74
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 23:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937893AbXG0VAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937874AbXG0VAc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 17:00:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34487 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbXG0VAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 17:00:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727210030.KZVT1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 17:00:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ul0V1X00q1kojtg0000000; Fri, 27 Jul 2007 17:00:30 -0400
In-Reply-To: <20070727083814.GE32258@kernel.dk> (Jens Axboe's message of "Fri,
	27 Jul 2007 10:38:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53969>

From: Jens Axboe <jens.axboe@oracle.com>

I switched git.kernel.dk to --base-path a few minutes ago, to get rid of
a /data/git postfix in the posted urls. But transitioning is tricky,
since now all old paths will fail miserably.

So I added this --base-path-relaxed option, that will make git-daemon
try the absolute path without prefixing --base-path before giving up.
With this in place and --base-path-relaxed added, both my new url of

    git://git.kernel.dk/linux-2.6-block.git

and the old

    git://git.kernel.dk/data/git/linux-2.6-block.git

work fine.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

---

 * I think this patch is a right step; we would need to help
   people transitioning their repository URL, not necessarily
   limited to --base-path usage.  This patch only deals with
   "with this base path or without" case, and does not help
   people who used to use base-path A and now wants to use
   different base-path B, so in that sense there *might* still
   be a room for improvement.  It could be as simple as allowing
   more than than one base-path and taking the first match.

   If you set one of them to an empty string, it would cover the
   case this patch addresses, I think.

   I personally do not think we would want to try 47 different
   base-paths, though.  List?

 Documentation/git-daemon.txt |    6 ++++++
 daemon.c                     |   26 ++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4b30b18..f902161 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -54,6 +54,12 @@ OPTIONS
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'.
 
+--base-path-relaxed::
+	If --base-path is enabled and repo lookup fails, with this option
+	`git-daemon` will attempt to lookup without prefixing the base path.
+	This is useful for switching to --base-path usage, while still
+	allowing the old paths.
+
 --interpolated-path=pathtemplate::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
diff --git a/daemon.c b/daemon.c
index a3f2ac1..9cf22fe 100644
--- a/daemon.c
+++ b/daemon.c
@@ -16,7 +16,8 @@ static int reuseaddr;
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--base-path=path] [--base-path-relaxed]\n"
+"           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
@@ -34,6 +35,7 @@ static int export_all_trees;
 /* Take all paths relative to this one if non-NULL */
 static char *base_path;
 static char *interpolated_path;
+static int base_path_relaxed;
 
 /* Flag indicating client sent extra args. */
 static int saw_extended_args;
@@ -180,6 +182,7 @@ static char *path_ok(struct interp *itable)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
+	int retried_path = 0;
 	char *path;
 	char *dir;
 
@@ -235,7 +238,22 @@ static char *path_ok(struct interp *itable)
 		dir = rpath;
 	}
 
-	path = enter_repo(dir, strict_paths);
+	do {
+		path = enter_repo(dir, strict_paths);
+		if (path)
+			break;
+
+		/*
+		 * if we fail and base_path_relaxed is enabled, try without
+		 * prefixing the base path
+		 */
+		if (base_path && base_path_relaxed && !retried_path) {
+			dir = itable[INTERP_SLOT_DIR].value;
+			retried_path = 1;
+			continue;
+		}
+		break;
+	} while (1);
 
 	if (!path) {
 		logerror("'%s': unable to chdir or not a git archive", dir);
@@ -1061,6 +1079,10 @@ int main(int argc, char **argv)
 			base_path = arg+12;
 			continue;
 		}
+		if (!strcmp(arg, "--base-path-relaxed")) {
+			base_path_relaxed = 1;
+			continue;
+		}
 		if (!prefixcmp(arg, "--interpolated-path=")) {
 			interpolated_path = arg+20;
 			continue;

-- 
Jens Axboe
