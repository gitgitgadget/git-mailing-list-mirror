From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Bug: rebase when an author uses accents in name on MacOSx
Date: Wed, 30 May 2012 17:16:53 -0500
Message-ID: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_10D8BC24-27A5-4D03-AAC1-5DD96251730D"; protocol="application/pgp-signature"; micalg=pgp-sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 00:17:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZrCK-0004Pa-29
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 00:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab2E3WQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 18:16:52 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53422 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2E3WQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 18:16:51 -0400
Received: by gglu4 with SMTP id u4so343781ggl.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 15:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:subject:date:message-id:to:mime-version:x-mailer
         :x-gm-message-state;
        bh=CvwBWbjaWsye+w2XG1gaQmj4WfdRq5EUSiH4NWk9qs8=;
        b=XpO+HBYoIOo7JyfLlwMzqXPbBO+byohNDDVSj1oA6rIWbqjS7fvrpw/CO/vWoqbiL8
         zHS4iwOVPB/UkA1WZaJ2jkDR00+WtU1rwL1eFelsBZjp4pfYR2nBJZ5Pw5q+cAN8VjUy
         W+i5bS0Ou/6uhTz04VuhS6YK8PfxDJvlEWUIgz+cAnRVqidf6bUl/yiLPFuLGzUPWJK1
         IUQmvbZOVL0GEv6m6imstzurUG0GxeR0CHwR5bO+MW9S0XSVEssFHUobg7qrGGbLu/jk
         phNVAHw8XMWfi3QUy2qgxMbUpUCf8AwHf/zrAsL9ujo2HA31y6UV95roohS85ruJMgSD
         QQEw==
Received: by 10.60.27.65 with SMTP id r1mr16744329oeg.55.1338416210267;
        Wed, 30 May 2012 15:16:50 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id a10sm897722obp.7.2012.05.30.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 15:16:49 -0700 (PDT)
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQnGqRoWGFIr5QVRXSPESFn2csUM5uhEn0id9HEN0KjYjlSpp+I5W0Xc8gK8JcRxiJnyjaRL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198846>


--Apple-Mail=_10D8BC24-27A5-4D03-AAC1-5DD96251730D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hello,

I've come across behavior I'd say is a bug.

We have a developer with an accent in his name, R=E9mi Leblond.  Very =
recently we stopped being able to rebase getting the error

  lanny(master);<work/IdeaProjects/Piper> git rebase master rl-clean292
  First, rewinding head to replay your work on top of it...
  /sw/lib/git-core/git-am: line 692: Leblond: command not found
  Patch does not have a valid e-mail address.
  lanny((ae6c220...)|REBASE);<work/IdeaProjects/Piper>=20

Versions 1.7.10.2 is (now?) exhibiting this behavior.  We've been =
rebasing fine for several month which is why I wonder if being on MacOSX =
is involved?  (I'm at 10.7.4)  Some digging shows the root cause to be =
in function get_author_ident_from_commit at line 210 of =
git-core/git-sh-setup, namely the sed with environment overrides LANG=3DC =
LC_ALL=3DC.  This causes git-am to incorrectly build the =
.git/rebase-apply/author-script.

  lanny((ae6c220...)|REBASE);<work/IdeaProjects/Piper> cat =
.git/rebase-apply/author-script
  GIT_AUTHOR_NAME=3D'R'=E9mi Leblond
  GIT_AUTHOR_EMAIL=3D'remi@spotinfluence.com'
  GIT_AUTHOR_DATE=3D'@1335301038 -0600'

=46rom the command-line

  lanny;~> echo $LANG
  en_US.UTF-8
  lanny;~> echo $LC_ALL

  lanny;~> echo "R=E9mi Leblond" | LANG=3DC LC_ALL=3DC sed -ne =
's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
  GIT_AUTHOR_NAME=3D'R'=E9mi Leblond
  lanny;~> echo "R=E9mi Leblond" | sed -ne =
's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
  GIT_AUTHOR_NAME=3D'R=E9mi Leblond'

I can work around it easily enough by editing git-sh-setup to remove the =
locale overrides but thought a bug report might be useful.

Enjoy,
  -ljr

---
Lanny Ripple
lanny@spotinfluence.com



--Apple-Mail=_10D8BC24-27A5-4D03-AAC1-5DD96251730D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/GnFYACgkQ+owW65SoXfhYUgD/c5AR932aJuTUze/TZPKgGXJr
+cC5DLzy7GB076ahJgIBANAaGVEkZNkY3CiT3zxfEfNwWRR/ijSEqwZXo5KruQSg
=aNeu
-----END PGP SIGNATURE-----

--Apple-Mail=_10D8BC24-27A5-4D03-AAC1-5DD96251730D--
