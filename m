Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4178FC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhKWML1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhKWMLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AE0C061756
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so1783142wms.3
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meQ6KK/SiaZeFv6oojUIpZbKcIgBAiccNEXIT0rpN0I=;
        b=MX3zwOct4C/YDcU9wD5O1GkDGwwRx+IxQvp/GzUoQJb+3kaUqcEkQTR2Z0OrVtDoTM
         snl1HYNRREAfHw2nuoJsH/59ae4ZbTfdBgtyYkuFDPLFpUL64Pj3DUfTOluWcrO8K6t+
         n90kND5krKrWfT7jK30kAvI93mMNKHl9rOIzddhnkiSBo4j8ie/ZSXoDORUMJ7Xadote
         ytlGbKNfRIP/47byBjKt+jhlgu2w4MNeUOumLb9NxKJUVMQMEsy+WwHc0enzRrsIbdiN
         zQQLmTR2dQ8Iur2h0mEr5gHOLEcGoqhPxKFeN6apd6pOV0fm0kHor1T+X0vjd2WSB+y7
         PcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meQ6KK/SiaZeFv6oojUIpZbKcIgBAiccNEXIT0rpN0I=;
        b=lqPGJAMz1sOnkC7Zsa6BUz/ydRcp7CoN85Ve99M9TZvQSxQOIlHMIqJQEIxiweB2f+
         /ewkTOnMlQ//+I9fiWV8b/2LsLoC86nouQBUX9qhE4yFRxyiEHzBcij98l2PQEW7e6Sf
         V9vK63H3Qyum1Rm794zL2wnxXucalH8C9GdvW9cILgXurWKajDK6sS9HW1MEWbx1XuD8
         7lQsgS3t4Q8Rsrln32gfcFBCFyq9eNhTlH3lN4dDfb+gcY+p4lufsOmu7uAPEPueZc97
         1Dy62uCKq3byxHaI4PnZ5iFAIGtkfXP/hkfdlbyg8PSrtP3/gUTuaonV9v2ETY5imTvx
         H/dw==
X-Gm-Message-State: AOAM531h7Qn4wZoPE1vnAC2Jkqik4Ndcr+Pm3SS3tIk2x7VIWFNS89CY
        G7oO7rRgBmLn36dP40tlptZ1XKwTNiMclA==
X-Google-Smtp-Source: ABdhPJx0LOng/coXNbz9IsEu+Sib/ylKMY0GqkkONnMYV6f1g/kvJf/jjweFuzojluWwWdNOvIEAVw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr2509786wmp.46.1637669286475;
        Tue, 23 Nov 2021 04:08:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:08:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] difftool: use "env_array" to simplify memory management
Date:   Tue, 23 Nov 2021 13:06:35 +0100
Message-Id: <patch-v2-8.9-b8387a4a76d-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in 03831ef7b50 (difftool: implement the functionality
in the builtin, 2017-01-19) to use the "env_array" in the
run_command.[ch] API. Now we no longer need to manage our own
"index_env" buffer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4931c108451..4ee40fe3a06 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -202,15 +202,10 @@ static void changed_files(struct hashmap *result, const char *index_path,
 {
 	struct child_process update_index = CHILD_PROCESS_INIT;
 	struct child_process diff_files = CHILD_PROCESS_INIT;
-	struct strbuf index_env = STRBUF_INIT, buf = STRBUF_INIT;
-	const char *git_dir = absolute_path(get_git_dir()), *env[] = {
-		NULL, NULL
-	};
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir = absolute_path(get_git_dir());
 	FILE *fp;
 
-	strbuf_addf(&index_env, "GIT_INDEX_FILE=%s", index_path);
-	env[0] = index_env.buf;
-
 	strvec_pushl(&update_index.args,
 		     "--git-dir", git_dir, "--work-tree", workdir,
 		     "update-index", "--really-refresh", "-q",
@@ -222,7 +217,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	update_index.use_shell = 0;
 	update_index.clean_on_exit = 1;
 	update_index.dir = workdir;
-	update_index.env = env;
+	strvec_pushf(&update_index.env_array, "GIT_INDEX_FILE=%s", index_path);
 	/* Ignore any errors of update-index */
 	run_command(&update_index);
 
@@ -235,7 +230,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	diff_files.clean_on_exit = 1;
 	diff_files.out = -1;
 	diff_files.dir = workdir;
-	diff_files.env = env;
+	strvec_pushf(&diff_files.env_array, "GIT_INDEX_FILE=%s", index_path);
 	if (start_command(&diff_files))
 		die("could not obtain raw diff");
 	fp = xfdopen(diff_files.out, "r");
@@ -248,7 +243,6 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	fclose(fp);
 	if (finish_command(&diff_files))
 		die("diff-files did not exit properly");
-	strbuf_release(&index_env);
 	strbuf_release(&buf);
 }
 
-- 
2.34.0.831.gd33babec0d1

