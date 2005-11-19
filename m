From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-proxy updates.
Date: Sat, 19 Nov 2005 04:13:21 -0800
Message-ID: <7vd5kw6djy.fsf_-_@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 13:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdRav-0003SJ-QX
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 13:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVKSMNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 07:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKSMNX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 07:13:23 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60642 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751094AbVKSMNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 07:13:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119121227.LHLH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 07:12:27 -0500
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <871x1wbgvn.fsf_-_@briny.internal.ondioline.org> (Paul Collins's
	message of "Fri, 04 Nov 2005 14:57:16 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12333>

Paul Collins <paul@briny.ondioline.org> writes:

> Here is an updated patch that first looks for GIT_PROXY_COMMAND in the
> environment and then git.proxycommand in the repository's
> configuration file.

Sorry for holding onto your patch without any action (other than
looking at it, which from your end you cannot tell I was doing
;-).  I think we will benefit from your patch in some form, and
here is what I tried on top to update it to the multivalue
configuration syntax Linus suggested during the list discussion.
Requesting for comments the original author and from the general
public.

I suspect this touches the same area as the user-path series
Andreas Ericsson has been working on, so it might need some
adjusting after that patch series goes in.  I'll see that soon
enough when I make the proposed updates branch tomorrow.

 -- >8 --

This builds on top of the git-proxy mechanism Paul Collins did,
and updates its configuration mechanism.

 * GIT_PROXY_COMMAND environment variable is used as the
   catch-all fallback, as in the original.  This has not
   changed.

 * Renames proxy configuration variables to core.gitproxy; this
   has become a multi-value variable per list discussion, most
   notably from suggestion by Linus.

	[core]
	;# matches www.kernel.org as well
	gitproxy = netcatter for kernel.org
	gitproxy = netscatter for sample.xz
	gitproxy = none for mydomain.xz
	gitproxy = netcatter-default

   The values are command names, followed by an optional " for "
   and domainname; the first tail-match of the domainname
   determines which proxy command is used.  An entry without "
   for " matches any domain and can be used as the default.

   The command name "none" is special -- it tells the mechanism
   not to use any proxy command and use the native git://
   connection.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 connect.c |   52 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 45 insertions(+), 7 deletions(-)

applies-to: d4a5ace05fd892cb455f330d379cdaa69dc6005c
c1d7ac7b4680202d3549a72188f372367ac8837c
diff --git a/connect.c b/connect.c
index 43eec67..11a804f 100644
--- a/connect.c
+++ b/connect.c
@@ -449,25 +449,63 @@ static int git_tcp_connect(int fd[2], co
 #endif /* NO_IPV6 */
 
 static char *git_proxy_command = NULL;
+static const char *rhost_name = NULL;
+static int rhost_len;
 
 static int git_proxy_command_options(const char *var, const char *value)
 {
-	if (git_proxy_command == NULL) {
-		if (!strcmp(var, "git.proxycommand")) {
-			git_proxy_command = xmalloc(strlen(value) + 1);
-			strcpy(git_proxy_command, value);
+	if (!strcmp(var, "core.gitproxy")) {
+		if (git_proxy_command)
 			return 0;
+		/* [core]
+		 * ;# matches www.kernel.org as well
+		 * gitproxy = netcatter-1 for kernel.org
+		 * gitproxy = netcatter-2 for sample.xz
+		 * gitproxy = netcatter-default
+		 */
+		const char *for_pos = strstr(value, " for ");
+		int matchlen = -1;
+		int hostlen;
+
+		if (!for_pos)
+			/* matches everybody */
+			matchlen = strlen(value);
+		else {
+			hostlen = strlen(for_pos + 5);
+			if (rhost_len < hostlen)
+				matchlen = -1;
+			else if (!strncmp(for_pos + 5,
+					  rhost_name + rhost_len - hostlen,
+					  hostlen) &&
+				 ((rhost_len == hostlen) ||
+				  rhost_name[rhost_len - hostlen -1] == '.'))
+				matchlen = for_pos - value;
+			else
+				matchlen = -1;
+		}
+		if (0 <= matchlen) {
+			/* core.gitproxy = none for kernel.org */
+			if (matchlen == 4 && 
+			    !memcmp(value, "none", 4))
+				matchlen = 0;
+			git_proxy_command = xmalloc(matchlen + 1);
+			memcpy(git_proxy_command, value, matchlen);
+			git_proxy_command[matchlen] = 0;
 		}
+		return 0;
 	}
 
 	return git_default_config(var, value);
 }
 
-static int git_use_proxy(void)
+static int git_use_proxy(const char *host)
 {
+	rhost_name = host;
+	rhost_len = strlen(host);
 	git_proxy_command = getenv("GIT_PROXY_COMMAND");
 	git_config(git_proxy_command_options);
-	return git_proxy_command != NULL;
+	rhost_name = NULL;
+	return (git_proxy_command && *git_proxy_command);
 }
 
 static int git_proxy_connect(int fd[2], const char *prog, char *host, char *path)
@@ -550,7 +588,7 @@ int git_connect(int fd[2], char *url, co
 	}
 
 	if (protocol == PROTO_GIT) {
-		if (git_use_proxy())
+		if (git_use_proxy(host))
 			return git_proxy_connect(fd, prog, host, path);
 		return git_tcp_connect(fd, prog, host, path);
 	}
---
0.99.9.GIT
 
