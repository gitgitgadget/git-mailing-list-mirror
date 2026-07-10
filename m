Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2C3B27EA
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665846; cv=none; b=ISZlbbJpQRXah3aN7+eXV7m/e7LoKaJcg8NJ6clbkajQAdsrV4UwCxZvclRRP34lstAH+8CuBux4Z+3EBoFlwroLneCtq21fy3yXL4A4H1HMv+PuB8IDKKUTy0vxB+jdD3aWSiSYK9NM99Mqw2v5NRZfbysERp8dzHuAHVMbW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665846; c=relaxed/simple;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEH0Af2IsKLVB268bWVZX3p0BY0d835gwAP6KF8nkZF2z8TEWSMi0uYvhOdPb7nQWHTBm5fF2dE3l4ua0wyb5UHGoBliUovCo/CQ+k4dnuWd59vwd4WA3cXPU31roOz9NG7zPfbBOdry785IPRIUiy40Ty1Hp+EujlHu4ScmdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQkjAgci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQkjAgci"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6657C2BCF4;
	Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783665845;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bQkjAgci9ItR2fketGDRdQiwtJIZPj/+JSW7nU2QMplCW25ro416K6XZ3vhFMHmCS
	 nK4WhTwJrB/wd2pKlSATN0XefY+8fGtrI98OThNoj0Xm7yl9BGO+KRICnLQ4fgKbIP
	 c5ECMca7W+RDi9qEl66bh3pp0D56bpzgwwC3G+rflv/CD2rwaLrz3gKYJh64rLkxVz
	 UpR6j+gAeCsseKrNi9n2h+KI4z2NbET8SS2OFInCeX8EyGSTLdFIPgtedsdBHMIVxu
	 10XQ1OGbXcVd65hJcMyHIq6gXBRMimJd0OPi7RTnNh+qDIaDBnKD+yXT3ZzTB3GvhK
	 BJ0cf0h8hLUhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA6C44501;
	Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Fri, 10 Jul 2026 14:43:29 +0800
Subject: [PATCH v8 1/2] config: refactor include_by_gitdir() into
 include_by_path()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-includeif-worktree-v8-1-04686d8a616c@black-desk.cn>
References: <20260710-includeif-worktree-v8-0-04686d8a616c@black-desk.cn>
In-Reply-To: <20260710-includeif-worktree-v8-0-04686d8a616c@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=ipYZMmHK39gpQV5AmNeMYl72bc8vJdBHiXJBfipzzao=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqUJSj7YtT23Hni0OoBRBX0V0mx+Zdo8KNDAQMG
 YTb9tSVlN+JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCalCUowAKCRB2HuYUOZmu
 i86rEACsWHUuZPx9VSGxf4lfJH/OksTnpvYSvG70/xxCXfNRDGV4fT064JuYKZ+HHLx1A5eo2iL
 V4Ax1nZXMU2BIGBPvP7NqAVbAWIUbZB5a0gk5xczfjUicKTRIQ0N8TF1lgsvqy5U+3yviiYH0wS
 mNsNpE/ysj5V1flVNAwl37UUjag0nZelYqaytzr5FVOWQHe3KNr+vpaTttPvL5fO6B8egsLSQJk
 LNS6WRkudbL8JIus/+wsDZT+oSqQ8RybTngaSA9I4Xh75+cz6lL3R7zYkMq9SWtCao6r2u1Qna9
 LkWTyfVjIphXV9kG0hST3J7psHP464n0SI1TQYx7vZJmLHtoVFikbMoqdVk91GoZEj6y2ULjUjU
 GeN4/oMWufSjA2mAg45WRm5gMuYyIreCkQJDiPk6a0QKZYY7knD99e8emoiUhEihTFsgxo5lY/i
 tlcmPEONNNNQDcYairFVPZOaM1fftHJovtJiuhDq3faU1zabJeay2tSiNcEgQRDJbMwef4T6a5s
 JYuVyQEPGXDL6OPMJHeGSIXzH8T1MMmBlWHM1SS1vAtYujLkmqHxsK64mECLSFbc1A+t63/P45+
 tY1KCBaoZFRqFXZM2BiqldooKgDbWFi+lcEDUk6Z1UUo8WWu8i+DpnazLnl1gLk4RopnM7iZMl2
 s82QpTG0KpejdKg==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

The include_by_gitdir() function matches the realpath of a given
path against a glob pattern, but its interface is tightly coupled to
the gitdir condition: it takes a struct config_options *opts and
extracts opts->git_dir internally.

Refactor it into a more generic include_by_path() helper that takes
a const char *path parameter directly, and update the gitdir and
gitdir/i callers to pass opts->git_dir explicitly.  No behavior
change, just preparing for the addition of a new worktree condition
that will reuse the same path-matching logic with a different path.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 config.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 6a0de86e3ae9..00eeeea370c9 100644
--- a/config.c
+++ b/config.c
@@ -235,23 +235,20 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 	return 0;
 }
 
-static int include_by_gitdir(const struct key_value_info *kvi,
-			     const struct config_options *opts,
-			     const char *cond, size_t cond_len, int icase)
+static int include_by_path(const struct key_value_info *kvi,
+			   const char *path,
+			   const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
 	size_t prefix;
 	int ret = 0;
-	const char *git_dir;
 	int already_tried_absolute = 0;
 
-	if (opts->git_dir)
-		git_dir = opts->git_dir;
-	else
+	if (!path)
 		goto done;
 
-	strbuf_realpath(&text, git_dir, 1);
+	strbuf_realpath(&text, path, 1);
 	strbuf_add(&pattern, cond, cond_len);
 	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
 	if (ret < 0)
@@ -284,7 +281,7 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 		 * which'll do the right thing
 		 */
 		strbuf_reset(&text);
-		strbuf_add_absolute_path(&text, git_dir);
+		strbuf_add_absolute_path(&text, path);
 		already_tried_absolute = 1;
 		goto again;
 	}
@@ -400,9 +397,9 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
+		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
+		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,

-- 
2.53.0


