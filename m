Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475441FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbdBNPsv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 10:48:51 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35291 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbdBNPst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 10:48:49 -0500
Received: by mail-wr0-f194.google.com with SMTP id o16so28133387wra.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HcU2fNVBc5JS0+U9wcICS7V2jmZUTRrB4Jsy6YIvB30=;
        b=jRMRM5xAsFIoqP1rPXJEtvlppbeKE8ZZZFGHPgf/fSw1//vQQxxGHMhAy3tYmUfvXN
         bIXCWZ/B3AxY8skoCLpltTLfDNZXO6ek5S6wrCyfTh6xda09vX/jrEPTfzlxKl/oRC22
         ilBbosm+bDz3mcR/gEiM8J3/9hpJ/l44GXGPBHWb+Omt20k09WS+TYNJ3j/MYF64OoKl
         UUxGi88jWC+mj+FzG3lwOAn5YOB4zMaeZSdrSa5mTPcX35eJCmuxsl6duUpGURM40Z9G
         53fMnGs3kzvbwr1YHjUgoAvwk+2oh+in2alP4mRlFqFmmTL/qwfb3aJV+5+fXgvRyUG5
         BvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HcU2fNVBc5JS0+U9wcICS7V2jmZUTRrB4Jsy6YIvB30=;
        b=anrwcyr0MMJSA6JI5ZZdUPaykQnB10ufX4HNyy9UUQ5qwCyqLc70vM9Uei7oZroJcW
         Sq2Z2j0lAu9cmRA8suJsHSjxRcu/p1m5tKvQAeyeZT6ItCybLvh90eYkCzJLnVXz72jr
         rRRRzVdEBDtc51s5b4wh6le0MubFlAyJlajB3/q2LfJwQgHWGPTrzZ6hWhJh17+x/KRV
         tMf4oyp7NJ1EcM4fOCh7OleFAyghKi3VguVa8zbv3vaMHWTBQowlIWAVmsmbE2OzT/gQ
         fiyIUGfuTdadqYtdWDaUE41FnjGATZ4KBgB/Zqpp5QJz1tAtAxjR4kVwdvpnN/PO60xy
         o4BA==
X-Gm-Message-State: AMke39nmpojBwYKoGhjuW75P0rS3wfo+2PE3JXD9NG0rsvuJIEBkWOfUGtih82KhNkXovg==
X-Received: by 10.223.136.155 with SMTP id f27mr25080262wrf.98.1487087328274;
        Tue, 14 Feb 2017 07:48:48 -0800 (PST)
Received: from localhost.localdomain (126.14.112.78.rev.sfr.net. [78.112.14.126])
        by smtp.gmail.com with ESMTPSA id 61sm1265459wrs.29.2017.02.14.07.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 07:48:47 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] show-branch: fix crash with long ref name
Date:   Tue, 14 Feb 2017 16:48:16 +0100
Message-Id: <20170214154816.12625-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a minimum fix for a crash with a long ref name.

Note that if the refname is too long (for example if you
use 100 instead of 50 in the test script) you could get
an error like:

fatal: cannot lock ref 'refs/heads/1_2_3_4_ ... _98_99_100_':
Unable to create '... /.git/refs/heads/1_2_3_4_ ... _98_99_100_.lock':
File name too long

when creating the ref instead of a crash when using
show-branch and that would be ok.

So a simpler fix could have been just something like:

-       char head[128];
+       char head[1024];

But if the filesystem ever allows filenames longer than 1024
characters then the crash could appear again.

Reported by: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/show-branch.c          | 14 +++++++-------
 t/t3204-show-branch-refname.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100755 t/t3204-show-branch-refname.sh

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 974f3403ab..3c0fe55eec 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -620,7 +620,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
-	char head[128];
+	char *head_cpy;
 	const char *head_p;
 	int head_len;
 	struct object_id head_oid;
@@ -791,11 +791,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				    head_oid.hash, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
-		memcpy(head, head_p, head_len + 1);
+		head_cpy = xstrdup(head_p);
 	}
 	else {
 		head_len = 0;
-		head[0] = 0;
+		head_cpy = xstrdup("");
 	}
 
 	if (with_current_branch && head_p) {
@@ -804,15 +804,15 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			/* We are only interested in adding the branch
 			 * HEAD points at.
 			 */
-			if (rev_is_head(head,
+			if (rev_is_head(head_cpy,
 					head_len,
 					ref_name[i],
 					head_oid.hash, NULL))
 				has_head++;
 		}
 		if (!has_head) {
-			int offset = starts_with(head, "refs/heads/") ? 11 : 0;
-			append_one_rev(head + offset);
+			int offset = starts_with(head_cpy, "refs/heads/") ? 11 : 0;
+			append_one_rev(head_cpy + offset);
 		}
 	}
 
@@ -865,7 +865,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	if (1 < num_rev || extra < 0) {
 		for (i = 0; i < num_rev; i++) {
 			int j;
-			int is_head = rev_is_head(head,
+			int is_head = rev_is_head(head_cpy,
 						  head_len,
 						  ref_name[i],
 						  head_oid.hash,
diff --git a/t/t3204-show-branch-refname.sh b/t/t3204-show-branch-refname.sh
new file mode 100755
index 0000000000..83b64e3032
--- /dev/null
+++ b/t/t3204-show-branch-refname.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='test show-branch with long refname'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	test_commit first &&
+	long_refname=$(printf "%s_" $(seq 1 50)) &&
+	git checkout -b "$long_refname"
+'
+
+test_expect_success 'show-branch with long refname' '
+
+	git show-branch first
+'
+
+test_done
-- 
2.12.0.rc0

