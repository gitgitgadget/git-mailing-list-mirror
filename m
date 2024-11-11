Received: from simark.ca (simark.ca [158.69.221.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDB1A08C2
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.221.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342724; cv=none; b=bqufG+OfBdLL/P7weoFDyxhHbad/6vIZJNxDdmSFM3cnhmRdXQaJbg/7IvJQ+YzAO8unsiz4EWSNXGkG/fD2EFGxQUeyj57fyqbfwZHl6+iFdUaDJGSG9LZqYgmvzqSGEL7hQ4N4rb0r7F0qRDrokNV3kF3Bvp9UgxtmSayl3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342724; c=relaxed/simple;
	bh=QJT3FRj44pDsnK5V9EfVm+B083m5awa9QEia2ZM3P0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNNmz6r4qfMimCy3KBIceULTSZh5xzkRcx1M0TXg95+EEXCLuJMsqUyEFGdctFf2bb1JqNhXdRoqHBSaq5NVbKC5v/MkeV1vjr7lRD7QRK40GpdpsnbH/j86PjrqqYEX1IwiQwotMkR4ltL53MNHdF4a1JOfHjzYXV2VNx3M7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com; spf=fail smtp.mailfrom=efficios.com; arc=none smtp.client-ip=158.69.221.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=efficios.com
Received: by simark.ca (Postfix, from userid 112)
	id 74EAA1E11B; Mon, 11 Nov 2024 11:21:56 -0500 (EST)
X-Spam-Level: 
Received: from smarchi-efficios.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by simark.ca (Postfix) with ESMTPSA id 94C511E0C1;
	Mon, 11 Nov 2024 11:21:52 -0500 (EST)
From: Simon Marchi <simon.marchi@efficios.com>
To: git@vger.kernel.org
Cc: Simon Marchi <simon.marchi@efficios.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] builtin/difftool: intialize some hashmap variables
Date: Mon, 11 Nov 2024 11:21:44 -0500
Message-ID: <20241111162148.337375-1-simon.marchi@efficios.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running a dir-diff command that produces no diff, variables
`wt_modified` and `tmp_modified` are used while uninitialized, causing:

    $ /home/smarchi/src/git/git-difftool --dir-diff master
    free(): invalid pointer
    [1]    334004 IOT instruction (core dumped)  /home/smarchi/src/git/git-difftool --dir-diff master
    $ valgrind --track-origins=yes /home/smarchi/src/git/git-difftool --dir-diff master
    ...
    Invalid free() / delete / delete[] / realloc()
       at 0x48478EF: free (vg_replace_malloc.c:989)
       by 0x422CAC: hashmap_clear_ (hashmap.c:208)
       by 0x283830: run_dir_diff (difftool.c:667)
       by 0x284103: cmd_difftool (difftool.c:801)
       by 0x238E0F: run_builtin (git.c:484)
       by 0x2392B9: handle_builtin (git.c:750)
       by 0x2399BC: cmd_main (git.c:921)
       by 0x356FEF: main (common-main.c:64)
     Address 0x1ffefff180 is on thread 1's stack
     in frame #2, created by run_dir_diff (difftool.c:358)
    ...

If taking any `goto finish` path before these variables are initialized,
`hashmap_clear_and_free()` operates on uninitialized data, sometimes
causing a crash.

Fix it by zero-initializing these variables, making
`hashmap_clear_and_free()` a no-op in that case.

Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: René Scharfe <l.s.r@web.de>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index ca1b0890659b..b902f5d2ae17 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -376,7 +376,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct hashmap wt_modified, tmp_modified;
+	struct hashmap wt_modified = {0};
+	struct hashmap tmp_modified = {0};
 	int indices_loaded = 0;
 
 	workdir = repo_get_work_tree(the_repository);

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
-- 
2.47.0

