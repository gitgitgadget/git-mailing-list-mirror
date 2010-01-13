From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 19:36:10 +0200
Message-ID: <20100113173610.GA7609@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
 <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV78n-000471-NA
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0AMRgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218Ab0AMRgR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:36:17 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:39860 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217Ab0AMRgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:36:16 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 2120DEF6A9;
	Wed, 13 Jan 2010 19:36:15 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A01C300D85E; Wed, 13 Jan 2010 19:36:15 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id E668D27D86;
	Wed, 13 Jan 2010 19:36:11 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100113161711.GB17687@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136849>

On Wed, Jan 13, 2010 at 05:17:11PM +0100, Andreas Krey wrote:
> On Wed, 13 Jan 2010 16:47:47 +0000, Ilari Liusvaara wrote:
> 
> If you don't want public read access then you need to wedge a script
> between stunnel and git itself that checks whether authentication is
> present, yes.

That would violate layering badly. You need to decode the request
first before you can authorize. And the git daemon does that.
 
> > And besides: Gits:// uses certificates as keypairs,
> 
> My gripe with this is that I would expect gits: to be the same
> as git: except that there is SSL underneath. git: does not have
> authentication, so there should be none in gits: except what
> SSL provides.

All authentication in gits:// is at TLS (SSL) level or even lower.

> (And the auth via unix domain sockets would be
> usable for plain git: as well; there is no reason to encrypt
> local traffic?)

In fact, git-remote-gits has unencrypted mode (should be compatible
with git-daemon). The reason its there is mainly for Unix domain
sockets support and more advanced IPv6 support (interface indexes and
numeric addresses actually work).

> (Is the unix auth via unix domain sockets part of GnuTLS?)

No, that server-only feature is part of the OS itself. In fact, it
needs no client-side support.

> That's another story. I think that it would be possible nowadays
> to implement gits:// (in both ways) via core.gitproxy and a server-side
> wrapper program (stunnel or else), but that has the disadvantage of
> being unable to just provide a clone url without installing special
> software besides git.

GIT_PROXY abuse? There are even better ways: smart transport remote
helpers (in next I think). Git can actually dispatch those (and yes,
that's exactly what this uses).

And gits:// client is also buildable selfstanding. That would require
new client software, but its still nicer than GIT_PROXY abuse.

Another problem with GIT_PROXY abuse: How to deal with potentially
multiple custom protocols. Remote helpers can deal with that nicely.

> ...
> > The authentication support for smart-http seems pretty bad (making the
> > old mistake of not binding authentications).
> 
> Mind to explain 'binding authentications'?

Actually, that was little badly choosen term and not the true problem,
but the basic problem is that one peer has to trust the the other peer's
authentication for security of its own authentication.

In how authentications used by gits:// are designed, even if client doesn't
detect trying to authenticate with attacker, the attacker doesn't get any
replayable credentials without breaking crypto keys (as opposed to just
passwords). This holds true even for password authentication (PAKE-type
scheme is used).

HTTP basic auth can be trivially sniffed if attacker can become other end
of the encrypted link (crypto is by far the strongest link...). Digest auth
is harder, but its essentially brute force against password (as opposed to
trying to break a key).


-Ilari
