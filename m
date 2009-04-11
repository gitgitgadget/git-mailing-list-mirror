From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 21:40:00 +0200
Message-ID: <20090411194000.GB21300@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet> <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111115210.4583@localhost.localdomain>
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
X-From: git-owner@vger.kernel.org Sat Apr 11 21:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsj5B-00013F-Ch
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbZDKTkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZDKTkF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:40:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:46083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753155AbZDKTkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:40:04 -0400
Received: (qmail invoked by alias); 11 Apr 2009 19:40:02 -0000
Received: from i59F56F7C.versanet.de (EHLO atjola.local) [89.245.111.124]
  by mail.gmx.net (mp018) with SMTP; 11 Apr 2009 21:40:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+ei0gnmYaeRyedgXjaA7rrPZBji/iDdZOtHPI+6U
	geg9hVolP564zt
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111115210.4583@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116337>

On 2009.04.11 11:19:01 -0700, Linus Torvalds wrote:
> On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
> > On 2009.04.11 15:41:12 +0200, Bj=F6rn Steinbrink wrote:
> > > On 2009.04.10 18:15:26 -0700, Linus Torvalds wrote:
> > > > It obviously goes on top of my previous patch.
> > >=20
> > > Gives some nice results for the "rev-list --all --objects" test o=
n the
> > > gentoo repo says (with the old pack):
> > >      | With my patch | With your patch on top
> > > -----|---------------|-----------------------
> > > VSZ  |       1667952 | 1319324
> > > RSS  |       1388408 | 1126080
> >=20
> > linux-2.6.git:
> >=20
> >      | With my patch | With your patch on top
> > -----|---------------|-----------------------
> > VSZ  |        460376 | 407900
> > RSS  |        292996 | 239760
>=20
> Interesting. That's a 18+% reduction in RSS in both cases. Much bigge=
r=20
> than I expected, or what I saw in my limited testing. Is this in 32-b=
it=20
> mode, where the pointers are cheaper, and thus the non-pointer data=20
> relatively more expensive and a bigger percentage of the total? We re=
ally=20
> wasted a _lot_ of memory on those names.

No, this is x86-64, 8 byte pointers. But the savings are trivially
explained I think. The struct object_array things are 20 bytes here (pe=
r
object overhead!), so that's about 5M * 20 =3D 100M. And the average na=
me
length for the objects was 19 bytes, which means about another 100M.
Both, the object_array stuff as well as the path names, were allocated
and never freed. Your patch removed the object_array stuff, and it made
the memory allocations for the names temporary. Right?

Had you moved just the path_name() calls, that would have meant that we
had needed to keep the name_path stuff around, which is also 20 bytes
here (two pointers, one int). And that would have meant that anything
that has a leading-up path shorter than 20 bytes (64 bit pointers) woul=
d
have seen increased memory usage (64bit pointers), but with 32 pointers=
,
the limit would have been 12 bytes.

So for the "just move path_name() call" solution, 32bit vs. 64bit would
have made a difference, but with your actual patches, you just turned
everything into temporary allocations. So the 4byte overhead on 64bit
platforms is just once linear with the directory-depth of the current
object, instead of with the number of objects in total.

Right?

Bj=F6rn
