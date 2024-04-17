Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071538DD6
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324775; cv=none; b=g07s6lt/YK9Tfq/L8vE3mDHypyLjl6Y66LEooebUKd7kmEDZygdWafykaCVC1+1P+AADPUWZ6SyF+e26llqnrv9ylNckGFJXlM1tAZH5PdSCAnDcQ8w0U6HYP5/e3cis7mxd07cIpy/Fhl1s4qssRZzPYa/htuZ3WYOmFnYeXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324775; c=relaxed/simple;
	bh=9iLZ6YHCjcGNiR+WPRJduspqZWVp3UuLFBY3pn9knEY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJLXQFfrHyGYcb9RuX4th0cQldU2aKIA2EzHfSDfLNruCyF/Amv+WqZZpCZlsNHhMLZioahUARDhBIi41lO8KzTH8G4foo4588z7+nK3IoGlGoaLtmn4BmLmkAwiyQ72zVN5981OICbHPzhWogHwyXocYwGqD9Q62VbkMKOJud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XA9jpjbJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XA9jpjbJ"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713324770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCwA0kxeJerDmuha2KFidN3EHfXB54Mr0Z/cEsoDbj4=;
	b=XA9jpjbJJ6xSGMTMjSbbOlfKn1kGYz4B6OI9sCHDYMiXwuKfcb3BxNYlA3liW63n1ZJVjR
	zpA8bQX1KJi9z7ti9KkJC+9wkaxwxNHo/ZPD59OXPaNb2n9CumpQE4x2C1UWxBxzdOrMST
	8i7wlHLuE8nR7CSNnn8JwZp09YvcjAWoUKg+VQM/UAwpYXxR1smswOiEtWq2CYnAE9Oom4
	UifKVzFW2zznIDbgFvFeN2O5KQkdZlRTVM9HjPoxpeK1TmVAWkXETKB9KIOG/9xp5/yltu
	BwkYhU7DNf+7xyCwUcDmorwV1vuoeW8nTXfzKinTdoosmXIazo1Iqa8U6aNN8A==
To: git@vger.kernel.org
Subject: [PATCH 4/4] t4014: add tests to cover --resend option and its exclusivity
Date: Wed, 17 Apr 2024 05:32:44 +0200
Message-Id: <42865d6c6694b9e6b745c328d717ed244dc25a1a.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <cover.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a few new tests to the t4014 that cover the --resend command-line option
for "git format-patch", which include the tests for its exclusivity with the
already existing -k and --rfc command-line options.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 t/t4014-format-patch.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e22c4ac34e6e..bcf7b633e78f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1401,6 +1401,43 @@ test_expect_success '--rfc and -k cannot be used together' '
 	test_must_fail git format-patch -1 --stdout --rfc -k >patch
 '
 
+test_expect_success '--resend' '
+	cat >expect <<-\EOF &&
+	Subject: [PATCH RESEND 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --resend >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--resend does not overwrite prefix' '
+	cat >expect <<-\EOF &&
+	Subject: [PATCH RFC RESEND 1/1] header with . in it
+	EOF
+	git -c format.subjectPrefix="PATCH RFC" \
+		format-patch -n -1 --stdout --resend >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--resend is argument order independent' '
+	cat >expect <<-\EOF &&
+	Subject: [PATCH RFC RESEND 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --resend \
+		--subject-prefix="PATCH RFC" >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--resend and -k cannot be used together' '
+	test_must_fail git format-patch -1 --stdout --resend -k >patch
+'
+
+test_expect_success '--rfc and --resend cannot be used together' '
+	test_must_fail git format-patch -1 --stdout --rfc --resend >patch
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
