From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Mon, 5 Oct 2015 22:16:19 +0200
Message-ID: <20151005201619.GA386@cruxbox>
References: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
 <20151005194134.GD11993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCBq-0004zI-Hp
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbJEUQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2015 16:16:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47221 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbJEUQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 16:16:13 -0400
Received: from mfilter48-d.gandi.net (mfilter48-d.gandi.net [217.70.178.179])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id D623BA80B9;
	Mon,  5 Oct 2015 22:16:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter48-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter48-d.gandi.net (mfilter48-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id XT7dZZyqW1AG; Mon,  5 Oct 2015 22:16:10 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 12A11A80B0;
	Mon,  5 Oct 2015 22:16:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151005194134.GD11993@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279076>

On Mon, Oct 05, 2015 at 12:41:34PM -0700, Jonathan Nieder wrote:
> Remi Pommarel wrote:

[...]

> Based on this dependency, shouldn't CURL_LIBCURL always include -lssl=
 when
> statically linking?  How does this relate to NEEDS_SSL_WITH_CURL?

In fact libcurl will only need -lssl when the curl library has been
statically compiled with ssl support. That is why NEEDS_SSL_WITH_CURL i=
s
useful.

>=20
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1029,7 +1029,6 @@ ifdef HAVE_ALLOCA_H
> >  endif
> > =20
> >  IMAP_SEND_BUILDDEPS =3D
> > -IMAP_SEND_LDFLAGS =3D $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CR=
YPTO)
>=20
> To protect against a value that might leak in from the environment, t=
his
> should say
>=20
> 	IMAP_SEND_LDFLAGS =3D
>=20
> [...]

Oups my bad.

> > @@ -1971,10 +1971,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BU=
ILDDEPS) GIT-LDFLAGS $(GITLIBS)
> > =20
> >  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(=
GITLIBS)
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) \
> > -		$(LIBS) $(CURL_LIBCURL)
> > +		$(CURL_LIBCURL) $(LIBS)
>=20
> What happens in the NEEDS_SSL_WITH_CURL=3DYes case?
>=20

In the NEEDS_SSL_WITH_CURL=3DYesPlease case, $(CURL_LIBCURL) will be
"-lcurl -lssl" and $(LIBS) will have "... -lz". That's important to put
$(LIBS) at the end because libcurl will also need symbols from zlib.

Maybe taking the -lssl example here could be misleading. In fact, putti=
ng
$(LIBS) at the end really fix the libcurl's need for zlib and libintl.

> >  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
> >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) \
> > -		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> > +		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>=20
> Same question.
>=20
> I guess the general principle is that $(LIBS) should always go at the
> end.  (That would make sense to me.)
>=20
> Ideally this would be two patches:
>=20
>  - one putting $(LIBS) at the end everywhere, which is the simple par=
t of the change
>  - a second doing some appropriate thing to turn on NEEDS_SSL_WITH_CU=
RL when appropriate
>    or something
>=20
> Sensible?

Agreed, that is why I have sent another patch here
http://marc.info/?l=3Dgit&m=3D144312206220612. This patch make ./config=
ure
to autodetect for libcurl's need for -lssl.

Thanks

--=20
R=C3=A9mi
