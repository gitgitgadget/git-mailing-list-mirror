Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7CE20756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdATORb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:17:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbdATOR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:17:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE38B7FEAD;
        Fri, 20 Jan 2017 14:17:12 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KEHBnw012420;
        Fri, 20 Jan 2017 09:17:12 -0500
Date:   Fri, 20 Jan 2017 14:17:10 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
Message-ID: <20170120141710.GD17499@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-3-stefanha@redhat.com>
 <20170119182934.GH10641@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20170119182934.GH10641@google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 20 Jan 2017 14:17:12 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 10:29:34AM -0800, Brandon Williams wrote:
> On 01/19, Stefan Hajnoczi wrote:
> > If the tree contains a sub-directory then git-grep(1) output contains a
> > colon character instead of a path separator:
> >=20
> >   $ git grep malloc v2.9.3:t
> >   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
> >   $ git show v2.9.3:t:test-lib.sh
> >   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
> >=20
> > This patch attempts to use the correct delimiter:
> >=20
> >   $ git grep malloc v2.9.3:t
> >   v2.9.3:t/test-lib.sh:	setup_malloc_check () {
> >   $ git show v2.9.3:t/test-lib.sh
> >   (success)
> >=20
> > This patch does not cope with @{1979-02-26 18:30:00} syntax and treats
> > it as a path because it contains colons.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  builtin/grep.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 3643d8a..06f8b47 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -493,7 +493,8 @@ static int grep_object(struct grep_opt *opt, const =
struct pathspec *pathspec,
> > =20
> >  			/* Add a delimiter if there isn't one already */
> >  			if (name[len - 1] !=3D '/' && name[len - 1] !=3D ':') {
> > -				strbuf_addch(&base, ':');
> > +				/* rev: or rev:path/ */
> > +				strbuf_addch(&base, strchr(name, ':') ? '/' : ':');
>=20
> As Jeff mentioned it may be better to base which character gets appended
> by checking the obj->type field like this maybe:
>=20
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 69dab5dc5..9dfe11dc7 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -495,7 +495,8 @@ static int grep_object(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
>  			/* Add a delimiter if there isn't one already */
>  			if (name[len - 1] !=3D '/' && name[len - 1] !=3D ':') {
>  				/* rev: or rev:path/ */
> -				strbuf_addch(&base, strchr(name, ':') ? '/' : ':');
> +				char del =3D obj->type =3D=3D OBJ_COMMIT ? ':' : '/';
> +				strbuf_addch(&base, del);

Nice, that also solves the false positive with @{1979-02-26 18:30:00}.

Stefan

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYghvmAAoJEJykq7OBq3PIpRUH/1kRMQZhO4HdCKU+VByOEwiz
+IUudkDFlCV+0b8dY59aqxQAQToO2xpFqTxAdz9xOiDu3S2sgVUmYxhj0+leCJ80
1JnwJb7Kb4MJkE6jGGMjKGjZQ3UqtcONIRLydC48MO7N5EAbG1FRm8le2TxRMnFe
cQuoy5NeUN7bg2Mhlb/koU+DdVXTr6xKZvX9rqtlFH/TzG7poKUxWj3TFlVM42SB
NVO//sl8s9zPgr8FPtNKkgZ1P0jHxldHW2cGOy24DMKBHFIofBk0xMhUhttJAQdq
CyfnC8hhglwvncnoNOIGmZzU4B5ASX1TXNvVJQnaCWezoCAVmh1HlsmvUnPr0WY=
=2hLL
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
