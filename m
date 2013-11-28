From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 04:29:35 -0500
Message-ID: <20131128092935.GC11444@sigill.intra.peff.net>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com>
 <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlxuq-0007eE-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab3K1J3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 04:29:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:47096 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751148Ab3K1J3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 04:29:37 -0500
Received: (qmail 21833 invoked by uid 102); 28 Nov 2013 09:29:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Nov 2013 03:29:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Nov 2013 04:29:35 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238486>

On Thu, Nov 28, 2013 at 04:09:18PM +0700, Duy Nguyen wrote:

> > Git should be better support resume transfer.
> > It now seems not doing better it=E2=80=99s job.
> > Share code, manage code, transfer code, what would it be a VCS we i=
magine it ?
>=20
> You're welcome to step up and do it. On top of my head  there are a f=
ew options:
>=20
>  - better integration with git bundles, provide a way to seamlessly
> create/fetch/resume the bundles with "git clone" and "git fetch"

I posted patches for this last year. One of the things that I got hung
up on was that I spooled the bundle to disk, and then cloned from it.
Which meant that you needed twice the disk space for a moment. I wanted
to teach index-pack to "--fix-thin" a pack that was already on disk, so
that we could spool to disk, and then finalize it without making anothe=
r
copy.

One of the downsides of this approach is that it requires the repo
provider (or somebody else) to provide the bundle. I think that is
something that a big site like GitHub would do (and probably push the
bundles out to a CDN, too, to make getting them faster). But it's not a
universal solution.

>  - stablize pack order so we can resume downloading a pack

I think stabilizing in all cases (e.g., including ones where the conten=
t
has changed) is hard, but I wonder if it would be enough to handle the
easy cases, where nothing has changed. If the server does not use
multiple threads for delta computation, it should generate the same pac=
k
from the same on-disk deterministically. We just need a way for the
client to indicate that it has the same partial pack.

I'm thinking that the server would report some opaque hash representing
the current pack. The client would record that, along with the number o=
f
pack bytes it received. If the transfer is interrupted, the client come=
s
back with the hash/bytes pair. The server starts to generate the pack,
checks whether the hash matches, and if so, says "here is the same pack=
,
resuming at byte X".

What would need to go into such a hash? It would need to represent the
exact bytes that will go into the pack, but without actually generating
those bytes. Perhaps a sha1 over the sequence of <object sha1, type,
base (if applicable), length> for each object would be enough. We shoul=
d
know that after calling compute_write_order. If the client has a match,
we should be able to skip ahead to the correct byte.

>  - remote alternates, the repo will ask for more and more objects as
> you need them (so goodbye to distributed model)

This is also something I've been playing with, but just for very large
objects (so to support something like git-media, but below the object
graph layer). I don't think it would apply here, as the kernel has a lo=
t
of small objects, and getting them in the tight delta'd pack format
increases efficiency a lot.

-Peff
