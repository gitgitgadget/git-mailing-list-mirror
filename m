Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B807C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 19:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiDFTks (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiDFTkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 15:40:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581591CFFBE
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:13:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so5983925ejd.5
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLd8WOW1RvHQ8O7rK7a5q4Zu1qIYpP9EreZfKTngxg8=;
        b=gP5OhSn9YxQNcn6BrIfwgWPmc6wRWC4zVSDmFYk+nzRYLSf+bUZbX6gIaqwYnPpJzo
         r/jX818ZoOUkqJRWmnr8G0+ORWaHHcXOmqZL3Wb65G6+a8Md29qR7zOBF0ZxxdZfqQhU
         c/H+4Fo2AFKx+PbFN7wueD3W2aV+bxnAYOzfRIMWchOEbrbl+oJhnJ/CPgqbj4ikAXWA
         LkqyE+MOTxH9SOmJVjFScsZ9XS6wzcd9W48eCAO26P9Vjjg5o/BQrFhi6KUvpHOn6IER
         IeA84+ssy5wYT/oFGhFikEL96dt5hwLCF5uDL/lu6y81BSrWEAtynvbzxesDIxULb6hy
         JBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLd8WOW1RvHQ8O7rK7a5q4Zu1qIYpP9EreZfKTngxg8=;
        b=8HXCyhiljeBGR0kxvXeVU5EA5qoyvbtkYVmvaAZea5USdmT4OVLB9HCesBdKFhYWvF
         PVS3vacT8q1+Z/Pn5QI0X0jrnu3LYLho5iaf6+jvqpM+r4jSFnJFWaCdyb0svfcX/CpD
         OI3zd38AbcCjKLB5WNML4WcSy1+IoMsdgS0vr4rNdLScT7mH0nmW4Mnpcb/k95d+jJrB
         AN3vqgBSu4ZTuD/3vjMEUm6CcF3vqe1b8C9/CwvZrhRjnqniqcRH2C3PGayW6eQkjVp9
         v8TtgnDJ9P7dYb2lafJvDLv3A1DKqpqzfyPj1LD4LQyrDR9u++Hs0s5hRDy4lbCO0i49
         8+8A==
X-Gm-Message-State: AOAM533RIilMQdorhP8aqXWnB4XkGv1Fw7Z7TXuHJw0FMyoYaPUGHZsA
        8/3qp1ywUsmyWGrFzloA/aw0REQtFEP0DQ==
X-Google-Smtp-Source: ABdhPJzZLRSODe92Qo2cA5od0ekrmiAJP7sgmZrxUIA61V5P/VLYrlbNhJq4cn6MJokcppgUCJ7QqQ==
X-Received: by 2002:a17:907:6d90:b0:6e4:de0d:462 with SMTP id sb16-20020a1709076d9000b006e4de0d0462mr9615651ejc.297.1649268808905;
        Wed, 06 Apr 2022 11:13:28 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm8503402edx.97.2022.04.06.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:13:27 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v4] blame: report correct number of lines in progress when using ranges
Date:   Wed,  6 Apr 2022 20:13:20 +0200
Message-Id: <20220406181320.16911-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using ranges, use the range sizes as the limit for progress
instead of the size of the full file.

Before:
$ git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines:  10% (122/1210), done.
$

After:
$ ./git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines: 100% (122/122), done.
$

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c     |  6 +++++-
 t/annotate-tests.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc..e33372c56b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
+	long num_lines = 0;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	for (range_i = ranges.nr; range_i > 0; --range_i) {
 		const struct range *r = &ranges.ranges[range_i - 1];
 		ent = blame_entry_prepend(ent, r->start, r->end, o);
+		num_lines += (r->end - r->start);
 	}
+	if (!num_lines)
+		num_lines = sb.num_lines;
 
 	o->suspects = ent;
 	prio_queue_put(&sb.commits, o->commit);
@@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
+		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
 
 	assign_blame(&sb, opt);
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 09e86f9ba0..cc01d89150 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -56,6 +56,10 @@ check_count () {
 	' "$@" <actual
 }
 
+get_progress_result () {
+	tr '\015' '\012' | tail -n 1
+}
+
 test_expect_success 'setup A lines' '
 	echo "1A quick brown fox jumps over the" >file &&
 	echo "lazy dog" >>file &&
@@ -604,3 +608,39 @@ test_expect_success 'blame -L X,-N (non-numeric N)' '
 test_expect_success 'blame -L ,^/RE/' '
 	test_must_fail $PROG -L1,^/99/ file
 '
+
+test_expect_success 'blame progress on a full file' '
+	cat >expect <<-\EOF &&
+	Blaming lines: 100% (10/10), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress hello.c 2>stderr &&
+
+	get_progress_result <stderr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame progress on a single range' '
+	cat >expect <<-\EOF &&
+	Blaming lines: 100% (4/4), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 3,6 hello.c 2>stderr &&
+
+	get_progress_result <stderr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame progress on multiple ranges' '
+	cat >expect <<-\EOF &&
+	Blaming lines: 100% (7/7), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 3,6 -L 8,10 hello.c 2>stderr &&
+
+	get_progress_result <stderr >actual &&
+	test_cmp expect actual
+'
-- 
2.35.1

