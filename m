From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] utf8: die if failed to re-encoding
Date: Tue, 21 Feb 2012 21:24:51 +0700
Message-ID: <1329834292-2511-3-git-send-email-pclouds@gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:26:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqfL-0004eJ-0S
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab2BUOZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:25:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60286 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab2BUOZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:25:57 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so7431291pbc.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:25:57 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.132.229 as permitted sender) client-ip=10.68.132.229;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.132.229 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.132.229])
        by 10.68.132.229 with SMTP id ox5mr67961757pbb.65.1329834357657 (num_hops = 1);
        Tue, 21 Feb 2012 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EcO4EN4Edk77KK5jzTIRerSMh00w4LMUYt4mJ/FJdik=;
        b=nnHK5x7yW7ia0SCmgpk7904PhB+aGU5QzsUtNMekTJVQD5m/WoKfMrv9GOdOfGy+r8
         lcBoJWKLVVvfffiUmmnNCSs8hC43cH2YeSdoxZBY9kW9yGBT6cdai0c73HONEgJoW7mx
         f6OwRDwIr9yUMyck3IEBqYbbgN9N6/g5GOcz8=
Received: by 10.68.132.229 with SMTP id ox5mr56061687pbb.65.1329834357603;
        Tue, 21 Feb 2012 06:25:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id c9sm16186895pbr.65.2012.02.21.06.25.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 06:25:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Feb 2012 21:25:09 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191159>

Return value NULL in this case means "no conversion needed", which is
not quite true when conv =3D=3D -1.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4201-shortlog.sh |    2 +-
 utf8.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6872ba1..d445665 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 		tr 1234 "\360\235\204\236")" a1 &&
=20
 	# now fsck up the utf8
-	git config i18n.commitencoding non-utf-8 &&
+	git config i18n.commitencoding viscii &&
 	echo 4 >a1 &&
 	git commit --quiet -m "$(
 		echo "This is a very, very long first line for the commit message to=
 see if it is wrapped correctly" |
diff --git a/utf8.c b/utf8.c
index def93ee..f918e9e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -444,7 +444,7 @@ char *reencode_string(const char *in, const char *o=
ut_encoding, const char *in_e
 		return NULL;
 	conv =3D iconv_open(out_encoding, in_encoding);
 	if (conv =3D=3D (iconv_t) -1)
-		return NULL;
+		die("failed to convert from %s to %s", in_encoding, out_encoding);
 	insz =3D strlen(in);
 	outsz =3D insz;
 	outalloc =3D outsz + 1; /* for terminating NUL */
--=20
1.7.8.36.g69ee2
