Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CE4201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbdBROSt (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 09:18:49 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:30302 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdBROSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 09:18:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vQX7T4rt0z5tl9;
        Sat, 18 Feb 2017 15:18:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 27FFB1E70;
        Sat, 18 Feb 2017 15:18:45 +0100 (CET)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
 <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
Date:   Sat, 18 Feb 2017 15:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.2017 um 12:15 schrieb Alex Hoffman:
> No one commented the fact, that I find this very confusing. Don't you
> find this confusing? I will underline, that 'git bisect good v.good'
> will fail if the commit 'v.good' is not a parent of the bad commit,
> meaning there MUST be at least a path between 'v.good' and 'v.bad',
> thus I would expect it looks on this path ONLY. Beside that, this is
> what I understand by 'binary search' (to search on this commit path).

But this is not how Git works. Git computes graph differences, i.e., it 
subtracts from the commits reachable from v.bad those that are reachable 
from v.good. This leaves more than just those on some path from v.good 
to v.bad. And it should work this way. Consider this history:

--o--o--o--G--X
    \           \
     x--x--x--x--X--B--

When you find B bad and G good, than any one of the x or X may have 
introduced the breakage, not just one of the X.

>> Correct. The assumption of bisection is that there is only one
>> transition between GOOD and BAD. By violating that assumption,
>> anything  can happen.
>
> I did not find that in the manpage or did I miss it? Why would someone
> assume that the commit graph looks in a certain way?

There is no restriction in the commit graph. The only restriction, 
actually assumption, is that there is *one* transition from good to bad 
and no transition from bad to good. Otherwise, bisection cannot work.

> I assume, that
> 'git bisect' was not thought through and that it considers the first
> directed path between v.good and v.bad, instead of all paths (in my
> example graph there are two such paths). I will also underline that
> git bisect was designed to work with multiple good commits and one bad
> commit (also multiple paths), but probably NOT with multiple paths
> between the same pair of good and bad commits.

Oh, IMO git bisect was well thought through. If it considered just paths 
from good to bad, it would not given the correct answer. See the example 
history above. Bisect authors would not have deemed that sufficiently 
good ;)

-- Hannes

