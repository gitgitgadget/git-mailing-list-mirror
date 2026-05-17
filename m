Received: from mail.thalheim.io (mail.thalheim.io [135.181.61.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B43B3BF9
	for <git@vger.kernel.org>; Sun, 17 May 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.61.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024090; cv=none; b=p9HqRpTTkysptTIXptNdaqDHgvhq2mgpBslWneP0YrpCXl+XUeit3hK3h0HfTDq8tG+nqhy+zFUu6YXlv5z+DenI6l0y671GJfTOTHFPTGjZAKnPOYLChPEe/K/q3NG3lHc33OcIsOzyBrQClFT7/23vfH67pi1vviyxx8u/vQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024090; c=relaxed/simple;
	bh=R++643zHRS20+DS3ZEL0dd5uiv3RZ3neC2dPxIScFtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPQCrNVhfj5k6JiB102dA5L6N8nXnSMlawNvgPt21uRKUXLVX4OJZ3S3qn66H2Le7HT8twXJ/eP9T9nL40IDQEWbLOUYEE+42wZGAssIHvdsvtpgunPtmUD9NvpKAKA2gbb0G+5BtFt2sH6H1xIsgSnDumPUR3s1aRTTiTTAzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=B8iKJDnP; arc=none smtp.client-ip=135.181.61.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="B8iKJDnP"
Received: from localhost (unknown [IPv6:2001:a61:2a98:d001:2dab:fd3c:8fc0:1811])
	by mail.thalheim.io (Postfix) with ESMTPSA id 6987212F9288;
	Sun, 17 May 2026 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1779024077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmKeQfcDEwHIBXDjaxbqL0bLA3c1FW3qIXbpC7SKDKc=;
	b=B8iKJDnPQM2M5LSQpd1fmJuZ5zQtmPGMbiGNK57L6JZXCb5Dwixqmbaa3OTtkLw4C4knQh
	k/th6JffkJ+uJgN35bO77WXT+b5cbtmcJbsGo3e7H0Ze9znzmNk/0Tt88R8JuMOOHUug5T
	A6eeaYUNO9qrJ5KY5ovjL5GUYSFHlBE=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@thalheim.io smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v2] config: retry acquiring config.lock, configurable via core.configLockTimeout
Date: Sun, 17 May 2026 15:21:11 +0200
Message-ID: <20260517132111.1014901-1-joerg@thalheim.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

Concurrent config writers race for the ".lock" file, which is taken
with open(O_EXCL) and no retry, so the losers fail right away with
"could not lock config file".

This shows up with parallel "git worktree add -b" against the same
repository: each one writes a couple of branch.* keys and the losers
fail at random. Worse, "git worktree add" doesn't propagate that
failure to its exit code, so the tracking config is silently dropped.
(The swallowed error is a separate bug.)

Retry instead of giving up on the first EEXIST. The lock is only held
while rewriting a small file, so the loser only has to wait out the
other writers. Same approach as 4ff0f01cb7 (refs: retry acquiring
reference locks for 100ms, 2017-08-21).

On the semantics: the on-disk config is read only after the lock is
taken, so writers touching different keys can't lose each other's
change. Writers touching the same key still get last-writer-wins, but
that is already the case today and would need a compare-and-swap config
API to fix. The retry only turns hard failures into successes.

Default to 1000ms, like core.packedRefsTimeout: same shape of problem,
one shared file everyone serializes through. A larger timeout only
costs anything when a stale lock is left behind by a crash, which is
rare; a smaller one fails spuriously on slow filesystems (NTFS has
been seen needing more than 100ms). Make it configurable as
core.configLockTimeout. There is no chicken-and-egg problem: we read
the config before we lock it.

microsoft/git carries a similar patch (core.configWriteLockTimeoutMS,
default off) for Scalar's tests. Defaulting to non-zero here because
the worktree case fails silently.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
Thanks for the review and for poking me, this had fallen off my radar.

v1 -> v2:

- added core.configLockTimeout. Johannes is right that there is no
  chicken-and-egg problem (config is read before the lock), so no env
  var needed.
- default bumped to 1000ms; packed-refs is the closer precedent and it
  keeps NTFS out of trouble.
- commit message now covers the read-after-lock / last-writer-wins
  semantics Patrick asked about.
- added tests; existing stale-lock tests in t3200/t5505 now pass
  -c core.configLockTimeout=0 so they still fail fast.

I matched the core.filesRefLockTimeout naming rather than reusing
microsoft/git's core.configWriteLockTimeoutMS, but can switch if the
downstream compat matters more.

 Documentation/config/core.adoc |  8 ++++++++
 config.c                       | 24 ++++++++++++++++++++++--
 t/t1300-config.sh              | 17 +++++++++++++++++
 t/t3200-branch.sh              |  6 ++++--
 t/t5505-remote.sh              |  3 ++-
 5 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index a0ebf03e2e..340329edc3 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -589,6 +589,14 @@ core.packedRefsTimeout::
 	all; -1 means to try indefinitely. Default is 1000 (i.e.,
 	retry for 1 second).
 
+core.configLockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	lock a configuration file for writing. Value 0 means not to
+	retry at all; -1 means to try indefinitely. Default is 1000
+	(i.e., retry for 1 second). This is read from the configuration
+	that is already on disk before the lock is taken, so it can be
+	set persistently like any other option.
+
 core.pager::
 	Text viewer for use by Git commands (e.g., 'less').  The value
 	is meant to be interpreted by the shell.  The order of preference
diff --git a/config.c b/config.c
index 156f2a24fa..ac9563781b 100644
--- a/config.c
+++ b/config.c
@@ -2903,6 +2903,24 @@ char *git_config_prepare_comment_string(const char *comment)
 	return prepared;
 }
 
