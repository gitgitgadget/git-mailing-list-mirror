Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE63D1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfIKRFU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 13:05:20 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:48451 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfIKRFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 13:05:20 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 13:05:19 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B4764A192E;
        Wed, 11 Sep 2019 18:58:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id GubxAFtftA-U; Wed, 11 Sep 2019 18:58:27 +0200 (CEST)
Subject: Re: git-send-email does not use conditional configuration
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <CANTPZbbLNJPEEeG8BgdDEVYS=gudz4SvqGe==28EQHXDXUxuwQ@mail.gmail.com>
 <20190911140833.GA13916@sigill.intra.peff.net>
From:   Konstantinos Dalamagkidis <konstantinos@dalamagkidis.info>
Message-ID: <d4717b7f-b7a4-208b-6b83-7993b6bd7886@dalamagkidis.info>
Date:   Wed, 11 Sep 2019 18:58:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190911140833.GA13916@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/19 4:08 PM, Jeff King wrote:
> On Wed, Sep 11, 2019 at 08:14:45AM +0200, Konstantinos Dalamagkidis wrote:
> 
>> In my git configuration, I have an includeif section for work
>> related repositories that configures the user and sendemail
>> sections.
> 
> What kind of includeIf are you using? Does it work with an
> unconditional include? This seems to work for me:
> 
>    $ git config --global include.path one
>    $ git config --file ~/one sendemail.smtpserver one.example.com
>    $ git send-email --dry-run -1 --to nobody | grep ^Server
>    Server: one.example.com
> 
>    $ git config --global includeIf.gitdir:$PWD/.path two
>    $ git config --file ~/two sendemail.smtpserver two.example.com
>    $ git send-email --dry-run -1 --to nobody | grep ^Server
>    Server: two.example.com
> 
> I.e. both unconditional and gitdir includes work for me. If you do
> something similar, what output do you get?

I am using "includeIf.gitdir:/work". I tried to reproduce it at my home 
workstation where I have the exact same configuration, but in the 
beginning I couldn't. Then I realized, that at work the /work folder is 
actually a symlink to a different directory. When I did the same at 
home, I could reproduce the issue:

% pwd
/work/repo
% git send-email --dry-run -1 --to nobody | grep ^From
From: Konstantinos Dalamagkidis <work-email@example.com>
% cd ../repo-symlink
% git send-email --dry-run -1 --to nobody | grep ^From
From: Konstantinos Dalamagkidis <personal-email@example.com>
% realpath .
/home/dalamagkidis/tmp/repo

It appears that git-config and git-send-email parse the gitdir slightly 
differently when it comes to symlinks. More specifically git-send-email 
uses the realpath of the repository to determine which configuration to 
use. It also explains why nobody came across this problem before.


Rgds
Konstantinos
