Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0CF1FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 04:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbcF1EBT (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 00:01:19 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:4333 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcF1EBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 00:01:18 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 949bdf5b
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Tue, 28 Jun 2016 06:01:13 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Nicolas Pitre <nico@fluxnic.net>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <alpine.LFD.2.20.1606271640230.2550@knanqh.ubzr>
Cc:	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j6t@kdbg.org>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
 <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
 <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
 <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
 <20160627161616.GA4430@sigill.intra.peff.net>
 <xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com>
 <146705966655.11886.6547584744094511110@typhoon>
 <alpine.LFD.2.20.1606271640230.2550@knanqh.ubzr>
Message-ID: <146708647010.14433.5732305874810138274@typhoon>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date:	Tue, 28 Jun 2016 06:01:10 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 27 Jun 2016 at 22:47:59, Nicolas Pitre wrote:
> On Mon, 27 Jun 2016, Lukas Fleischer wrote:
> 
> > On Mon, 27 Jun 2016 at 19:50:13, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > > 
> > > > On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:
> > > >
> > > >> It's just you used xwrite() there that introduced a different issue.
> > > >> Wouldn't replacing it with fwrite(stderr) without changing anything
> > > >> else solve that?
> > 
> > I do not see how using fwrite() buys us anything. Neither fwrite() nor
> > fputs() nor fprintf() guarantee to call write() only once. Each of these
> > three functions is buffered when printing to stdout and unbuffered when
> > printing to stderr.
> 
> You are right.  However, in practice:
> 
> - fprintf(stderr, "%s", buffer) is likely to call write() only once 
>   given there is only one string specifier, and
> 
> - On Windows the ANSI escape sequences are interpreted by fprintf() and 
>   not by write() nor by the actual display console code. Insane but such 
>   is life sometimes.
> 
> So the point is simply to replace your call to write() by a call to 
> fprintf(..., "%*s", ...) in your patch which should provide the same 
> end result as before.

Well, this is essentially what I tried to make clear in my previous
email. In practice, each of the following lines should work:

    fwrite(outbuf.buf, 1, outbuf.len, stderr);
    fputs(outbuf.buf, stderr);
    fprintf("%s", outbuf.buf, stderr);
    fprintf("%.*s", outbuf.len, outbuf.buf, stderr);

The first version is probably to most "efficient" one and I personally
find the fputs() line to be the one that is easiest to read. However, I
think it does not make sense to start another bikeshedding discussion at
this point. I will make a defensive choice and use fprintf() with "%.*s"
since that is what we used before, so it is tested well enough.

Given the amount of discussion required to get this right, I also
strongly believe this code deserves a comment with a short explanation
on why things are done this way...
