Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FA282F3A
	for <git@vger.kernel.org>; Mon, 25 May 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779679228; cv=none; b=GNZ+WENSQpJjm2VYGyuMMDghCMBN8Z4wQGEXlxN+VCQZc4CI+A+GlI1J+fcsceSqNZsisv8k4/6Vy4LE9MbKEttiRIgAhQ6CHx6QJ2rc8WojOthxtXiK4ydSq1x6NVdy7Im+BHogt6U1ed3LloMlzXdYpyn8yiN0D96CRhbEh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779679228; c=relaxed/simple;
	bh=ogB+XTuCS5ikQqpnZfSq1KlpAHzoGHpU4UI0fTseWVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J43OqFMxUmZpOxvtQAMDQVfkHWzNjco3idGnAyDjAbBhUZlfg1B8Qm+vAuejK+i4Z2klNJiOYHBDLtrardM9skTK6ZUMQSjJtX93e6KGunumf+647yBPAwPZZOdPU1VAuT+h5acdSzknIimE27R3N61VGpeL81SQLBPU877KMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYZhXMCh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYZhXMCh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A74DBC2BCC4;
	Mon, 25 May 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779679228;
	bh=ogB+XTuCS5ikQqpnZfSq1KlpAHzoGHpU4UI0fTseWVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HYZhXMChiJjdsUlirHwSN7TfymFY66pT68d3uWqlgFF61CardNN/gNQoFxW9a9X5p
	 mm6lz3ivg771KA0RUTXfNC8P+yVA6EA7NlPClWQz0oZpELukbDpjeywN16xS/9C3pc
	 19J0shYHR5ihVNPk7ynssyGB2UOqRdBHUYesIUAeqHK0Zqz5I20Zh0yQG3rlBxbeZq
	 83lIpCjGlwXoaZ9O5PnU8Xklp00GNKRnYmZ2CfCnVPbepTcpQMAclKAUF5hIqIYNnb
	 bphCsDRsxFiHZniukXBeVzbUiRmhtj3XKRoaPUvdYjWy4elj5FjH2iGDW3jVZvl7k4
	 dRznZmnFaCyLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA6CD5BBF;
	Mon, 25 May 2026 03:20:28 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Mon, 25 May 2026 11:20:08 +0800
Subject: [PATCH v5 1/2] config: refactor include_by_gitdir() into
 include_by_path()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-includeif-worktree-v5-1-1efe525d025a@black-desk.cn>
References: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
In-Reply-To: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=2LURLG5TI+EvAwKerMK90lXMVn+WNDEa02BaoePsuGk=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqE7/4RIDmleDRIUCZ5ftBE+fA1qDVeKRngwbZ0
 aEQNHvaQB2JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCahO/+AAKCRB2HuYUOZmu
 ixTED/47HJAwAqHb+Iiv67/g4nxLuPzJfLvEusO8rgUfiMlJNfHE4QasaH8jbFPDsh6F9ucn75Q
 k9ctJU/cjXG5th9Tr89U2WsR2o1a0lL4UDUqQlKaOi8PWfbz6k8zQleQU4nQ0sv6v+2CvL/8hKe
 rPuhOSK3el9F83hwys8n5LESXbHk1TgIKiZpEJNKAeQUxb7ZM6drfzb8wNwGCVkUYToiP0DUjgL
 /6PFswXFXKwrD+zUhr40BfGEFVkndrnhn8GBxSXxke+s6e1sagqRgdFWXBRqzYIKoLEthfb9+EO
 /KvHqqM95ulChUZ/RK4n2ZoY3D2t+0IJglB2Ah4twlEj9XRKGSV/6TL9I7yPVCsgXOTV92i9kIA
 Ph+nINds5xw+akrQ3keTX6CKRc3VvR1utrhNnZBB1LcvXJtzK5vG/DN0KIbb5HxopcOgDseUJay
 MV9UeHvgqzEAqZn3DP5Ajf0seEPUOOyozSJVZNCba78auFxIqo3b3o22I9yD4/cayxRt+r8uYmm
 g+bjHwdE9mqDSZMFFWtNWVp8/ip0Oh3NoX3pPxyZa3C9RCUpt3GrRImr3eIqs6BR+Pqj3oGfITw
 UJyVw1usmmnNa16E/URW+xWB0StoAOSuXZksVeokfwV4KxuSgISKHEyJSec3bxazwCsoWQGk8de
 84uaSgnwVNE+8Lg==
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
index a1b92fe083cf..d95e2804c29b 100644
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


