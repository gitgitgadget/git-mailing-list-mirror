Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="ADjwBe0u";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="5ppAOcjC"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6FD47
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:23 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBM3pheqAfvIwZ94WX+6jcakvF1IDMrEpgtOY6z9ixQ=;
	b=ADjwBe0u1pXxp71tID5qcHh4sjigf/zT0vpv+CVeG8gplAFYxB96mIC1R2Uap8lsAkujqc
	OC2O0HIHGk6O2r8JaOzAXCieFwDoH3QR7Inh5Om322vc9QuTna2ffBbj6l3XsRZhysmGdp
	JG6ft0tJBgvjqiUFoUh03RgH7D/ZSgZ3EbBjKS7F/4FOcQ0QE9AutiEaS05AKLwlVTS6Ld
	5BBfs6jvOo5dO2wOkP45C7b4TlPcHrF9ttcMnbiMnHoNQvjd7cmmBNmT2jCX6iPxOi5gg+
	YioeXBHCA9xGcdhjMIH+V9Cqu/z/XKU5mtiYtv7PtTZbSwQDR98YiTjoanNQbvbhdjXE1A
	MAC4oYj4ESs3rpFqNf/3kbo4SOwcCuHbDG7O8nmZXKrURpwpVfEPQ9RS87b3dpieImc0r/
	EnaOhn/B1Sg7yDhyirmEzU2asMkoiOo8M9w/6027ofGb3zZt+8PNAt5ejzK1zuneuRwLD+
	jgTUDvusEXMOQDvkMyYYrbzd8a3ANX2UIW3SDpqWxTetdlhIQEurBsftKqPlE6wAU0LDdJ
	JEpyLS49Xdjenjcw3C1ozpnJuAycHq9Mz28LtHuXefzGgyZTNLxGthmTDE+d270RQ5ACRx
	CGKqUMjnKjZW48PjHPawCxIsmfNOqMvlWQxY75Jbluu+y3PRI8J50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBM3pheqAfvIwZ94WX+6jcakvF1IDMrEpgtOY6z9ixQ=;
	b=5ppAOcjCB45A+KF6ZcAxsKkAtWtewq1vaxeMXVOzBfof0wGtsnrnDTxdxE2hq/aKTR9kV2
	kFzj+D9wR/aFaTCA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 5/6] t7419: test that we correctly handle renamed submodules
Date: Tue, 21 Nov 2023 21:32:46 +0100
Message-ID: <20231121203413.176414-5-heftig@archlinux.org>
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

Add the submodule again with an explicitly different name and path. Test
that calling set-branch modifies the correct .gitmodules entries. Make
sure we don't create a section named after the path instead of the name.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7419-submodule-set-branch.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 3cd30865a7..a5d1bc5c54 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -38,7 +38,8 @@ test_expect_success 'submodule config cache setup' '
 	(cd super &&
 		git init &&
 		git submodule add ../submodule &&
-		git commit -m "add submodule"
+		git submodule add --name thename ../submodule thepath &&
+		git commit -m "add submodules"
 	)
 '
 
@@ -100,4 +101,31 @@ test_expect_success 'test submodule set-branch -d' '
 	)
 '
 
+test_expect_success 'test submodule set-branch --branch with named submodule' '
+	(cd super &&
+		git submodule set-branch --branch topic thepath &&
+		test_cmp_config topic -f .gitmodules submodule.thename.branch &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thepath.branch &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		b
+		EOF
+		git -C thepath show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'test submodule set-branch --default with named submodule' '
+	(cd super &&
+		git submodule set-branch --default thepath &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thename.branch &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		a
+		EOF
+		git -C thepath show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.43.0

