From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 19:05:19 +0200
Message-ID: <46F0054F.8060503@lsrfire.ath.cx>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org> <46EFE75D.7000805@lsrfire.ath.cx> <20070918155214.GQ19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXgW1-0002Yl-GR
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 19:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759909AbXIRRFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 13:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760022AbXIRRFc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 13:05:32 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43740
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759880AbXIRRFb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 13:05:31 -0400
Received: from [10.0.1.201] (p57B7C83E.dip.t-dialin.net [87.183.200.62])
	by neapel230.server4you.de (Postfix) with ESMTP id C4EB6873BA;
	Tue, 18 Sep 2007 19:05:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070918155214.GQ19019@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58626>

Miklos Vajna schrieb:
> $ unzip -v
> UnZip 5.52 of 28 February 2005, by Info-ZIP.  Maintained by C. Spiele=
r.
> Send
> bug reports using http://www.info-zip.org/zip-bug.html; see README fo=
r
> details.
>=20
> Latest sources and executables are at
> ftp://ftp.info-zip.org/pub/infozip/ ;
> see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.
>=20
> Compiled with gcc 4.1.2 for Unix (Linux ELF) on May  9 2007.
>=20
> UnZip special compilation options:
>         ASM_CRC
>         COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
>         SET_DIR_ATTRIB
>         TIMESTAMP
>         USE_EF_UT_TIME
>         USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
>         USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
>         VMS_TEXT_CONV
>         [decryption, version 2.9 of 05 May 2000]
>=20
> if i'm not wrong then these options should be ok. :S

Well, looks OK to me at least.  The Debian package (and thus Ubuntu's
too) has a symlink related fix, from Christian Spieler, no less:

  http://packages.debian.org/changelogs/pool/main/u/unzip/unzip_5.52-9/=
changelog
  http://ftp.de.debian.org/debian/pool/main/u/unzip/unzip_5.52-9.diff.g=
z

Perhaps this is missing from your version?

Let's check if the ZIP file on our machines match.  In order for
this to succeed we need to first take out any randomness.  Please
apply the patch at the end of the mail, which sets GIT_AUTHOR_DATE
to a fixed value instead of using the current time, run the test
and then this:

  $ md5sum t/trash/d.zip	# run just after t5000-tar-tree.sh
  35f6183b7816960cadfc6cac74530640  t/trash/d.zip

The test passes just fine here, so if the checksums match then your
unzip is most likely to blame.  In this case you can work around
your problem by commenting out the "ln -s" in t5000-tar-tree.sh.

Ren=E9


--- snip! ---
archive: make test repeatable

Set GIT_AUTHOR_DATE to a fixed value, just like it's already done
for GIT_COMMITTER_DATE.  This makes the test repeatable, and
resulting archive files can by compared on mailing lists simply by
comparing their checksums.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 42e28ab..f341451 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,7 +50,7 @@ test_expect_success \
      treeid=3D`git write-tree` &&
      echo $treeid >treeid &&
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
-     git commit-tree $treeid </dev/null)'
+     GIT_AUTHOR_DATE=3D"2007-09-18 19:00:00" git commit-tree $treeid <=
/dev/null)
=20
 test_expect_success \
     'git archive' \
