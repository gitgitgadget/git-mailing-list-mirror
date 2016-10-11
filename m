Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A582098A
	for <e@80x24.org>; Tue, 11 Oct 2016 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbcJKQCt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:02:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753492AbcJKQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:02:37 -0400
Received: (qmail 22024 invoked by uid 109); 11 Oct 2016 16:02:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 16:02:36 +0000
Received: (qmail 9802 invoked by uid 111); 11 Oct 2016 16:02:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 12:02:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 12:02:35 -0400
Date:   Tue, 11 Oct 2016 12:02:35 -0400
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161011160234.ve72wdqujdz4zrrq@sigill.intra.peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpqfuo3l4fl.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 09:39:58AM +0200, Matthieu Moy wrote:

> >> I can't reproduce the problem with this simple setup:
> >> 
> >> 	git init
> >> 	echo content >file && git add file
> >> 	git commit -F- <<-\EOF
> >> 	the subject
> >> 
> >> 	the body
> >> 
> >> 	Cc: Stable <stable@vger.kernel.org> [4.8+]
> 
> Is this RFC2822 compliant (https://tools.ietf.org/html/rfc2822)? Not an
> expert of the norm, but my understanding is that you're allowed to use
> either "Name <addr@domain.com>" (name-addr) or addr@domain.com
> (addr-spec), and that comments are allowed within parenthesis like
> "Stable <stable@vger.kernel.org> (4.8+)".

I'm not sure. I don't recall seeing anything like it in the wild before,
but I find it interesting that we behave differently than Mail::Address
(which I generally assume to adhere to a mix of spec and common
practice). I couldn't find anything relevant in rfc2822.

> What is this [4.8+] supposed to mean?
> 
> The guilty function is parse_mailboxes in perl/Git.pm. It should be
> rather easy to modify it but I need to understand the spec before I can
> try to implement anything.

It seems to be syntactically invalid as an rfc2822 address. If it's in
common use on trailer lines[1], I think the only sane things are to drop
it, or to stick it in the name. Between the two, I'd argue for the
latter, as that matches what Git historically has done.

I also found it interesting that:

  Cc: Stable [4.8+] <stable@vger.kernel.org>

ends up as:

  Cc: "Stable [ v4 . 8+ ]" <stable@vger.kernel.org>

I think this is also syntactically invalid as an rfc2822 address, but we
have a habit in Git of treating single-line "name <email>" in a pretty
lax manner, and just letting any character except "<" exist in the name
field. I wonder if we should do something similar here.

-Peff

[1] Running `git log | grep -i '^ *cc:' | grep '\['` on linux.git
    shows that it is a common pattern there, though there are other uses
    of brackets that probably would not want to include their contents
    in the name.

    It also looks like:

      Cc: stable@vger.kernel.org # 4.8+

    is a common pattern.

    So I suspect we really are in the realm of micro-formats here, and
    it is less about what rfc2822 says, and what people would find it
    useful for send-email to do with these bits after the address (and
    possibly what other people's scripts do with them).
