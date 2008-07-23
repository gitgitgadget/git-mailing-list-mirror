From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-branch.c: optimize --merged and --no-merged
Date: Wed, 23 Jul 2008 15:15:54 -0700
Message-ID: <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
 <20080723140441.GA9537@elte.hu> <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmdw-0007ho-Ls
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYGWWQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYGWWQG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:16:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbYGWWQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:16:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 808A438106;
	Wed, 23 Jul 2008 18:16:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D48AC38100; Wed, 23 Jul 2008 18:15:56 -0400 (EDT)
In-Reply-To: <7vy73seb2p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Jul 2008 10:59:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EEF9F292-5904-11DD-B5A7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89794>

"git branch --no-merged $commit" used to compute the merge base between
the tip of each and every branch with the named $commit, but this was
wasteful when you have many branches.  Inside append_ref() we literally
ran has_commit() between the tip of the branch and the merge_filter_ref.

Instead, we can let the revision machinery traverse the history as if we
are running:

    $ git rev-list --branches --not $commit

by queueing the tips of branches we encounter as positive refs (this
mimicks the "--branches" option in the above command line) and then
appending the merge_filter_ref commit as a negative one, and finally
calling prepare_revision_walk() to limit the list..

After the traversal is done, branch tips that are reachable from $commit
are painted UNINTERESTING; they are already fully contained in $commit
(i.e. --merged).  Tips that are not painted UNINTERESTING still have
commits that are not reachable from $commit, thus "--no-merged" will show
them.

With an artificial repository that has "master" and 1000 test-$i branches
where they were created by "git branch test-$i master~$i":

    (with patch)
    $ /usr/bin/time git-branch --no-merged master >/dev/null
    0.12user 0.02system 0:00.15elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+1588minor)pagefaults 0swaps

    $ /usr/bin/time git-branch --no-merged test-200 >/dev/null
    0.15user 0.03system 0:00.18elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+1711minor)pagefaults 0swaps

    (without patch)
    $ /usr/bin/time git-branch --no-merged master >/dev/null
    0.69user 0.03system 0:00.72elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+2229minor)pagefaults 0swaps

    $ /usr/bin/time git-branch --no-merged test-200 >/dev/null
    0.58user 0.03system 0:00.61elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+2248minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c |   59 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3708a50..5db8ad8 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -13,6 +13,8 @@
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
+#include "diff.h"
+#include "revision.h"
 
 static const char * const builtin_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -179,25 +181,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 struct ref_item {
 	char *name;
 	unsigned int kind;
-	unsigned char sha1[20];
+	struct commit *commit;
 };
 
 struct ref_list {
+	struct rev_info revs;
 	int index, alloc, maxwidth;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
 };
 
-static int has_commit(const unsigned char *sha1, struct commit_list *with_commit)
+static int has_commit(struct commit *commit, struct commit_list *with_commit)
 {
-	struct commit *commit;
-
 	if (!with_commit)
 		return 1;
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (!commit)
-		return 0;
 	while (with_commit) {
 		struct commit *other;
 
@@ -213,6 +211,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
+	struct commit *commit;
 	int kind;
 	int len;
 	static struct commit_list branch;
@@ -227,8 +226,12 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	} else
 		return 0;
 
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return error("branch '%s' does not point at a commit", refname);
+
 	/* Filter with with_commit if specified */
-	if (!has_commit(sha1, ref_list->with_commit))
+	if (!has_commit(commit, ref_list->with_commit))
 		return 0;
 
 	/* Don't add types the caller doesn't want */
@@ -239,12 +242,8 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		branch.item = lookup_commit_reference_gently(sha1, 1);
 		if (!branch.item)
 			die("Unable to lookup tip of branch %s", refname);
-		if (merge_filter == SHOW_NOT_MERGED &&
-		    has_commit(merge_filter_ref, &branch))
-			return 0;
-		if (merge_filter == SHOW_MERGED &&
-		    !has_commit(merge_filter_ref, &branch))
-			return 0;
+		add_pending_object(&ref_list->revs,
+				   (struct object *)branch.item, refname);
 	}
 
 	/* Resize buffer */
@@ -258,7 +257,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	newitem = &(ref_list->list[ref_list->index++]);
 	newitem->name = xstrdup(refname);
 	newitem->kind = kind;
-	hashcpy(newitem->sha1, sha1);
+	newitem->commit = commit;
 	len = strlen(newitem->name);
 	if (len > ref_list->maxwidth)
 		ref_list->maxwidth = len;
@@ -305,7 +304,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 {
 	char c;
 	int color;
-	struct commit *commit;
+	struct commit *commit = item->commit;
+
+	if (merge_filter != NO_FILTER) {
+		int is_merged = !!(item->commit->object.flags & UNINTERESTING);
+		if (is_merged != (merge_filter == SHOW_MERGED))
+			return;
+	}
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
@@ -333,7 +338,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		strbuf_init(&subject, 0);
 		stat[0] = '\0';
 
-		commit = lookup_commit(item->sha1);
+		commit = item->commit;
 		if (commit && !parse_commit(commit)) {
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 					    &subject, 0, NULL, NULL, 0, 0);
@@ -346,7 +351,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->sha1, abbrev),
+		       find_unique_abbrev(item->commit->object.sha1, abbrev),
 		       stat, sub);
 		strbuf_release(&subject);
 	} else {
@@ -359,22 +364,34 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 {
 	int i;
 	struct ref_list ref_list;
+	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
 	ref_list.with_commit = with_commit;
+	if (merge_filter != NO_FILTER)
+		init_revisions(&ref_list.revs, NULL);
 	for_each_ref(append_ref, &ref_list);
+	if (merge_filter != NO_FILTER) {
+		struct commit *filter;
+		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
+		filter->object.flags |= UNINTERESTING;
+		add_pending_object(&ref_list.revs,
+				   (struct object *) filter, "");
+		ref_list.revs.limited = 1;
+		prepare_revision_walk(&ref_list.revs);
+	}
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && has_commit(head_sha1, with_commit)) {
+	if (detached && head_commit && has_commit(head_commit, with_commit)) {
 		struct ref_item item;
 		item.name = xstrdup("(no branch)");
 		item.kind = REF_LOCAL_BRANCH;
-		hashcpy(item.sha1, head_sha1);
+		item.commit = head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
-			      ref_list.maxwidth = strlen(item.name);
+			ref_list.maxwidth = strlen(item.name);
 		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
 		free(item.name);
 	}
-- 
1.6.0.rc0.31.g128c7
