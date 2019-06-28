Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5694E1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF1Jhy (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:37:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:53708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbfF1Jhy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:37:54 -0400
Received: (qmail 14436 invoked by uid 109); 28 Jun 2019 09:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 09:37:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16071 invoked by uid 111); 28 Jun 2019 09:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 05:38:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 05:37:52 -0400
Date:   Fri, 28 Jun 2019 05:37:52 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 0/6] easy bulk commit creation in tests
Message-ID: <20190628093751.GA3569@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064103.GA19777@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628064103.GA19777@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 02:41:03AM -0400, Jeff King wrote:

> I think this would exercise it, at the cost of making the test more
> expensive:
> 
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 82d7f7f6a5..8ed6982dcb 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -21,7 +21,7 @@ has_any () {
>  }
>  
>  test_expect_success 'setup repo with moderate-sized history' '
> -	for i in $(test_seq 1 10)
> +	for i in $(test_seq 1 100)
>  	do
>  		test_commit $i
>  	done &&
> 
> It would be nice if we had a "test_commits_bulk" that used fast-import
> to create larger numbers of commits.

So here's a patch to do that. Writing the bulk commit function was a fun
exercise, and I found a couple other places to apply it, too, shaving
off ~7.5 seconds from my test runs. Not ground-breaking, but I think
it's nice to have a solution where we don't have to be afraid to
generate a bunch of commits.

I'm sure there are other spots that could be converted, too (either ones
that are slow loops now, or ones that use fast-import themselves but
could be made more readable by using the helper), but I stopped digging
after finding the low-hanging fruit here.

  [1/6]: test-lib: introduce test_commit_bulk
  [2/6]: t5310: increase the number of bitmapped commits
  [3/6]: t3311: use test_commit_bulk
  [4/6]: t5702: use test_commit_bulk
  [5/6]: t5703: use test_commit_bulk
  [6/6]: t6200: use test_commit_bulk

 t/t3311-notes-merge-fanout.sh      |  10 +--
 t/t5310-pack-bitmaps.sh            |  15 +---
 t/t5702-protocol-v2.sh             |  10 +--
 t/t5703-upload-pack-ref-in-want.sh |   4 +-
 t/t6200-fmt-merge-msg.sh           |   7 +-
 t/test-lib-functions.sh            | 131 +++++++++++++++++++++++++++++
 6 files changed, 144 insertions(+), 33 deletions(-)

-Peff
