Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C581F731
	for <e@80x24.org>; Thu,  1 Aug 2019 13:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfHAN0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 09:26:04 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.111]:56728 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbfHAN0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 09:26:04 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htB5k-0002yu-U0; Thu, 01 Aug 2019 15:26:00 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <20190731171956.GA26746@sigill.intra.peff.net>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
Date:   Thu, 1 Aug 2019 15:25:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731171956.GA26746@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.07.2019 19:19, Jeff King wrote:
> I don't have any real objection to adding stdin support for more
> commands. Bu tin the specific case you're discussing, it seems like
> using "git update-index" might already solve your problem. It's the
> intended plumbing for scripted index updates, and it already supports
> receiving paths from stdin.

I have now studied which git commands already use commandline splitting
in our application. For some of them, I didn't find comparable plumbing;
for others, I feel that a lot of new edge cases will arise, and it will
need a lot of testing to make sure things work as expected.

Therefore, for us it would be best if high-level commands also accepted
--stdin-paths. If I develop good enough patches for that, will you
accept them?

We're interested in these high-level commands:
1) git add
2) git rm
3) git checkout
4) git reset
5) git stash
6) git commit

Here's the list of detailed commands and plumbings I found:
01) git add
     'git update-index' doesn't seem to be able to skip ignored files.
02) git add --force
     Probably 'git update-index --add --stdin'.
03) git checkout
     Probably 'git checkout-index --stdin'
04) git checkout HEAD
     Didn't find a plumbing to only affect named paths.
05) git checkout --ours
     Probably 'git checkout-index --stage=2 --force --stdin'
06) git checkout --theirs
     Probably 'git checkout-index --stage=3 --force --stdin'
07) git rm [--force] [--cached]
     Probably 'git update-index --force-remove'
     Didn't find how to delete files from working tree.
08) git reset -q HEAD
     Didn't find a plumbing to only affect named paths.
09) git add --update
     Probably 'git update-index --again --add --stdin'
     Not sure that --again is good replacement.
10) git stash push [--keep-index] [--include-untracked] [--message]
     Didn't find plumbing for stashes.
11) git commit [--allow-empty] [--amend] [--signoff] [--no-verify]
       --file=CommitMessage.txt -o
     Didn't find a plumbing to only affect named staged paths.
