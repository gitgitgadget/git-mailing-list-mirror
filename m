From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 9 Nov 2007 19:46:37 -0500
Message-ID: <20071110004635.GA14992@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeV3-0007ma-GY
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbXKJAqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbXKJAqr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:46:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2448 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbXKJAqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:46:46 -0500
Received: (qmail 20647 invoked by uid 111); 10 Nov 2007 00:46:43 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 Nov 2007 19:46:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2007 19:46:37 -0500
Content-Disposition: inline
In-Reply-To: <4734EA4E.8070405@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64289>

On Sat, Nov 10, 2007 at 12:16:30AM +0100, Ren=E9 Scharfe wrote:

> > A partial patch on top of yours is below (it caches commit and tree=
=20
> > abbreviations; parent abbreviations and person-parsing are probably=
=20
> > worth doing). Some timings:
>=20
> ... but I object to the choice of items to cache.  Are there real-wor=
ld
> formats containing the same placeholder twice or even more often?

My choice of items was more "here is what I am talking about" and not
"this is the best set of items."

As for what real-world workloads are like, part of the _point_ of
--pretty=3Dformat: is for one-off formats that users use in their
workflow. So yes, I have used formats that repeat specifiers, but they
are probably not common.

The point of my timings was to show not only that we sped up that
uncommon case, but that there was negligible cost to the common case.
And since we don't know what formats users will provide, it makes sense
not to have lousy performance on the uncommon.

> There is probably more to gain from the interdependencies of differen=
t
> placeholders.  The patch below attempts to avoid parsing the commit
> twice, by saving pointers to the different parts.

Looks sane, although I don't see any reason this couldn't just go on to=
p
of my patch, and then we can speed up both cases.

> (next)
> $ time git log --pretty=3Dformat:"* %cd %cn%n%n%s%n%b" >/dev/null
> real    0m0.631s
[...]
> (next+patch)
> $ time git log --pretty=3Dformat:"* %cd %cn%n%n%s%n%b" >/dev/null
> real    0m0.570s

Great, you have sped up the uncommon case. But what is the cost to "git
log --pretty=3Dformat:" and "git log --pretty=3Dformat:%cd"?

-Peff
