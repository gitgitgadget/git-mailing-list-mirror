From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Latest builtin-commit series
Date: Wed, 19 Sep 2007 00:31:19 +0200
Message-ID: <20070918223119.GA4535@artemis.corp>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zYM0uCDKw75PZbzx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlbP-0004vX-TP
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbXIRWbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbXIRWbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:31:25 -0400
Received: from pan.madism.org ([88.191.52.104]:34836 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbXIRWbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:31:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0663B208A9;
	Wed, 19 Sep 2007 00:31:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3F4A1344ABC; Wed, 19 Sep 2007 00:31:19 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1190129009.23692.24.camel@hinata.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58643>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 03:23:29PM +0000, Kristian H=C3=B8gsberg wrote:
>       * rebase to Pierres strbuf changes.  Note, there is still some
>         strbuf tweaking required, to let stripspace work on a strbuf.

  Yeah I wondered if that would be a gain to migrate stripspace as a
first class citizen strbuf function. Note though, that if you always
want to stripspace in place, changing it is an overkill. I mean, there
isn't a lot of gain, as making it work on a strbuf is just a matter of:

    strbuf_setlen(&buf, stripspaces(buf.buf, buf.len));

If you want to do sth like:

    stripspaces(&buf, some_other_string);

And see the stripped version of "some_other_string" appended to the
strbuf "buf", then yes, it's not trivial to use the current stripspaces
as is.


General Note:
~~~~~~~~~~~~

  As a general rule, and I say this to the list, not only to you,
strbufs should not be used everywhere. It may _look_ like I'm peeing
over all the code putting strbufs anywhere I can, it's not true.
Strbuf's can help for two things:
  * the obvious: dealing with variable length strings, it's the least
    they can do.
  * be used as reused, variable length buffer, instead of loops that do:
      for (;;) {
         char *foo =3D xmalloc(...);
         [...]
         free(foo);
      }
    here, you can have a strbuf outside of the loop, and just reset it
    at the begining of the loop. You'll then work on a buffer that will
    stop beeing reallocated at some point. This make allocation patterns
    better.

  Strbuf's are not especially convenient when it comes to parsing.
Unlike the bstring's that have been discussed here recently, I don't
mean strbuf's to supersede all the standard C string API, because when
it comes to parsing, as soon as your buffers are properly NUL
terminated, C functions are _not_ usafe, no matter what people say.
strchr/memchr, strc?spn, strn?cmp/memcmp, ... are very efficient, and
there is little point to hide them behind stupid strbuf's APIs. Hence,
when it comes to parsing, you just fallback to a string, whose length is
known[0].

  That's the reason why I won't probably be the one converting
builtin-mailinfo.c to strbuf's because there is very little point to do
so in the current state of the art.


Cheers,


  [0] that allows to fallback to memchr[1] instead of strchr, which is
      slightly faster I'm told.

  [1] Note that you must be sure you don't have embedded NULs or memchr
      and strchr won't have the same result then ;)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8FG3vGr7W6HudhwRAjowAJ0cpmKlXX3QgFsCDgQpNnpiew0BOACdFCAP
3PRapo2R0Pt6+mVmQkQb8Dg=
=X2Pr
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
