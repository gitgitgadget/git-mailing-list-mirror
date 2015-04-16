From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/9] address packed-refs speed regressions
Date: Thu, 16 Apr 2015 05:25:19 -0400
Message-ID: <20150416092518.GA18135@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 11:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yig35-00047Y-5S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbbDPJZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 05:25:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754212AbbDPJZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 05:25:22 -0400
Received: (qmail 23178 invoked by uid 102); 16 Apr 2015 09:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:25:22 -0500
Received: (qmail 23751 invoked by uid 107); 16 Apr 2015 09:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 05:25:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 05:25:19 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267271>

On Thu, Apr 16, 2015 at 04:47:34AM -0400, Jeff King wrote:

> Here's a re-roll incorporating feedback from the list. Thanks everybo=
dy
> for your comments. Last time the final number was ~8.5s, which was
> disappointingly slower than v2.0.0. In this iteration, my final numbe=
rs
> are:
>=20
>   real    0m5.703s
>   user    0m5.276s
>   sys     0m0.432s
>=20
> which is quite pleasing.

I forgot to mention what I _didn't_ include.

We discussed using mmap instead of stdio. Applying Ren=C3=A9's mmap pat=
ch
drops my best-of-five here to 5.114s. Which is nice, but it is a bit
more invasive (and does not help other callers of strbuf_getline).

If I further apply my really nasty patch to avoid the strbuf entirely
(i.e., we parse straight out of the mmap), I can get it down to 4.835s.

I don't know if the complexity is worth it or not. Ultimately, I think
the best route to making packed-refs faster is to drop the whole
ref_cache structure and just iterate directly over the mmap data. It
would use less RAM, and it opens the possibility of binary-searching to
look at only a subset of the entries. That's a _lot_ more invasive,
though.

-Peff
