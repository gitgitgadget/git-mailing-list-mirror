From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sun, 4 Oct 2015 23:41:26 -0400
Message-ID: <20151005034126.GA5639@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net>
 <560F6E98.8030305@web.de>
 <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com>
 <561044AD.8010803@web.de>
 <20151004033713.GB20876@sigill.intra.peff.net>
 <5610C7C3.807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 05:41:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ziwec-0002uR-St
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 05:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbbJEDla convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2015 23:41:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:39526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbbJEDl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 23:41:29 -0400
Received: (qmail 30122 invoked by uid 102); 5 Oct 2015 03:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 22:41:29 -0500
Received: (qmail 11667 invoked by uid 107); 5 Oct 2015 03:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 23:41:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2015 23:41:26 -0400
Content-Disposition: inline
In-Reply-To: <5610C7C3.807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279030>

On Sun, Oct 04, 2015 at 08:31:31AM +0200, Torsten B=C3=B6gershausen wro=
te:

> > That is the original signature, before my sprintf series. I do not =
mind
> > leaving that as-is, and simply cleaning up probe_utf8_pathname_comp=
osition
> > by using a strbuf internally there. Though I have to wonder if it e=
ven
> > needs us to pass _anything_ at that point. It could just call
> > git_path_buf("config%s", auml_nfd) itself. The whole reason to pass
> > anything was to let it reuse the buffer the caller had.
> >
> > -Peff
> Makes sense, here is V2:

Yeah, I think this is much nicer.

And because it decouples the interface between init-db.c and the
precompose code, it is easy to do it as a separate patch before the
init-db one.

> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index b4dd3c7..64b85f2 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -8,6 +8,7 @@
>  #include "cache.h"
>  #include "utf8.h"
>  #include "precompose_utf8.h"
> +#include "strbuf.h"

I think this is actually redundant; it is part of cache.h included abov=
e
(and the precompose_utf8.h header file does not need to care anymore,
since the strbuf is not part of the interface).

> -void probe_utf8_pathname_composition(struct strbuf *path)
> +void probe_utf8_pathname_composition(void)
>  {
> +    struct strbuf sbuf =3D STRBUF_INIT;
>      static const char *auml_nfc =3D "\xc3\xa4";
>      static const char *auml_nfd =3D "\x61\xcc\x88";
> -    size_t baselen =3D path->len;
> +    const char *path;

I don't think we need this separate "path"; we can just access the
strbuf directly (that makes the diff a little noisier, but I think the
end result is simpler).

> diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
> index 7fc7be5..a94e7c4 100644
> --- a/compat/precompose_utf8.h
> +++ b/compat/precompose_utf8.h
> @@ -27,7 +27,7 @@ typedef struct {
>  } PREC_DIR;
> =20
>  void precompose_argv(int argc, const char **argv);
> -void probe_utf8_pathname_composition(struct strbuf *path);
> +void probe_utf8_pathname_composition(void);

I think we need a similar fix for the compat macro to build on non-Mac
platforms.

Here's a mini-series I came up with, which I hope is polished enough fo=
r
Junio to apply as a drop-in replacement for the "init: use strbufs"
patch from my original series. I compiled-tested it on Linux, with and
without precompose_utf8.o support hacked in. I don't have access to an
OS X machine to test on, so I'd appreciate confirmation that t3910 stil=
l
passes there.

  [1/3]: precompose_utf8: drop unused variable
  [2/3]: probe_utf8_pathname_composition: use internal strbuf
  [3/3]: init: use strbufs to store paths

-Peff
