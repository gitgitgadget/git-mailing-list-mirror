Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA2C237C
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098857; cv=none; b=sR6k1709yL96AvD8vzV/hekMcQ0mgQ6FTk7VD0PA2Nh+xU1TdjNgjj/+S7D6ywNSLRtOE5Lxg8rcJZot1P+pNDOZX1v8xpHlFyMbABKvVYBOUIJJkd88Osgmu6+oV4qZ9nLZ0gh4cYsQ3ya+VOka8uJhfxoxHixw4ouOgfOjQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098857; c=relaxed/simple;
	bh=Ii7Pyppl1KIXnDxErmK1ANwDlJuuroIz8MCot78hFG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSi8hMHnTUg3yKFR/0f9M7qroHau2SR83HkV4KNJOA+eKC/93cbPUtdTzbLaaHOpA2hdbonuYmQUUA48/PKB+/NhtFTv9ohuQYyf6/XyryOXBDPtjSSBz03Tb7ky3b5p0N9etlPa6UNolIdPTmcHGGI586c1E0NE0UNG2pbizJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hX8Ex+od; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hX8Ex+od"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773098846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v1mWrPBGj80BOmEx5xpKHIloDj9kiKJFeMe4lbR9eNs=;
	b=hX8Ex+odesq3iiIY+2dEVem5J8zXa5s6QFhaO+o3RT3K0jS8asvwzmTKaQQX5brJ2TZk6M
	w1rc0l41oOCK/xNacpZr4stPiOfkRY4PqdF2WkBPFqlPsHImg3IzTlxPvCOnFCiEw3QGzQ
	kJzkf5B+TfqjDWGAZHx+NSq49C+z/9WQ+gV5CcRHiAgr102yRm+O9IbYt4zbVgj31QXRCA
	Cnqin8KwGj2h2PSJswgGq0wCJt8vvIj/GhPMClIBQ6liONsYCPVVQ+Ns6y5Lv70C75z2x1
	lncTR+qIrKH5+TaESKU2IyKa+tZ89t7QC82Twc+d0lu9wWpdhLyW9CmhaZkYJA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] apply.c: fix -p argument parsing
Date: Tue, 10 Mar 2026 00:26:58 +0100
Message-ID: <20260309232700.553168-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

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
Unlike [1], this argument doesn't overwrite an argument initialized to a
default value. Instead state->p_value_known is used instead to see if
the p_value should be used.

[1] https://lore.kernel.org/git/xmqq5y181fx0.fsf_-_@gitster.g/

 apply.c               |  3 ++-
 t/meson.build         |  1 +
 t/t4142-apply-args.sh | 31 +++++++++++++++++++++++++++++++
 t/t4142/patch         | 16 ++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100755 t/t4142-apply-args.sh
 create mode 100644 t/t4142/patch

diff --git a/apply.c b/apply.c
index b6dd1066a0..b6c9e40700 100644
--- a/apply.c
+++ b/apply.c
@@ -4981,7 +4981,8 @@ static int apply_option_parse_p(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 
-	state->p_value = atoi(arg);
+	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
+		die("<num> has to be non negative an integer");
 	state->p_value_known = 1;
 	return 0;
 }
diff --git a/t/meson.build b/t/meson.build
index 106c68df3d..d26df707cb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -547,6 +547,7 @@ integration_tests = [
   't4139-apply-escape.sh',
   't4140-apply-ita.sh',
   't4141-apply-too-large.sh',
+  't4142-apply-args.sh',
   't4150-am.sh',
   't4151-am-abort.sh',
   't4152-am-subjects.sh',
diff --git a/t/t4142-apply-args.sh b/t/t4142-apply-args.sh
new file mode 100755
index 0000000000..6fe73289f2
--- /dev/null
+++ b/t/t4142-apply-args.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+test_description='git apply test for various malformed arguments
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git commit --allow-empty -m "Initial commit"
+'
+
+test_expect_success 'git apply -p 1 patch' '
+	test_when_finished "rm -rf result t" &&
+	git apply -p 1 $TEST_DIRECTORY/t4142/patch &&
+	ls -l >result &&
+	test_line_count = 3 result
+'
+
+test_expect_success 'git apply -p malformed patch' '
+	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4142/patch
+'
+
+test_expect_success 'git apply -p 2q patch' '
+	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4142/patch
+'
+
+test_expect_success 'git apply -p -1 patch' '
+	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4142/patch
+'
+
+test_done
diff --git a/t/t4142/patch b/t/t4142/patch
new file mode 100644
index 0000000000..c4511bb708
--- /dev/null
+++ b/t/t4142/patch
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

