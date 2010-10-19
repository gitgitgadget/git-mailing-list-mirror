From: Joey Hess <joey@kitenet.net>
Subject: git subcommand sigint gotcha
Date: Tue, 19 Oct 2010 00:53:00 -0400
Message-ID: <20101019045300.GA18043@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 07:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P84JI-0004Dw-32
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 07:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab0JSFAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 01:00:22 -0400
Received: from wren.kitenet.net ([80.68.85.49]:34615 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab0JSFAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 01:00:22 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2010 01:00:22 EDT
Received: from gnu.kitenet.net (dialup-4.153.251.152.Dial1.Atlanta1.Level3.net [4.153.251.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 05882119049
	for <git@vger.kernel.org>; Tue, 19 Oct 2010 00:53:05 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 4B2AE48F43; Tue, 19 Oct 2010 00:53:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159304>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was trying to write a git subcommand, and I noticed that if I ctrl-c'd
it, git would return, but leave the subcommand running in the
background.

You can see the problem with this test case.=20

#!/usr/bin/perl
print "first sleep...\n";
$ret=3Dsystem("sleep", "1m");
print "second sleep...\n";
system("sleep", "1s");
print "done with second sleep\n";

If you put it in path named git-sleep, then run "git sleep" and press ctrl-=
c,
it keeps running:

joey@gnu:~>git sleep
first sleep...
^Csecond sleep...
joey@gnu:~>done with second sleep

So what's going on? Well, perl's system() blocks sigint while the child
process is running. So if you run this as git-sleep, and press ctrl-c,
it will continue on to the second sleep. If the code above checked the
return status of system() it could detect that it was killed by SIGINT
and itself exit.

What I don't understand is, why does git not wait() on the subcommand it
ran? Any subcommand that forgets to check exit codes is liable to exhibit
this weird behavior sometimes.=20

Ie, imagine the subcommand was running something like=20
"git config --get core.bare" instead of sleep.=20
It'd be easy to forget to check the exit status of that for a SIGINT; if
the user ctrl-c'd at just the right instant, weird things would happen.

--=20
see shy jo

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTL0kKckQ2SIlEuPHAQgNYQ/+PouPqv5lsPVKA2qdFm9Lovy1tj4lA7rJ
YUV2r6t0iv3pMcF/jug48/wK33C04ZE/REYhAtXryP98zvBDLVc6l/irnyX+GVXQ
9L/JFB/645sAfiPUT7iosLxrup8gadonvvPcSTcEQtIdDba/NVT081Kq9+ipvisq
W3MeQl0ZsYXr5TJlJY+msx4RMMoVjBlnnAN7mALTKBvAZadWvEXrAnY+8eX8QQAw
RhPP5gIxzGR0eRK+31wUhJy/dMPae0DeFjW2ZcrNt8SOtnBX9hO952wJR34zYPLl
Ft4yi9sj/QYhO2kQdfyFnO/IQToQwr2MBhJzxbtP+a1T8pvyW6YYgZj+QbhLpier
gtk7+RZ1s3U7VYoTMavYUz4+fhO0FhBSDOxROvBZBhd+gqf9sQ67Flv0Vl4J/hLL
j1olaXXomfXVJBONQgppuE9gSpZBvNE94pOITEBDAyJaC/YwbbIiK/Uw/IeWGRrx
S6PsL3werS0zUPA96IJpIYF0242S/LadfeF66s1uLyLjxY95pVr0POR+y7FcwVfJ
6PO6Bax4VZsCwNbBpy33GDl7l9Vr5yZFNOnZI9h3tsuJzQlOeDAisLeXJ7c3M1I6
diQ1FryozX1NMer+kBlZBAUIetSIV6QKn8sZ5yDsbiCNiLVI2AHgoV1uDu6H0q47
Kdbi3i7SAYI=
=q2Yq
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
