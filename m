Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E90120437
	for <e@80x24.org>; Fri, 13 Oct 2017 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757670AbdJMP1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 11:27:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753506AbdJMP1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 11:27:53 -0400
Received: (qmail 26111 invoked by uid 109); 13 Oct 2017 15:27:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 15:27:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26174 invoked by uid 111); 13 Oct 2017 15:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 11:27:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 11:27:45 -0400
Date:   Fri, 13 Oct 2017 11:27:45 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: [PATCH] revision: quit pruning diff more quickly when possible
Message-ID: <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net>
References: <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
 <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
 <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 10:26:46AM -0400, Jeff King wrote:

> On Fri, Oct 13, 2017 at 10:25:10AM -0400, Derrick Stolee wrote:
> 
> > This does appear to be the problem. The missing DIFF_OPT_HAS_CHANGES is
> > causing diff_can_quit_early() to return false. Due to the corner-case of the
> > bug it seems it will not be a huge performance improvement in most cases.
> > Still worth fixing and I'm looking at your suggestions to try and learn this
> > area better.
> 
> Yeah, I just timed some pathspec limits on linux.git, and it makes at
> best a fraction of a percent improvement (but any improvement is well
> within run-to-run noise). Which is not surprising.
> 
> I agree it's worth fixing, though.

Here it is cleaned up and with a commit message. There's another case
that can be optimized, too: --remove-empty with an all-deletions commit.
That's probably even more obscure and pathological, but it was easy to
cover in the same breath.

I didn't bother making a perf script, since this really isn't indicative
of real-world performance. If we wanted to do perf regression tests
here, I think the best path forward would be:

  1. Make sure there the perf tests cover pathspecs (maybe in p0001?).

  2. Make it easy to run the whole perf suite against a "bomb" repo.
     This surely isn't the only slow thing of interest.

-- >8 --
Subject: revision: quit pruning diff more quickly when possible

When the revision traversal machinery is given a pathspec,
we must compute the parent-diff for each commit to determine
which ones are TREESAME. We set the QUICK diff flag to avoid
looking at more entries than we need; we really just care
whether there are any changes at all.

But there is one case where we want to know a bit more: if
--remove-empty is set, we care about finding cases where the
change consists only of added entries (in which case we may
prune the parent in try_to_simplify_commit()). To cover that
case, our file_add_remove() callback does not quit the diff
upon seeing an added entry; it keeps looking for other types
of entries.

But this means when --remove-empty is not set (and it is not
by default), we compute more of the diff than is necessary.
You can see this in a pathological case where a commit adds
a very large number of entries, and we limit based on a
broad pathspec. E.g.:

  perl -e '
    chomp(my $blob = `git hash-object -w --stdin </dev/null`);
    for my $a (1..1000) {
      for my $b (1..1000) {
        print "100644 $blob\t$a/$b\n";
      }
    }
  ' | git update-index --index-info
  git commit -qm add

  git rev-list HEAD -- .

This case takes about 100ms now, but after this patch only
needs 6ms. That's not a huge improvement, but it's easy to
get and it protects us against even more pathological cases
(e.g., going from 1 million to 10 million files would take
ten times as long with the current code, but not increase at
all after this patch).

This is reported to minorly speed-up pathspec limiting in
real world repositories (like the 100-million-file Windows
repository), but probably won't make a noticeable difference
outside of pathological setups.

This patch actually covers the case without --remove-empty,
and the case where we see only deletions. See the in-code
comment for details.

Note that we have to add a new member to the diff_options
struct so that our callback can see the value of
revs->remove_empty_trees. This callback parameter could be
passed to the "add_remove" and "change" callbacks, but
there's not much point. They already receive the
diff_options struct, and doing it this way avoids having to
update the function signature of the other callbacks
(arguably the format_callback and output_prefix functions
could benefit from the same simplification).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.h     |  1 +
 revision.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/diff.h b/diff.h
index 7dcfcfbef7..4a34d256f1 100644
--- a/diff.h
+++ b/diff.h
@@ -180,6 +180,7 @@ struct diff_options {
 	pathchange_fn_t pathchange;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	void *change_fn_data;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
diff --git a/revision.c b/revision.c
index 8fd222f3bf..a3f245e2cc 100644
--- a/revision.c
+++ b/revision.c
@@ -399,8 +399,16 @@ static struct commit *one_relevant_parent(const struct rev_info *revs,
  * if the whole diff is removal of old data, and otherwise
  * REV_TREE_DIFFERENT (of course if the trees are the same we
  * want REV_TREE_SAME).
- * That means that once we get to REV_TREE_DIFFERENT, we do not
- * have to look any further.
+ *
+ * The only time we care about the distinction is when
+ * remove_empty_trees is in effect, in which case we care only about
+ * whether the whole change is REV_TREE_NEW, or if there's another type
+ * of change. Which means we can stop the diff early in either of these
+ * cases:
+ *
+ *   1. We're not using remove_empty_trees at all.
+ *
+ *   2. We saw anything except REV_TREE_NEW.
  */
 static int tree_difference = REV_TREE_SAME;
 
@@ -411,9 +419,10 @@ static void file_add_remove(struct diff_options *options,
 		    const char *fullpath, unsigned dirty_submodule)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
+	struct rev_info *revs = options->change_fn_data;
 
 	tree_difference |= diff;
-	if (tree_difference == REV_TREE_DIFFERENT)
+	if (!revs->remove_empty_trees || tree_difference != REV_TREE_NEW)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
@@ -1351,6 +1360,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	DIFF_OPT_SET(&revs->pruning, QUICK);
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
+	revs->pruning.change_fn_data = revs;
 	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs->dense = 1;
 	revs->prefix = prefix;
-- 
2.15.0.rc1.395.ga4290b5804

