Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1220EC433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E651C207D0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgFWTLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:11:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:40708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387445AbgFWTLo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:11:44 -0400
Received: (qmail 13209 invoked by uid 109); 23 Jun 2020 19:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 19:11:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19781 invoked by uid 111); 23 Jun 2020 19:11:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 15:11:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 15:11:43 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] pkt-line: use string versions of functions
Message-ID: <20200623191143.GE1444619@coredump.intra.peff.net>
References: <cover.1592119902.git.liu.denton@gmail.com>
 <cover.1592934880.git.liu.denton@gmail.com>
 <d283a1b514c46ed75d88918f136ca0a6f4b90adc.1592934880.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d283a1b514c46ed75d88918f136ca0a6f4b90adc.1592934880.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 01:55:33PM -0400, Denton Liu wrote:

>  void packet_flush(int fd)
>  {
> -	packet_trace("0000", 4, 1);
> -	if (write_in_full(fd, "0000", 4) < 0)
> -		die_errno(_("unable to write flush packet"));
> +	control_packet_write(fd, "0000", _("unable to write flush packet"));
>  }

I like this kind of abstraction much more than what was going on in the
previous patch.

> +#define control_packet_write(fd, s, errstr) \
> +	do { \
> +		(void)s"is a string constant"; \

This is a neat trick. It might be nice to wrap in
BUILD_ASSERT_IS_STRING_LITERAL() or similar. (Though I wonder a bit if
we even really need to assert that; wouldn't it be OK to use this
function without it? We're using strlen(), after all, and not sizeof).

Would it also be useful to assert that the length of the control packet
is 4? And likewise that it's less than 4? That seems much more
interesting to me (as we'd be violating the protocol otherwise). And
that would be easy to do if the we passed the packet number as an
integer and formatted it ourselves.

But the result gets kind of ugly:

  void control_packet_write(int fd, unsigned packet_id, const char *errstr)
  {
	char buf[4 + 1];

	assert(packet_id < 4); /* >= 4 are actual data packets */
	vsnprintf(buf, sizeof(buf), "%04u", packet_id);
	if (write_in_full(fd, buf, 4))
		...;
  }

There are only 3 of these, and their whole point is to hide not just
this magic "4", but the whole idea of "this is what a control packet
looks like". I kind of wonder if the abstractions we need to reduce the
3 lines to 1 is really making anything more readable.

-Peff
