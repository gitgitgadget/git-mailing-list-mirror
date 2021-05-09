Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AEC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFA613B6
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEIWSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 18:18:12 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:48544 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhEIWSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 18:18:11 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:11f:fd59:c265:f799:b7d8:2f59])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id CC36B45FEAF;
        Mon, 10 May 2021 00:17:04 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1620598625; bh=Edcy30+cvomSnn301cNYCSHzqoAWCABXAgA5DeuqPP0=;
        h=From:To:Cc:Subject:Date;
        b=nO203ax9s6RUGwzFiFuoe+FH1FJKVf/ohC/fcMBT+0rWxjaWLMVWvx9SKcDDre11f
         1r/deE/T33kNdGKqkTLVgMd3n90TG9lDKrUYc1NdnDpajfmlSlLuMH2t23Zr/dVkCo
         mQyP+sWmASkN6G2W7i/HhUV3UqEunYzbBPHxi1y8=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH] maintenance: fix two memory leaks
Date:   Mon, 10 May 2021 00:16:13 +0200
Message-Id: <20210509221613.474887-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes two memory leaks when running `git maintenance start` or `git
maintenance stop` in `update_background_schedule`:

$ valgrind --leak-check=full ~/git/bin/git maintenance start
==76584== Memcheck, a memory error detector
==76584== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==76584== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==76584== Command: /home/lenaic/git/bin/git maintenance start
==76584==
==76584==
==76584== HEAP SUMMARY:
==76584==     in use at exit: 34,880 bytes in 252 blocks
==76584==   total heap usage: 820 allocs, 568 frees, 146,414 bytes allocated
==76584==
==76584== 65 bytes in 1 blocks are definitely lost in loss record 17 of 39
==76584==    at 0x483E6AF: malloc (vg_replace_malloc.c:306)
==76584==    by 0x3DC39C: xrealloc (wrapper.c:126)
==76584==    by 0x3992CC: strbuf_grow (strbuf.c:98)
==76584==    by 0x39A473: strbuf_vaddf (strbuf.c:392)
==76584==    by 0x39BC54: xstrvfmt (strbuf.c:979)
==76584==    by 0x39BD2C: xstrfmt (strbuf.c:989)
==76584==    by 0x18451B: update_background_schedule (gc.c:1977)
==76584==    by 0x1846F6: maintenance_start (gc.c:2011)
==76584==    by 0x1847B4: cmd_maintenance (gc.c:2030)
==76584==    by 0x127A2E: run_builtin (git.c:453)
==76584==    by 0x127E81: handle_builtin (git.c:704)
==76584==    by 0x128142: run_argv (git.c:771)
==76584==
==76584== 240 bytes in 1 blocks are definitely lost in loss record 29 of 39
==76584==    at 0x4840D7B: realloc (vg_replace_malloc.c:834)
==76584==    by 0x491CE5D: getdelim (in /usr/lib/libc-2.33.so)
==76584==    by 0x39ADD7: strbuf_getwholeline (strbuf.c:635)
==76584==    by 0x39AF31: strbuf_getdelim (strbuf.c:706)
==76584==    by 0x39B064: strbuf_getline_lf (strbuf.c:727)
==76584==    by 0x184273: crontab_update_schedule (gc.c:1919)
==76584==    by 0x184678: update_background_schedule (gc.c:1997)
==76584==    by 0x1846F6: maintenance_start (gc.c:2011)
==76584==    by 0x1847B4: cmd_maintenance (gc.c:2030)
==76584==    by 0x127A2E: run_builtin (git.c:453)
==76584==    by 0x127E81: handle_builtin (git.c:704)
==76584==    by 0x128142: run_argv (git.c:771)
==76584==
==76584== LEAK SUMMARY:
==76584==    definitely lost: 305 bytes in 2 blocks
==76584==    indirectly lost: 0 bytes in 0 blocks
==76584==      possibly lost: 0 bytes in 0 blocks
==76584==    still reachable: 34,575 bytes in 250 blocks
==76584==         suppressed: 0 bytes in 0 blocks
==76584== Reachable blocks (those to which a pointer was found) are not shown.
==76584== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==76584==
==76584== For lists of detected and suppressed errors, rerun with: -s
==76584== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 builtin/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bc..2574068ae2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1947,6 +1947,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 		fprintf(cron_in, "\n%s\n", END_LINE);
 	}
 
+	strbuf_release(&line);
 	fflush(cron_in);
 	fclose(cron_in);
 	close(crontab_edit.in);
@@ -1999,6 +2000,7 @@ static int update_background_schedule(int enable)
 		die("unknown background scheduler: %s", scheduler);
 
 	rollback_lock_file(&lk);
+	free(lock_path);
 	free(testing);
 	return result;
 }
-- 
2.31.1

