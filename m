From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 32/32] t2025: add a test to make sure grafts is working from a linked checkout
Date: Thu, 11 Sep 2014 05:42:08 +0700
Message-ID: <1410388928-32265-33-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:45:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqdL-0002im-C4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbaIJWo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:59 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48052 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbaIJWo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:58 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so13134297pdj.10
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jSSK1LyQK4lSj9UoaGYWT+sYEZoDMW9OByWlbNFurMs=;
        b=OJtmwT6w/dy36JK9UD2w2p/cTtPBP/lMYe8fMAnWfZ5tnNkH6WaqyklKl0Xd8Xyjhr
         rEtEJbtFM05WPfeTv41c5nulyZzi0oY4/mOvbbRqTk2Yhnrzpsq8c4QBzXrZyb4KWcUq
         7T8UPxU1yfA0qfNPMfAsbcYq6xoDrH+2zPrWPNfKxcUvEO3JYAhgK3qH+onvQpUdqJ5k
         VsQb6XlRo+mLM8WtMcyowqVAAVD/qgKBB5TLAKdSvBcH0+2Pk6sdOiUJamyN4tXu/n4q
         SHL05bXwcxHKDSJuqBqNbgn+JWGkcyCVC3b54BOB4O7bJJ19ptbIgrbInGzqOEfrJxQk
         mGUQ==
X-Received: by 10.68.164.35 with SMTP id yn3mr42226508pbb.104.1410389098493;
        Wed, 10 Sep 2014 15:44:58 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id xo3sm16351199pac.21.2014.09.10.15.44.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:45:18 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256809>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2025-checkout-to.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 2cddbf1..27384a1 100755
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
