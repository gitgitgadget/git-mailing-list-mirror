Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD711F954
	for <e@80x24.org>; Wed, 22 Aug 2018 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeHVXRB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 19:17:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728163AbeHVXRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 19:17:01 -0400
Received: (qmail 28299 invoked by uid 109); 22 Aug 2018 19:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 19:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3571 invoked by uid 111); 22 Aug 2018 19:50:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 15:50:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 15:50:46 -0400
Date:   Wed, 22 Aug 2018 15:50:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] rev-list: make empty --stdin not an error
Message-ID: <20180822195045.GC19730@sigill.intra.peff.net>
References: <20180727174811.27360-1-avarab@gmail.com>
 <20180822174820.12909-1-szeder.dev@gmail.com>
 <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
 <20180822192308.GB19730@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180822192308.GB19730@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 03:23:08PM -0400, Jeff King wrote:

> > +	/* 
> > +	 * Even if revs->pending is empty after all the above, if we
> > +	 * handled "--stdin", then the caller really meant to give us
> > +	 * an empty commit range.  Just let the traversal give an
> > +	 * empty result without causing a "no input?  do you know how
> > +	 * to use this command?" failure.
> > +	 *
> > +	 * NOTE!!!  Because "--stdin </dev/null --default HEAD" should
> > +	 * default to HEAD, this must come _after_ the above block
> > +	 * that deals with revs->ref fallback.
> > +	 */
> > +	if (read_from_stdin)
> > +		revs->rev_input_given = 1;
> 
> I think this should do the right thing. All of the issues discussed in
> the earlier thread were about using revs->def, and this neatly sidesteps
> that by touching the flag afterwards. It's a little funny that the flag
> now means two things (earlier in the function it is "we should use the
> default" and later it becomes "the caller may complain").

Here's my "two flags" approach as a real patch. After giving it some
thought, I really do think it's cleaner.

I know we're in a freeze. If you want to pick this up for pu or maybe
next, that's fine. If not, I'll re-send it after the release. It applies
on top of Gábor's text fixup patch.

-- >8 --
Subject: [PATCH] rev-list: make empty --stdin not an error

When we originally did the series that contains 7ba826290a
(revision: add rev_input_given flag, 2017-08-02) the intent
was that "git rev-list --stdin </dev/null" would similarly
become a successful noop. However, an attempt at the time to
do that did not work[1]. The problem is that rev_input_given
serves two roles:

 - it tells rev-list.c that it should not error out

 - it tells revision.c that it should not have the "default"
   ref kick (e.g., "HEAD" in "git log")

We want to trigger the former, but not the latter. This is
technically possible with a single flag, if we set the flag
only after revision.c's revs->def check. But this introduces
a rather subtle ordering dependency.

Instead, let's keep two flags: one to denote when we got
actual input (which triggers both roles) and one for when we
read stdin (which triggers only the first).

This does mean a caller interested in the first role has to
check both flags, but there's only one such caller. And any
future callers might want to make the distinction anyway
(e.g., if they care less about erroring out, and more about
whether revision.c soaked up our stdin).

[1] https://public-inbox.org/git/20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net/

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c       | 2 +-
 revision.c               | 1 +
 revision.h               | 5 +++++
 t/t6018-rev-list-glob.sh | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a2..ed0ea7dc5b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -493,7 +493,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr) &&
-	     !revs.rev_input_given) ||
+	     !revs.rev_input_given && !revs.read_from_stdin) ||
 	    revs.diff)
 		usage(rev_list_usage);
 
diff --git a/revision.c b/revision.c
index de4dce600d..4d53102cf4 100644
--- a/revision.c
+++ b/revision.c
@@ -2369,6 +2369,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				}
 				if (read_from_stdin++)
 					die("--stdin given twice?");
+				revs->read_from_stdin = 1;
 				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
diff --git a/revision.h b/revision.h
index 007278cc11..1225957927 100644
--- a/revision.h
+++ b/revision.h
@@ -82,6 +82,11 @@ struct rev_info {
 	 */
 	int rev_input_given;
 
+	/*
+	 * Whether we read from stdin due to the --stdin option.
+	 */
+	int read_from_stdin;
+
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 0bf10d0686..db8a7834d8 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -255,7 +255,7 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
-test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
+test_expect_success 'rev-list should succeed with empty output on empty stdin' '
 	git rev-list --stdin </dev/null >actual &&
 	test_must_be_empty actual
 '
-- 
2.19.0.rc0.412.g7005db4e88

