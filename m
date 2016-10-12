Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78137209F6
	for <e@80x24.org>; Wed, 12 Oct 2016 20:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934141AbcJLUR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 16:17:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934094AbcJLURY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 16:17:24 -0400
Received: (qmail 25348 invoked by uid 109); 12 Oct 2016 20:10:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 20:10:42 +0000
Received: (qmail 23568 invoked by uid 111); 12 Oct 2016 20:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 16:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 16:10:40 -0400
Date:   Wed, 12 Oct 2016 16:10:40 -0400
From:   Jeff King <peff@peff.net>
To:     Stepan Kasal <kasal@ucw.cz>
Cc:     John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: [PATCH] merge-base: handle --fork-point without reflog
Message-ID: <20161012201040.pyrp6bktz3fgmqzn@sigill.intra.peff.net>
References: <20161012103716.GA31533@ucw.cz>
 <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 12:32:09PM -0400, Jeff King wrote:

> > The problem seems to be that command
> >   git merge-base --fork-point refs/remotes/origin/tmp refs/heads/tmp
> > returns nothing, because the refs are packed.
> 
> The --fork-point option looks in the reflog to notice that the upstream
> branch has been rebased. I don't think clone actually writes reflog
> entries, though, which would explain why it happens only on the first
> pull after clone.
> 
> I suspect the necessary information _is_ there, though. When we update
> the tracking branch, the new reflog entry will show it going from sha1
> X to sha1 Y. So my guess is that --fork-point is looking for the entry
> where it became "X" (which doesn't exist, because clone did not write
> it), but it _could_ find that we came from "X" in the very first reflog
> entry.

Actually, --fork-point gets this case right; it will put the "old" sha1
for the initial reflog entry into the list of base tips. But this
merge-base actually runs before we fetch, so there literally is no
reflog when it runs. And it doesn't get that case right.

Here's a fix. The test I added checks things more directly, but I
confirmed manually that it also fixes the rebase case that you reported.

-- >8 --
Subject: merge-base: handle --fork-point without reflog

The --fork-point option looks in the reflog to try to find
where a derived branch forked from a base branch. However,
if the reflog for the base branch is totally empty (as it
commonly is right after cloning, which does not write a
reflog entry), then our for_each_reflog call will not find
any entries, and we will come up with no merge base, even
though there may be one with the current tip of the base.

We can fix this by just adding the current tip to
our list of collected entries.

Signed-off-by: Jeff King <peff@peff.net>
---
It would actually be correct to just unconditionally add the ref tip, as
add_one_commit already drops duplicates. But it would only be necessary
in other cases if you have a broken reflog which is missing the entry
that moved us to the current tip.

 builtin/merge-base.c  | 3 +++
 t/t6010-merge-base.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c0d1822..b572a37 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -173,6 +173,9 @@ static int handle_fork_point(int argc, const char **argv)
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
+	if (!revs.nr && !get_sha1(refname, sha1))
+		add_one_commit(sha1, &revs);
+
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index e0c5f44..31db7b5 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -260,6 +260,12 @@ test_expect_success 'using reflog to find the fork point' '
 	test_cmp expect3 actual
 '
 
+test_expect_success '--fork-point works with empty reflog' '
+	git -c core.logallrefupdates=false branch no-reflog base &&
+	git merge-base --fork-point no-reflog derived &&
+	test_cmp expect3 actual
+'
+
 test_expect_success 'merge-base --octopus --all for complex tree' '
 	# Best common ancestor for JE, JAA and JDD is JC
 	#             JE
-- 
2.10.1.587.g4098016

