From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/34] t2025: add a test to make sure grafts is working from a linked checkout
Date: Sun, 30 Nov 2014 15:24:57 +0700
Message-ID: <1417335899-27307-33-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuztp-0000k3-Sj
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbaK3Iaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:30:30 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:65016 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbaK3Ia3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:30:29 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so9009742pdi.27
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3YBK798PZv+gBVQzacDuIBjw4wIPfZACXbHbT/IHbh8=;
        b=1C3UZP7QZFHPVaDNUmNFygt06YtbIKhUKOX7jM8sMnqFdL2L2npcyJSgUzCQPQITIb
         w18c2znRDys0BAKVjP5PJARZUnR8Ksb/uhdox8TXjLgFx37orCuZQtuRNKDVsaIuRnQz
         BoOPcbLQPV5Mp+KjUjvdsGTj9XBrEXwWjD7lot+/RvIhW/L682a0D3SnfSvua+W2bRbI
         JZ7ZXi1AyRi1Ley84XPcspzr0Oh1CUaV2vveo3W93BRlQxN84uJGkZz4QCyaoY/aXR5v
         1fNeeS+REhmAxULWcqroX85ld1CzmZQjO2OypS8O10GeNVhWVpR7gZzGCGbvdVwgg/GI
         Uhjw==
X-Received: by 10.68.247.226 with SMTP id yh2mr1514210pbc.109.1417336229003;
        Sun, 30 Nov 2014 00:30:29 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ez1sm14314592pdb.86.2014.11.30.00.30.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:30:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:30:27 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260419>

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
