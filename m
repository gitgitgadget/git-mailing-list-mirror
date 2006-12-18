X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch: deleting remote branches in new layout
Date: Sun, 17 Dec 2006 23:49:58 -0800
Message-ID: <7vodq11w49.fsf@assigned-by-dhcp.cox.net>
References: <45863044.4040406@gmail.com>
	<7vbqm13cm0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 07:50:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqm13cm0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 17 Dec 2006 23:08:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34724>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDG8-0000E0-Me for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753472AbWLRHuA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbWLRHuA
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:50:00 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56871 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753472AbWLRHuA (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:50:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218074959.QXVD25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 02:49:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 07qB1W0051kojtg0000000; Mon, 18 Dec 2006
 02:50:11 -0500
To: Quy Tonthat <qtonthat@gmail.com>
Sender: git-owner@vger.kernel.org

How about this instead?

Because -r already means "remote" when listing, you can say:

	$ git branch -d -r origin/todo origin/html origin/man

I just twisted it not to do fast-forward check with the current
branch, because remote tracking branches are more like tags than
branches, and when you are removing them, most likely that is
not because you are "done with" them (for a local branch, it
usually means "you merged it up") but because you are not even
interested in them.

--

Junio C Hamano <junkio@cox.net> writes:

> Quy Tonthat <qtonthat@gmail.com> writes:
>
>> Now that remote branches are in refs/remotes/, branch -D needs to know
>> where to find them.
>>
>> Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
>
> I recognize that giving end users a way to remove a "remote
> tracking branch" might be a worthy goal ("update-ref -d" _could_
> be used, but "branch -D" feels more natural).

 builtin-branch.c |   41 ++++++++++++++++++++++++++++-------------
 1 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 560309c..7fb93e7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,8 +12,12 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [-r | -a] [-v [--abbrev=<length>]]";
+  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [-r | -a] [-v [--abbrev=<length>]]";
 
+#define REF_UNKNOWN_TYPE    0x00
+#define REF_LOCAL_BRANCH    0x01
+#define REF_REMOTE_BRANCH   0x02
+#define REF_TAG             0x04
 
 static const char *head;
 static unsigned char head_sha1[20];
@@ -89,25 +93,40 @@ static int in_merge_bases(const unsigned char *sha1,
 	return ret;
 }
 
-static void delete_branches(int argc, const char **argv, int force)
+static void delete_branches(int argc, const char **argv, int force, int kinds)
 {
 	struct commit *rev, *head_rev = head_rev;
 	unsigned char sha1[20];
 	char *name;
+	const char *fmt, *remote;
 	int i;
 
+	switch (kinds) {
+	case REF_REMOTE_BRANCH:
+		fmt = "refs/remotes/%s";
+		remote = "remote ";
+		force = 1;
+		break;
+	case REF_LOCAL_BRANCH:
+		fmt = "refs/heads/%s";
+		remote = "";
+		break;
+	default:
+		die("cannot use -a with -d");
+	}
+
 	if (!force) {
 		head_rev = lookup_commit_reference(head_sha1);
 		if (!head_rev)
 			die("Couldn't look up commit object for HEAD");
 	}
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(head, argv[i]))
+		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, argv[i]))
 			die("Cannot delete the branch you are currently on.");
 
-		name = xstrdup(mkpath("refs/heads/%s", argv[i]));
+		name = xstrdup(mkpath(fmt, argv[i]));
 		if (!resolve_ref(name, sha1, 1, NULL))
-			die("Branch '%s' not found.", argv[i]);
+			die("%sbranch '%s' not found.", remote, argv[i]);
 
 		rev = lookup_commit_reference(sha1);
 		if (!rev)
@@ -128,19 +147,15 @@ static void delete_branches(int argc, const char **argv, int force)
 		}
 
 		if (delete_ref(name, sha1))
-			printf("Error deleting branch '%s'\n", argv[i]);
+			printf("Error deleting %sbranch '%s'\n", remote,
+			       argv[i]);
 		else
-			printf("Deleted branch %s.\n", argv[i]);
+			printf("Deleted %sbranch %s.\n", remote, argv[i]);
 
 		free(name);
 	}
 }
 
-#define REF_UNKNOWN_TYPE    0x00
-#define REF_LOCAL_BRANCH    0x01
-#define REF_REMOTE_BRANCH   0x02
-#define REF_TAG             0x04
-
 struct ref_item {
 	char *name;
 	unsigned int kind;
@@ -435,7 +450,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	head += 11;
 
 	if (delete)
-		delete_branches(argc - i, argv + i, force_delete);
+		delete_branches(argc - i, argv + i, force_delete, kinds);
 	else if (i == argc)
 		print_ref_list(kinds, verbose, abbrev);
 	else if (rename && (i == argc - 1))
