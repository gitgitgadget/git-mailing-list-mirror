Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AA820989
	for <e@80x24.org>; Mon, 10 Oct 2016 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbcJJVs7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 17:48:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:55371 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbcJJVs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 17:48:59 -0400
Received: (qmail 19783 invoked by uid 109); 10 Oct 2016 21:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 21:48:58 +0000
Received: (qmail 2128 invoked by uid 111); 10 Oct 2016 21:49:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 17:49:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 17:48:56 -0400
Date:   Mon, 10 Oct 2016 17:48:56 -0400
From:   Jeff King <peff@peff.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 04:00:56PM -0500, Larry Finger wrote:

> I have recently switched to openSUSE Leap 42.2 and found that some of the
> features of send_mail no longer work. The problem occurs when trying to add
> information to a Cc to Stable.
> 
> The initial pass through the patch produces the output
> (body) Adding cc: Stable <stable@vger.kernel.org> [4.8+] from line 'Cc:
> Stable <stable@vger.kernel.org> [4.8+]'
> 
> That is correct, but the actual Cc list contains
>         Stable <stable@vger.kernel.org[4.8+]>,
> 
> The mangled address is not legal and the mail attempt fails.

I can't reproduce the problem with this simple setup:

	git init
	echo content >file && git add file
	git commit -F- <<-\EOF
	the subject

	the body

	Cc: Stable <stable@vger.kernel.org> [4.8+]
	EOF

If I then run:

	git send-email -1 --to=peff@peff.net --dry-run

I get:

	/tmp/MH8SfHOjCv/0001-the-subject.patch
	(mbox) Adding cc: Jeff King <peff@peff.net> from line 'From: Jeff King <peff@peff.net>'
	(body) Adding cc: Stable <stable@vger.kernel.org> [4.8+] from line 'Cc: Stable <stable@vger.kernel.org> [4.8+]'
	Dry-OK. Log says:
	Sendmail: /usr/sbin/sendmail -i peff@peff.net stable@vger.kernel.org
	From: Jeff King <peff@peff.net>
	To: peff@peff.net
	Cc: "Stable [4.8+]" <stable@vger.kernel.org>
	Subject: [PATCH] the subject
	Date: Mon, 10 Oct 2016 17:44:25 -0400
	Message-Id: <20161010214425.9761-1-peff@peff.net>
	X-Mailer: git-send-email 2.10.1.527.g93d4615
	
	Result: OK

So it looks like it parsed the address, and shifted the "4.8+" bit into
the name, which seems reasonable. Does my example behave differently on
your system? If not, can you see what's different between your
real-world case and the example?

It might also be related to which perl modules are available. We'll use
Mail::Address if you have it, but some fallback routines if you don't.
They may behave differently.

Alternatively, if this used to work, you might try bisecting it.

-Peff
