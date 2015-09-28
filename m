From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/6] t0002: add test for enter_repo(), non-strict mode
Date: Mon, 28 Sep 2015 20:06:12 +0700
Message-ID: <1443445576-29526-3-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8Y-0005gk-HC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652AbbI1NG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34585 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbbI1NG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:28 -0400
Received: by padhy16 with SMTP id hy16so174448123pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TmYyXNlXBC4qk+r5cN6tfwND72mLIV+rhXf0PHn3n+Y=;
        b=wcbcuTWQwXLtGMgH8TU7C+yNNhODW4kfAl8IVgiEs1MRIwbjmTJB3emKt5axnuvVZ8
         LLE2ms4mNxultoFFCU9PZHPdRuOKFnnrTh+ixbiDJX0xvt6XEoN+H72jFsis20lP20gn
         QIVahhpsJkRh+4H7KzSi/tQ0Qr6hPApOl6ZRjySPmM8onA8S8KizC2uKXTdFtmQyD7NI
         jH6zLAwbO2j3b6Nbpoo/73EsB0xrT5/XtMCAD8PX2m48Xo6mIqayq8PtUf8FWmYi0z5L
         kFtmHuMte/LAvHxFkDlBnw9qQVj7w4jb/2MA+ID7fzOgUkJSFByXhwlfd4TCj9kJV5zC
         Jzmg==
X-Received: by 10.68.132.234 with SMTP id ox10mr26054280pbb.128.1443445588357;
        Mon, 28 Sep 2015 06:06:28 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id b7sm19400354pbu.20.2015.09.28.06.06.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:07:03 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278718>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0002-gitfile.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9393322..545bfe2 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -116,4 +116,22 @@ test_expect_success 'setup_git_dir twice in subdir=
' '
 	)
 '
=20
+test_expect_success 'enter_repo non-strict mode' '
+	test_create_repo enter_repo &&
+	(
+		cd enter_repo &&
+		test_tick &&
+		test_commit foo &&
+		mv .git .realgit &&
+		echo "gitdir: .realgit" >.git
+	) &&
+	git ls-remote enter_repo >actual &&
+	cat >expected <<-\EOF &&
+	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
