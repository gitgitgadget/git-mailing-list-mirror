From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 03:06:09 +0200
Message-ID: <20080627010609.GJ29404@genesis.frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1QNVEJ+caSPQxLiY"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 03:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC2Qf-00014f-6w
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 03:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbYF0BGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 21:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbYF0BGP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 21:06:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34877 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285AbYF0BGN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 21:06:13 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8571D1B24FF;
	Fri, 27 Jun 2008 03:06:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A94BE44668;
	Fri, 27 Jun 2008 02:39:51 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1ABC1177001C; Fri, 27 Jun 2008 03:06:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486270D5.5050204@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86511>


--1QNVEJ+caSPQxLiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2008 at 06:22:45PM +0200, Olivier Marin <dkr+ml.git@free.fr=
> wrote:
> > +	if (new_head && show_diffstat) {
> > +		diff_setup(&opts);
> > +		opts.output_format |=3D
> > +			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> > +		opts.detect_rename =3D DIFF_DETECT_RENAME;
>=20
> You probably want to add DIFF_OPT_SET(&opts, COLOR_DIFF) to have a nice c=
olored diff
> like the original script.

That would always turn colors on.

This should respect diff.color:

diff --git a/builtin-merge.c b/builtin-merge.c
index 66189d2..c2a32ee 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -331,6 +331,8 @@ static void finish(const unsigned char *new_head, const=
 char *msg)
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
+		if (diff_use_color_default > 0)
+			DIFF_OPT_SET(&opts, COLOR_DIFF);
 		diff_tree_sha1(head, new_head, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
@@ -693,6 +695,7 @@ int cmd_merge(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	git_config(git_merge_config, NULL);
+	git_config(git_diff_ui_config, NULL);
=20
 	argc =3D parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);

> > +int cmd_merge(int argc, const char **argv, const char *prefix)
> > +{
>=20
> [...]
>=20
> > +	} else if (allow_fast_forward && !remoteheads->next &&
> > +		!hashcmp(common->item->object.sha1, head)) {
> > +		/* Again the most common case of merging one remote. */
> > +		struct strbuf msg;
> > +		struct object *o;
> > +
> > +		printf("Updating %s..%s\n",
> > +			find_unique_abbrev(head, DEFAULT_ABBREV),
> > +			find_unique_abbrev(remoteheads->item->object.sha1,
> > +			DEFAULT_ABBREV));
>=20
> Here, the second call to find_unique_abbrev() will overwrite the previous=
 returned
> value because this function return a pointer to a static buffer.

This should fix it:

diff --git a/builtin-merge.c b/builtin-merge.c
index cc04d01..77de9e8 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -836,9 +836,12 @@ int cmd_merge(int argc, const char **argv, const char =
*prefix)
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg;
 		struct object *o;
+		char hex[41];
+
+		memcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV), 41);
=20
 		printf("Updating %s..%s\n",
-			find_unique_abbrev(head, DEFAULT_ABBREV),
+			hex,
 			find_unique_abbrev(remoteheads->item->object.sha1,
 			DEFAULT_ABBREV));
 		refresh_cache(REFRESH_QUIET);

I pushed both to my working branch and I'll send proper patches to this
list among with other small changes soon.

Thanks!

--1QNVEJ+caSPQxLiY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhkPQEACgkQe81tAgORUJZIEwCeMEldwa6Y7maM4De9SgNxU3vM
AtEAn0fwEQtLTG3nJBj3Cc47pTi55QFf
=4kn2
-----END PGP SIGNATURE-----

--1QNVEJ+caSPQxLiY--
