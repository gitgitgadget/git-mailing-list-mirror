Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2C28468E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119206; cv=none; b=ubzdo3TO9E2onR+y0l9gGtMQzyo0QQAF4QzeLisY+HLNAPlvscLQovnmkJrArueOqfiIioVld11sBLZ4gYPhQsL18jaVLR4ds5C5WUmteT2pkSTmzaSXnYeC2yDFrkUms123J1hJjz9qy3WYQYOdB/yWor0GIKUweVLEUV28LNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119206; c=relaxed/simple;
	bh=AukjCjrRg1YwpY6JpH0GUgm5KU689cHNq5/XBV8uAmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbrz/Gbi45sTl4leh+YWanlHUbiqDM7kh0VcgPwoQywupHbCd5Mxq37tkDAowxa9D9G3Hpip8i8Wspejmjw6FvtjLK3CaxniKyR5Q9mPIaRa9qcVU1xcLGxmGrJXpKOIt/N/x5OBz3D4++ZWtmonsE3oWcocii10sj/lQ+QTP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=OmrSCgui; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="OmrSCgui"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773119202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIaXCWzogtgGV9JuosrrB+U8OBtfY2kqE3f89aZwNP0=;
	b=OmrSCguiaW3ois27Ob6iipO/33dMW/CGXzanCZNEqUzmb6ZfmgKZB+vQ1Hh4IoiZF0Knem
	RRfzuO1tf1Zn0O3Ptu80/BkJI89S01DzkAl6vje2nEZ7HAfe6wMwsmFsYN/F96mK5XZoEX
	dcHV8T1Wgm0PPNPbrZlmhE3NxalUVw8ePqzh2HKliTldFgF2WkbtbM9EMiupZwdyS9466V
	O+puWohZRD1P5K9tA7zGBm+glsxnGnOK8NDAeNxE93u2gu9TTANGpVdj4GTmp3OIEHmJCs
	Sv+bkaCU4IWB/J7x7JuhUdbKS+W2BJ4mh1eXkAzbmQOG5OujVJWLgrfqw/RAjg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] apply.c: fix -p argument parsing
Date: Tue, 10 Mar 2026 06:06:15 +0100
Message-ID: <20260310050621.3849719-1-mroik@delayed.space>
In-Reply-To: <20260310005408.2022216-1-mroik@delayed.space>
References: <20260310005408.2022216-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ------

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
 apply.c               |  3 ++-
 t/t4120-apply-popt.sh | 21 +++++++++++++++++++++
 t/t4120/patch         | 16 ++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 t/t4120/patch

diff --git a/apply.c b/apply.c
index b6dd1066a0..61df3bdcd0 100644
--- a/apply.c
+++ b/apply.c
@@ -4981,7 +4981,8 @@ static int apply_option_parse_p(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 
-	state->p_value = atoi(arg);
+	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
+		die("<num> has to be a non-negative integer");
 	state->p_value_known = 1;
 	return 0;
 }
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 697e86c0ff..3fdcfecc52 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -23,6 +23,27 @@ test_expect_success setup '
 	rmdir süb
 '
 
+test_expect_success 'git apply -p 1 patch' '
+	test_when_finished "rm -rf t" &&
+	git apply -p 1 $TEST_DIRECTORY/t4120/patch &&
+	test_path_is_dir t
+'
+
+test_expect_success 'apply fails due to non-num -p' '
+	test_when_finished "rm -rf t test" &&
+	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4120/patch
+'
+
+test_expect_success 'apply fails due to trailing non-digit in -p' '
+	test_when_finished "rm -rf t test" &&
+	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4120/patch
+'
+
+test_expect_success 'apply fails due to negative number in -p' '
+	test_when_finished "rm -rf t test" &&
+	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4120/patch
+'
+
 test_expect_success 'apply git diff with -p2' '
 	cp file1.saved file1 &&
 	git apply -p2 patch.file
diff --git a/t/t4120/patch b/t/t4120/patch
new file mode 100644
index 0000000000..c4511bb708
--- /dev/null
+++ b/t/t4120/patch
@@ -0,0 +1,16 @@
+From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
+From: Mroik <mroik@delayed.space>
+Date: Mon, 9 Mar 2026 23:25:00 +0100
+Subject: [PATCH] Test
+
+---
+ t/test/test | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+ create mode 100644 t/test/test
+
+diff --git a/t/test/test b/t/test/test
+new file mode 100644
+index 0000000000..e69de29bb2
+-- 
+2.53.0.851.ga537e3e6e9
+
-- 
2.53.0.316.gd563ecec28

