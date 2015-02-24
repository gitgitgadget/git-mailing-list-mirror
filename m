From: Jeff King <peff@peff.net>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 18:47:37 -0500
Message-ID: <20150224234737.GA8370@peff.net>
References: <20150224214311.GA8622@peff.net>
 <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
 <20150224224918.GA24749@peff.net>
 <xmqqd24yq517.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 00:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQPCb-0004dH-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 00:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbBXXrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 18:47:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:52941 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbbBXXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 18:47:39 -0500
Received: (qmail 13854 invoked by uid 102); 24 Feb 2015 23:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 17:47:39 -0600
Received: (qmail 10526 invoked by uid 107); 24 Feb 2015 23:47:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 18:47:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2015 18:47:37 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd24yq517.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264361>

On Tue, Feb 24, 2015 at 03:11:00PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm assuming there _is_ a sane sort order. We have two halves of a
> > filepair, but I think before any of the rename or break detection kicks
> > in, each pair should either:
> >
> >   1. Have a name in pair->one, and an invalid filespec in pair->two
> >      (i.e., a deletion).
> >
> >   2. The opposite (name in pair->two, /dev/null in pair->one). An
> >      addition.
> >
> >   3. The same name in pair->one and pair->two.
> 
> I think creation and deletion are expressed with mode=0 and not with
> /dev/null.

Yeah, or better spelled DIFF_FILE_VALID().

So here's a first stab at doing this. There are a couple of issues:

  1. It makes the check part of diffcore_std. My thinking was that we
     can actually correct some problems (like sort order) for all cases,
     and the duplicate check may want to disable more than renames
     (e.g., it could turn off any fancy features like break detection).

     It is possible to run diffcore_rename by itself, which would miss
     this protection. We don't seem to do that anywhere, though (even
     for try_to_follow_renames, we set up a new diff_options struct and
     just call diffcore_std).

  2. It disables rename detection by tweaking the diff_options struct.
     This is OK for a single diff, but I suspect is wrong for "git log",
     as we use the same diff_options for each (so one bogus diff would
     turn off renames for the rest of the commits). We can probably get
     around this by returning a "bogus, don't do renames" flag from
     diffcore_sanity and respecting it in diffcore_std.

  3. The sort order check is wrong. :-/ It needs to take into account
     git's magic "if it's a tree, pretend it has '/' after it" rule.
     That's not too hard for a single tree (fsck.c:verify_ordered does
     it). But for filepairs, I'm not sure what to do. Most cases
     have a single mode/name pair. But what about a D/F typechange? If
     "foo" becomes "foo/", which do I use to sort?

     I have a feeling the order in which we queue the pairs may even
     depend on the direction of the typechange. Or maybe it always
     matches the p->one version. I'll have to think on it.

I'm out of time to work on this tonight, but I'll try to get back to it
tomorrow. Any wisdom is appreciated.

---
diff --git a/Makefile b/Makefile
index 44f1dd1..838a21c 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
+LIB_OBJS += diffcore-sanity.o
 LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
diff --git a/diff.c b/diff.c
index d1bd534..5f7c43a 100644
--- a/diff.c
+++ b/diff.c
@@ -4768,6 +4768,7 @@ void diffcore_std(struct diff_options *options)
 	/* NOTE please keep the following in sync with diff_tree_combined() */
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
+	diffcore_sanity(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
 		if (options->break_opt != -1)
diff --git a/diffcore-sanity.c b/diffcore-sanity.c
new file mode 100644
index 0000000..ab770c9
--- /dev/null
+++ b/diffcore-sanity.c
@@ -0,0 +1,84 @@
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+
+enum sanity_check {
+	SANITY_OK,
+	SANITY_UNSORTED,
+	SANITY_DUPLICATES
+};
+
+static const char *filepair_name(const struct diff_filepair *p)
+{
+	/*
+	 * There's no point in checking that one or the other is valid;
+	 * that invariant is set by earlier code, not by the trees
+	 * themselves.
+	 */
+	if (!DIFF_FILE_VALID(p->one))
+		return p->two->path;
+	if (!DIFF_FILE_VALID(p->two))
+		return p->one->path;
+	/*
+	 * one->path should be the same as two->path here;
+	 * we could check, but again, this invariant comes
+	 * from our diff code, not the tree
+	 */
+	return p->one->path;
+}
+
+static enum sanity_check check_sanity(struct diff_queue_struct *q)
+{
+	int i;
+	for (i = 1; i < q->nr; i++) {
+		int cmp = strcmp(filepair_name(q->queue[i - 1]),
+				 filepair_name(q->queue[i]));
+		if (cmp == 0)
+			return SANITY_DUPLICATES;
+		if (cmp > 0)
+			return SANITY_UNSORTED;
+	}
+	return SANITY_OK;
+}
+
+int cmp_filepair(const void *va, const void *vb)
+{
+	const struct diff_filepair * const *a = va, * const *b = vb;
+	return strcmp(filepair_name(*a), filepair_name(*b));
+}
+
+static void sort_diff_queue(struct diff_queue_struct *q)
+{
+	qsort(q->queue, q->nr, sizeof(*q->queue), cmp_filepair);
+}
+
+void diffcore_sanity(struct diff_options *options)
+{
+	enum sanity_check check = check_sanity(&diff_queued_diff);
+
+	if (check == SANITY_OK)
+		return;
+
+	/*
+	 * We can fix sorting, but once fixed, we have to check
+	 * again to make sure we don't have duplicates, since
+	 * that relies on sort order.
+	 */
+	if (check == SANITY_UNSORTED) {
+		warning("diff entries are not sorted; your trees may be broken");
+		sort_diff_queue(&diff_queued_diff);
+		check = check_sanity(&diff_queued_diff);
+		if (check == SANITY_OK)
+			return;
+	}
+
+	/*
+	 * If we get here, we have duplicates. The rename code isn't ready
+	 * to handle this, so we have to turn it off.
+	 */
+	if (options->detect_rename) {
+		warning("duplicate tree entries found; disabling rename detection");
+		options->detect_rename = 0;
+	}
+	/* XXX break detection, too? */
+}
diff --git a/diffcore.h b/diffcore.h
index 33ea2de..fa359ce 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,6 +107,7 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+extern void diffcore_sanity(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
