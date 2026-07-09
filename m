Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892E342517
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564932; cv=none; b=K8HlOLEDMKE0lKgAF2ArWIvaUuxCqB4paQcQK6RTFir1HjENiR2jvh0BRy0jMEyQ4thE1AigIJk36v36DJGOmvpoqMIs7jKJ6eUDcXmOkEdNjcvI8lovdYLlNbycmDDKz4/1qhonk/O18jG5acU+EnauffKpgOehClNjtwyM+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564932; c=relaxed/simple;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxy4oQVUn1Ep35IeJ5WGpwfdUW7RGJNvGjzcfsxOqv84zV9aplcRtp/GW7NOSSPrVNaxQ6sgTQLRe52Ak1bIgxbJ/KCMYmDdMQohpyqlMuJ4aUcUWth/7R5WBnF8EbqOV1oxhNlBan6OSqRkw6zQriGCAPGHjA2YOwz51BmJXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF31QDtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF31QDtV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11EC2C2BCB3;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783564932;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cF31QDtVWeSZLsXBLvJUKETVhv5c3N8IzynL+0SndyKqImXszN7x6SouFWBlEGUcf
	 yj5NjMxyyoJXSBgFnqMwsyT1townVbsjKDehG9woKLUBkXubSfrfxxM7eNE/IsBKvx
	 aqs869EkGmRl7FqJqwZlTxaF6EzJax2+g2rJE3QadGbnohVgi0onkshEojPAMrMgGZ
	 FTWHLhjqgcSY0WGvMPupW89QCFJJNDA2u90FyMSiA7rbDUO5YjR+T84zgekCiDe4bK
	 hnHuG3MeNp6XOOgD5kjjj8bptIqu41rBFdjN7Rtc4X0xUxxHrjKvEGSEut76JjdLZZ
	 a0XqxMvh5a9lQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7838C44501;
	Thu,  9 Jul 2026 02:42:11 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 09 Jul 2026 10:41:41 +0800
Subject: [PATCH v7 1/3] config: refactor include_by_gitdir() into
 include_by_path()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-includeif-worktree-v7-1-e87e705e8df6@black-desk.cn>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=ipYZMmHK39gpQV5AmNeMYl72bc8vJdBHiXJBfipzzao=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqTwp/bEnS8+0AyGh0V0sU1hFKGw1rnpk01jIbB
 rv4PUU2uBmJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCak8KfwAKCRB2HuYUOZmu
 i9pVD/4o9f9HDZCvbFTFDWaaVkRRC60SWZjo3+p0oRT616oIvkh3HLvJHBmWR5iVA+tynHSgcdP
 RgKj3MQe8CJgr/H18iduMuAMKyHROJOniqAAzxd4queHe4+T8nuAOZVw3iRXFsaBa2JmyGrqMTT
 hDaxzgN6HdEuz990qNulp7Dk1u51F59KB/NNaZLOZ95/GTE5RVfnkteUQQN2omOGCIc9nDqbQun
 XQ1lb/umozAy+xT9E2fvYwqjCZjugSUUG2Qea/Mx34WPXc8ZoSem/D6Ujf1lJszmL8JfDDcsuS2
 63/LAsCR92/mSbsLrQiIA7znhXNHrGzNi8t4NejSAd3usiAidqxigH2LvJP4oSp8aVz5adi7n7x
 bwRsrigzGbGzzBbv0lBOL87qF6Oc2MXKdUf5rnfRBREwoHQzGgMVgLmCrgMNLnlYaooUkJrBqQO
 dwGYahRi5UYT/GAQ/3/QcpYFXtvHLZrpULbpsFgYzNp+HBa6lz6E+pk0LnTWWHUqHbul2SjyNPM
 gcgddav6F42kOiuSdmskwYxTHQoVbQXv0p9sLmnKJgi4XlapQ9rkhb4H+aGZngTiEKn9b0v2MSx
 VZPSE7I+/wxBrEjcvBa2W1Z3VS4aVpekdm8+2YQc4NmBHEpNkpsT6joaebRewxZndWXGloC/viy
 k9yc1MCjvl9y3TQ==
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


