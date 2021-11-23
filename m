Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC8C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhKWMLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhKWMLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028FC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so38518644wrd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/qhT/R+WF8OZX+3o91/6JFOgtmBOBfS/01pfn85rCM=;
        b=LWFAxI8pwD716azjW8inSzftEMeyeJlUY2AR7K6WgGgnhK3UfpYBw8GmpAY1/yKARf
         CkJDbUQIswCeoGkaYvYP6HQJrENUkd5/T/BWYMw8KNVrx1H3bfbzZdgVdKp1R1kcKb9M
         aJthZ5kyZdjB4ZYvePmKsD1njalSWMMe76m54DIk0YuPZm455vc9O4lga/83Zx3ko422
         PSr3DqFyladCo7TL/a5EOopdR5FP2fV27+8jUs7Z9fmnZPl8QwTMdJUqhvxOMHR8RztI
         /NOTF5D3Yh4EWg/ezu87SZEv9V9Hj1wuB+xomCipgZ3N9zDJTZn/9e/TOxtQyqto1WeL
         OYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/qhT/R+WF8OZX+3o91/6JFOgtmBOBfS/01pfn85rCM=;
        b=TMUiuvGQjf89YuVeVFDknsHbl4ys8TDksJXxP1zKBm2cYyO2MUhH7OkwfiSuLHG3QV
         KKj8xwh+A/VdPlVklhFfZfHPvWq3+axKugf7YFXlFNCe7aFpN6ZdqbLQwr+4iqKkLlR7
         IDa39+r6jnDUrptYMLsS1paFZaw9FgH8oSklTOJNbNdLy8cLSG9K6GKgbjI0Q6tj2XKU
         ETwZkcexC0aclFMj1r2FDpOEl4iCfDFeV0QAhbfPbh56wVy/PXL8BBTx0m5xMa3oeUFs
         56CmbmmE5IqH07pgW2Bxzukf07urM/wu9gKBUB3W+go/PDhGIXlsFgmfNqW6A81DRiFs
         GSOA==
X-Gm-Message-State: AOAM533GFvmrwQz+PAeCQPIyI8OsSUtco0wC1iqx0juWp30xFUb/Iaq9
        jcAL2izT+SNuMMQc8RfqxedUi/bcbGsCtg==
X-Google-Smtp-Source: ABdhPJyeGiFoD2yZZNARIotHqJYsj5yaGvxl6rmUBpXTgQAISXtCMaNP5S0Id/KUwStSk78Zq+QzOQ==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr6960413wrq.94.1637669278706;
        Tue, 23 Nov 2021 04:07:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:07:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] upload-archive: use regular "struct child_process" pattern
Date:   Tue, 23 Nov 2021 13:06:29 +0100
Message-Id: <patch-v2-2.9-bfa65e5afd7-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pattern added [1] in seems to have been intentional, but since
[2] and [3] we've wanted do initialization of what's now the "struct
strvec" "args" and "env_array" members. Let's not trample on that
initialization here.

1. 1bc01efed17 (upload-archive: use start_command instead of fork,
   2011-11-19)
2. c460c0ecdca (run-command: store an optional argv_array, 2014-05-15)
3. 9a583dc39e (run-command: add env_array, an optional argv_array for
   env, 2014-10-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/upload-archive.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 24654b4c9bf..98d028dae67 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -77,7 +77,7 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	struct child_process writer = { argv };
+	struct child_process writer = CHILD_PROCESS_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
@@ -89,9 +89,10 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	 * multiplexed out to our fd#1.  If the child dies, we tell the other
 	 * end over channel #3.
 	 */
-	argv[0] = "upload-archive--writer";
 	writer.out = writer.err = -1;
 	writer.git_cmd = 1;
+	strvec_push(&writer.args, "upload-archive--writer");
+	strvec_pushv(&writer.args, argv + 1);
 	if (start_command(&writer)) {
 		int err = errno;
 		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
-- 
2.34.0.831.gd33babec0d1

