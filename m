Received: from mail.thalheim.io (mail.thalheim.io [135.181.61.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0E38759D
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.61.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210866; cv=none; b=bVS9xN6LNPgKYdYbIG0ZGFsu38ZSCHinbpgdYj3+7jRqmu1CB3e3P2v/NPWu097APOiX9VPI2ZXf7VvP+4hRrb6zNHE3e0vjBRNLy9EWik6ON7ZYUj897qh7TDTxH6NmrUKBf3PbDJuvkETsFSolIpnV7IAr+0o+3IXBakVVg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210866; c=relaxed/simple;
	bh=1sfzdYQkPo+rHHKu3Digr6cN1IPI0AnhI/sdQIbfhgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9Z5k0h0lSWjI9d1DPuDrUtUeTuRH3yqEcKMt3gAnXWmvYgRuwSojUTF8B/j+aCC3CnJMNoahg/8WJo/i1E2y2ufRNmlOnskUR12V3zkNHRgPbYO7drQgE0a7SICEww1Atu2QQ5+PBu0Hj8vGXfY01VHKPCf/Aus5NXuaA3cOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=cXP7hIIN; arc=none smtp.client-ip=135.181.61.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="cXP7hIIN"
Received: from localhost (unknown [IPv6:2001:a61:2b19:f801:7b4f:8b3f:6dec:a944])
	by mail.thalheim.io (Postfix) with ESMTPSA id E29F218CE693;
	Fri, 03 Apr 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1775210510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbKZhrs4NwG9YVQBiLvp6tCwAvL+rrl3Lcx09BN+lx4=;
	b=cXP7hIIN6pEDiwwWib/BtX53aKkxltvMMZ5aQk55HGOctltxDiNlBkMdqdcl/C1waZ8AJ3
	BOBnSeuCXSDFFoxvRUYG5CH1bfASYyLWcZd0OFHELbn2vJlLlXkumVayEMIlbC+D0ClbUW
	e99eYgPH4sjQ/kMYu6YeGx9qKOASz2E=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@thalheim.io smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH] config: retry acquiring config.lock for 100ms
Date: Fri,  3 Apr 2026 12:01:35 +0200
Message-ID: <20260403100135.3901610-1-joerg@thalheim.io>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

When multiple processes write to a config file concurrently, they
contend on its ".lock" file, which is acquired via open(O_EXCL) with
no retry. The losers fail immediately with "could not lock config
file". Two processes writing unrelated keys (say, "branch.a.remote"
and "branch.b.remote") have no semantic conflict, yet one of them
fails for a purely mechanical reason.

This bites in practice when running `git worktree add -b` concurrently
against the same repository. Each invocation makes several writes to
".git/config" to set up branch tracking, and tooling that creates
worktrees in parallel sees intermittent failures. Worse, `git worktree
add` does not propagate the failed config write to its exit code: the
worktree is created and the command exits 0, but tracking
configuration is silently dropped.

The lock is held only for the duration of rewriting a small file, so
retrying for 100 ms papers over any realistic contention while still
failing fast if a stale lock has been left behind by a crashed
process. This mirrors what we already do for individual reference
locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
2017-08-21)).

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 config.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 156f2a24fa..f7aff8725d 100644
--- a/config.c
+++ b/config.c
@@ -2903,6 +2903,14 @@ char *git_config_prepare_comment_string(const char *comment)
 	return prepared;
 }
 
+/*
+ * How long to retry acquiring config.lock when another process holds it.
+ * The lock is held only for the duration of rewriting a small file, so
+ * 100 ms covers any realistic contention while still failing fast if
+ * a stale lock has been left behind by a crashed process.
+ */
+#define CONFIG_LOCK_TIMEOUT_MS 100
+
 static void validate_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -2986,7 +2994,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
+					       CONFIG_LOCK_TIMEOUT_MS);
 	if (fd < 0) {
 		error_errno(_("could not lock config file %s"), config_filename);
 		ret = CONFIG_NO_LOCK;
@@ -3331,7 +3340,8 @@ static int repo_config_copy_or_rename_section_in_file(
 	if (!config_filename)
 		config_filename = filename_buf = repo_git_path(r, "config");
 
-	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	out_fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
+						   CONFIG_LOCK_TIMEOUT_MS);
 	if (out_fd < 0) {
 		ret = error(_("could not lock config file %s"), config_filename);
 		goto out;
-- 
2.53.0

