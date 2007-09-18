From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 16:57:33 +0200
Message-ID: <46EFE75D.7000805@lsrfire.ath.cx>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXeWR-0000Ko-L6
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829AbXIRO5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 10:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757799AbXIRO5t
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:57:49 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48718
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757766AbXIRO5s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 10:57:48 -0400
Received: from [10.0.1.201] (p57B7C83E.dip.t-dialin.net [87.183.200.62])
	by neapel230.server4you.de (Postfix) with ESMTP id 08556873BA;
	Tue, 18 Sep 2007 16:57:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070917220408.GG19019@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58616>

Miklos Vajna schrieb:
> On Mon, Sep 17, 2007 at 11:50:32PM +0200, Ren=E9 Scharfe <rene.scharf=
e@lsrfire.ath.cx> wrote:
>> The failing tests check ZIP file creation, not tar file creation.
>> Perhaps your unzip command works a bit differently from Info-ZIP's?
>=20
> $ zip -v
> Copyright (c) 1990-2006 Info-ZIP - Type 'zip "-L"' for software licen=
se.
> This is Zip 2.32 (June 19th 2006), by Info-ZIP.
>=20
> should this version be ok?

Info-ZIP zip and unzip are two different programs, each with their
own version numbers.

>> Also, what is the difference between t/trash/a and t/trash/d/a after
>> running the test script (that's what test 21 is comparing)?
>=20
> $ diff -Naur t/trash/a t/trash/d/a
> diff -Naur t/trash/a/l1 t/trash/d/a/l1
> --- t/trash/a/l1        2007-09-17 23:10:03.000000000 +0200
> +++ t/trash/d/a/l1      2007-09-17 23:10:03.000000000 +0200
> @@ -1 +1 @@
> -simple textfile
> +a
> \ No newline at end of file

Ah!  l1 is a symlink to a.  The target of a symlink is stored as file
content in a ZIP archive and marked with a special flag.  An unzipper
that doesn't understand this flag would create a file containing the
link target's name instead of a symlink pointing to the target.

The unzip on my system says:

  $ unzip -v
  UnZip 5.52 of 28 February 2005, by Ubuntu. Original by Info-ZIP.

  Latest sources and executables are at  ftp://ftp.info-zip.org/pub/inf=
ozip/ ;
  see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.

  Compiled with gcc 4.1.2 (Ubuntu 4.1.2-0ubuntu4) for Unix (Linux ELF) =
on Mar 31 2007.

  UnZip special compilation options:
          ACORN_FTYPE_NFS
          COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
          SET_DIR_ATTRIB
          TIMESTAMP
          USE_EF_UT_TIME
          USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
          USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
          VMS_TEXT_CONV
          WILD_STOP_AT_DIR
          [decryption, version 2.9 of 05 May 2000]

I suspect you need SET_DIR_ATTRIB in order to extract symlinks.

Ren=E9
