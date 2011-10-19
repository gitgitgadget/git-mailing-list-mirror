From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 15:01:14 -0400
Message-ID: <20111019190114.GA4670@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 21:01:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGbOD-0000a7-O6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab1JSTBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 15:01:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35738
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab1JSTBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 15:01:16 -0400
Received: (qmail 31524 invoked by uid 107); 19 Oct 2011 19:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Oct 2011 15:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2011 15:01:14 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183941>

On Wed, Oct 19, 2011 at 08:03:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> This is quick hack I wrote just before leaving work to show that I
> could indeed push patches to our main repository starting with
> 31337. Names hidden to protect the innocent.

Clever and amusing.

> Which in just over a minute will generate, in my case:
>=20
>     $ git show --pretty=3Draw 313375d995e6f8b7773c6ed1ee165e5a9e15690=
b | head -n 7
>     commit 313375d995e6f8b7773c6ed1ee165e5a9e15690b
>     tree c9bebc99c05dfe61cccf02ebdf442945c8ff8b3c
>     parent 0dce2d45a79d26a593f0e12301cdfeb7eb23c17a
>     author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.com> =
<censored> <censored>
>     committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.co=
m> <censored> <censored>
>     lulz 697889

Nice header name.

> I also think it's interesting that we seemingly don't have (in my
> brief search, maybe I missed it) an API for writing a complete commit
> object into a strbuf, so I had to write a lot of commit objects to
> disk, and keep unlinking the unacceptable candidates so the repositor=
y
> wouldn't balloon in size.

Calculating an object sha1 is pretty straightforward. I think you could
just tack the "commit <size>" header in front of the commit strbuf, and
sha1 that, and then just send the "winner" to actually be written.

Too bad it won't work in an append only way.  The internal state of sha=
1
after a certain set of bytes is deterministic, so you could do somethin=
g
like:

  void leetify_object(struct strbuf *data)
  {
          SHA_CTX base, guess;
          int len =3D data->len;
          int i =3D 0;

          /* come up with a base internal state representing
           * the commit */
          SHA1_Init(&base);
          SHA1_Update(&base, data->buf, data->len);

          while (1) {
                  char append[64];
                  int n =3D snprintf(append, sizeof(append),
                                   "x-lulz-by: %d\n", i);
                  unsigned char sha1[20];

                  /* and then from that state, see what the sha1 would
                   * be if we add our few new bytes */
                  memcpy(&guess, &base, sizeof(guess));
                  SHA1_Update(&guess, append, n);
                  SHA1_Final(sha1, &guess);

                  /* did we pick a winner? */
                  if (sha1[0] =3D=3D 0x31 &&
                      sha1[1] =3D=3D 0x33 &&
                      &sha1[2] & 0xf0) =3D=3D 0x70) {
                            strbuf_addstr(data, append);
                            return;
                  }

                  i++;
          }
  }

There are two problems with this:

  1. The x-lulz-by header is visible in the commit message. I think you
     can actually get around this by appending a NUL character, and "gi=
t
     log" and friends will stop processing the commit message there.

  2. The object header will actually have the length of the object at
     the beginning. So as your lulz number grows, the length of the
     object will change, and invalidate your earlier sha1. You could ge=
t
     around this by using a fixed-size guess (e.g., start with 20 bytes
     of zeroes, and then just keep incrementing).

-Peff
