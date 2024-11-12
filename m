Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC791206972
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.207.4.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429800; cv=none; b=KzLqEYXMtfMr6/QpVoi9CDMSTXuTKXY44OhGlHOTc0XiwMJuE5RoW/Zn+47uapIMZV7jOQI/zfpUTT3MliR1tSRgwL8I0ETqKRS6jVgdjiAsorvW3Ckmy3cH2doum81wMD71JA5lfZQONkIVHQT+5jyxxevQaucpNpYt3Twceqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429800; c=relaxed/simple;
	bh=/Vt2/WNeZ/a3n2GR+4IPxH0LciG+m9bWh43X+ym47Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAW2+YWOB6Xqyc1SgGm976A8O3H8ZQa2TSXL1TXWzmsP8ELkXyi2qhLS4SCrEqrOsno7k+3RD6jqCsiB/PeddDKJQbwEhNZr2fmQ79ry993/4Hxy7W6JIuetlHVJR9tWzdmrlqH6JkYDC5UD3CrCURpd2UOsajIz5qUNVV6Cfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polymtl.ca; spf=pass smtp.mailfrom=polymtl.ca; dkim=pass (1024-bit key) header.d=polymtl.ca header.i=@polymtl.ca header.b=QJDnNK6u; arc=none smtp.client-ip=132.207.4.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polymtl.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polymtl.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polymtl.ca header.i=@polymtl.ca header.b="QJDnNK6u"
Received: from simark.ca (simark.ca [158.69.221.121])
	(authenticated bits=0)
	by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 4ACGW1ep125912
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 11:32:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 4ACGW1ep125912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polymtl.ca;
	s=default; t=1731429126;
	bh=eAJg15jqmdXqpHG2LC5hbUputNoYVMgPkkwZud1YQ2E=;
	h=From:To:Cc:Subject:Date:From;
	b=QJDnNK6uH7CwxTlODlazt8zobuBv9ATfoyTvLYTr2FolzlvHxFZdBsmeSWx4tlI1L
	 9aTH29+dlyW66sMeraNPU/Gfq3FVevag+G113M44USlp8r+IlpA0Q40cj+JkgsP0MB
	 ansrqzjpCUVopRCHbFZfo8/Bck0hI3mUkrVrr/mo=
Received: by simark.ca (Postfix, from userid 112)
	id 8966F1E15E; Tue, 12 Nov 2024 11:23:25 -0500 (EST)
X-Spam-Level: 
Received: from simark.localdomain (modemcable238.237-201-24.mc.videotron.ca [24.201.237.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by simark.ca (Postfix) with ESMTPSA id C65E31E11C;
	Tue, 12 Nov 2024 11:23:21 -0500 (EST)
From: Simon Marchi <simon.marchi@polymtl.ca>
To: git@vger.kernel.org
Cc: Simon Marchi <simon.marchi@efficios.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] builtin/difftool: intialize some hashmap variables
Date: Tue, 12 Nov 2024 11:22:57 -0500
Message-ID: <20241112162320.818091-1-simon.marchi@polymtl.ca>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Poly-FromMTA: (simark.ca [158.69.221.121]) at Tue, 12 Nov 2024 16:32:01 +0000

From: Simon Marchi <simon.marchi@efficios.com>

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

This regression was introduced in 7f795a1715 (builtin/difftool: plug
several trivial memory leaks, 2024-09-26).

Fix it by initializing those variables with the `HASHMAP_INIT` macro.

Add a test comparing the main branch to itself, resulting in no diff.

Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: René Scharfe <l.s.r@web.de>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>
---

New in v2:

 - Use the `HASHMAP_INIT` macro instead of zero-initializing the
   variables.
 - Improve an existing test to cover this case.

---
 builtin/difftool.c  | 6 ++----
 t/t7800-difftool.sh | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index ca1b0890659b..40e971e2259d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -376,7 +376,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct hashmap wt_modified, tmp_modified;
+	struct hashmap wt_modified = HASHMAP_INIT(path_entry_cmp, NULL);
+	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
 	int indices_loaded = 0;
 
 	workdir = repo_get_work_tree(the_repository);
@@ -601,9 +602,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * in the common case of --symlinks and the difftool updating
 	 * files through the symlink.
 	 */
-	hashmap_init(&wt_modified, path_entry_cmp, NULL, wtindex.cache_nr);
-	hashmap_init(&tmp_modified, path_entry_cmp, NULL, wtindex.cache_nr);
-
 	for (i = 0; i < wtindex.cache_nr; i++) {
 		struct hashmap_entry dummy;
 		const char *name = wtindex.cache[i]->name;
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index f67b9345b8a0..fcaa1748e4a8 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -666,6 +666,10 @@ run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
 	test_cmp expect file
 '
 
+run_dir_diff_test 'difftool --dir-diff with no diff' '
+	git difftool -d main main
+'
+
 write_script modify-file <<\EOF
 echo "new content" >file
 EOF

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
-- 
2.47.0

