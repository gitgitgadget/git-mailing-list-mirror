Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC1C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8758261214
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhHYBgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:36:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhHYBgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:36:39 -0400
Received: (qmail 21332 invoked by uid 109); 25 Aug 2021 01:35:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 01:35:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4230 invoked by uid 111); 25 Aug 2021 01:35:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 21:35:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 21:35:52 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
Message-ID: <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
 <xmqq8s0rpwiw.fsf@gitster.g>
 <20210824185942.GE2257957@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210824185942.GE2257957@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 08:59:42PM +0200, SZEDER Gábor wrote:

> > Unlike the apparent
> > copy-and-paste source, this is a more modern script that limits the
> > chdir inside subshells to avoid moving around in the main flow of
> > the test, and the fix proposed here looks the most sensible.  
> 
> 'grep " cd $" test-results/*.out' shows that there is a similar case
> in 't5323-pack-redundant.sh' as well, in test 'master: pack-redundant
> works with no packfile'.

Hmm. I think that one is different, in that the "cd" is not redundant,
but wrong. But it turns out not to matter to the test. ;)

-- >8 --
Subject: [PATCH] t5323: drop mentions of "master"

Commit 0696232390 (pack-redundant: fix crash when one packfile in repo,
2020-12-16) added one some new tests to t5323. At the time, the sub-repo
we used was called "master". But in a parallel branch, this was switched
to "main".

When the latter branch was merged in 27d7c8599b (Merge branch
'js/default-branch-name-tests-final-stretch', 2021-01-25), some of those
spots caused textual conflicts, but some (for tests that were far enough
away from other changed code) were just semantic. The merge resolution
fixed up most spots, but missed this one.

Even though this did impact actual code, it turned out not to fail the
tests. Running 'cd "$master_repo"' ended up staying in the same
directory, running the test in the main trash repo instead of the
sub-repo. But because the point of the test is checking behavior when
there are no packfiles, it worked in either repo (since both are empty
at this point in the script).

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5323-pack-redundant.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 8b01793845..8dbbcc5e51 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -114,9 +114,9 @@ test_expect_success 'setup main repo' '
 	create_commits_in "$main_repo" A B C D E F G H I J K L M N O P Q R
 '
 
-test_expect_success 'master: pack-redundant works with no packfile' '
+test_expect_success 'main: pack-redundant works with no packfile' '
 	(
-		cd "$master_repo" &&
+		cd "$main_repo" &&
 		cat >expect <<-EOF &&
 			fatal: Zero packs found!
 			EOF
-- 
2.33.0.394.gce7abe507a

