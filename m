Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008119D07E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622296; cv=none; b=apTVjCFIMQ8e1bjtfUDwEfCXWZ5sFJwf6vHeeatmVSeL0PHwtzu04gTi9MQmWvrsO9O8OlC7xsnZUcsACBPaOaxsccdvJBj/uB7jSr7brmsoxEyDqfkt6J433yVfTeQrcWLw8AY1wel40IbeG4ZhZn9tAiTECa/m3gKiWSdMH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622296; c=relaxed/simple;
	bh=SOwDrJ4ogN6/c1tiE3YHhdtBg7mHTS0jLHsi9B3czBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Suc/jzl9AEqaimIcvwSXUNFfv7W2OG6b/kJQj/EJ9bCo626Fec+jOFO+yaWlH2LbCi3cmKxL/TPfRCbr+FRt8zRP/Dnl+I5EKltbylpDTtz8zXegALi1Lujwz+ndIOGaqMNLH+gpOMcBk6bA8DrNmi0LKsV4ZeIzsxwm18OUMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=e/PzOP/d; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="e/PzOP/d"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773622286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pb+KRgl1h7KgmO+V540XykKA0chsu3hxH0mHtUyp2Y=;
	b=e/PzOP/d5zPm1eu27BxqZCiFQSraoc2m3N7u+uu17Y96fZjKPt9d6kA9jenLoFMzuO7OcQ
	3+gdoxZVHRgtBAwOxvIYw0j0xgVtGgVvHYOMLf55iLpnok8QhLIJU7BaCKGBI8FtBt0eLw
	4reja8sGNbVH7O8LuPZ7VxCFwgKglI2dpfNuPHFpy90RwNqoaowxl0SEZdQohUsxnqAsYW
	5kPWbR53MEM6TS4ZQVzaR3oXvBFc8aEeIEAUWN1Lkoyo0MlSLSuJUmzGsx43RSB7TejvDz
	egVpoouDvUMoUnivFWMcQS4Kq05Dm3j2kMJPtKb7KLEnZOl/sky2IBTgLWJgrw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <a3205153416@gmail.com>
Subject: [PATCH] apply.c: fix -p argument parsing
Date: Mon, 16 Mar 2026 01:51:16 +0100
Message-ID: <20260316005120.7079-1-mroik@delayed.space>
In-Reply-To: <20260313031950.1695103-1-mroik@delayed.space>
References: <20260313031950.1695103-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; i=mroik@delayed.space; h=from:subject; bh=SOwDrJ4ogN6/c1tiE3YHhdtBg7mHTS0jLHsi9B3czBQ=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpt1P3T7qxC90VmkU3+zzhcuir97hX8OE5whzOy y6w3/yHwMiJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabdT9wAKCRBIeX6hnBm+ 0RtzEACy51fvQCwEOdrvXWit6ujNqps59+BB7VpzVN9OzXbHMyz8aJaM/yg40hG9/1F9/jtyFUS lRCv0yIriUIzCw6qLDieITBUr2bxmwKh3Beycw9X+TRswoQ3nqhsQa9Ksjx+RPHtwjQxoWEt9Ij f9UZsJH/23TPm46xU9dyUGbV7hRfAIzY5+6HlyjTicRqATXOHjBKUhPNcZK5JKq24yP4fMB22Sy k7k88ZveYCo5M7MTCuAN7bQ8Az0ofhQqmvJ7jy+3v3EjirtGrdU7QGkklCG2UarNTB1NMitHVQ2 rsLSnB9HvoJo99Py96rhv3GgMZa1FhjqNWiPVjjSKcjuHz1LH/ZjYR/MpuJG9ksaKW3xteA+rL7 QJ7smnXMdS/fvjG6yMS8TzRpjVY/e0WPWmQgjBjGiE0cqfDmSYxWjCZPvop9KB5xGNMHXvxN7Ql E/gmHGb8cOigUBJiUC1ogrb4TLAZiuZqulEw9gUZ6pzafRdoWMnaIiyeMFi+4laytfQKdQc90Qa 4ucLb5MVSRTmHZXftzj7O//AQaJHAbV8PpgY8dAte2yt3/vaAdV01R8/3pbKPEiWCkd4oUbOf2m yJ9UL6nQyVymfXMcWqLHOXusiqIP+9RECFRkfg/J6+vQLXqM2ciltOcZiZcxZnSk36pSIWhX9fP R1DlOPJfzL6XVCw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --

"git apply" has an option -p that takes an integer as its argument.
Unfortunately the function apply_option_parse_p() in charge of parsing
this argument uses atoi() to convert from string to integer, which
allows a non-digit after the number (e.g. "1q") to be silently ignored.
As a consequence, an argument that does not begin with a digit silently
becomes a zero. Despite this command working fine when a non-positive
argument is passed, it might be useful for the end user to know that
their input contains non-digits that might've been unintended.

Replace atoi() with strtol_i() to catch malformed inputs.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
Sending a new version 'cause Tian pointed out that the die message is
not explicit enough, and a user might not understand which option we're
referring to if there are multiple.

 apply.c               |  3 ++-
 t/t4120-apply-popt.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index b6dd1066a0..52cd590bdb 100644
--- a/apply.c
+++ b/apply.c
@@ -4981,7 +4981,8 @@ static int apply_option_parse_p(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 
-	state->p_value = atoi(arg);
+	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
+		die(_("option -p expects a non-negative integer, got '%s'"), arg);
 	state->p_value_known = 1;
 	return 0;
 }
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 697e86c0ff..acb5462a25 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -23,6 +23,47 @@ test_expect_success setup '
 	rmdir süb
 '
 
+test_expect_success 'git apply -p 1 patch' '
+	cat >patch <<-\EOF &&
+	From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
+	From: Mroik <mroik@delayed.space>
+	Date: Mon, 9 Mar 2026 23:25:00 +0100
+	Subject: [PATCH] Test
+
+	---
+	 t/test/test | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	 create mode 100644 t/test/test
+
+	diff --git a/t/test/test b/t/test/test
+	new file mode 100644
+	index 0000000000..e69de29bb2
+	-- 
+	2.53.0.851.ga537e3e6e9
+	EOF
+	test_when_finished "rm -rf t" &&
+	git apply -p 1 patch &&
+	test_path_is_dir t
+'
+
+test_expect_success 'apply fails due to non-num -p' '
+	test_when_finished "rm -rf t test err" &&
+	test_must_fail git apply -p malformed patch 2>err &&
+	test_grep "option -p expects a non-negative integer" err
+'
+
+test_expect_success 'apply fails due to trailing non-digit in -p' '
+	test_when_finished "rm -rf t test err" &&
+	test_must_fail git apply -p 2q patch 2>err &&
+	test_grep "option -p expects a non-negative integer" err
+'
+
+test_expect_success 'apply fails due to negative number in -p' '
+	test_when_finished "rm -rf t test err patch" &&
+	test_must_fail git apply -p -1 patch 2> err &&
+	test_grep "option -p expects a non-negative integer" err
+'
+
 test_expect_success 'apply git diff with -p2' '
 	cp file1.saved file1 &&
 	git apply -p2 patch.file
-- 
2.53.0.959.g497ff81fa9

