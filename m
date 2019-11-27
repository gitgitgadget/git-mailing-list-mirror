Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E9C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 23:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E6C2086A
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 23:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfK0Xps (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:45:48 -0500
Received: from mailout08.hostingdiscounter.nl ([91.217.57.99]:57066 "EHLO
        mailout08.hostingdiscounter.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfK0Xps (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Nov 2019 18:45:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTP id 47164C28;
        Thu, 28 Nov 2019 00:45:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mailout08.hostingdiscounter.nl
Received: from mailout08.hostingdiscounter.nl ([127.0.0.1])
        by localhost (mailout08.hostingdiscounter.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fwLA+I9mWrJB; Thu, 28 Nov 2019 00:45:20 +0100 (CET)
Received: from mail41.hostingdiscounter.nl (mail41.hostingdiscounter.nl [IPv6:2a00:1478:200:0:f:1053:0:1])
        by mailout08.hostingdiscounter.nl (Postfix) with ESMTPS;
        Thu, 28 Nov 2019 00:45:20 +0100 (CET)
Received: from [192.168.1.105] (130-208-201-31.ftth.glasoperator.nl [31.201.208.130])
        by mail41.hostingdiscounter.nl (Postfix) with ESMTPSA id B60AD4054C;
        Thu, 28 Nov 2019 00:45:53 +0100 (CET)
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
 <20191127112150.GA22221@sigill.intra.peff.net>
From:   Ruud van Asseldonk <dev@veniogames.com>
Message-ID: <55d0bcd1-1f15-46ff-42f1-be87eedc2e11@veniogames.com>
Date:   Thu, 28 Nov 2019 00:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127112150.GA22221@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmm. I don't think that technique gives complete coverage. There are
> other scripts (e.g., filter-branch) that call a bare "perl" (not
> PERL_PATH), which presumably pass the tests even though they'd break in
> a real-world system without perl. In fact, many scripts used to do this
> before fcb06a8d54 (use @@PERL@@ in built scripts, 2013-10-28). I don't
> think the effects on NO_PERL were really considered there; it was more
> about finding the right perl.

Hmm, filter-branch calls bare "perl", not @@PERL@@ or Perl at an 
absolute path. At first I thought that made it pass when "perl" is on 
the PATH in tests. But even when I replace those with @@PERL@@, the test 
still pass. I will investigate further.

> I think NO_PERL has historically mostly meant "do not build or install
> perl scripts", and not "everything ought to run fine without perl".
> We've generally assumed you can run vanilla perl snippets from the
> command line the same way you'd run awk or sed (and the tests use this
> extensively, which is why you have to set PERL_PATH again to run them)
> That said, most of those casual uses of perl in actual built scripts
> have gone away because the shell scripts have gone away. It looks like
> filter-branch, request-pull, and instaweb are the last holdouts. So
> maybe we should be treating NO_PERL as disabling those scripts, too.
> 
> But then, should we be doing more to make it clear that those scripts
> are broken in a NO_PERL build? Who knows what happens if you run
> filter-branch without any perl available?

My understanding was that NO_PERL controlled the runtime dependencies of 
Git, and that the tests require Perl either way. Of course, without Perl 
any scripts that depend on it can't be used, but like you say, there are 
few of them left. I think it would make sense to not install those 
scripts when NO_PERL=1. Should I make a patch to change that in the 
makefile?

Best,
Ruud
