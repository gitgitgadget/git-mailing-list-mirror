Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9F31FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbdBGPE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 10:04:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754210AbdBGPE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 10:04:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 229868047C;
        Tue,  7 Feb 2017 15:04:18 +0000 (UTC)
Received: from localhost (ovpn-116-85.ams2.redhat.com [10.36.116.85])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v17F4Fv9021362;
        Tue, 7 Feb 2017 10:04:16 -0500
Date:   Tue, 7 Feb 2017 15:04:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
Message-ID: <20170207150414.GD8583@stefanha-x1.localdomain>
References: <20170120171126.16269-1-stefanha@redhat.com>
 <20170120171126.16269-3-stefanha@redhat.com>
 <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
 <20170120235133.GA146274@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <20170120235133.GA146274@google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 07 Feb 2017 15:04:18 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 03:51:33PM -0800, Brandon Williams wrote:
> On 01/20, Junio C Hamano wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >=20
> > > If the tree contains a sub-directory then git-grep(1) output contains=
 a
> > > colon character instead of a path separator:
> > >
> > >   $ git grep malloc v2.9.3:t
> > >   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
> > >   $ git show v2.9.3:t:test-lib.sh
> > >   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
> > >
> > > This patch attempts to use the correct delimiter:
> > >
> > >   $ git grep malloc v2.9.3:t
> > >   v2.9.3:t/test-lib.sh:	setup_malloc_check () {
> > >   $ git show v2.9.3:t/test-lib.sh
> > >   (success)
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  builtin/grep.c  | 4 +++-
> > >  t/t7810-grep.sh | 5 +++++
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/builtin/grep.c b/builtin/grep.c
> > > index 90a4f3d..7a7aab9 100644
> > > --- a/builtin/grep.c
> > > +++ b/builtin/grep.c
> > > @@ -494,7 +494,9 @@ static int grep_object(struct grep_opt *opt, cons=
t struct pathspec *pathspec,
> > > =20
> > >  			/* Add a delimiter if there isn't one already */
> > >  			if (name[len - 1] !=3D '/' && name[len - 1] !=3D ':') {
> > > -				strbuf_addch(&base, ':');
> > > +				/* rev: or rev:path/ */
> > > +				char delim =3D obj->type =3D=3D OBJ_COMMIT ? ':' : '/';
> >=20
> > Why check the equality with commit, rather than un-equality with
> > tree?  Wouldn't you want to treat $commit:path and $tag:path the
> > same way?
>=20
> I assume Stefan just grabbed my naive suggestion hence why it checks
> equality with a commit.  So that's my fault :)  Either of these may
> not be enough though, since if you do 'git grep malloc v2.9.3^{tree}'
> with this change the output prefix is 'v2.9.3^{tree}/' instead of the
> correct prefix 'v2.9.3^{tree}:'

I revisited this series again today and am coming to the conclusion that
forming output based on the user's rev is really hard to get right in
all cases.  I don't have a good solution to the v2.9.3^{tree} problem.

Perhaps it's better to leave this than to merge code that doesn't work
correctly 100% of the time.

Stefan

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYmeHuAAoJEJykq7OBq3PIE0YH/Au+ERnSRa4xpFDVn092EJzx
Yyxc2fXwzOvq6wxjguJy7cfudZidJN/WBANdwG5mtKt21XlRNX5vwW/Yu0WX+FMG
i0D6OeABNAzpftb5UQYdcWIlylU6iiMTdtmHixP+/iOE+7VuOKEzIUsVWK23jomq
JDvjteiD1M7zTtpDTguAhf2aGNPecgRFoBE78lWrO4edo6str1os0+2pHAzyQazr
+izDlMPGq1DHbVtaJ41hPwqcqzmQnkRabC0SRqw9StaPhztQitKFD3SQq9I80Zff
HlHYloE4b0NPSQP9oCa49eJ7Vh6rN8JAZK+lvpmqNfqiP0dsQN2FrKkTCeMmC0g=
=gSW9
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
