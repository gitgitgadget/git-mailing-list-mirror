From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] On compresing large index
Date: Sun,  5 Feb 2012 15:30:02 +0700
Message-ID: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 09:31:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtxVJ-0002Mi-SY
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 09:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab2BEIau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 03:30:50 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36557 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2BEIat (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 03:30:49 -0500
Received: by pbdu11 with SMTP id u11so4091382pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0ERPL3CXP+VwA8tauEQFhZloPy1e5UlM6bhMO0ejlLE=;
        b=RH4Vqmn6RGaFY64gO2qUnIultIbeB7xUVjF8JHgqOEVxZE2ucR5Q930DFiB0Qk5+Km
         6gVHbnFkD/vEf1U3zHEkNakYlgr8d8Ej1NhWk9hrYJvkqYT6ejZhtfhsP9NqKjqYVDI9
         A9G5JbQHD1ZbntLVP+wq0fo2ZrX6hoJlnKEic=
Received: by 10.68.195.73 with SMTP id ic9mr35659210pbc.72.1328430648744;
        Sun, 05 Feb 2012 00:30:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id a5sm28940250pbh.15.2012.02.05.00.30.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 00:30:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 05 Feb 2012 15:30:05 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189933>

I was thinking whether compressing index might help when it contained
~2M files. It turns out that only makes the situation worse. Anyway, I
post the code and some numbers here.

The index is created artifically with the program [1]

$ git init
$ touch foo
$ git hash-object -w foo
$ ./a.out 256 256 32 | git update-index --index-info

That gives ~2M files in index, 209 MB in size.

$ time ~/w/git/git ls-files | head >/dev/null
real    0m4.635s
user    0m4.258s
sys     0m0.329s

$ time ~/w/git/git update-index level-0-0000/foo
real    0m4.593s
user    0m4.264s
sys     0m0.323s

Index is compressed with GIT_ZCACHE=3D1.

$ GIT_ZCACHE=3D1 ~/w/git/git update-index level-0-0000/foo

which gives 6.8 MB index (the true number may be less impressive
because compressing rate in my artificial tree is really high). The
only problem with this is git uses more time, not less

$ time ~/w/git/git ls-files | head >/dev/null
real    0m4.970s
user    0m4.675s
sys     0m0.289s

$ time GIT_ZCACHE=3D1 ~/w/git/git update-index level-0-0000/foo
real    0m4.959s
user    0m4.682s
sys     0m0.273s

My guess is Linux caches the whole index in memory already so I/O time
does not really matter, while we still have to pay for zlib's time. We
need to figure out what git uses 4s user time for.

This series may be useful on OSes that do not cache heavily. Though
I'm not sure if there is any out there nowadays.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  read-cache: factor out cache entries reading code
  read-cache: reduce malloc/free during writing index
  Support compressing index when GIT_ZCACHE=3D1

 cache.h      |    1 +
 read-cache.c |  172 +++++++++++++++++++++++++++++++++++++++++++++++++-=
--------
 2 files changed, 148 insertions(+), 25 deletions(-)

[1]
-- 8< --
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
	const char *prefix =3D "100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c539=
1 0\t";
	int l1, l2, l3;
	int m1, m2, m3;

	m1 =3D atoi(argv[1]);
	m2 =3D atoi(argv[2]);
	m3 =3D atoi(argv[3]);

	for (l1 =3D 0; l1 < m1; l1++) {
		printf("%slevel-0-%04d/foo\n", prefix, l1);
		for (l2 =3D 0; l2 < m2; l2++)
			for (l3 =3D 0; l3 < m3; l3++)
				printf("%slevel-0-%04d/level-1-%04d/foo-%04d\n",
				       prefix, l1, l2, l3);
	}
	return 0;
}
-- 8< --
--=20
1.7.8.36.g69ee2
