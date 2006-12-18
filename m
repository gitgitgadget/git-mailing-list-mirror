X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] (Take 2) git-branch: deleting remote branches in new
 layout
Date: Tue, 19 Dec 2006 00:39:08 +1100
Message-ID: <458699FC.9060407@gmail.com>
References: <45863044.4040406@gmail.com>	<7vbqm13cm0.fsf@assigned-by-dhcp.cox.net> <7vodq11w49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:45:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7vodq11w49.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34767>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwIiU-0005ku-NH for gcvg-git@gmane.org; Mon, 18 Dec
 2006 14:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754005AbWLRNjg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 08:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbWLRNjf
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 08:39:35 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:33353 "EHLO
 pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S1754005AbWLRNjf (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 08:39:35 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95]
 helo=[192.168.64.35]) by pecan.exetel.com.au with esmtp (Exim 4.63)
 (envelope-from <qtonthat@gmail.com>) id 1GwIiJ-00045c-EC; Tue, 19 Dec 2006
 00:39:32 +1100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch is based on Junio's patch (all errors are my fault, of
course) to provide the following features to 'git-branch -d|-D'

o Option -r can be used with -d or -D to delete "remote" (tracking)
  branch(es), for examples,
	git branch -d -r origin/man origin/html
  this command will delete the named branches in $GIT_DIR/refs/remotes,
  according to the new layout.
  (No, you can no longer mix "local" and "remote" branches in one
  deletion command.)

o If there are more than one branches to be deleted, failure on one will
  no longer stop git-branch to process the next ones.

o 'git-branch -d|-D' now returns error code 1 if at least one of
  branches deleting is failed. (0 returned for fully success as before) 

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---

	This patch is to replace my previous patch.


 builtin-branch.c |   57 ++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 7fb93e7..52b6b5a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -93,13 +93,14 @@ static int in_merge_bases(const unsigned char *sha1,
 	return ret;
 }
 
-static void delete_branches(int argc, const char **argv, int force, int kinds)
+static int delete_branches(int argc, const char **argv, int force, int kinds)
 {
 	struct commit *rev, *head_rev = head_rev;
 	unsigned char sha1[20];
-	char *name;
+	char *name = NULL;
 	const char *fmt, *remote;
 	int i;
+	int ret = 0;
 
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
@@ -121,16 +122,30 @@ static void delete_branches(int argc, const char **argv, int force, int kinds)
 			die("Couldn't look up commit object for HEAD");
 	}
 	for (i = 0; i < argc; i++) {
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, argv[i]))
-			die("Cannot delete the branch you are currently on.");
+		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, argv[i])) {
+			error("Cannot delete the branch '%s' "
+				"which you are currently on.", argv[i]);
+			ret = 1;
+			continue;
+		}
+
+		if (name)
+			free(name);
 
 		name = xstrdup(mkpath(fmt, argv[i]));
-		if (!resolve_ref(name, sha1, 1, NULL))
-			die("%sbranch '%s' not found.", remote, argv[i]);
+		if (!resolve_ref(name, sha1, 1, NULL)) {
+			error("%sbranch '%s' not found.",
+					remote, argv[i]);
+			ret = 1;
+			continue;
+		}
 
 		rev = lookup_commit_reference(sha1);
-		if (!rev)
-			die("Couldn't look up commit object for '%s'", name);
+		if (!rev) {
+			error("Couldn't look up commit object for '%s'", name);
+			ret = 1;
+			continue;
+		}
 
 		/* This checks whether the merge bases of branch and
 		 * HEAD contains branch -- which means that the HEAD
@@ -139,21 +154,26 @@ static void delete_branches(int argc, const char **argv, int force, int kinds)
 
 		if (!force &&
 		    !in_merge_bases(sha1, rev, head_rev)) {
-			fprintf(stderr,
-				"The branch '%s' is not a strict subset of your current HEAD.\n"
-				"If you are sure you want to delete it, run 'git branch -D %s'.\n",
+			error("The branch '%s' is not a strict subset of your current HEAD."
+				"If you are sure you want to delete it, run 'git branch -D %s'.",
 				argv[i], argv[i]);
-			exit(1);
+			ret = 1;
+			continue;
 		}
 
-		if (delete_ref(name, sha1))
-			printf("Error deleting %sbranch '%s'\n", remote,
+		if (delete_ref(name, sha1)) {
+			error("Error deleting %sbranch '%s'", remote,
 			       argv[i]);
-		else
+			ret = 1;
+		} else
 			printf("Deleted %sbranch %s.\n", remote, argv[i]);
 
-		free(name);
 	}
+
+	if (name)
+		free(name);
+
+	return(ret);
 }
 
 struct ref_item {
@@ -372,6 +392,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int reflog = 0;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
+	int status = 0;
 
 	setup_ident();
 	git_config(git_branch_config);
@@ -450,7 +471,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	head += 11;
 
 	if (delete)
-		delete_branches(argc - i, argv + i, force_delete, kinds);
+		status = delete_branches(argc - i, argv + i, force_delete, kinds);
 	else if (i == argc)
 		print_ref_list(kinds, verbose, abbrev);
 	else if (rename && (i == argc - 1))
@@ -464,5 +485,5 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else
 		usage(builtin_branch_usage);
 
-	return 0;
+	return (status);
 }
-- 
1.4.4.1.GIT
