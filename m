Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567474C14
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104068; cv=none; b=ir1TZxJamxc3qCoUsfjTfIo/g/dV04UK2m6eJAaTmpqJv1tu7oBaYyNlJ0MKRZV6vV8yjQzx4TZmHN2reIZ+fqyWCv0P7f8uvxVK+HTHimJLiwFv0CYh0jYPdTzJqBDYPp66OTQKR7ggFkYx6EiRmdXpu+qx234im2p12D2R8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104068; c=relaxed/simple;
	bh=UjGbU8TYJWBK/s2Mb9kTDB1MKCZmt/RzYppMz4Jkmy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8JKFwTVZ4Dn9/ENgVSyg3VH4jWL6NWUA9Jkt1JocMGpL8CLXK24xBG995OGEoSkN4CiY5qbB1sSGyEepKHzRz29O1Ba1RDzKPIfB6tJigjN2lOzDvRIFOb5vyN1CqihE6+TuGsN7xEfiq1wlu+km3+TOcCqHO1n0RL3Uz3pN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=RqGY1y/R; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="RqGY1y/R"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773104064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFsty6tLVhHwk4jTIwzvnZHOAExJIditK6MdpjLtHIo=;
	b=RqGY1y/RbIW+Fw+zy1FB8PjYa/KWxruuq6vo1hgFBUX7eZukBF6nka5Le4eBOIGwYz/zOO
	ylm4uvub37H58kgcJLKz/KJukQmRdWuSIkqvZJaJv/n9GdU9q6s78zYsT0zczK0ooVczKo
	cF0vXR2s2aeyN1PfOXbqafJ877bZaJt3aauEoLoHmOhKAaTF4gaYeBdu3mgZ4sG1ZxM2AQ
	J3ltGY86j5VHq5lzT0OapbYgU1UOLLyzEwEdSBRtQNzh0LiGiXCReLgFIXVPgVFgDKlpdj
	wxWc8l94Uui6ojkDgzNP2WM1O4iSOaAKwFEDJbbKhSeBfHrDmBw2e1AsMi/Y9g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] apply.c: fix -p argument parsing
Date: Tue, 10 Mar 2026 01:54:07 +0100
Message-ID: <20260310005408.2022216-1-mroik@delayed.space>
In-Reply-To: <20260309232700.553168-1-mroik@delayed.space>
References: <20260309232700.553168-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

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
 apply.c                 |  3 ++-
 t/t4103-apply-binary.sh | 19 +++++++++++++++++++
 t/t4103/patch           | 16 ++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 t/t4103/patch

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
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 8e302a5a57..d9dc884946 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -53,6 +53,25 @@ test_expect_success 'setup' '
 	)
 '
 
+test_expect_success 'git apply -p 1 patch' '
+	test_when_finished "rm -rf result t" &&
+	git apply -p 1 $TEST_DIRECTORY/t4103/patch &&
+	ls -l | sed -e "/[[:space:]]t$/!d" >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'git apply -p malformed patch' '
+	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4103/patch
+'
+
+test_expect_success 'git apply -p 2q patch' '
+	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4103/patch
+'
+
+test_expect_success 'git apply -p -1 patch' '
+	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4103/patch
+'
+
 test_expect_success 'stat binary diff -- should not fail.' \
 	'git checkout main &&
 	 git apply --stat --summary B.diff'
diff --git a/t/t4103/patch b/t/t4103/patch
new file mode 100644
index 0000000000..c4511bb708
--- /dev/null
+++ b/t/t4103/patch
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
2.53.0.851.ga537e3e6e9

