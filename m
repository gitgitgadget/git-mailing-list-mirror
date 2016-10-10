Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C7420989
	for <e@80x24.org>; Mon, 10 Oct 2016 21:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbcJJV5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 17:57:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55383 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbcJJV5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 17:57:14 -0400
Received: (qmail 20284 invoked by uid 109); 10 Oct 2016 21:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 21:57:13 +0000
Received: (qmail 2227 invoked by uid 111); 10 Oct 2016 21:57:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 17:57:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 17:57:11 -0400
Date:   Mon, 10 Oct 2016 17:57:11 -0400
From:   Jeff King <peff@peff.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc authors of b1c8a11, which regressed this case; I'll quote liberally
     to give context]

On Mon, Oct 10, 2016 at 05:48:56PM -0400, Jeff King wrote:

> I can't reproduce the problem with this simple setup:
> 
> 	git init
> 	echo content >file && git add file
> 	git commit -F- <<-\EOF
> 	the subject
> 
> 	the body
> 
> 	Cc: Stable <stable@vger.kernel.org> [4.8+]
> 	EOF
> 
> If I then run:
> 
> 	git send-email -1 --to=peff@peff.net --dry-run
> 
> I get:
> 
> 	/tmp/MH8SfHOjCv/0001-the-subject.patch
> 	(mbox) Adding cc: Jeff King <peff@peff.net> from line 'From: Jeff King <peff@peff.net>'
> 	(body) Adding cc: Stable <stable@vger.kernel.org> [4.8+] from line 'Cc: Stable <stable@vger.kernel.org> [4.8+]'
> 	Dry-OK. Log says:
> 	Sendmail: /usr/sbin/sendmail -i peff@peff.net stable@vger.kernel.org
> 	From: Jeff King <peff@peff.net>
> 	To: peff@peff.net
> 	Cc: "Stable [4.8+]" <stable@vger.kernel.org>
> 	Subject: [PATCH] the subject
> 	Date: Mon, 10 Oct 2016 17:44:25 -0400
> 	Message-Id: <20161010214425.9761-1-peff@peff.net>
> 	X-Mailer: git-send-email 2.10.1.527.g93d4615
> 	
> 	Result: OK
> 
> So it looks like it parsed the address, and shifted the "4.8+" bit into
> the name, which seems reasonable. Does my example behave differently on
> your system? If not, can you see what's different between your
> real-world case and the example?
> 
> It might also be related to which perl modules are available. We'll use
> Mail::Address if you have it, but some fallback routines if you don't.
> They may behave differently.
> 
> Alternatively, if this used to work, you might try bisecting it.

Ah, it is Mail::Address. It gets this case right, but if I uninstall it,
then the cc becomes:

  Cc: Stable <stable@vger.kernel.org[4.8+]>

that you saw, which is broken. Older versions of git, even without
Mail::Address, got this right. The breakage bisects to b1c8a11
(send-email: allow multiple emails using --cc, --to and --bcc,
2015-06-30) from v2.6.0, but I didn't dig deeper into the cause.

-Peff
