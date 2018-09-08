Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B3C1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 05:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeIHKZh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 06:25:37 -0400
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:51937
        "EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbeIHKZh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 06:25:37 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id yVzVfZz081XJgyVzXfDWu6; Fri, 07 Sep 2018 22:41:09 -0700
Date:   Sat, 8 Sep 2018 08:41:05 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180908054105.GC20545@jessie.local>
References: <20180906193516.28909-1-max@max630.net>
 <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
 <20180907032740.GA20545@jessie.local>
 <20180907033831.GB1383@sigill.intra.peff.net>
 <CAF7_NFRg8wOQ0JbjkJ2gpxKs+oh3s8qXVSPfsWSth2tiUK39hw@mail.gmail.com>
 <xmqqsh2ly6vw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh2ly6vw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfKq38z+i2VxGqeNI6KYoyUZoW/Pek3DOyFMbFD0Mq976upJc5Zp7PD8RUvWtJacxh54X/zW5I+ZWCYXBoHPqCZROck44HXoYggukHSx3NZZ7NF8XQGnK
 AoLGkPE1cxBLMkLiRFoH/Y3HPETsJQYtjT+hjEBTZ+IZ2iOvIp1/nmLot0YtFHDd7ncuKHThVUA/230oUwBU3YgTYjKoiry+O2AI3zKRtTke7R1xbE3DyP1o
 +o9L8Iwx12QbWV7Wq5FbBrJ24MkC4sFb6akc/Yl9OTzK23SdP3P3nslSm6p1GD0p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 02:49:23AM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> Actually, another reason for the latest issue was that CONTENT_LENGTH
>> is parsed for GET requests at all. It should be parsed only for POST
>> requests, or, rather, only for upoad-pack and receive-pack requests.
> 
> Not really.  The layered design of the HTTP protocol means that any
> request type can have non-empty body, but request types for which
> no semantics of the body is defined must ignore what is in the body,
> which in turn means we need to parse and pay attention to the
> content length etc. to find the end of the body, if only to ignore
> it.

I don't think it is git's job to police web server implementations,
especially considering that there is a gap between letter of RFC and
actual behavior.  Anyway, it only runs the check for "*/info/refs" GET
request, which ends up in get_info_refs(). Other GET requests do not
check CONTENT_LENGTH. Also, the version of service which is started from
get_info_refs() do not consume input (I think, actually, the
"--stateless-rpc" argument is not needed there).

> In any case, hopefully we can fix this before the final, as this is
> a regression introduced during this cycle?

Yes, I'm working on it.