+/*
+ * How long to retry acquiring config.lock when another process holds
+ * it. Default matches core.packedRefsTimeout; override via
+ * core.configLockTimeout.
+ */
+static long config_lock_timeout_ms(struct repository *r)
+{
+	static int configured;
+	static int timeout_ms = 1000;
+
+	if (!configured) {
+		repo_config_get_int(r, "core.configlocktimeout", &timeout_ms);
+		configured = 1;
+	}
+
+	return timeout_ms;
+}
+
 static void validate_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -2986,7 +3004,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
+					       config_lock_timeout_ms(r));
 	if (fd < 0) {
 		error_errno(_("could not lock config file %s"), config_filename);
 		ret = CONFIG_NO_LOCK;
@@ -3331,7 +3350,8 @@ static int repo_config_copy_or_rename_section_in_file(
 	if (!config_filename)
 		config_filename = filename_buf = repo_git_path(r, "config");
 
-	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	out_fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
+						   config_lock_timeout_ms(r));
 	if (out_fd < 0) {
 		ret = error(_("could not lock config file %s"), config_filename);
 		goto out;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 128971ee12..12a1cb8580 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2939,4 +2939,21 @@ test_expect_success 'writing value with trailing CR not stripped on read' '
 	test_cmp expect actual
 '
 
+test_expect_success 'writing config fails immediately with core.configLockTimeout=0' '
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	test_must_fail git -c core.configLockTimeout=0 config foo.bar baz 2>err &&
+	test_grep "could not lock config file" err
+'
+
+test_expect_success 'writing config retries until lock is released' '
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	{
+		( sleep 1 && rm -f .git/config.lock ) &
+	} &&
+	git -c core.configLockTimeout=5000 config retried.key value &&
+	test "$(git config retried.key)" = value
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..5f8a31c21d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1037,7 +1037,8 @@ test_expect_success '--set-upstream-to fails on locked config' '
 	test_when_finished "rm -f .git/config.lock" &&
 	>.git/config.lock &&
 	git branch locked &&
-	test_must_fail git branch --set-upstream-to locked 2>err &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		branch --set-upstream-to locked 2>err &&
 	test_grep "could not lock config file .git/config" err
 '
 
@@ -1068,7 +1069,8 @@ test_expect_success '--unset-upstream should fail if config is locked' '
 	test_when_finished "rm -f .git/config.lock" &&
 	git branch --set-upstream-to locked &&
 	>.git/config.lock &&
-	test_must_fail git branch --unset-upstream 2>err &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		branch --unset-upstream 2>err &&
 	test_grep "could not lock config file .git/config" err
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e592c0bcde..aea9222649 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1327,7 +1327,8 @@ test_expect_success 'remote set-url with locked config' '
 	test_when_finished "rm -f .git/config.lock" &&
 	git config --get-all remote.someremote.url >expect &&
 	>.git/config.lock &&
-	test_must_fail git remote set-url someremote baz &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		remote set-url someremote baz &&
 	git config --get-all remote.someremote.url >actual &&
 	cmp expect actual
 '
-- 
2.53.0

