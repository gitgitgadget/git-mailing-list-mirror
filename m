Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2221F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfJ2UYz (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:24:55 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.99]:31756 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJ2UYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:24:54 -0400
Received: from [84.175.178.241] (helo=[192.168.2.6])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iPY2t-0006Wi-NB; Tue, 29 Oct 2019 21:24:51 +0100
Subject: Re: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
 <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
 <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
 <20191029200936.GA12337@sigill.intra.peff.net>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <56f1bb8c-c4dc-4537-b42b-e728d2f2df19@syntevo.com>
Date:   Tue, 29 Oct 2019 21:24:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029200936.GA12337@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.10.2019 21:09, Jeff King wrote:

> I think the issue is not the comparison, but rather that forming the
> pointer "msg + off" is undefined, since its point outside of any object
> (including the "one past" rule). And this is illegal in both C and C++,

Yes, thanks for clarifying.

 > +    p = msg + off < pend ? msg + off : pend - 1;

 > though of course it works fine in practice most of the time.

The easiest thing that an optimizer can do (and that's actually quite 
likely in my understanding) is to conclude that 'msg + off' is the only 
non-UB branch here, therefore 'msg + off < pend' can be taken as always 
true, and then discard 'pend - 1' branch. Afterall, UB serve the biggest 
role in optimizations.

That's even more true now that all parts of equation are local and easy 
to grasp for static analysis.
