From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 22:50:44 +0200
Message-ID: <20090411205044.GA21673@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet> <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LskBd-0004LA-8m
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 22:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341AbZDKUuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759310AbZDKUuv
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 16:50:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759417AbZDKUut (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 16:50:49 -0400
Received: (qmail invoked by alias); 11 Apr 2009 20:50:47 -0000
Received: from i59F56F7C.versanet.de (EHLO atjola.local) [89.245.111.124]
  by mail.gmx.net (mp026) with SMTP; 11 Apr 2009 22:50:47 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+YsHF88quY7NnbEQUBULgz4vMXiW8mrNJxHncCgn
	z8W6LCq/3WPFC2
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116347>

On 2009.04.11 11:06:17 -0700, Linus Torvalds wrote:
>=20
>=20
> On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
> >=20
> > And for completeness, here are the results for linux-2.6.git
> >=20
> >      | With my patch | With your patch on top
> > -----|---------------|-----------------------
> > VSZ  |        460376 | 407900
> > RSS  |        292996 | 239760
> > time |       0:14.28 | 0:14.66
>=20
> Ok, it uses less memory, but more CPU time. That's reasonable - we "w=
aste"=20
> CPU time on doing the extra free's, and since the memory use isn't a =
huge=20
> constraining factor and cache behavior is bad anyway, it's then actua=
lly=20
> slightly slower.
>=20
> > And again, the new pack is slightly worse than the old one
> >  (window=3D250, --depth=3D250).
> > Old: 240238406
> > New: 240280452
> >=20
> > But again, it's negligible.
>=20
> Well, it's sad that it's consistently a bit worse, even if we're talk=
ing=20
> just small small fractions of a percent (looks like 0.02% bigger ;).=20
>=20
> And I think I can see why. The new code actually does a _better_ job =
of=20
> the resulting list being in "recency" order, whereas the old code use=
d to=20
> output the root trees all together. Now they're spread out according =
to=20
> how soon they are reached.

Hm, I don't think that was the case. When iterating over the commits,
process_tree was called with commit->tree, and that added the root tree
to the objects array as well as walking it to add all referenced object=
s.

And yep, the 'old' "rev-list --all-objects" shows for example:
ebace34d059216b3573cd67a83068d2eafe2f2e7 read-cache.c
a869cb0789d8ad87f04d28dd9b703f3ff343a4a7=20
497a05b8fa8e9aa3a5db9b42e5c50392f352d2b4 cache.h
91b2628e3c18e7f75e477c24197d9ef2eca14125 read-cache.c
6862d1012681cd6812ab9bfe1a866446f92a7c91 read-tree.c

a869cb0 being a root tree, inbetween two blobs.

Bj=F6rn
