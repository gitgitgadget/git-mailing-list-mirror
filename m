From: Kacper Kornet <draenog@pld-linux.org>
Subject: [RFC/PATCH] Option to revert order of parents in merge commit
Date: Fri, 23 Nov 2012 09:35:53 +0100
Message-ID: <20121123083550.GA702@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 09:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbokN-0003aM-90
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 09:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab2KWIgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 03:36:12 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:53644 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816Ab2KWIgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 03:36:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2AFDC5F004A
	for <git@vger.kernel.org>; Fri, 23 Nov 2012 09:34:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Mb-O-Ag3askd for <git@vger.kernel.org>;
	Fri, 23 Nov 2012 09:34:39 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 01D7E5F004E
	for <git@vger.kernel.org>; Fri, 23 Nov 2012 09:34:39 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 3CB9D43CFD; Fri, 23 Nov 2012 09:35:53 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210246>

When the changes are pushed upstream, and in the meantime someone else
updated upstream branch git advises to use git pull. This results in
history:

     ---A---B---C--
         \     /
          D---E

where B is my commit. D, E are commits pushed by someone else when I was
working on B. However sometimes the following history is preferable:

    ---A---D---C'--
        \     /
          -B-

The difference between C and C' is the order of parents. Presently to
obtain it, instead of git pull, one needs to do (assuming that I am on
the master branch):

git fetch origin
git branch tmp_branch
git reset --hard origin/master
git merge tmp_branch

Reverting from wrong pull is more cumbersome. It would be simpler if git
merge learn an option to reverse order of parents in the produced
commits, so one could do:

git fetch origin
git merge --revert-order origin/master

The following patch is an attempt to implement this idea.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---

I'm not 100% percent sure that it is a good idea. But it would make life
of our developers easier and produced nicer history then using git pull.
Git pull seems to written for a case of single maintainer who gathers
contributions from other developers and incorporates them in master
branch. However in my opinion it doesn't produce best history when many
developers modify the canonical repository. 

 builtin/commit.c | 22 ++++++++++++++--------
 builtin/merge.c  | 16 ++++++++++++----
 commit.c         | 11 +++++++++++
 commit.h         |  2 ++
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1dd2ec5..ab2b844 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1427,7 +1427,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
-	struct stat statbuf;
 	int allow_fast_forward = 1;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
@@ -1478,10 +1477,21 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
+		int reversed_order=0;
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
-		pptr = &commit_list_insert(current_head, pptr)->next;
+		if((fp = fopen(git_path("MERGE_MODE"), "r"))) {
+			while (strbuf_getline(&m, fp, '\n') != EOF) {
+				if (!strcmp(m.buf, "no-ff"))
+					allow_fast_forward = 0;
+				if (!strcmp(m.buf, "reversed-order"))
+					reversed_order = 1;
+			}
+			fclose(fp);
+		}
+		if (!reversed_order)
+			pptr = &commit_list_insert(current_head, pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1496,12 +1506,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno(_("could not read MERGE_MODE"));
-			if (!strcmp(sb.buf, "no-ff"))
-				allow_fast_forward = 0;
-		}
+		if (reversed_order)
+			pptr = &commit_list_insert(current_head, pptr)->next;
 		if (allow_fast_forward)
 			parents = reduce_heads(parents);
 	} else {
diff --git a/builtin/merge.c b/builtin/merge.c
index a96e8ea..8d0ed18 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -65,6 +65,7 @@ static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
 static const char *sign_commit;
+static int reversed_order=0;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -213,6 +214,7 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOLEAN(0, "revert-order", &reversed_order, N_("reverse order of parents")),
 	OPT_END()
 };
 
@@ -822,9 +824,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
-	parent->item = head;
+	parent->item = reversed_order ? remoteheads->item : head;
 	parent->next = xmalloc(sizeof(*parent->next));
-	parent->next->item = remoteheads->item;
+	parent->next->item = reversed_order ? head : remoteheads->item;
 	parent->next->next = NULL;
 	prepare_to_commit(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parent, result_commit, NULL,
@@ -848,8 +850,12 @@ static int finish_automerge(struct commit *head,
 
 	free_commit_list(common);
 	parents = remoteheads;
-	if (!head_subsumed || !allow_fast_forward)
+	if (!head_subsumed || !allow_fast_forward) {
+	    if (reversed_order )
+		commit_list_insert_end(head, &parents);
+	    else
 		commit_list_insert(head, &parents);
+	}
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
 	if (commit_tree(&merge_msg, result_tree, parents, result_commit,
@@ -994,7 +1000,9 @@ static void write_merge_state(struct commit_list *remoteheads)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
 	if (!allow_fast_forward)
-		strbuf_addf(&buf, "no-ff");
+		strbuf_addf(&buf, "no-ff\n");
+	if (reversed_order)
+		strbuf_addf(&buf, "reversed-order\n");
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
 		die_errno(_("Could not write to '%s'"), filename);
 	close(fd);
diff --git a/commit.c b/commit.c
index e8eb0ae..6e58994 100644
--- a/commit.c
+++ b/commit.c
@@ -363,6 +363,17 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+struct commit_list *commit_list_insert_end(struct commit *item, struct commit_list **list_p)
+{
+	struct commit_list *list_iter = *list_p;
+	while(list_iter->next)
+		list_iter = list_iter->next;
+	list_iter->next = xmalloc(sizeof(*list_iter->next));
+	list_iter->next->item = item;
+	list_iter->next->next = NULL;
+	return *list_p;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index b6ad8f3..17ae5e5 100644
--- a/commit.h
+++ b/commit.h
@@ -53,6 +53,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+struct commit_list *commit_list_insert_end(struct commit *item,
+					struct commit_list **list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
-- 
1.8.0
