Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC34C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3218E206BE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=artfulrobot.uk header.i=@artfulrobot.uk header.b="l6/SDTIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1Gnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 02:43:39 -0400
Received: from mail.artfulrobot.uk ([185.13.148.55]:56936 "EHLO
        ar4.artfulrobot.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1Gnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 02:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=artfulrobot.uk; s=20151210; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tBnBKVaQoBvgULDMBzwadg329Kr3IXJXJgxHHRSO3ko=; b=l6/SDTIE10fxibpNT0HRB/Ghiv
        1bMkNJ3o7WZ587XX9f5BqoTZPTs7Q2DfL8Gemm2JNw9M5AYG/LhdNVSbTO7JrlvWVgRXZDN2NUmLg
        Da1Rgd6XsrmOXX4IcJoXg3lKH+fzS3V2OBB7peTL1ORR3tdjuX3eR9AI8N/vFOSezs4M=;
Received: from shinyblue.plus.com ([81.174.169.217] helo=[192.168.1.118])
        by mail.artfulrobot.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <forums@artfulrobot.uk>)
        id 1kMmsq-0001xW-Re; Mon, 28 Sep 2020 07:43:36 +0100
Subject: Re: Segfault during fsck and spreading brokenness
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <2aa62ff7-0780-8e20-e87d-387152524971@artfulrobot.uk>
 <20200925174718.GA70005@coredump.intra.peff.net>
From:   Rich <forums@artfulrobot.uk>
Message-ID: <5cb3e4da-05ef-ac6a-2b8c-fab3137cdc68@artfulrobot.uk>
Date:   Mon, 28 Sep 2020 07:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925174718.GA70005@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Thanks for a friendly and welcoming response (I was a bit scared posting 
here I suppose because the project's creator has a rep for not suffering 
fools!).

I copied the repo that causes a segfault on 2.11.0 to my laptop which 
runs 2.25.1 and I'm pleased to report that there's no segfault. I've 
posted the errors it does show below this message in case they're useful.

>   What transport do you use between the two servers? The usual
> git-over-ssh and git-over-http protocols should be pretty resilient, but
> I would not be surprised if the old dumb-http protocol, which just
> downloads remote files wholesale, would be confused by a zero-length
> loose object file or similar.

The two servers are connected by SSH. As in:

% git config remote.origin.url sshalias:path/to/repo

where sshalias is defined in my .ssh/config file.

To test again,I made a bare clone of the fixed repo on my 2.25.1 host. I 
still had some dangling trees/blobs so I ran the following to make sure 
we were all clean:

git reflog expire --expire-unreachable=now --all
git gc --prune=now
git fsck --full


Then I added the broken repo as a remote (ssh) repo and ran fetch, which 
crashed (presumably correctly):

% git fetch broke
error: object file ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833 
is empty
error: object file ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833 
is empty
fatal: loose object 3e9c7cd338d2ea3603d0c23b4b56902a04937833 (stored in 
./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833) is corrupt
fatal: the remote end hung up unexpectedly

I re-ran fsck and it was still all clean. So 2.25.1 seems safe.I 
repeated the same procedure on the 2.11.0 version (Debian 10 host), and 
the same thing happened.

So I'm not sure what happened with the two repos getting broken at once; 
can't repeat it.

Let's hope that this was something that was fixed as you say!

Thanks,
Rich




## Errors shown when running fsck on 2.25.1 on the broken repo:

git --version
git version
% git fsck --full
error: object file ./objects/14/2d73242bba1e4aee89a887ec37d3b1ef00461c 
is empty
error: unable to mmap 
./objects/14/2d73242bba1e4aee89a887ec37d3b1ef00461c: No such file or 
directory
error: 142d73242bba1e4aee89a887ec37d3b1ef00461c: object corrupt or 
missing: ./objects/14/2d73242bba1e4aee89a887ec37d3b1ef00461c
error: object file ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833 
is empty
error: unable to mmap 
./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833: No such file or 
directory
error: 3e9c7cd338d2ea3603d0c23b4b56902a04937833: object corrupt or 
missing: ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833
error: object file ./objects/45/aaa8e78abffa54ee2a620ef453d2b73443a3f9 
is empty
error: unable to mmap 
./objects/45/aaa8e78abffa54ee2a620ef453d2b73443a3f9: No such file or 
directory
error: 45aaa8e78abffa54ee2a620ef453d2b73443a3f9: object corrupt or 
missing: ./objects/45/aaa8e78abffa54ee2a620ef453d2b73443a3f9
error: object file ./objects/51/c79dda59372c0bd44457fbf810c66a6b184bb4 
is empty
error: unable to mmap 
./objects/51/c79dda59372c0bd44457fbf810c66a6b184bb4: No such file or 
directory
error: 51c79dda59372c0bd44457fbf810c66a6b184bb4: object corrupt or 
missing: ./objects/51/c79dda59372c0bd44457fbf810c66a6b184bb4
error: object file ./objects/92/92c90c7f01b5f9252a4631071d8ed39b121d52 
is empty
error: unable to mmap 
./objects/92/92c90c7f01b5f9252a4631071d8ed39b121d52: No such file or 
directory
error: 9292c90c7f01b5f9252a4631071d8ed39b121d52: object corrupt or 
missing: ./objects/92/92c90c7f01b5f9252a4631071d8ed39b121d52
error: object file ./objects/a0/1c6d43bb04b86b8263848c9d8daa20d4a68be4 
is empty
error: unable to mmap 
./objects/a0/1c6d43bb04b86b8263848c9d8daa20d4a68be4: No such file or 
directory
error: a01c6d43bb04b86b8263848c9d8daa20d4a68be4: object corrupt or 
missing: ./objects/a0/1c6d43bb04b86b8263848c9d8daa20d4a68be4
error: object file ./objects/c6/480c5f0be01c6860a17123bef79aa3fb98dd8b 
is empty
error: unable to mmap 
./objects/c6/480c5f0be01c6860a17123bef79aa3fb98dd8b: No such file or 
directory
error: c6480c5f0be01c6860a17123bef79aa3fb98dd8b: object corrupt or 
missing: ./objects/c6/480c5f0be01c6860a17123bef79aa3fb98dd8b
error: object file ./objects/e7/e8f34edee57ed77b240fa024df2f472dd9776d 
is empty
error: unable to mmap 
./objects/e7/e8f34edee57ed77b240fa024df2f472dd9776d: No such file or 
directory
error: e7e8f34edee57ed77b240fa024df2f472dd9776d: object corrupt or 
missing: ./objects/e7/e8f34edee57ed77b240fa024df2f472dd9776d
Checking object directories: 100% (256/256), done.
Checking objects: 100% (310949/310949), done.
error: object file ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833 
is empty
error: object file ./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833 
is empty
fatal: loose object 3e9c7cd338d2ea3603d0c23b4b56902a04937833 (stored in 
./objects/3e/9c7cd338d2ea3603d0c23b4b56902a04937833) is corrupt

