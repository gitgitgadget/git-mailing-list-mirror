Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009E20C038
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372003; cv=none; b=Y3qV5kLFok1klbx2LvFB3E/88D4EA9r1jNNZK8b1lYMY38vFyF5/lkJlSl/60OCcgoGhine15YZXjx0HN7/TCgis+HGoYY4p87DoZFDMqDVTNNGkBIu1Rcc32Xzi1fdHGsRNUdkWEeh8vB0dP759KUJ6XFt+l2PsGEjIoELpNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372003; c=relaxed/simple;
	bh=gQfT59ToCoauUkUWBcNI+QP3WKsqMtMVt3q7GeJglB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh2VcJqjc5egJzu0NOtMPnI5jegJr2Wtvuq3ASRgpMWS1nA8DGOC68uAhagh/zvBtlPmKLU12RC4EMc+YFgrxeLGIrs5q8ZHXVgwfVnpkBOnHjiJjdQvzVyIF2J1eoGDILn7TMZjuaWUo+R5QUZJ6rvZpwS2I6Cb1gpFWFOjONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=S7z2ceDF; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="S7z2ceDF"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773371998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z282bFq3K3HFx6GFM+nF8hWFgb6Yo/Rb0Tgwe/OhghI=;
	b=S7z2ceDFsBIINpfWFzZ/1x3p+gx5pGKAPYMKglVUzP0cuMCPA/8RuyzLG0vENkPot6bPbZ
	S559iMCVWOQPDw5y49/jGTBIObkL++b4OlHmYt+gu3VJNxEoQOxpDBiuGz8LTOtQzdS/Fh
	/5LgmMZzvYjKbmXpStVP2zdNs/+DUaxr/XRWq4oKOlbBoi8wmOn36CLaQFa6b4U08qsY7s
	8b+27RnMvLYuR7cqBYAvlYRZAHuU8cTrLUwSZYqYDKSXxgbfk33ORc1C+3OlNqlgNjR8s2
	QRvyNABaear97KwPhRYw/4rcdkg6xERebcqJDJ5oTX1PRfvHXJGx7r+qdyGIsg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4] apply.c: fix -p argument parsing
Date: Fri, 13 Mar 2026 04:19:47 +0100
Message-ID: <20260313031950.1695103-1-mroik@delayed.space>
In-Reply-To: <20260310050621.3849719-1-mroik@delayed.space>
References: <20260310050621.3849719-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
As Jeff pointed out, the previous patch doesn't pass tests on windows...
Inlined as a workaround and to avoid adding additional folders to the
existing test directory.

Thank you for the review :)

 apply.c               |  3 ++-
 t/t4120-apply-popt.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

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
index 697e86c0ff..3dbccbfc03 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -23,6 +23,45 @@ test_expect_success setup '
 	rmdir süb
 '
 
+test_expect_success 'git apply -p 1 patch' '
+	cat >patch <<-\EOF &&
+		From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
+		From: Mroik <mroik@delayed.space>
+		Date: Mon, 9 Mar 2026 23:25:00 +0100
+		Subject: [PATCH] Test
+
+		---
+		 t/test/test | 0
+		 1 file changed, 0 insertions(+), 0 deletions(-)
+		 create mode 100644 t/test/test
+
+		diff --git a/t/test/test b/t/test/test
+		new file mode 100644
+		index 0000000000..e69de29bb2
+		-- 
+		2.53.0.851.ga537e3e6e9
+
+	EOF
+	test_when_finished "rm -rf t" &&
+	git apply -p 1 patch &&
+	test_path_is_dir t
+'
+
+test_expect_success 'apply fails due to non-num -p' '
+	test_when_finished "rm -rf t test" &&
+	test_must_fail git apply -p malformed patch
+'
+
+test_expect_success 'apply fails due to trailing non-digit in -p' '
+	test_when_finished "rm -rf t test" &&
+	test_must_fail git apply -p 2q patch
+'
+
+test_expect_success 'apply fails due to negative number in -p' '
+	test_when_finished "rm -rf t test patch" &&
+	test_must_fail git apply -p -1 patch
+'
+
 test_expect_success 'apply git diff with -p2' '
 	cp file1.saved file1 &&
 	git apply -p2 patch.file
-- 
2.53.0.931.gb56d940889

