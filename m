From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/17] pack-objects: disable pack size limit feature on pack v4
Date: Sat, 21 Sep 2013 20:58:02 +0700
Message-ID: <1379771883-10278-17-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:56:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNfX-0002MD-VO
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab3IUN4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:56:15 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35858 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUN4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:56:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so531758pad.35
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KoN2In88KvBqC76KJr3GDlgn+48Eg1lDmWSy2ey3Ivk=;
        b=NXTULsvpbY59OsMm/VnZXsqpWmcLGuB2EJVwNNGlkrPd5MapY3RKTSJgJ4JIEAsV8W
         PHJnMLa2HK2gFXSbfXe04nXATrugh2/npRdWllYqMifyE/ksIHJKY2rhw0jCt1hg/woL
         i80m9L9HRsHjfITJvkBhkEuoi/K/2SmmoGOOHVOuWRKN1LPzkWVtcU9jaxWs47/lX3v0
         Z1QqcmnMvMM2fZyckDmObEfPsgjy0uwo5IkpMSHwSWOwOLO/m7Gg6bnLwTQfZbuHtHW4
         NzB7Pe9SfynaNrRy+FTxWMaV132o+w0Koc/PpVDsIsjqBQVkdyeWOG3hKpw6aph/T4Pd
         zoMw==
X-Received: by 10.68.115.15 with SMTP id jk15mr13812913pbb.36.1379771773863;
        Sat, 21 Sep 2013 06:56:13 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id nj9sm22200654pbc.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:56:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235117>

pack v4 format does not go along well with pack size limit feature. v4
requires to know the number of objects in the pack in advance in order
to contruct various tables after pack header. When pack size is
limited, we don't know this number until we write objects out and hit
it. By then the only option we have is rewrite the pack and update the
tables.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 2 ++
 t/t5300-pack-object.sh | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 01954cb..3fd761a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2804,6 +2804,8 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		warning("minimum pack size limit is 1 MiB");
 		pack_size_limit =3D 1024*1024;
 	}
+	if (pack_size_limit && pack_version >=3D 4)
+		die("pack size limiting is not supported with pack version 4");
=20
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 62fc997..831ab79 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -385,9 +385,9 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
=20
-test_expect_success 'honor pack.packSizeLimit' '
+test_expect_success 'honor pack.packSizeLimit (pack v2)' '
 	git config pack.packSizeLimit 3m &&
-	packname_10=3D$(git pack-objects test-10 <obj-list) &&
+	packname_10=3D$(git pack-objects --version=3D2 test-10 <obj-list) &&
 	test 2 =3D $(ls test-10-*.pack | wc -l)
 '
=20
@@ -395,9 +395,9 @@ test_expect_success 'verify resulting packs' '
 	git verify-pack test-10-*.pack
 '
=20
-test_expect_success 'tolerate packsizelimit smaller than biggest objec=
t' '
+test_expect_success 'tolerate packsizelimit smaller than biggest objec=
t (pack v2)' '
 	git config pack.packSizeLimit 1 &&
-	packname_11=3D$(git pack-objects test-11 <obj-list) &&
+	packname_11=3D$(git pack-objects --version=3D2 test-11 <obj-list) &&
 	test 5 =3D $(ls test-11-*.pack | wc -l)
 '
=20
--=20
1.8.2.83.gc99314b
