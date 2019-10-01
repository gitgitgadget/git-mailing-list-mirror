Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C701F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 14:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfJAOtm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 10:49:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727137AbfJAOtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 10:49:42 -0400
Received: (qmail 12202 invoked by uid 109); 1 Oct 2019 14:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 01 Oct 2019 14:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12343 invoked by uid 111); 1 Oct 2019 14:52:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Oct 2019 10:52:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Oct 2019 10:49:41 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-recursive: fix the diff3 common ancestor label
 for virtual commits
Message-ID: <20191001144940.GH10875@sigill.intra.peff.net>
References: <20190930225455.6208-1-newren@gmail.com>
 <20191001065849.29491-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001065849.29491-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 11:58:49PM -0700, Elijah Newren wrote:

> In commit 743474cbfa8b ("merge-recursive: provide a better label for
> diff3 common ancestor", 2019-08-17), the label for the common ancestor
> was changed from always being
> 
>          "merged common ancestors"
> 
> to instead be based on the number of merge bases:
> 
>     >=2: "merged common ancestors"
>       1: <abbreviated commit hash>
>       0: "<empty tree>"
> 
> Unfortunately, this did not take into account that when we have a single
> merge base, that merge base could be fake or constructed.  In such
> cases, this resulted in a label of "00000000".  Of course, the previous
> label of "merged common ancestors" was also misleading for this case.

Yeah, I agree the original was not great, either, but the "0000000"
looked like a bug to me. Hey, at least we didn't segfault! :)

> Since we have an API that is explicitly about creating fake merge base
> commits in merge_recursive_generic(), we should provide a better label
> when using that API with one merge base.  So, when
> merge_recursive_generic() is called with one merge base, set the label
> to:
> 
>          "constructed merge base"

That makes perfect sense to me. Thanks for the quick turnaround.

> Changes since v1:
>   - We only had a problem if the number of fake merge bases was exactly
>     one; update the patch to check for that and update the commit message
>     accordingly.

That makes sense. We'd still want to say "merged common ancestors" even
if one of those ancestors was fake.

>  merge-recursive.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

The patch itself looks good to me (though admittedly I'm not too
familiar with this area).

Maybe worth squashing in this test?

diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 3fb68e0aae..860542aad0 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,4 +186,17 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
+test_expect_success 'rebase describes fake ancestor base' '
+	test_create_repo rebase &&
+	(
+		cd rebase &&
+		test_commit base file &&
+		test_commit master file &&
+		git checkout -b side HEAD^ &&
+		test_commit side file &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		grep "||||||| constructed merge base" file
+	)
+'
+
 test_done

-Peff
