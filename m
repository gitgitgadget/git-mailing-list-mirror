From: Ingo Ruhnke <grumbel@gmail.com>
Subject: Problems with format-patch UTF-8 and a missing second empty line
Date: Thu, 15 Sep 2011 11:45:15 +0200
Message-ID: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 11:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R48VX-0003BZ-Mz
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291Ab1IOJpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 05:45:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37129 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab1IOJpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 05:45:16 -0400
Received: by bkbzt4 with SMTP id zt4so2319894bkb.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7Ogrvwa+slbuEmlszJfFWgUJiHlK9Yq3HDMkDcFzvB4=;
        b=oExSNs9IDToG+ISqBkh995sBmK++wxgDDIhGOzYm/ssV+2YSpXewQrj/c0Got9tlHl
         q8ZDQpgo8XOCzi0gdomzLb/ME21I/zolQ0VPy3s+oE0zpv//VuMlH+4uX7gcHnundV0C
         DI/oeTQHUinhlvBEpujv2N5uIkoOvM+ZZeG8o=
Received: by 10.204.131.88 with SMTP id w24mr541626bks.297.1316079915132; Thu,
 15 Sep 2011 02:45:15 -0700 (PDT)
Received: by 10.204.122.1 with HTTP; Thu, 15 Sep 2011 02:45:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181453>

Creating a patch of a commit including UTF-8 and no empty second line,
like this:

mkdir foobar
cd foobar
git init
echo "Hello World" > file
git add file
git commit -m "=C3=84=C3=96=C3=9C
=C3=84=C3=96=C3=9C" file
git format-patch --root HEAD --stdout

Results in this:

=46rom f4f889bad560c479a70fbf5f70a4239576001262 Mon Sep 17 00:00:00 200=
1
=46rom: Ingo Ruhnke <grumbel@gmail.com>
Date: Thu, 15 Sep 2011 11:25:11 +0200
Subject: [PATCH] =3D?UTF-8?q?=3DC3=3D84=3DC3=3D96=3DC3=3D9C
=3D20=3DC3=3D84=3DC3=3D96=3DC3=3D9C?=3D
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit
=2E..

Trying to apply the patch then results in this:

$ git am /tmp/foobar/0001-.patch
Applying: =3D?UTF-8?q?=3DC3=3D84=3DC3=3D96=3DC3=3D9C
applying to an empty history
$ git log
commit 6f27fc51a8c52fdb595131a934d8d56c9df3b5c0
Author: Ingo Ruhnke <grumbel@gmail.com>
Date:   Thu Sep 15 11:27:47 2011 +0200

    =3D?UTF-8?q?=3DC3=3D84=3DC3=3D96=3DC3=3D9C

    =3D20=3DC3=3D84=3DC3=3D96=3DC3=3D9C?=3D
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit

The UTF-8 stuff doesn't get decoded and the log message ends up broken.

The problem seems to already start with just the lack of an empty secon=
d line:

mkdir foobar
cd foobar
git init
echo "Hello World" > file
git add file
git commit -m "ABC
ABC" file
git format-patch --root HEAD --stdout

=46rom 3abc0e59abc4c9343d22e79575e02910073d1013 Mon Sep 17 00:00:00 200=
1
=46rom: Ingo Ruhnke <grumbel@gmail.com>
Date: Thu, 15 Sep 2011 11:31:03 +0200
Subject: [PATCH] ABC
 ABC

$ git am /tmp/foobar/0001-ABC.patch
Applying: ABC ABC
applying to an empty history
ingo@duo:/tmp/5/bar$ git log | cat
commit eb8a9e9a1421ae6d930d99bfb8f2eab47349c387
Author: Ingo Ruhnke <grumbel@gmail.com>
Date:   Thu Sep 15 11:31:03 2011 +0200

    ABC ABC

Here the newline between ABC\nABC gets stripped out and replaced with
a space when transferring the commit with format-patch from one
repository to another.

Inserting an empty second line in the commit message makes both
problems go away.

Another small issue is that the filename of the patch will strip out
any UTF-8 characters, Thus a commit message of "123=C3=84=C3=B6=C3=BC45=
6" will result
in "0001-123-456.patch".

The problems happen with git version 1.7.4.1 (4b5eac7f0) on Ubuntu 11.0=
4.

--=20
Blog:=C2=A0 =C2=A0=C2=A0 http://grumbel.blogspot.com/
JabberID: xmpp:grumbel@jabber.org
ICQ:=C2=A0 =C2=A0 =C2=A0 59461927
