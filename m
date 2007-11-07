From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-branch --with=commit
Date: Wed, 07 Nov 2007 15:15:42 -0800
Message-ID: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 00:16:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipu7u-0004lF-84
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbXKGXPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXKGXPs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:15:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36067 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbXKGXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:15:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8FF842EF;
	Wed,  7 Nov 2007 18:16:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D533093513;
	Wed,  7 Nov 2007 18:16:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63891>

This teaches git-branch to limit its listing to branches that
are descendants to the named commit.

When you are using many topic branches, you often would want to
see which branch already includes a commit, so that you know
which can and cannot be rewound without disrupting other people.

One thing that sometimes happens to me is:

 * Somebody sends a patch that is a good maint material.  I
   apply it to 'maint':

     $ git checkout maint
     $ git am -3 -s obvious-fix.patch

 * Then somebody else sends another patch that is possibly a
   good maint material, but I'd want to cook it in 'next' to be
   extra sure.  I fork a topic from 'maint' and apply the patch:

     $ git checkout -b xx/maint-fix-foo
     $ git am -3 -s ,xx-maint-fix-foo.patch

 * A minor typo is found in the "obvious-fix.patch".

The above happens without pushing the results out, so I can
freely recover from it by amending 'maint', as long as I do not
forget to rebase the topics that were forked previously.

With this patch, I could do this to find out which topic
branches already contain the faulty commit:

    $ git branch --with=maint^ | grep /
      xx/maint-fix-foo

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3bf40f1..d13e64f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -184,9 +184,30 @@ struct ref_item {
 struct ref_list {
 	int index, alloc, maxwidth;
 	struct ref_item *list;
+	struct commit_list *with_commit;
 	int kinds;
 };
 
+static int has_commit(const unsigned char *sha1, struct commit_list *with_commit)
+{
+	struct commit *commit;
+
+	if (!with_commit)
+		return 1;
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return 0;
+	while (with_commit) {
+		struct commit *other;
+
+		other = with_commit->item;
+		with_commit = with_commit->next;
+		if (in_merge_bases(other, &commit, 1))
+			return 1;
+	}
+	return 0;
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
@@ -206,6 +227,10 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		refname += 10;
 	}
 
+	/* Filter with with_commit if specified */
+	if (!has_commit(sha1, ref_list->with_commit))
+		return 0;
+
 	/* Don't add types the caller doesn't want */
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
@@ -296,13 +321,14 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
 	struct ref_list ref_list;
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
+	ref_list.with_commit = with_commit;
 	for_each_ref(append_ref, &ref_list);
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
@@ -505,6 +531,22 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die("Branch is renamed, but update of config-file failed");
 }
 
+static int opt_parse_with_commit(const struct option *opt, const char *arg, int unset)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (!arg)
+		return -1;
+	if (get_sha1(arg, sha1))
+		die("malformed object name %s", arg);
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		die("no such commit %s", arg);
+	commit_list_insert(commit, opt->value);
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
@@ -512,6 +554,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH, kind_remote = 0, kind_any = 0;
+	struct commit_list *with_commit = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
@@ -519,6 +562,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_BOOLEAN('r', NULL,     &kind_remote, "act on remote-tracking branches"),
+		OPT_CALLBACK(0, "with",    &with_commit, "commit",
+			     "print only branches that contain the commit",
+			     opt_parse_with_commit),
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
@@ -566,7 +612,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, force_delete, kinds);
 	else if (argc == 0)
-		print_ref_list(kinds, detached, verbose, abbrev);
+		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], force_rename);
 	else if (rename && (argc == 2))
-- 
1.5.3.5.1593.g5baf
