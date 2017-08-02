Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDB020899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdHBWeT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:56304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751073AbdHBWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:34:18 -0400
Received: (qmail 4318 invoked by uid 109); 2 Aug 2017 22:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14181 invoked by uid 111); 2 Aug 2017 22:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:34:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:34:16 -0400
Date:   Wed, 2 Aug 2017 18:34:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH DONOTAPPLY 5/4] revision: let --stdin set rev_input_given
Message-ID: <20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 06:24:25PM -0400, Jeff King wrote:

> I noticed that:
> 
>   git log --tags=does-not-exist
> 
> will show all of HEAD, which is rather confusing. This fixes it, and
> also hits several other cases that were marked as expect_failure for
> rev-list. There is one case it doesn't handle: --stdin. It's not clear
> to me what the right behavior is there. I'll follow up with more
> discussion.

So here that is. The patch below is what I had intended to send, but I
found some interesting corner cases.

This patch makes "rev-list --stdin </dev/null" return an empty set.
Which makes sense to me. But a side effect is that:

  git log --stdin </dev/null

now shows nothing (rather than HEAD). I think that's probably the right
thing. But:

  (echo --; echo t) | git log --stdin

no longer defaults to HEAD. Which maybe people would see as a
regression. I could see arguments either way.

But this also breaks filter-branch (or at least a few of its tests),
which really wants to do:

  git rev-list --default HEAD --stdin <maybe-empty

and traverse HEAD. I didn't dig enough to see if it's actually sane or
not. The failing tests seem to be weird noop filters that our test
script uses. But I'm worried it would break some real case, too.

-- >8 --
Subject: [PATCH] revision: let --stdin set rev_input_given

Currently "git rev-list --stdin </dev/null" returns a usage
error.

This is similar to the "rev-list --glob=does-not-exist" case
we fixed recently: in both cases the user tried to give us
some input, but it happened to be empty. But what we should
do in that case is less clear than with ref patterns like
"--glob". In those cases the user clearly asked us
to look for something which turned out to be the empty set,
and we now handle that by returning an empty output.

With --stdin, on the other hand, they just asked us to take
input from a different place. So one could argue that a
totally empty input is still a usage problem. Or even that:

  (
    # no commits!
    echo "--"
    echo "pathspec"
  ) | git rev-list --stdin

should complain, because they gave us no starting points.

But in practice that distinction isn't really helpful.
Giving "--stdin" does show a conscious effort to provide
some input (so showing the usage message is likely to be
annoying and useless). And it's handy for scripted callers
to be able to map an empty input to an empty output; it's
one less corner case for them to worry about.

So let's treat "--stdin" as "giving input", even if it's
empty.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c               | 1 +
 t/t6018-rev-list-glob.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ba2b166cd..6a1ccd407 100644
--- a/revision.c
+++ b/revision.c
@@ -2253,6 +2253,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				}
 				if (read_from_stdin++)
 					die("--stdin given twice?");
+				revs->rev_input_given = 1;
 				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index d3453c583..bd300521b 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -255,7 +255,7 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
-test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
+test_expect_success 'rev-list should succeed with empty output on empty stdin' '
 	>expect &&
 	git rev-list --stdin <expect >actual &&
 	test_cmp expect actual
-- 
2.14.0.rc1.586.g00244b0b6

