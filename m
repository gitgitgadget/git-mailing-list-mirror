From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 12:45:37 +0000
Message-ID: <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1gsfN/+pS0/2Ta7u"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5Oa-0003Do-SM
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab3GEMpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:45:49 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:47164
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757225Ab3GEMps (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 08:45:48 -0400
Received: from omta09.emeryville.ca.mail.comcast.net ([76.96.30.20])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id wcd61l0030S2fkC01cln6s; Fri, 05 Jul 2013 12:45:47 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta09.emeryville.ca.mail.comcast.net with comcast
	id wclm1l00325wmie8VclnSj; Fri, 05 Jul 2013 12:45:47 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AA22C28057;
	Fri,  5 Jul 2013 12:45:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1373025947-26495-3-git-send-email-artagnon@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373028347;
	bh=81nS/oZ4Vk4so0kFHDIdwq4A0mhEvZApQc4ntaKMSNA=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=IQf30eDy9lRuvqzmgUnZhnSnbIDnNBbhbEZIaJsducdu/WUQ2ODO/BliBgmAXTYmv
	 a06WoYKewNp1vdfZNFtu2hpouKd4LI185+vUHdSTacILzoWovCv6NOSnsbhjCDCDaF
	 fjM+e9QGTjenenZoapefvnM+ET74QU7gkXEIH2AcXeT5CJrca3ry3iQlA/Em3vT89h
	 g1xkq38fO7hD1E1TzuPNl3TrLsQ8VlwE0L+102IZLQrsmoxAiyocBQBYihp24KirtJ
	 8wmZq6SuG+HTqkngefpTJUPSynpguUKfd7ShqvQkE2Emsk3kNhaaJq22LHLc0MIr/F
	 si+lrGY18Faag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229662>


--1gsfN/+pS0/2Ta7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 05:35:47PM +0530, Ramkumar Ramachandra wrote:
> @@ -1193,13 +1197,23 @@ X-Mailer: git-send-email $gitversion
>  						 Debug =3D> $debug_net_smtp);
>  			if ($smtp_encryption eq 'tls' && $smtp) {
>  				require Net::SMTP::SSL;
> -				use IO::Socket::SSL qw(SSL_VERIFY_NONE);
> +				use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
>  				$smtp->command('STARTTLS');
>  				$smtp->response();
>  				if ($smtp->code =3D=3D 220) {
> -					$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
> -									  SSL_verify_mode =3D> SSL_VERIFY_NONE)
> -						or die "STARTTLS failed! ".$smtp->message;
> +					# Attempt to use a ca-certificate by default
> +					$smtp_ssl_cert_path |=3D "/etc/ssl/certs";
> +					if (-d $smtp_ssl_cert_path) {
> +						$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
> +										  SSL_verify_mode =3D> SSL_VERIFY_PEER,
> +										  SSL_ca_path =3D> $smtp_ssl_cert_path)
> +							or die "STARTTLS failed! ".$smtp->message;
> +					} else {
> +						print STDERR "warning: Using SSL_VERIFY_NONE.  See sendemail.smtps=
slcertpath.\n";
> +						$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
> +										  SSL_verify_mode =3D> SSL_VERIFY_NONE)
> +							or die "STARTTLS failed! ".$smtp->message;
> +					}

You've covered the STARTTLS case, but not the SSL one right above it.
Someone using smtps on port 465 will still see the warning.  You can
pass SSL_verify_mode to Net::SMTP::SSL->new just like you pass it to
start_SSL.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--1gsfN/+pS0/2Ta7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1r/wAAoJEL9TXYEfUvaLRuoP/jAIO/3JYN8MYt4yZRts58ZC
1pskWOrLtK9fex+ejt/oDAdFFKW7IF1PM/AUWAH/OoTx7okSuscwc+Zjpgb3BNIY
yM3k8hFcZ5ir8BEGkz0re45Vhv78X9eHnsFxm2/YxbiGdEOGnI6iQlo3wFeAF5n3
FbxIO1jwFhoI+J7aV+FvIOqsMNvy7gZhm+i/7+18MjEhFI2JLUGTTE1YM2CBWTL0
+B2DgOPYDzZH9eP+OKTMxHTWsUbCsNyNjBcotaVG71B7NvriVxjrlg748c20yn5Y
cJrzHouKd6iVdNL1ablTyDvkgkyG+JfPOHrpbU8VgJ5mXOawnrZvbnI5nWSYQXAk
xY/eQn52Modk3o+itlyYjiWzvU8uJZDE0ZpM4rM2YOI0WGpbhCNEbAIkAtc7kKNK
DrK9uXbkrtKwaSenYAGWKzmke0DHxoPs2STMRBKc/eDA6pBiCU9+8p72v3VucP4I
d+vOKTeLLqxD7n2EIvwHx3+q4b4biAJjXZzsKW0TBpd3+mqrIvxaajLZq+JE3Lwh
bLNGdlearUglEpjzBuFBZthHv5srU9ZCA77UsYwddwKve6NUiu76G4S4oyQ5sGfx
G4hT9mz6iWtMrH8oFzJ3P9eWyKWDryq6ZoueCYNizzg391SjsS4G60G5nV+rATdj
d7z9UR0WxLYCbnr8dhHg
=UFtr
-----END PGP SIGNATURE-----

--1gsfN/+pS0/2Ta7u--
