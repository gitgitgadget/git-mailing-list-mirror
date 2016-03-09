From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 19:10:43 -0500
Message-ID: <20160309001042.GA32669@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
 <56DEC4B4.2000902@web.de>
 <56DED770.4050603@drmicha.warpmail.net>
 <20160308143556.GA10153@sigill.intra.peff.net>
 <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:10:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adRiE-0007LI-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbcCIAKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:10:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:56699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbcCIAKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:10:46 -0500
Received: (qmail 5900 invoked by uid 102); 9 Mar 2016 00:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 19:10:45 -0500
Received: (qmail 9003 invoked by uid 107); 9 Mar 2016 00:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 19:10:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 19:10:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288461>

On Tue, Mar 08, 2016 at 03:20:26PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I actually wonder if we should have a build-time knob to put "grep -a"
> > into sane_grep(). We do not ever plan to feed it binary data, so that
> > will do what, provided the system grep handles "-a". And on those that
> > do not know about "-a", one imagines that they do not suffer from this
> > problem in the first place (which is really limited to recent versions
> > of GNU grep).
> 
> Something along this line, you mean?  I'll leave it as a
> low-hanging-fruit to add autoconf support ;-)

Yeah, though I think I would probably squash in:

diff --git a/config.mak.uname b/config.mak.uname
index 723f632..15557c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	HAVE_GETDELIM = YesPlease
+	SANE_TEXT_GREP = -a
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease

It's not necessary on all Linux platforms yet, but it doesn't hurt, so
we can err on the side of including it (and I think we can assume all
Linux systems have GNU grep or equivalent).

-Peff
