Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC3BE5F
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4410F
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:06:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r0GAW-0006Na-39; Tue, 07 Nov 2023 08:06:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r0GAT-007EOl-Gh; Tue, 07 Nov 2023 08:06:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r0GAT-00EJak-5z; Tue, 07 Nov 2023 08:06:33 +0100
Date: Tue, 7 Nov 2023 08:06:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Douglas Anderson <dianders@chromium.org>, git@vger.kernel.org,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email Message-Id: numbering doesn't start
 at 1 any more
Message-ID: <20231107070632.spe3cappk5b5jg3q@pengutronix.de>
References: <20231106153214.s5abourejkuiwk64@pengutronix.de>
 <xmqqwmuucwi9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xg3pq2j6dilluvxm"
Content-Disposition: inline
In-Reply-To: <xmqqwmuucwi9.fsf@gitster.g>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--xg3pq2j6dilluvxm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Junio,

On Tue, Nov 07, 2023 at 08:06:22AM +0900, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > Hello,
> >
> > Since commit 3ece9bf0f9e24909b090cf348d89e8920bd4f82f I experience that
> > the generated Message-Ids don't start at ....-1-... any more. I have:
> >
> > $ git send-email w/*
> > ...
> > Subject: [PATCH 0/5] watchdog: Drop platform_driver_probe() and convert=
 to platform remove callback returning void (part II)
> > Date: Mon,  6 Nov 2023 16:10:04 +0100
> > Message-ID: <20231106151003.3844134-7-u.kleine-koenig@pengutronix.de>
> > ...
> >
> > So the cover letter is sent with Message-Id: ...-7-...
>=20
> The above is consistent with the fact that a 5-patch series with a
> cover letter consists of 6 messages.  Dry-run uses message numbers
> 1-6 and forgets to reset the counter, so the next message becomes 7.
> As you identified, the fix in 3ece9bf0 (send-email: clear the
> $message_id after validation, 2023-05-17) for the fallout from an
> even earlier change to process each message twice still had left an
> observable side effect subject to the Hyrum's law, it seems.
>=20
> > +my ($message_id_stamp, $message_id_serial);
> >  if ($validate) {
> >  	# FIFOs can only be read once, exclude them from validation.
> >  	my @real_files =3D ();
> > @@ -821,6 +822,7 @@ sub is_format_patch_arg {
> >  	}
> >  	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
> >  	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
> > +	$message_id_serial =3D 0;
> >  }
>=20
> This fix looks quite logical to me, but even with this, the side
> effects of the earlier "read message twice" persists in end-user
> observable form, don't they?  IIRC, when sending out an N message
> series, we start from the timestamp as of N seconds ago and give
> each message the Date: header that increments by 1 second, which
> would mean the validator will see Date: that is different from what
> will actually be sent out, and more importantly, the messages sent
> out for real will have timestamps from the future, negating the
> point of starting from N seconds ago in the first place.

The series I used as an example here was finally sent out with
git-send-email patched with my suggested change.

The Message-Ids involved are:

	20231106154807.3866712-1-u.kleine-koenig@pengutronix.de
	20231106154807.3866712-2-u.kleine-koenig@pengutronix.de
	20231106154807.3866712-3-u.kleine-koenig@pengutronix.de
	20231106154807.3866712-4-u.kleine-koenig@pengutronix.de
	20231106154807.3866712-5-u.kleine-koenig@pengutronix.de
	20231106154807.3866712-6-u.kleine-koenig@pengutronix.de

So the Ids are are identical apart from the number this report is about.

> Your script may not have been paying attention to it and only noticed
> the difference in id_serial, but somebody else would complain the
> difference coming from calling gen_header more than once for each
> messages since a8022c5f (send-email: expose header information to
> git-send-email's sendemail-validate hook, 2023-04-19).
>=20
> So, I dunno.  Michael, what do you think?  It appears to me that a
> more fundamental fix to the fallout from a8022c5f might be needed
> (e.g., we still let gen_header run while validating, but once
> validation is done, save the headers that validator saw and use them
> without calling gen_header again when we send the messages out, or
> something), if we truly want to be regression free.

That sounds sane.

> By the way, out of curiosity, earlier you said your script looks at
> the Message-IDs and counts the number of messages.  How does it do
> that?  Does it read the output of send-email and pass the messages
> to MTA for sending out for real?

The output of git send-email dumps the messages it sends out and then I
pick the message-id of the last mail by cut-n-paste and call my script
with that as a parameter. It then adds notes to the $commitcount topmost
commits such that I have something like this on the sent out commits:

	Notes:
	    Forwarded: id:20231106154807.3866712-2-u.kleine-koenig@pengutronix.de =
(v1)

This is very convenient to find the thread to ping if a patch doesn't
make it into the next release.

(By the way, one difficulty in my script is that depending on the series
having a cover letter or not I have to apply the id:....-1-... marker or
not. Would be great if git send-email started with ...-0-... for a
series with a cover letter. Detecting that reliably isn't trivial I
guess.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xg3pq2j6dilluvxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVJ4fgACgkQj4D7WH0S
/k4Q4Af9FEfl4iQuUrUsCWu4Mlewm68NxxooIwG6PYfYKz7GuohPDglcyrhlwCSA
KPbgfURtzvzp4r6uYUAk6EmnDrVU4Ec83VFb2qGh3BaJld85mpSRRngs22kDzwpa
hC1xMXkzHmd/tMcqt8hmGdnuobl3Bi6cnR51nIBfIrdy8yZtyrmKeSkypnfkN9m2
62BKQAWTU3qYZ9W+wWozaYDFTrxchAgbvbKe4PG3uInf+APSv3L+k3Il+6JtI8mK
+KuviPD8waYpaDngxmabHiLb6qrD7O0HDmbeQVjBCc/QkuFH0j2bOM7/APc97qAU
r+EGnDuWzI9AynTlCLg3YT3DqIzK1w==
=coou
-----END PGP SIGNATURE-----

--xg3pq2j6dilluvxm--
