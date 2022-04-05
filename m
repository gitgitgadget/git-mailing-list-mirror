Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC2C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbiDEVoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457932AbiDERAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 13:00:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0C70F55
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:58:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p23so8100023edi.8
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvkLYCBphUuQ+HoXHcA6wWZTJYRjEhfjpxzMD8rMwDE=;
        b=j16euXePPv562Sj0hAvMOza/SGv0YvPhdrSVKeQf5SYfO9diXtCABWAg2A6DjZCEd8
         wyCMAmd5AS05XVX9Dx+nSovAk7Kph7RaC9PtA99sLb1WDgA1X/jZP7qmm//xS6ORYe1i
         xqnrsjEnMi0/Rm1niwKQvXs+xeVV/1heEXr4kABIZfvYLVcYGvzT4amoO3QwbRj1zQLk
         sJmQsDetJ/6eCX9xN2gWHK/hEWZWUOMqByCZRVc2CQxv+zqA6V2k5LBuWI+t5uk+k/X6
         stxmLJELoB48qH55EEXZ7jRbL0TnGekU5zMnrjGFJQW/PP+xQMHkT8wLg5+9PMZP23hJ
         tp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvkLYCBphUuQ+HoXHcA6wWZTJYRjEhfjpxzMD8rMwDE=;
        b=6v/8vymKzghqyKvie/vsithvDYVVuxznmu2FxNJ+ouRMbVNyyM6hDShGzeCSAD0K7N
         KrA9XZ7h7kIowA0eFPhzM2TPXzgxbFmD4+oFwovn46UL8eBQGBwYoI8fFxmEj1fuV3j4
         guz4CV2C7Eoh1MVhCLQrFPjgLyJECS/ayXKraG+MQU5C1BiqsBCt4jux/QQHf5TjQYSe
         p1s2Rc604bF7fRxKjJTlllZ0h/8uP0TMcE5SHby5+WhYemEVIYwwNYYUpY9R9eFr2QTG
         4ukkHGzUW+jGKORTGjtrVlNwapqZOTsfgyVDwt7c2gbEdqpLkCDYKQ6UhlaffuZv+EWd
         3N4A==
X-Gm-Message-State: AOAM5337ttHMyN9NjkMCOe2l8fBfSc2UOKxLDp77n15+yLkKTuJJaB4F
        o1GkfQwDeduUpT2eNLjH3cM=
X-Google-Smtp-Source: ABdhPJwKzEJmTd5wJN8W+8//Pck64WWroWk/Cj2koc3GafDQGTxpLA8FQmbsGqTe3Ss93Nf4KzYwcg==
X-Received: by 2002:aa7:d8d6:0:b0:41c:e20b:dd10 with SMTP id k22-20020aa7d8d6000000b0041ce20bdd10mr4716445eds.99.1649177901110;
        Tue, 05 Apr 2022 09:58:21 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id qp27-20020a170907207b00b006e66a4e924bsm4248589ejb.201.2022.04.05.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:58:20 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v3] blame: report correct number of lines in progress when using ranges
Date:   Tue,  5 Apr 2022 18:58:06 +0200
Message-Id: <20220405165806.842520-1-eantoranz@gmail.com>
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

Note: Shamelessly copied show_cr from t0500-progress-display.sh
Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c     |  6 ++++-
 t/annotate-tests.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

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
index 09e86f9ba0..90932e304b 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -12,6 +12,10 @@ else
   }
 fi
 
+show_cr () {
+	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
+}
+
 check_count () {
 	head= &&
 	file='file' &&
@@ -604,3 +608,52 @@ test_expect_success 'blame -L X,-N (non-numeric N)' '
 test_expect_success 'blame -L ,^/RE/' '
 	test_must_fail $PROG -L1,^/99/ file
 '
+
+test_expect_success 'blame progress on a full file' '
+	cat >expect <<-\EOF &&
+	Blaming lines:  10% (1/10)<CR>
+	Blaming lines:  50% (5/10)<CR>
+	Blaming lines:  60% (6/10)<CR>
+	Blaming lines:  90% (9/10)<CR>
+	Blaming lines: 100% (10/10)<CR>
+	Blaming lines: 100% (10/10), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress hello.c 2>stderr &&
+
+	show_cr <stderr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame progress on a single range' '
+	cat >expect <<-\EOF &&
+	Blaming lines:  25% (1/4)<CR>
+	Blaming lines:  75% (3/4)<CR>
+	Blaming lines: 100% (4/4)<CR>
+	Blaming lines: 100% (4/4), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 3,6 hello.c 2>stderr &&
+
+	show_cr <stderr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame progress on multiple ranges' '
+	cat >expect <<-\EOF &&
+	Blaming lines:  42% (3/7)<CR>
+	Blaming lines:  57% (4/7)<CR>
+	Blaming lines:  85% (6/7)<CR>
+	Blaming lines: 100% (7/7)<CR>
+	Blaming lines: 100% (7/7), done.
+	EOF
+
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 3,6 -L 8,10 hello.c 2>stderr &&
+
+	cp stderr /home/antoranz/proyectos/git/git/stderr &&
+	show_cr <stderr >actual &&
+	test_cmp expect actual
+'
-- 
2.35.1

