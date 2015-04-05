From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Sun, 5 Apr 2015 14:52:59 -0400
Message-ID: <20150405185259.GB13096@peff.net>
References: <20150405010611.GA15901@peff.net>
 <55213B93.9050207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 05 20:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YepfW-0008OL-Fk
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 20:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbbDESxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 14:53:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:42669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528AbbDESxC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 14:53:02 -0400
Received: (qmail 24787 invoked by uid 102); 5 Apr 2015 18:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 13:53:01 -0500
Received: (qmail 6370 invoked by uid 107); 5 Apr 2015 18:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 14:53:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2015 14:52:59 -0400
Content-Disposition: inline
In-Reply-To: <55213B93.9050207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266813>

On Sun, Apr 05, 2015 at 03:41:39PM +0200, Ren=C3=A9 Scharfe wrote:

> > The main culprits seem to be d0f810f (which introduced some extra
> > expensive code for each ref) and my 10c497a, which switched from fg=
ets()
> > to strbuf_getwholeline. It turns out that strbuf_getwholeline is re=
ally
> > slow.
>=20
> 10c497a changed read_packed_refs(), which reads *all* packed refs.
> Each is checked for validity.  That sounds expensive if the goal is
> just to look up a single (non-existing) ref.
>=20
> Would it help to defer any checks until a ref is actually accessed?
> Can a binary search be used instead of reading the whole file?

Yes, but addressing that is much more invasive.

Right now we parse all of the packed-refs file into an in-memory cache,
and then do single lookups from that cache. Doing an mmap() and a binar=
y
search is way faster (and costs less memory) for doing individual
lookups. It relies on the list being sorted. This is generally true, bu=
t
not something we currently rely on (however, it would be easy to add a
"sorted" flag to top of the file and have the readers fall back when th=
e
flag is missing). I've played with a patch to do this (it's not entirel=
y
trivial, because you jump into the middle of a line, and then have to
walk backwards to find the start of the record).

=46or traversals, it's more complicated. Obviously if you are traversin=
g
all refs, you have to read the whole thing anyway. If you are traversin=
g
a subset of the refs, you can binary-search the start of the subset, an=
d
then walk forward. But that's where it gets tricky with the current
code.

The ref_cache code expects to fill in from outer to inner. So if you
have "refs/foo", you should also have filled in all of "refs/" (but not
necessarily "refs/bar"). This matches the way we traverse loose ref
directories; we opendir "refs/", find out that it has "foo" and "bar",
and the descend into "foo", and so forth. But reading a subset of the
packed-ref file is "inside out". You fill in all of "refs/foo", but you
have no idea what else is in "refs/".

So going in that direction would involve some surgery to the ref_cache
code. It might even involve throwing it out entirely (i.e., just mmap
the packed-refs file and look through it directly, without any kind of
in-memory cache; we don't tend to do more than one ref-iteration per
program anyway, so I'm not sure the caching is buying us much anyway).
My big concern there would be that there are a lot of subtle race issue=
s
between packed and loose refs, and the current state is the result of a
lot of tweaking. I'd be worried that a heavy rewrite there would risk
introducing subtle and rare corruptions.

Plus it would be a lot of work, which leads me to...

> I wonder if pluggable reference backends could help here.  Storing re=
fs
> in a database table indexed by refname should simplify things.

=2E..this. I think that effort might be better spent on a ref storage
format that's more efficient, simpler (with respect to subtle races and
such), and could provide other features (e.g., transactional atomicity)=
=2E

The big plus side of packed-refs improvements is that they "just work"
without worrying about compatibility issues. But ref storage is local,
so I'm not sure how big a deal that is in practice.

> Short-term, can we avoid the getc()/strbuf_grow() dance e.g. by mappi=
ng
> the packed refs file?  What numbers do you get with the following pat=
ch?

It's about 9% faster than my series + the fgets optimization I posted
(or about 25% than using getc).  Which is certainly nice, but I was
really hoping to just make strbuf_getline faster for all callers, rathe=
r
than introducing special code for one call-site. Certainly we could
generalize the technique (i.e., a struct with the mmap data), but then =
I
feel we are somewhat reinventing stdio. Which is maybe a good thing,
because stdio has a lot of rough edges (as seen here), but it does feel
a bit like NIH syndrome.

-Peff
