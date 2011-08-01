From: Jeff King <peff@peff.net>
Subject: Re: Possibly solved invalid free() in git-remote-http from Git
 1.7.2.1
Date: Mon, 1 Aug 2011 12:00:19 -0600
Message-ID: <20110801180018.GA10636@sigill.intra.peff.net>
References: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
 <CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
 <CACBZZX5N0DaSrU6rxW=PTMQ8b6c_sxMFJQHMaZy1L138eFFo6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:00:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwmx-0007gU-4F
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1HASAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 14:00:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36933
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab1HASAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:00:21 -0400
Received: (qmail 20691 invoked by uid 107); 1 Aug 2011 18:00:54 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 14:00:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 12:00:19 -0600
Content-Disposition: inline
In-Reply-To: <CACBZZX5N0DaSrU6rxW=PTMQ8b6c_sxMFJQHMaZy1L138eFFo6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178368>

On Mon, Aug 01, 2011 at 05:42:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Mon, Aug 1, 2011 at 17:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
> > On Mon, Aug 1, 2011 at 17:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> >> In case anyone would like to look into this I had this undiagnosed
> >> free() error from git-remote-http in git version 1.7.2.1:
> >
> > Actually this is still an issue in master, CC-ing Tay who introduce=
d
> > this error.
> >
> > This evil hack would get around it most of the time, but would
> > introduce another race condition:
>=20
> *brainfart*. This would be better:
>=20
>     diff --git a/http.c b/http.c
>     index a1ea3db..c5da23a 100644
>     --- a/http.c
>     +++ b/http.c
>     @@ -1298,7 +1298,7 @@ struct http_object_request
> *new_http_object_request(const char *base_url,
>                             if (ftruncate(freq->localfile, 0) < 0) {
>                                     error("Couldn't truncate temporar=
y
> file %s: %s",
>                                               freq->tmpfile, strerror=
(errno));
>     -                               goto abort;
>     +                               goto abort_url;
>                             }
>                     }
>             }
>     @@ -1328,9 +1328,10 @@ struct http_object_request
> *new_http_object_request(const char *base_url,
>=20
>             return freq;
>=20
>     +abort_url:
>     +       free(freq->url);
>      abort:
>             free(filename);
>     -       free(freq->url);
>             free(freq);
>             return NULL;

Hmm. The memory management in the function seems weird to me.

Why do we free filename only on abort? Are we leaking it otherwise? Eve=
n
weirder, AFAICT, filename can only ever point to the static buffer
returned by sha1_file_name. So it should _never_ be freed. And I'm
surprised glibc's free() checker isn't complaining about that. Am I
reading it wrong?

With respect to freq->url, from your patch I expected that some code
paths would allocate it on the heap, and some would not. But it looks
like there is only one spot, and the problem is that freq is filled wit=
h
uninitialized cruft. Wouldn't it be simpler to just s/xmalloc/xcalloc/,
and then you know all of the pointers are initialized properly to NULL?
You can also get rid of the memset-to-zero later in the function.

-Peff
