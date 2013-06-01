From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Test 'commit --only' after 'checkout --orphan'
Date: Sat, 1 Jun 2013 13:02:00 +0200
Message-ID: <78176f4fca45213961f0e4d15ac72012d6a0a10b.1370084247.git.trast@inf.ethz.ch>
References: <CACsJy8A6Hq_LEqAxUTLKP9-TA6aTq+91Wx2vYLhSuMSmRvpYiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 13:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UijZl-0001F3-SU
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 13:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab3FALCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 07:02:14 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:36176 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab3FALCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 07:02:04 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 1 Jun
 2013 13:01:58 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 1 Jun
 2013 13:02:00 +0200
X-Mailer: git-send-email 1.8.3.509.g0de0faa
In-Reply-To: <CACsJy8A6Hq_LEqAxUTLKP9-TA6aTq+91Wx2vYLhSuMSmRvpYiA@mail.gmail.com>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226121>

There are some index handling subtleties in 'commit --only' that are
best tested when we have an existing index, but an unborn or empty
HEAD.  These circumstances are easily produced by 'checkout --orphan',
but we did not previously have a test for it.

The main expected failure mode would be: erroneously loading the
existing index contents when building the temporary index that is used
for --only.  Cf.

  http://article.gmane.org/gmane.comp.version-control.git/225969

and subsequent discussion.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t7501-commit.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 195e747..99ce36f 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -524,4 +524,17 @@ test_expect_success 'commit a file whose name is a dash' '
 	test_i18ngrep " changed, 5 insertions" output
 '
 
+test_expect_success '--only works on to-be-born branch' '
+	# This test relies on having something in the index, as it
+	# would not otherwise actually prove much.  So check this.
+	test -n "$(git ls-files)" &&
+	git checkout --orphan orphan &&
+	echo foo >newfile &&
+	git add newfile &&
+	git commit --only newfile -m"--only on unborn branch" &&
+	echo newfile >expected &&
+	git ls-tree -r --name-only HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.3.509.g0de0faa
