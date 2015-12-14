From: Florian Bruhin <me@the-compiler.org>
Subject: git bisect with temporary commits
Date: Mon, 14 Dec 2015 17:37:26 +0100
Message-ID: <20151214163726.GY13519@tonks>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_mehl.schokokeks.org-20733-1450111048-0001-2"
Cc: r.seitz@beh.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 17:42:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8WCu-00036p-F6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 17:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbbLNQmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 11:42:35 -0500
Received: from mehl.schokokeks.org ([46.4.40.247]:38708 "EHLO
	mehl.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbLNQme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 11:42:34 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 11:42:34 EST
Received: from tonks ([2001:41d0:2:3b68::1])
  (AUTH: PLAIN me@the-compiler.org, TLS: TLSv1/SSLv3,128bits,ECDHE-RSA-AES128-GCM-SHA256)
  by mehl.schokokeks.org with ESMTPSA; Mon, 14 Dec 2015 17:37:28 +0100
  id 0000000000000056.00000000566EF048.000050FD
Content-Disposition: inline
Accept-Language: de, en
X-URL: http://www.the-compiler.org/
X-Operating-System: Arch Linux
X-Editor: vim 7.4
X-PGP-Key: http://www.the-compiler.org/pubkey.asc
OpenPGP: id=FD55A072; url=http://www.the-compiler.org/pubkey.asc;
 preference=signencrypt
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282371>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mehl.schokokeks.org-20733-1450111048-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Today I bisected a bug which required cherry-picking an (unrelated)
compile fix later in the history so I could test the commits.

After testing a commit, I didn't reset to the commit before the
cherry-picked one, which seemed to work well, but doesn't in my minimal
example:

    $ git init
    $ echo 'good and does not compile' > file
    $ git add file && git commit -m 'good and does not compile'
    $ echo again >> file && git commit -am 'still good and does not compile'
    $ echo 'bad and compiles' > file && git commit -am 'bad and compiles'
    $ git log --oneline --decorate
    97f9214 (HEAD, master) bad and compiles
    981e109 still good and does not compile
    753ed25 good and does not compile

Now I start bisecting and cherry-pick the compile fix in master:

    $ git bisect start
    $ git bisect bad master
    $ git bisect good master~2  # 753ed25
    Bisecting: 0 revisions left to test after this (roughly 0 steps)
    [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not comp=
ile
    florian@ws042:~/tmp/bisect1$ git cherry-pick master
    [detached HEAD b49872b] bad and compiles
     Date: Mon Dec 14 17:26:51 2015 +0100
      1 file changed, 1 insertion(+), 2 deletions(-)

Now when trying to say it's good (and forgetting to remove the
temporary commits), I get this:

    $ git bisect good
    Bisecting: a merge base must be tested
    [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not comp=
ile

Is this intended behaviour? Shouldn't git either do a reset to the
commit we're currently bisecting, or warn the user as it was probably
unintended to add new commits?

Currently it seems bisect just treats the current HEAD as good, and
then the bisect algorithm tries to (I think) select a commit between
the currently bisected one and the (temporary) HEAD?

When I used it today, it actually seemed to work well until I hit an
*actual* merge base, and then it started to bisect something
unexpected, which got me a bit confused ;)

Florian

--=20
http://www.the-compiler.org | me@the-compiler.org (Mail/XMPP)
   GPG: 916E B0C8 FD55 A072 | http://the-compiler.org/pubkey.asc
         I love long mails! | http://email.is-not-s.ms/

--=_mehl.schokokeks.org-20733-1450111048-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbvBGAAoJEJFusMj9VaBy8ZsQAIFM9tVffwEkefxT67vk0EYZ
9vhRdlKRAZtID5c+6Q9DCroSTwerBluy/HRMelcHLCVWQezGXBUTM6PuZKU5W1/R
IEYkWGXKZ9xalSZbGhOD+4EbccrELl9RPUU9FJVcxQBr6guFTUtzbLxnHpqiR0zL
59Favx0yQuFM17DflTsS4i63Gyplyvyk4B6zx6JNsRk94uCv26hurSodUBUF4Cce
DwP2605Lv8YdjotflfNaYVi4mwTIspOGQ7syLNZoNdi0tJ26g4EVHuwDH6wKLX3S
4E+0AEbwuS5cu7F4lY7bri/4mZce/6X973SqYpGTjWN3NGXTUD6dIKw7Wt5Va+Wm
QBvtKaTa/d7DrZ5y6W1KZKK7avpPk0NNP3qOS07GM5sXSWJrTujE3XeY3YYHCaJq
w+I1vsbhg2eN97X/9x49IjE3iBLmT3MuIf/xzDyJEYeYkYyFSoM4cy+HrBfZv3Mj
J/T8sHHa8fQ61C3HAvvCSqg154kL4aBdATPSTS6TL1KGuP2MQhZuvyP/KTePAmwj
1dSspS2zwfdoRCdza24IEtUeXfOegKllKfLPgqXy7AToopEkcIT0CkjXpJ7m9qbj
zy8rFluO6K0iKYT7CoVQN6qDH/gOBuCHnhocM9Y8LnbEzfvNoDHhgCtcB9WDIOmi
dhP0AMgwAP89nKwMmFjU
=Soza
-----END PGP SIGNATURE-----

--=_mehl.schokokeks.org-20733-1450111048-0001-2--
