Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB2D1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 06:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbeKVRWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 12:22:36 -0500
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:47589
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbeKVRWg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 12:22:36 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2018 12:22:36 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PibxgzMibmt8MPibzgmAou; Wed, 21 Nov 2018 23:37:16 -0700
Date:   Thu, 22 Nov 2018 08:37:14 +0200
From:   Max Kirillov <max@max630.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181122063714.GE5348@jessie.local>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
 <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMSpQw0VuWspXvM+3W01RdXn7YcCNLJiv6V5wf/guEvXNLxX6JOSb+CJ4m1SYwhCw22Z1M+swquNRSfGdUHq/v+RFgcEM0CU+/+9DnbDrSOZItN/o/AI
 CpUs95cRtt5AeaAdqSAIT2y0Y/972LcYuxKdIjjSdsdqbrYlfyinN/QvltJIVpTSpTuiwndzrHGJ4rPr5lQMlGHF2ZM1Ovw53NqQKedGpUVo7FOfNpUipGx4
 78EonqO3yfXx+CSXLDdEaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 05:04:25PM -0800, Carlo Arenas wrote:
> the error that gets eventually to stderr in the caller comes from
> get_packet_data, who is trying to read 4 bytes and gets 0.
> when looking at the trace (obtained with ktrace)

Yes too early close of the input data is the thing which
triggers the "remote end hung up unexpectedly" message.

> I see there is no
> longer any other process running,

do you mean git receive-pack? This is strange, all its
parents should be waiting for it to exit.

> the last child of it is long gone with an error as shown by :
> 
>   9255      1 git-http-backend CALL  close(1)
...
>   9255      1 git-http-backend CALL  write(2,0xbfb2a604,0x36)
>   9255      1 git-http-backend GIO   fd 2 wrote 54 bytes
>        "fatal: request ended in the middle of the gzip stream\n"

This should be some other test than push_plain, some of the
gzip related ones. Are there other tests failing?

>   9255      1 git-http-backend RET   write 54/0x36
>   9255      1 git-http-backend CALL  write(1,0xb781f0e0,0x94)
>   9255      1 git-http-backend RET   write -1 errno 9 Bad file descriptor

This is interesting. http-backend for some reason closes its
stdout. Here it then tries to write there something. I have
not seen it in my push_plain run. Maybe it worth redirecting instead
to stderr, to avoid losing some diagnostics?

> 
> not sure how it got into that state, though
> 
> Carlo
