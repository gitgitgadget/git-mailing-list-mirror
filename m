From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 29/33] refs: resolve symbolic refs first
Date: Thu, 12 May 2016 03:45:28 -0400
Message-ID: <20160512074528.GB10922@sigill.intra.peff.net>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 12 09:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lJR-0004aF-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 09:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcELHpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 03:45:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752181AbcELHpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 03:45:31 -0400
Received: (qmail 3200 invoked by uid 102); 12 May 2016 07:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:45:31 -0400
Received: (qmail 7479 invoked by uid 107); 12 May 2016 07:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:45:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 03:45:28 -0400
Content-Disposition: inline
In-Reply-To: <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294397>

On Fri, May 06, 2016 at 06:14:10PM +0200, Michael Haggerty wrote:

> This makes use of a new function, lock_ref_raw(), which is analogous =
to
> read_ref_raw(), but acquires a lock on the reference before reading i=
t.

Minor nit: the new function is actually called lock_raw_ref(). I don't
care which is used, just an inconsistency.

But my much bigger (non-)nit is that this seems to make large ref
updates much slower. You can see this by running t5551 with "--long".
In t5551.26, we fetch 48000 new tags into a repository that already has
2000 tags. Before this patch, it takes about 2 seconds. After, it chews
CPU for several minutes (I never actually let it finish).

The perf output isn't all that instructive. We seem to spend a lot of
time reading directory entries. Attaching with gdb shows:

#0  0x00007f35e00c2670 in __open_nocancel () at ../sysdeps/unix/syscall=
-template.S:84
#1  0x0000000000533982 in read_raw_ref (
    refname=3D0x4e899f0 "refs/tags/blablablablablablablablablablablabla=
blablablablablablablablablablablablablablablablablabla-11520", sha1=3D0=
x7fff7c5aff30 "\002\357\373\070\332{\341\005\366=EC=B8=96\265G\276\332\=
f\025\271\276\377\177",=20
    referent=3D0x836300 <sb_refname>, type=3D0x7fff7c5afe34) at refs/fi=
les-backend.c:1468
#2  0x0000000000530bf3 in resolve_ref_unsafe (
    refname=3D0x4e899f0 "refs/tags/blablablablablablablablablablablabla=
blablablablablablablablablablablablablablablablablabla-11520", resolve_=
flags=3D1,=20
    sha1=3D0x7fff7c5aff30 "\002\357\373\070\332{\341\005\366=EC=B8=96\2=
65G\276\332\f\025\271\276\377\177",=20
    flags=3D0x7fff7c5aff2c) at refs.c:1209
#3  0x000000000052e56f in read_ref_full (
    refname=3D0x4e899f0 "refs/tags/blablablablablablablablablablablabla=
blablablablablablablablablablablablablablablablablabla-11520", resolve_=
flags=3D1,=20
    sha1=3D0x7fff7c5aff30 "\002\357\373\070\332{\341\005\366=EC=B8=96\2=
65G\276\332\f\025\271\276\377\177",=20
    flags=3D0x7fff7c5aff2c) at refs.c:169
#4  0x000000000053316e in read_loose_refs (dirname=3D0x4e30f80 "refs/ta=
gs/", dir=3D0x4e30f58) at refs/files-backend.c:1216
#5  0x0000000000531435 in get_ref_dir (entry=3D0x4e30f50) at refs/files=
-backend.c:174
#6  0x000000000053265c in verify_refname_available_dir (
    refname=3D0x1cd9438 "refs/tags/blablablablablablablablablablablabla=
blablablablablablablablablablablablablablablablablabla-12016", extras=3D=
0x7fff7c5b01d0, skip=3D0x0, dir=3D0x4dd6e98, err=3D0x7fff7c5b02a0) at r=
efs/files-backend.c:789
#7  0x0000000000533e44 in lock_raw_ref (
    refname=3D0x1cd9438 "refs/tags/blablablablablablablablablablablabla=
blablablablablablablablablablablablablablablablablabla-12016", mustexis=
t=3D0, extras=3D0x7fff7c5b01d0, skip=3D0x0, lock_p=3D0x1cd9420, referen=
t=3D0x7fff7c5b0140, type=3D0x1cd9428,=20
    err=3D0x7fff7c5b02a0) at refs/files-backend.c:1663
#8  0x00000000005379d7 in lock_ref_for_update (update=3D0x1cd93f0, tran=
saction=3D0x4db0150,=20
    head_ref=3D0x4db0000 "refs/heads/master", affected_refnames=3D0x7ff=
f7c5b01d0, err=3D0x7fff7c5b02a0)
    at refs/files-backend.c:3416
[...]

So I'd expect us to hit that lock_ref_for_update() for each of the new
refs. But then we end up in verify_refname_available_dir(), which wants
to read all of the loose refs again. So we end up with a quadratic
number of calls to read_ref_full().

I haven't found the actual bug yet. It may be something as simple as no=
t
clearing REF_INCOMPLETE from the loose-ref cache when we ought to. But
that's a wild (optimistic) guess.

-Peff
