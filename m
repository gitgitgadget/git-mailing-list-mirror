From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] gc: make --prune useful again by accepting an optional parameter
Date: Sat, 14 Feb 2009 22:33:02 +0100
Message-ID: <200902142233.07190.trast@student.ethz.ch>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214074954.7e423dd2@perceptron> <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25727240.oR6OpnucAz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jan =?utf-8?q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSA3-0000mo-0T
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbZBNVdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbZBNVdS
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:33:18 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:34376 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbZBNVdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:33:16 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 22:33:15 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 22:33:14 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Feb 2009 21:33:14.0912 (UTC) FILETIME=[D8003200:01C98EEB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109935>

--nextPart25727240.oR6OpnucAz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> With this patch, "git gc --no-prune" will not prune any loose (and
> dangling) object, and "git gc --prune=3D5.minutes.ago" will prune
> all loose objects older than 5 minutes.

Prompted by discussion on IRC, I just spent some time staring at the
code, and for the code part and FWIW,

  Acked-by: Thomas Rast <trast@student.ethz.ch>

Meaning that for all I can see, it handles every combination of
config, --prune and --no-prune correctly.

I have some non-code nits however:

> +--prune=3D<date>::
> +	Prune loose objects older than date (default is 2 weeks ago).
> +	This option is on by default.

This isn't really true; to the user, it defaults to the value of
'gc.pruneExpire'.  That this is done by defaulting the state of
=2D-prune to 2 weeks ago is an implementation detail.

> +		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
> +			"prune unreferenced objects (deprecated)",
> +			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },

You still call the option "deprecated" :-)

> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
[...]
> +test_expect_success 'gc --no-prune && gc --prune=3D<date>' '
> +
> +	before=3D$(git count-objects | sed "s/ .*//") &&
> +	BLOB=3D$(echo aleph_0 | git hash-object -w --stdin) &&
> +	BLOB_FILE=3D.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
> +	test $((1 + $before)) =3D $(git count-objects | sed "s/ .*//") &&
> +	test -f $BLOB_FILE &&
> +	test-chmtime =3D-$((86400*5001)) $BLOB_FILE &&
> +	git gc --no-prune &&
> +	test 1 =3D $(git count-objects | sed "s/ .*//") &&
> +	test -f $BLOB_FILE &&
> +	git gc --prune=3D5002.days.ago &&
> +	test 1 =3D $(git count-objects | sed "s/ .*//") &&
> +	test -f $BLOB_FILE &&
> +	git gc --prune=3D5000.days.ago &&
> +	test 0 =3D $(git count-objects | sed "s/ .*//") &&
> +	test ! -f $BLOB_FILE
> +
> +'
> +

I'm not a huge fan of such contiguous blocks, as a failure is harder
to pin to any of the several tests inside, especially with 'test' not
showing any output when it fails.

Also, it does test the interaction between having gc.pruneExpire set,
but passing --no-prune: the tests above leave gc.pruneExpire at
"2.days.ago".  This wasn't immediately obvious however, and you should
probably set the config again just in case someone decides to insert a
test with a different value.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart25727240.oR6OpnucAz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmXOJMACgkQqUud07tmzP16MACdEI7c1p+BXH8xbGTyar8BSp4V
Ts0AniX+OlP8NFLlQAMYtRdfwGvkLkqm
=rJQa
-----END PGP SIGNATURE-----

--nextPart25727240.oR6OpnucAz--
