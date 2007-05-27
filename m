From: Johan Herland <johan@herland.net>
Subject: [PATCH 12/15] git-note: (Transfer) Teach git-push to push notes when
 --all or --notes is given
Date: Sun, 27 May 2007 16:15:55 +0200
Message-ID: <200705271615.55294.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJXV-0007Td-5D
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbXE0OQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXE0OQF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:16:05 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52103 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbXE0OQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:16:04 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00009EAQGC00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:02 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00054EAJ7J00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:55 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000CEEAJJB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:55 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48552>

As with tags, git-push will not push notes by default. However, if --all
or --notes (new) is given, git-push will now push notes (similary to tags,
if --all or --tags is given).

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-push.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index cb78401..e3d6a21 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,9 +8,9 @@
 
 #define MAX_URI (16)
 
-static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all] [--tags] [--notes] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
-static int all, tags, force, thin = 1, verbose;
+static int all, tags, notes, force, thin = 1, verbose;
 static const char *receivepack;
 
 #define BUF_SIZE (2084)
@@ -32,7 +32,8 @@ static int expand_one_ref(const char *ref, const unsigned char *sha1, int flag,
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
 
-	if (!prefixcmp(ref, "tags/"))
+	if ((tags  && !prefixcmp(ref, "tags/")) ||
+	    (notes && !prefixcmp(ref, "notes/")))
 		add_refspec(xstrdup(ref));
 	return 0;
 }
@@ -49,9 +50,8 @@ static void expand_refspecs(void)
 		 */
 		return;
 	}
-	if (!tags)
-		return;
-	for_each_ref(expand_one_ref, NULL);
+	if (tags || notes)
+		for_each_ref(expand_one_ref, NULL);
 }
 
 struct wildcard_cb {
@@ -141,7 +141,7 @@ static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 {
 	int n = 0;
 	FILE *f = fopen(git_path("remotes/%s", repo), "r");
-	int has_explicit_refspec = refspec_nr || all || tags;
+	int has_explicit_refspec = refspec_nr || all || tags || notes;
 
 	if (!f)
 		return -1;
@@ -227,7 +227,7 @@ static int get_config_remotes_uri(const char *repo, const char *uri[MAX_URI])
 	config_repo = repo;
 	config_current_uri = 0;
 	config_uri = uri;
-	config_get_refspecs = !(refspec_nr || all || tags);
+	config_get_refspecs = !(refspec_nr || all || tags || notes);
 	config_get_receivepack = (receivepack == NULL);
 
 	git_config(get_remote_config);
@@ -388,6 +388,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			tags = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--notes")) {
+			notes = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
 			force = 1;
 			continue;
-- 
1.5.2.101.gee49f
