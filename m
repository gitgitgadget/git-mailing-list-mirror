Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B1B2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbcF0Uee (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 16:34:34 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:1919 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcF0Uee convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 16:34:34 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 8b86f769
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Mon, 27 Jun 2016 22:34:28 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Junio C Hamano <gitster@pobox.com>, "Jeff King" <peff@peff.net>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com>
Cc:	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@fluxnic.net>, "Johannes Sixt" <j6t@kdbg.org>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <20160624153121.GA2494@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
 <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
 <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
 <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
 <20160627161616.GA4430@sigill.intra.peff.net>
 <xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com>
Message-ID: <146705966655.11886.6547584744094511110@typhoon>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date:	Mon, 27 Jun 2016 22:34:27 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 27 Jun 2016 at 19:50:13, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:
> >
> >> It's just you used xwrite() there that introduced a different issue.
> >> Wouldn't replacing it with fwrite(stderr) without changing anything
> >> else solve that?

I do not see how using fwrite() buys us anything. Neither fwrite() nor
fputs() nor fprintf() guarantee to call write() only once. Each of these
three functions is buffered when printing to stdout and unbuffered when
printing to stderr. I do not think there is any serious implementation
of any of those functions that performs segmented write() calls (but I
might be mistaken). According to POSIX, write() can take up to SSIZE_MAX
bytes which is guaranteed to be at least 32767 but is actually much
larger on most systems (2^32 - 1 here). It is very unlikely that this
limit will ever be reached by a single line of a diagnostic error
message.

Frankly, there is a small benefit to fwrite() because we already know
the string length from the strbuf and most fputs() implementations
probably do something equivalent to

    fwrite(s, 1, strlen(s), stream);

I can switch to using fwrite() instead of fputs() in v4 if you prefer
that.

> >
> > I am having trouble actually seeing how the ANSI-emulation code gets
> > triggered, but the comment in color.h implies that it is only printf,
> > fprintf, and fputs that have the desired effect. So fwrite() may not be
> > sufficient, and we may need fprintf("%.*s", len, buf) or something.
> 
> I have no idea how, either X-<.  But you're probably right about the
> magic being limited to the printf family of functions---I do recall
> hearing something like that in the past.

I do not know anything about the emulation code as well but from a
cursory read of winansi_init(), it looks like there is some magic that
hooks into the stdout and stderr streams, redirects them to a named
pipe, then replaces ANSI control codes and actually prints to the
console from console_thread(). So it should work with any of the
stream-based functions but not with write(), puts(), etc.
