Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01B28E07
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9C100
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 07:32:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r01aL-0005A6-Dp; Mon, 06 Nov 2023 16:32:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r01aJ-0074kH-1Z; Mon, 06 Nov 2023 16:32:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r01aI-00DmBo-Ob; Mon, 06 Nov 2023 16:32:14 +0100
Date: Mon, 6 Nov 2023 16:32:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Douglas Anderson <dianders@chromium.org>,
	entwicklung@pengutronix.de
Subject: Regression: git send-email Message-Id: numbering doesn't start at 1
 any more
Message-ID: <20231106153214.s5abourejkuiwk64@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlqy5rpm7gnuj6li"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--dlqy5rpm7gnuj6li
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Since commit 3ece9bf0f9e24909b090cf348d89e8920bd4f82f I experience that
the generated Message-Ids don't start at ....-1-... any more. I have:

$ git send-email w/*
=2E..
Subject: [PATCH 0/5] watchdog: Drop platform_driver_probe() and convert to =
platform remove callback returning void (part II)
Date: Mon,  6 Nov 2023 16:10:04 +0100
Message-ID: <20231106151003.3844134-7-u.kleine-koenig@pengutronix.de>
=2E..

So the cover letter is sent with Message-Id: ...-7-...

Before above mentioned commit I had:

=2E..
Message-ID: <20231106151003.3844134-1-u.kleine-koenig@pengutronix.de>
=2E..

Similar to my earlier regression report this also only happens in the
presence of a sendemail-validate hook. Passing --no-validate works
around this issue.

While this isn't an issue for git itself, it breaks one of my scripts
that knows how to determine the number of patches in a series from the
last Message-Id:.

The following patch works for me:

diff --git a/git-send-email.perl b/git-send-email.perl
index 9e21b0b3f43a..095a3d9dd720 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -799,6 +799,7 @@ sub is_format_patch_arg {
=20
 $time =3D time - scalar $#files;
=20
+my ($message_id_stamp, $message_id_serial);
 if ($validate) {
 	# FIFOs can only be read once, exclude them from validation.
 	my @real_files =3D ();
@@ -821,6 +822,7 @@ sub is_format_patch_arg {
 	}
 	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
 	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
+	$message_id_serial =3D 0;
 }
=20
 @files =3D handle_backup_files(@files);
@@ -1181,7 +1183,6 @@ sub validate_address_list {
=20
 # We'll setup a template for the message id, using the "from" address:
=20
-my ($message_id_stamp, $message_id_serial);
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {

But I guess this could be done prettier by someone who is fluent in
Perl.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dlqy5rpm7gnuj6li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVJBv0ACgkQj4D7WH0S
/k6W3wf/Zy2acywfewElUld6uL7akvOtZ1ymCch+zr9zlgHpNoVAa7XMkYHXNjiC
0J5fimuelWe6H+jANH1wd5pEvLYovAZ5Ni8dXGVuYaCuZ0cKG4Ljd+CrT/bh8Lt4
AnvnS4qBcDECVpqrS7SBFMnPy/PB/GmB1sYhNEDooh2zeyLjfeXq+2SHJ/gZLxZM
52U4EaeqO4ehSqR2Rdg2GspPK6aF0pfnY8BtvJAn0thwkXfjsUs0gGZGSLfy8ZVm
aun0jeLKa0Lp8pwqo91feFgvrC+VjWWjofgpdCx66bGwTl6gtbMruqo7K5qnNa54
eZBcKy71p9IWdRf9hjE5gHuLSfsk7A==
=9rbO
-----END PGP SIGNATURE-----

--dlqy5rpm7gnuj6li--
