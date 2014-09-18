From: Jeff King <peff@peff.net>
Subject: [PATCH] branch: clean up commit flags after merge-filter walk
Date: Thu, 18 Sep 2014 06:49:43 -0400
Message-ID: <20140918104943.GA13481@peff.net>
References: <87fvfutza3.fsf@fencepost.gnu.org>
 <xmqq38bs92sg.fsf@gitster.dls.corp.google.com>
 <87a960r9d2.fsf@fencepost.gnu.org>
 <xmqqwq944ov0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 12:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUZHd-0002iw-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 12:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbaIRKtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 06:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:49773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755987AbaIRKts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 06:49:48 -0400
Received: (qmail 3110 invoked by uid 102); 18 Sep 2014 10:49:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Sep 2014 05:49:48 -0500
Received: (qmail 20869 invoked by uid 107); 18 Sep 2014 10:50:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Sep 2014 06:50:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Sep 2014 06:49:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq944ov0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257256>

On Mon, Sep 15, 2014 at 01:20:51PM -0700, Junio C Hamano wrote:

> David Kastrup <dak@gnu.org> writes:
> 
> > This gives the same result as
> >
> > git branch --verbose --merged
> >
> > namely _only_ listing the current branch verbosely.
> 
> Hmph.  Then that is a different issue.  As I never use --merged
> myself, even though I use "git branch [--verbose] --no-merged pu"
> quite often to check the list of topics that I received but not yet
> merged anywhere in my tree, I wouldn't be entirely surprised that
> the combination does not work, but with a quick glance of the code,
> especially how matches_merge_filter() uses "--[no-]merged", I cannot
> offhand imagine how --no-merged would work and --merged break.

Ugh. The bug is caused by a failure to clean up the global flag state. I
am really tempted to try converting the revision walker to keep its
flags in a commit_slab so that this sort of thing can never bite us
again.

But here is the minimal fix.

-- >8 --
Subject: branch: clean up commit flags after merge-filter walk

When we run `branch --merged`, we use prepare_revision_walk
with the merge-filter marked as UNINTERESTING. Any branch
tips that are marked UNINTERESTING after it returns must be
ancestors of that commit. As we iterate through the list of
refs to show, we check item->commit->object.flags to see
whether it was marked.

This interacts badly with --verbose, which will do a
separate walk to find the ahead/behind information for each
branch. There are two bad things that can happen:

  1. The ahead/behind walk may get the wrong results,
     because it can see a bogus UNINTERESTING flag leftover
     from the merge-filter walk.

  2. We may omit some branches if their tips are involved in
     the ahead/behind traversal of a branch shown earlier.
     The ahead/behind walk carefully cleans up its commit
     flags, meaning it may also erase the UNINTERESTING
     flag that we expect to check later.

We can solve this by moving the merge-filter state for each
ref into its "struct ref_item" as soon as we finish the
merge-filter walk. That fixes (2). Then we are free to clear
the commit flags we used in the walk, fixing (1).

Note that we actually do away with the matches_merge_filter
helper entirely here, and inline it between the revision
walk and the flag-clearing. This ensures that nobody
accidentally calls it at the wrong time (it is only safe to
check in that instant between the setting and clearing of
the global flag).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c           | 33 +++++++++++++++++++--------------
 t/t3201-branch-contains.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ced422b..9e4666f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -280,6 +280,7 @@ struct ref_item {
 	char *dest;
 	unsigned int kind, width;
 	struct commit *commit;
+	int ignore;
 };
 
 struct ref_list {
@@ -385,6 +386,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	newitem->commit = commit;
 	newitem->width = utf8_strwidth(refname);
 	newitem->dest = resolve_symref(orig_refname, prefix);
+	newitem->ignore = 0;
 	/* adjust for "remotes/" */
 	if (newitem->kind == REF_REMOTE_BRANCH &&
 	    ref_list->kinds != REF_REMOTE_BRANCH)
@@ -484,17 +486,6 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	free(ref);
 }
 
-static int matches_merge_filter(struct commit *commit)
-{
-	int is_merged;
-
-	if (merge_filter == NO_FILTER)
-		return 1;
-
-	is_merged = !!(commit->object.flags & UNINTERESTING);
-	return (is_merged == (merge_filter == SHOW_MERGED));
-}
-
 static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 			     int verbose, int abbrev)
 {
@@ -522,10 +513,9 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 {
 	char c;
 	int color;
-	struct commit *commit = item->commit;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 
-	if (!matches_merge_filter(commit))
+	if (item->ignore)
 		return;
 
 	switch (item->kind) {
@@ -575,7 +565,7 @@ static int calc_maxwidth(struct ref_list *refs)
 {
 	int i, w = 0;
 	for (i = 0; i < refs->index; i++) {
-		if (!matches_merge_filter(refs->list[i].commit))
+		if (refs->list[i].ignore)
 			continue;
 		if (refs->list[i].width > w)
 			w = refs->list[i].width;
@@ -618,6 +608,7 @@ static void show_detached(struct ref_list *ref_list)
 		item.kind = REF_LOCAL_BRANCH;
 		item.dest = NULL;
 		item.commit = head_commit;
+		item.ignore = 0;
 		if (item.width > ref_list->maxwidth)
 			ref_list->maxwidth = item.width;
 		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
@@ -656,6 +647,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 
 		if (prepare_revision_walk(&ref_list.revs))
 			die(_("revision walk setup failed"));
+
+		for (i = 0; i < ref_list.index; i++) {
+			struct ref_item *item = &ref_list.list[i];
+			struct commit *commit = item->commit;
+			int is_merged = !!(commit->object.flags & UNINTERESTING);
+			item->ignore = is_merged != (merge_filter == SHOW_MERGED);
+		}
+
+		for (i = 0; i < ref_list.index; i++) {
+			struct ref_item *item = &ref_list.list[i];
+			clear_commit_marks(item->commit, ALL_REV_FLAGS);
+		}
+		clear_commit_marks(filter, ALL_REV_FLAGS);
+
 		if (verbose)
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 141b061..912a663 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -130,4 +130,33 @@ test_expect_success 'implicit --list conflicts with modification options' '
 
 '
 
+# We want to set up a case where the walk for the tracking info
+# of one branch crosses the tip of another branch (and make sure
+# that the latter walk does not mess up our flag to see if it was
+# merged).
+#
+# Here "topic" tracks "master" with one extra commit, and "zzz" points to the
+# same tip as master The name "zzz" must come alphabetically after "topic"
+# as we process them in that order.
+test_expect_success 'branch --merged with --verbose' '
+	git branch --track topic master &&
+	git branch zzz topic &&
+	git checkout topic &&
+	test_commit foo &&
+	git branch --merged topic >actual &&
+	cat >expect <<-\EOF &&
+	  master
+	* topic
+	  zzz
+	EOF
+	test_cmp expect actual &&
+	git branch --verbose --merged topic >actual &&
+	cat >expect <<-\EOF &&
+	  master c77a0a9 second on master
+	* topic  2c939f4 [ahead 1] foo
+	  zzz    c77a0a9 second on master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.0.486.g83bb229
