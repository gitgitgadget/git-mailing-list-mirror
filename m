From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] Add tests for wildcard "path vs ref" disambiguation
Date: Wed,  1 Jul 2015 18:08:14 +0700
Message-ID: <1435748894-4636-1-git-send-email-pclouds@gmail.com>
References: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 13:07:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAFrn-00046B-Pf
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 13:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbbGALHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 07:07:44 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36104 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbbGALHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 07:07:42 -0400
Received: by pdcu2 with SMTP id u2so24520678pdc.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/Z8tj1SrYpZQnoR4s53bwuG9i64J+8upxg7rnfw+ajw=;
        b=TndbJSncou7b93UqiZ90fBgfN5VWlv4abWVFJKEkfVNLkv9hj3fS9Kk8RaB/HMVXUA
         4XU4jGLofCO7MfYeu0Cfg0f2+FfxE8Wy9mo+vqWSE+EutmwjYI/pIbNoTQetDsWF87JG
         mQsHM3O9MNiTLbrX6BrnT4APFv3GFoGtps1P6ePVv+8JSkKEEFWCUAbLX4Ihg2IrEbD0
         vhFuDL5vTmvzyz42DynY/+ShFLaydm9shRg3ZQS4NKqDPDkJxhSfDh8tYtRU/PCO4f+u
         XgkezGEOXjsJ93VbIr+mrs//+ULLteHss4v43zKhiqeY9OFpduwzhP/nIoiO8u4shuDX
         YCeA==
X-Received: by 10.70.19.200 with SMTP id h8mr15072842pde.66.1435748862421;
        Wed, 01 Jul 2015 04:07:42 -0700 (PDT)
Received: from lanh ([115.73.56.51])
        by mx.google.com with ESMTPSA id do16sm1927099pac.15.2015.07.01.04.07.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 04:07:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 Jul 2015 18:08:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273151>

Commit 28fcc0b (pathspec: avoid the need of "--" when wildcard is used =
-
2015-05-02) changes how the disambiguation rules work. This patch adds
some tests to demonstrate, basically, if wildcard characters are in an
argument:

 - if the argument is valid extended sha-1 syntax, "--" must be used
 - otherwise the argument is considered a path, even without "--"

And wildcard can appear in extended sha-1 syntax, either as part of
regex in ":/<regex>" or as the literal path in ":<path>". The latter
case is less likely to happen in real world. But if you do ":/" a lot,
you may need to type "--" more.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 just adds tests as the code is already in 'master' for some time.

 t/t2019-checkout-ambiguous-ref.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambig=
uous-ref.sh
index b99d519..e5ceba3 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -56,4 +56,30 @@ test_expect_success VAGUENESS_SUCCESS 'checkout repo=
rts switch to branch' '
 	test_i18ngrep ! "^HEAD is now at" stderr
 '
=20
+test_expect_success 'wildcard ambiguation, paths win' '
+	git init ambi &&
+	(
+		cd ambi &&
+		echo a >a.c &&
+		git add a.c &&
+		echo b >a.c &&
+		git checkout "*.c" &&
+		echo a >expect &&
+		test_cmp expect a.c
+	)
+'
+
+test_expect_success 'wildcard ambiguation, refs lose' '
+	git init ambi2 &&
+	(
+		cd ambi2 &&
+		echo a >"*.c" &&
+		git add . &&
+		test_must_fail git show :"*.c" &&
+		git show :"*.c" -- >actual &&
+		echo a >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
