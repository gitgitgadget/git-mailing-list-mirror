From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: use strlcpy() to copy strings
Date: Mon, 23 Feb 2015 13:36:09 -0500
Message-ID: <20150223183609.GC19904@peff.net>
References: <54E8E2AA.1020300@web.de>
 <xmqqsidxvhrk.fsf@gitster.dls.corp.google.com>
 <54EA592C.6040701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPxrd-0003bX-V6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbbBWSgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2015 13:36:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52404 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752403AbbBWSgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:36:12 -0500
Received: (qmail 24031 invoked by uid 102); 23 Feb 2015 18:36:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 12:36:11 -0600
Received: (qmail 26391 invoked by uid 107); 23 Feb 2015 18:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 13:36:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2015 13:36:09 -0500
Content-Disposition: inline
In-Reply-To: <54EA592C.6040701@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264280>

On Sun, Feb 22, 2015 at 11:33:16PM +0100, Ren=C3=A9 Scharfe wrote:

> Am 22.02.2015 um 21:00 schrieb Junio C Hamano:
> >Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> >
> >>Use strlcpy() instead of calling strncpy() and then setting the las=
t
> >>byte of the target buffer to NUL explicitly.  This shortens and
> >>simplifies the code a bit.
> >
> >Thanks.  It makes me wonder if the longer term direction should be
> >not to use a bound buffer for oc->path, though.
>=20
> That's a good idea in general, but a bit more involved since we'd nee=
d to
> introduce a cleanup function that releases the memory allocated by th=
e new
> version of get_sha1_with_context() first and call it from the appropr=
iate
> places.
>=20
> Would that be a good micro-project for GSoC or is it too simple?

Yeah, avoiding resource ownership questions was one of the reasons I
went with the static buffer in the first place. But I would love to see
it go away. Not only does it potentially truncate paths, but I recall
there was some complication with the size of "struct object_context" (I
couldn't find the details in a cursory search, but basically it was not
reasonable to have a big array of them).

Could we perhaps make this more like sha1_object_info_extended, where
the caller "asks" for fields by filling in pointers, and the
object_context itself can be discarded without leaking resources?

Like:

  struct strbuf path =3D STRBUF_INIT;
  struct object_context oc =3D OBJECT_CONTEXT_INIT;

  oc.path =3D &path;
  get_sha1_with_context(sha1, &oc);

  ... use path directly ...
  strbuf_release(&path);

Then callers who do not care about the path do not have to even know th=
e
feature exists (and it opens us up to adding new string-like context
fields in the future if we need to).

-Peff
