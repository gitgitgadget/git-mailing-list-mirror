From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Implement --recover for git-*-fetch
Date: Mon, 26 Sep 2005 21:38:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509262137360.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 03:34:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK4MQ-0001Vy-9s
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 03:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVI0Bdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVI0Bdo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 21:33:44 -0400
Received: from iabervon.org ([66.92.72.58]:29702 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964787AbVI0Bdo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 21:33:44 -0400
Received: (qmail 3490 invoked by uid 1000); 26 Sep 2005 21:38:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2005 21:38:08 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9361>

With the --recover option, we verify that we have absolutely
everything reachable from the target, not assuming that things
reachable from refs will be complete.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 fetch.c       |    5 ++++-
 fetch.h       |    3 +++
 http-fetch.c  |    2 ++
 local-fetch.c |    2 ++
 ssh-fetch.c   |    2 ++
 5 files changed, 13 insertions(+), 1 deletions(-)

96e5339ec5759c716282465cb86e3e559270c51c
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -15,6 +15,7 @@ int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
 int get_verbosely = 0;
+int get_recover = 0;
 static unsigned char current_commit_sha1[20];
 
 void pull_say(const char *fmt, const char *hex) 
@@ -214,7 +215,9 @@ int pull(char *target)
 			return -1;
 	}
 
-	for_each_ref(mark_complete);
+	if (!get_recover) {
+		for_each_ref(mark_complete);
+	}
 
 	if (interpret_target(target, sha1))
 		return error("Could not interpret %s as something to pull",
diff --git a/fetch.h b/fetch.h
--- a/fetch.h
+++ b/fetch.h
@@ -40,6 +40,9 @@ extern int get_all;
 /* Set to be verbose */
 extern int get_verbosely;
 
+/* Set to check on all reachable objects. */
+extern int get_recover;
+
 /* Report what we got under get_verbosely */
 extern void pull_say(const char *, const char *);
 
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -491,6 +491,8 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = argv[arg + 1];
 			arg++;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_recover = 1;
 		}
 		arg++;
 	}
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -231,6 +231,8 @@ int main(int argc, char **argv)
 			get_verbosely = 1;
 		else if (argv[arg][1] == 'w')
 			write_ref = argv[++arg];
+		else if (!strcmp(argv[arg], "--recover"))
+			get_recover = 1;
 		else
 			usage(local_pull_usage);
 		arg++;
diff --git a/ssh-fetch.c b/ssh-fetch.c
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -119,6 +119,8 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = argv[arg + 1];
 			arg++;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_recover = 1;
 		}
 		arg++;
 	}
