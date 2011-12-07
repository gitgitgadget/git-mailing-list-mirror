From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 7 Dec 2011 13:28:43 -0500
Message-ID: <20111207182843.GB6124@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <4EDE9ED1.8010502@lsrfire.ath.cx>
 <20111207044242.GB10765@sigill.intra.peff.net>
 <4EDF9E53.7090702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 19:28:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYMEc-0004Us-SF
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 19:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab1LGS2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 13:28:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42807
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab1LGS2p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 13:28:45 -0500
Received: (qmail 18706 invoked by uid 107); 7 Dec 2011 18:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 13:35:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 13:28:43 -0500
Content-Disposition: inline
In-Reply-To: <4EDF9E53.7090702@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186480>

On Wed, Dec 07, 2011 at 06:11:47PM +0100, Ren=C3=A9 Scharfe wrote:

> >   $ time git grep --threads=3D8 'a.*b' HEAD >/dev/null
> >   real    0m8.655s
> >   user    0m23.817s
> >   sys     0m0.480s
> [...]
>
> Ugh, right, Turbo Boost complicates matters.
>=20
> I don't understand the multiplied user time in the threaded case,
> though.  Is it caused by busy-waiting?  Thomas reported similar numbe=
rs
> earlier.

I think it's mostly the clock speed. This processor runs at 1.86GHz but
boosts to 3.2GHz. So we'd expect just the actual work to take close to
twice as long. Plus it's a quad-core with hyperthreading, so 8 threads
is going to mean two threads sharing each core, including cache (i.e.,
hyperthreading a core does not let you double performance, even though
it presents itself as an extra core).

And then you have context switching and lock overhead. So I can believe
that it takes 3x the CPU time to accomplish the task. In an ideal world=
,
it would be mitigated by having 8x the threads, but in this case, lock
contention brings us down to less than 3x, and it's a slight net loss.

-Peff
