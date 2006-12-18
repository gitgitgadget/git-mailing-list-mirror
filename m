X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add --remotes option to show-branch
Date: Mon, 18 Dec 2006 09:53:29 -0500
Message-ID: <20061218145053.GA5175@178.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 23:19:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34758>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwJsB-0006wN-F2 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 15:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754096AbWLROxc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 09:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbWLROxc
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 09:53:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50667 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1754096AbWLROxc (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 09:53:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 silverinsanity.com (Postfix) with ESMTP id 05B821FFC02B for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 14:53:30 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2 
 (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

We had --heads for refs/heads and --tags for refs/tags, but no easy
way to specify refs/remotes, which is going to be more common now that
it's the default layout for clone.

Also add remotes to --all and update documentation.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Another patch in my "features I wasted time looking for" series.
 I figure that patches are more useful than feature requests, and
 that seems to be proven by the fact my patches are getting applied.

 This is my first serious foray into git's C code.  I simply copied
 append_head_ref to get append_remote_ref, since the goal was similar.
 If there are additional checks that would need to be done in there,
 feel free to fix it, or tell me what I should look for.

 As a side note, there's no documentation for the --topics option for
 show-branch.  If I figure out what it does, I'll write it, but I'd bet
 someone else already knows and would love to help a neophite git coder
 figure it out.  ;-)

 Documentation/git-show-branch.txt |   18 +++++++++---------
 builtin-show-branch.c             |   31 ++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index a2445a4..25136b0 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,9 +8,9 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git-show-branch' [--all] [--heads] [--tags] [--topo-order] [--current]
+'git-show-branch' [--all] [--heads] [--remotes] [--tags] [--topo-order]
 		[--more=<n> | --list | --independent | --merge-base]
-		[--no-name | --sha1-name] [<rev> | <glob>]...
+		[--current] [--no-name | --sha1-name] [<rev> | <glob>]...
 
 DESCRIPTION
 -----------
@@ -37,14 +37,9 @@ OPTIONS
 	branches under $GIT_DIR/refs/heads/topic, giving
 	`topic/*` would show all of them.
 
---all --heads --tags::
+--all --heads --remotes --tags::
 	Show all refs under $GIT_DIR/refs, $GIT_DIR/refs/heads,
-	and $GIT_DIR/refs/tags, respectively.
-
---current::
-	With this option, the command includes the current
-	branch to the list of revs to be shown when it is not
-	given on the command line.
+	$GIT_DIR/refs/remotes, and $GIT_DIR/refs/tags, respectively.
 
 --topo-order::
         By default, the branches and their commits are shown in
@@ -77,6 +72,11 @@ OPTIONS
 	Among the <reference>s given, display only the ones that
 	cannot be reached from any other <reference>.
 
+--current::
+	With this option, the command includes the current
+	branch to the list of revs to be shown when it is not
+	given on the command line.
+
 --no-name::
 	Do not show naming strings for each commit.
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index fb1a400..91251f9 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -6,7 +6,7 @@
 #include "builtin.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--sparse] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...]";
+"git-show-branch [--sparse] [--current] [--all] [--heads] [--remotes] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...]";
 
 static int default_num;
 static int default_alloc;
@@ -383,6 +383,20 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	return append_ref(refname + ofs, sha1, flag, cb_data);
 }
 
+static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	unsigned char tmp[20];
+	int ofs = 13;
+	if (strncmp(refname, "refs/remotes/", ofs))
+		return 0;
+	/* If both remotes/_/foo and tags/foo exists, get_sha1 would
+	 * get confused.
+	 */
+	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+		ofs = 5;
+	return append_ref(refname + ofs, sha1, flag, cb_data);
+}
+
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (strncmp(refname, "refs/tags/", 10))
@@ -423,13 +437,18 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 	return append_ref(refname, sha1, flag, cb_data);
 }
 
-static void snarf_refs(int head, int tag)
+static void snarf_refs(int head, int tag, int remote)
 {
 	if (head) {
 		int orig_cnt = ref_name_cnt;
 		for_each_ref(append_head_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
+	if (remote) {
+		int orig_cnt = ref_name_cnt;
+		for_each_ref(append_remote_ref, NULL);
+		sort_ref_range(orig_cnt, ref_name_cnt);
+	}
 	if (tag) {
 		int orig_cnt = ref_name_cnt;
 		for_each_ref(append_tag_ref, NULL);
@@ -554,7 +573,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	struct commit_list *list = NULL, *seen = NULL;
 	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
-	int all_heads = 0, all_tags = 0;
+	int all_heads = 0, all_tags = 0, all_remotes;
 	int all_mask, all_revs;
 	int lifo = 1;
 	char head[128];
@@ -586,9 +605,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			break;
 		}
 		else if (!strcmp(arg, "--all"))
-			all_heads = all_tags = 1;
+			all_heads = all_remotes = all_tags = 1;
 		else if (!strcmp(arg, "--heads"))
 			all_heads = 1;
+		else if (!strcmp(arg, "--remotes"))
+			all_remotes = 1;
 		else if (!strcmp(arg, "--tags"))
 			all_tags = 1;
 		else if (!strcmp(arg, "--more"))
@@ -630,7 +651,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		all_heads = 1;
 
 	if (all_heads + all_tags)
-		snarf_refs(all_heads, all_tags);
+		snarf_refs(all_heads, all_tags, all_remotes);
 	while (0 < ac) {
 		append_one_rev(*av);
 		ac--; av++;
-- 
1.4.4.1.GIT
