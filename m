From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 32/32] t2025: add a test to make sure grafts is working from a linked checkout
Date: Sun, 28 Sep 2014 08:22:46 +0700
Message-ID: <1411867366-3821-33-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3FG-0002tQ-37
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbaI1BZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47276 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so4856292pad.15
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3YBK798PZv+gBVQzacDuIBjw4wIPfZACXbHbT/IHbh8=;
        b=Vbpy2ZmDUe4elQYVMaYsGRiEsIyLFBfc1OHURykPJS2cINoQNy/JFVXO0LI1Y6Yu3K
         ew5aGDC2bpJnWQeBN9K3YMuC7YzazTxDyhNkzF9RScPCqYRGj1MOv+JcEZUNYOQp4AjI
         FS9r3vjauqVU4rEJMMoDjDaUT3q8F44aXOdodrUNlOxjIhVeEa0e5wHtT/1ZvrJPA9C8
         Sg5dGLthmSA9s7fWEowt4Hdsqffyf1WdK7IeeT7y7f86Cdt+FuBbEn9IE+xigaTGfSI9
         jRwD21zzlA8JF2qVPLq7Uw5suMq7ySzi7vT3IByfl/GdsMwpuL/GYccSxQSASzjexTng
         i8qA==
X-Received: by 10.68.94.34 with SMTP id cz2mr46021406pbb.7.1411867545235;
        Sat, 27 Sep 2014 18:25:45 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id rg1sm8576077pdb.14.2014.09.27.18.25.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:48 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257591>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2025-checkout-to.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 4bd1df4..eddd325 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -96,4 +96,22 @@ test_expect_success 'checkout from a bare repo witho=
ut --to' '
 	)
 '
=20
+test_expect_success 'checkout with grafts' '
+	test_when_finished rm .git/info/grafts &&
+	test_commit abc &&
+	SHA1=3D`git rev-parse HEAD` &&
+	test_commit def &&
+	test_commit xyz &&
+	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
+	cat >expected <<-\EOF &&
+	xyz
+	abc
+	EOF
+	git log --format=3D%s -2 >actual &&
+	test_cmp expected actual &&
+	git checkout --detach --to grafted master &&
+	git --git-dir=3Dgrafted/.git log --format=3D%s -2 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
