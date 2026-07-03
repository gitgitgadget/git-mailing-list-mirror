Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178127E076
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048427; cv=none; b=HQq0dWSPHvW9zVRn5SXG9I3u+bCF9eLk3g7nlNGPBvHV3QRw8RTMXqwtWtmB0+SWjRCcc7l8jArjeonopycRieJuwsrKZX7108G9KxQpjUmx60kUUH9UbIjYdL+2pJLbIqUSi2eg1faSZK97mxOR7jhNuR/6BvFjh+SZ07zrKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048427; c=relaxed/simple;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7AxfUx9QsPzlEF6eui56J6q/5e02YLchEmWLi1wlDViE5TsddkCZU4dwu6Zt6KybTrUGkLeOylCrqGe58OPvBx2Rhfh3gWGlvCGj/JlfgLDOu15qsD7Kbefi5sNL4imx8PwEv8EShEDiveDEIgn6mEuCTCB4+YMsQ/S1q5oEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfUuNh+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfUuNh+7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD2BC2BCC9;
	Fri,  3 Jul 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783048427;
	bh=9Qx8qRWNy6I1qTM7fP04lZ8nPNVYD+cVeHnrVT2WSq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FfUuNh+7AAgq9gBqG8wwqWGdHGX5dFacL8HtV/tKgblbb4pcs3kg0d8s/Tfpns6sg
	 1fT5k4LtP4NFGqb1+xx8tGv9Sp9uCOd4qF3B5lWetspZhQ6BXfUN2r0S0nrdvCPOKr
	 WGehaXB6SkYG+T9neQcLMFQA/QYqD3TX/CUEC9UTepaC8448br01vaOTN/Zj/zZMUa
	 DfPUPT+Xnqc/qlss47vypbP/2nKXAxT4Djrf9NCbVIe6vle6ls9EYxsYyWgWgJb1ok
	 kiYFfXSzkq8dlWR9pfYyx+vWN1E/KfbTpoXCDqOB2pxCabxzwW7PCnv7G1w7RlQJhh
	 +51XV7K0NvS1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F321EC43602;
	Fri,  3 Jul 2026 03:13:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Fri, 03 Jul 2026 11:13:17 +0800
Subject: [PATCH v6 1/2] config: refactor include_by_gitdir() into
 include_by_path()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-includeif-worktree-v6-1-a13893ad9a7f@black-desk.cn>
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
In-Reply-To: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=ipYZMmHK39gpQV5AmNeMYl72bc8vJdBHiXJBfipzzao=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqRyjnh5Kf+4exl7tr9NFJGvypMnlzcTQRU0jbh
 Pjw37HRsk2JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCakco5wAKCRB2HuYUOZmu
 i7HyD/9y0/WYtdt2R6y8IBjpvlg5KOCggwKQ23ojmyGv1noW+aJi+TrHzFpn11wqPs+4tXaXVMa
 EvCn/fCfEB2cj0MJhAnuJ91UyKJ8koHh9tkYZCNmGJDcelVR5ax1Nf0M1PwwozzSJsCn5/rlDqe
 Czem+OGtlBl5K4sZtMwmkPs2853qgnutidYtl1Fq1WwzYGegsKb1A6FYJXyLh1m3hdCTqN1vlGL
 rkSAgGXkAUmReBrldn8G4uDy3IkD1xIUc/nqYMmjEBZxQazPCj6DtP29zu3TMqmb6JGQtyJ9gpA
 PIQaCcYYFRCvMNFOD1HtbXREw+mTNBarH91DWRtxjNwmWT/91LfJCuvJMosEpnaE6/LJjaYtorj
 ZdBYpAHOl0+mVE0PwkE1nMVBKX3nDliMF4DdTWC9fxJlu819j260A4XrvXPpsg+U/7Ic7aRYAxn
 6xqnyCtrejhNyhaH9MMYhOZA6y3IDiAWfVmM0WeLcoKHmcY7fZwiQS4gbJYpHREPz4TYUVbveZz
 7Kw8dbTt2cQnptgKKo67fcnmqmtTr8r5NV8+LDahZ9FqKKpcBLVM3DK1w9dsIFQCR2Gyge1/RYM
 UeAJ9AgGdz3zM+A88cwA35mxRtQu+n93VagjLiJ8LHu20eg2a/7Dvj0Yqa67vkXmCsnSxPJdkjB
 LsX8hT7RHtMozbw==
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


