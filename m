Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643561F462
	for <e@80x24.org>; Thu,  6 Jun 2019 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfFFRfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 13:35:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:48124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726863AbfFFRfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 13:35:19 -0400
Received: (qmail 15812 invoked by uid 109); 6 Jun 2019 17:35:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jun 2019 17:35:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31570 invoked by uid 111); 6 Jun 2019 17:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Jun 2019 13:36:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jun 2019 13:35:17 -0400
Date:   Thu, 6 Jun 2019 13:35:17 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: Git self test failure on Solaris 11.3
Message-ID: <20190606173516.GA25089@sigill.intra.peff.net>
References: <CAH8yC8kynjwT8wbHYV0DpDaMX=AnfmXeOci3uYUnnfsvbq4iRg@mail.gmail.com>
 <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
 <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 06, 2019 at 01:18:01PM -0400, Eric Sunshine wrote:

> > > not ok 12 - check normal git operations: twelve packs
> > > #
> > > #                       midx_git_two_modes "rev-list --objects --all" &&
> > > #                       midx_git_two_modes "log --raw" &&
> > > #                       midx_git_two_modes "count-objects --verbose" &&
> > > #                       midx_git_two_modes "cat-file
> > > --batch-all-objects --buffer --batch-check" &&
> > > #                       midx_git_two_modes "cat-file
> > > --batch-all-objects --buffer --batch-check --unsorted" sorted
> > > #
> [...]
> 
> Jeff Walton reported this to me privately. I'm not familiar with this
> code and don't have time presently to investigate it, so I'm
> forwarding it to the list in the hope that someone who knows the code
> intimately (Stolee) or someone who has touched this code (Peff) might
> have some idea about it. The failure is intermittent, so perhaps the
> output of some command is not stable sort-wise(?).

I can't seem to get it to fail for me, even under high load. Do you know
which of those commands is failing (i.e., what does "-v -x" say)?

If it's the rev-list or log output, it could be due to traversal order.
I notice that the commit creation doesn't increment the timestamps. This
might help:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 70926b5bc0..79aa97efce 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -60,6 +60,7 @@ commit_and_list_objects () {
 	} >file_101 &&
 	git update-index --add file_101 &&
 	tree=$(git write-tree) &&
+	test_tick &&
 	commit=$(git commit-tree $tree -p HEAD</dev/null) &&
 	{
 		echo $tree &&

Though I think in each case that the results should be deterministic for
a given set of commits (and the tests here are just running over the
same set of commits with and without midx; so we should see the same
output in both cases).

The normal "cat-file" output should be sorted by sha1, so should be
stable. The unsorted output will be in whatever order we happen to hit
the packfiles, which _would_ be subject to timestamp variations.
However, Jeffrey's email mentions Git 2.21, which predates my b4a14394af
(t5319: fix bogus cat-file argument, 2019-04-05). So before that,
"cat-file --unsorted" should always be producing no output. :)

After the switch to correctly use --unordered, I could believe there
might be a timestamp issue, but the "sorted" flag there means that we
should be sorting the output before comparing.

I can't reproduce the intermittent failure either on 2.21.0, or with
v2.22.0-rc3.

-Peff
