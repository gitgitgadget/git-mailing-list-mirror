From: Jeff Epler <unpythonic.net@unpythonic.net>
Subject: [PATCH 1/2] add new output-tuning flags to 'git cherry'
Date: Fri, 29 May 2009 20:39:14 -0500
Message-ID: <1243647555-25098-1-git-send-email-user@lamp>
Cc: Jeff Epler <jepler@unpythonic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 03:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MADgy-0007WA-7q
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 03:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511AbZE3Bsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 21:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757299AbZE3Bsw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 21:48:52 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:38768 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755665AbZE3Bsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 21:48:50 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 21:48:50 EDT
Received: by unpythonic.net (Postfix, from userid 1000)
	id BEA5E1146F7; Fri, 29 May 2009 20:39:15 -0500 (CDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120333>

From: Jeff Epler <jepler@unpythonic.net>

The new flags are:
    -a or -##: abbreviate SHA1s to 7 or ## places
    -r: reverse 'upstream' and 'head' (useful when on 'head' and wanting to
        pick from 'upstream')
    -d: only show "+" (doesn't have) patches
    -D: only show "-" (does have) patches

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---
 builtin-log.c |   54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f10cfeb..420f39e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1130,7 +1130,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 }
 
 static const char cherry_usage[] =
-"git cherry [-v] [<upstream> [<head> [<limit>]]]";
+"git cherry [-v] [-a|-#] [-r] [-d|-D] [<upstream> [<head> [<limit>]]]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1142,9 +1142,29 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *head = "HEAD";
 	const char *limit = NULL;
 	int verbose = 0;
+	int reverse = 0;
+	int abbrev = 40;
+	int show_has = 0;
+	int show_hasnt = 0;
+
+	while(argc > 1 && argv[1][0] == '-')
+	{
+		if (!strcmp(argv[1], "-v")) {
+			verbose = 1;
+		} else if(!strcmp(argv[1], "-a")) {
+			abbrev = DEFAULT_ABBREV;
+		} else if(isdigit(argv[1][1])) {
+			abbrev = atoi(argv+1);
+		} else if(!strcmp(argv[1], "-r")) {
+			reverse = 1;
+		} else if(!strcmp(argv[1], "-d")) {
+			show_hasnt = 1;
+		} else if(!strcmp(argv[1], "-D")) {
+			show_has = 1;
+		} else {
+			die("unrecognized argument: %s", argv[1]);
+		}
 
-	if (argc > 1 && !strcmp(argv[1], "-v")) {
-		verbose = 1;
 		argc--;
 		argv++;
 	}
@@ -1173,6 +1193,16 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		upstream = current_branch->merge[0]->dst;
 	}
 
+	if(reverse) {
+		const char *temp = upstream;
+		upstream = head;
+		head = temp;
+	}
+
+	if(!show_has && !show_hasnt) {
+		show_has = show_hasnt = 1;
+	}
+
 	init_revisions(&revs, prefix);
 	revs.diff = 1;
 	revs.combine_merges = 0;
@@ -1207,27 +1237,31 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		commit_list_insert(commit, &list);
 	}
 
-	while (list) {
+	for (; list; list=list->next) {
 		char sign = '+';
+		int has;
 
 		commit = list->item;
-		if (has_commit_patch_id(commit, &ids))
+
+		if ((has = has_commit_patch_id(commit, &ids))) {
 			sign = '-';
+			if(!show_has) continue;
+		} else {
+			if(!show_hasnt) continue;
+		}
 
 		if (verbose) {
 			struct strbuf buf = STRBUF_INIT;
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-			                    &buf, 0, NULL, NULL, 0, 0);
-			printf("%c %s %s\n", sign,
+					    &buf, 0, NULL, NULL, 0, 0);
+			printf("%c %.*s %s\n", sign, abbrev,
 			       sha1_to_hex(commit->object.sha1), buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
-			printf("%c %s\n", sign,
+			printf("%c %.*s\n", sign, abbrev,
 			       sha1_to_hex(commit->object.sha1));
 		}
-
-		list = list->next;
 	}
 
 	free_patch_ids(&ids);
-- 
1.5.4.3
