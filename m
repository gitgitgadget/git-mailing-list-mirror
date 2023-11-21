Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="ZNt06AWC";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="ex/Yi4Sh"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48971A3
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:26 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U17eXxRTr7NJp7PzSMwWnoxspEkh00JPf6CNEyYFse4=;
	b=ZNt06AWC6YIomO8EFAmEqdZiTLJenr8aPG+id1WvWIh5xhRIKcuxwkmw5zAOtfbo8ocQmX
	p76f8lC5aoDDZh8/sKbDWkx7AbBq1wDMYdpGVZGzJQvGoN8ndqOsgrx/v2WXYgS4on4qBS
	BbKsNTa+DDj7FGjBJwYLza715QCUY3t/SDaQrfng2SgC6oXurnuDL0fVLl6beV7cpNVGCn
	WIZ06ypHwVkCkHi5Ed2/GSVgZTt16JZUq1Wl+JgZQRUpi7nf7Q1dSswTxqAJch2HA0IEbl
	sCDizcAncmTeFbBfq4apTP93cnkeCdvTjNG4G5GcHgVPX5uXraLq6ic/QkqvMStnGWOi+1
	X3sgBbOz3cYpV7nzwf6ijjPDff4yXPOV1Y4nXlojTEhgFu1RKKY/Fw2hH4k3Uql7vXYJ0+
	NqRHe5xPWbBPguoEWZyNw/SNjfi4YOiTNrpk6rw6i8C18ce1L2TS/mrJ8Jb6fwenfNXbzi
	9dbU9SlhdxQo5KnsEZizfgIn7F+6CcVJbFIuuTvwM9g9wEef/5QXCrLjPUcqKDMvQDGIbO
	SoTlgLqjWVfb2y4UYt0MsKPXOxSRZL+HtbxlhyTrjh4k84Qt5bd0psDHemacRBXiAMDIkV
	P/FaNoXi6SOCkd7nsJUe56bJGeZdkLqieCyxAh9cLOAoEMSsyBpiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U17eXxRTr7NJp7PzSMwWnoxspEkh00JPf6CNEyYFse4=;
	b=ex/Yi4ShWPrHjw3Scqbs+ImlqFdaV/wkY/qJj6dLCf6geau2sPMovYnv586hGUadpxPvHp
	dGe5Dpnf7R402XDA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 6/6] t7420: test that we correctly handle renamed submodules
Date: Tue, 21 Nov 2023 21:32:47 +0100
Message-ID: <20231121203413.176414-6-heftig@archlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231121203413.176414-1-heftig@archlinux.org>
References: <20231003185047.2697995-1-heftig@archlinux.org>
 <20231121203413.176414-1-heftig@archlinux.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a second submodule with a name that differs from its path. Test
that calling set-url modifies the correct .gitmodules entries. Make sure
we don't create a section named after the path instead of the name.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7420-submodule-set-url.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index aa63d806fe..bf7f15ee79 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -25,34 +25,56 @@ test_expect_success 'submodule config cache setup' '
 		git add file &&
 		git commit -ma
 	) &&
+	mkdir namedsubmodule &&
+	(
+		cd namedsubmodule &&
+		git init &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m1
+	) &&
 	mkdir super &&
 	(
 		cd super &&
 		git init &&
 		git submodule add ../submodule &&
-		git commit -m "add submodule"
+		git submodule add --name thename ../namedsubmodule thepath &&
+		git commit -m "add submodules"
 	)
 '
 
 test_expect_success 'test submodule set-url' '
-	# add a commit and move the submodule (change the url)
+	# add commits and move the submodules (change the urls)
 	(
 		cd submodule &&
 		echo b >>file &&
 		git add file &&
 		git commit -mb
 	) &&
 	mv submodule newsubmodule &&
 
+	(
+		cd namedsubmodule &&
+		echo 2 >>file &&
+		git add file &&
+		git commit -m2
+	) &&
+	mv namedsubmodule newnamedsubmodule &&
+
 	git -C newsubmodule show >expect &&
+	git -C newnamedsubmodule show >>expect &&
 	(
 		cd super &&
 		test_must_fail git submodule update --remote &&
 		git submodule set-url submodule ../newsubmodule &&
 		test_cmp_config ../newsubmodule -f .gitmodules submodule.submodule.url &&
+		git submodule set-url thepath ../newnamedsubmodule &&
+		test_cmp_config ../newnamedsubmodule -f .gitmodules submodule.thename.url &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thepath.url &&
 		git submodule update --remote
 	) &&
 	git -C super/submodule show >actual &&
+	git -C super/thepath show >>actual &&
 	test_cmp expect actual
 '
 
-- 
2.43.0

