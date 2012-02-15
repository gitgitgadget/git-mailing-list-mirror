From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Wed, 15 Feb 2012 14:03:18 -0500
Message-ID: <20120215190318.GA5992@sigill.intra.peff.net>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 20:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxk8T-0001AI-DU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 20:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab2BOTDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 14:03:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37311
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab2BOTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 14:03:20 -0500
Received: (qmail 21725 invoked by uid 107); 15 Feb 2012 19:10:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 14:10:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 14:03:18 -0500
Content-Disposition: inline
In-Reply-To: <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190849>

On Wed, Feb 15, 2012 at 09:57:29AM +0100, Piotr Krukowiecki wrote:

> All is on local disk and system is idle.
>=20
> Indeed, after gc the times went down:
> 10s -> 2.3s (subdirectory)
> 17s -> 9.5s (whole repo)
>=20
> 2 seconds is much better and I'd say acceptable for me. But my questi=
ons are:

Obviously these answers didn't come from any deep analysis, but are
educated guesses from me based on previous performance patterns we've
seen on the list:

> - why is it so slow with not packed repo?

Your numbers show that you're I/O-bound:

>>> $ time git status =C2=A0 =C2=A0> /dev/null
>>> real =C2=A0 =C2=A00m41.670s
>>> user =C2=A0 =C2=A00m0.980s
>>> sys =C2=A0 =C2=A0 0m2.908s
>>>
>>> $ time git status -- src/.../somedir =C2=A0 > /dev/null
>>> real =C2=A0 =C2=A00m17.380s
>>> user =C2=A0 =C2=A00m0.748s
>>> sys =C2=A0 =C2=A0 0m0.328s

which is not surprising, since you said you dropped caches before-hand.
Repacking probably reduced your disk footprint by a lot, which meant
less I/O.

I notice that you're still I/O bound even after the repack:

> $ time git status  -- .
> real    0m2.503s
> user    0m0.160s
> sys     0m0.096s
>=20
> $ time git status
> real    0m9.663s
> user    0m0.232s
> sys     0m0.556s

Did you drop caches here, too?  Usually that would not be the case on a
warm cache. If it is, then it sounds like you are short on memory to
actually hold the directory tree and object db in cache. If not, what d=
o
the warm cache numbers look like?

> - can it be faster without repacking?

Not really. You're showing an I/O problem, and repacking is git's way o=
f
reducing I/O.

> - even with packed repo, the time on small subdirectory is much highe=
r
> than I'd expect given time on whole repo and subdirectory size - why?

Hard to say without profiling.  It may be that we reduced the object db
lookups, saving some time, but still end up stat()ing the whole tree.
The optimization to stat only the directories of interest was in 688cd6=
d
(status: only touch path we may need to check, 2010-01-14), which went
into v1.7.0. What version of git are you using?

-Peff
