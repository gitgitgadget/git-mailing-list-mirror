Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4DC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 12:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DBE615A4
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 12:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350711AbhI3MNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348271AbhI3MMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 08:12:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476AC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 05:11:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m21so5942728pgu.13
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71FA4MyfvkpynsBOY8ltXV0Fe2MI9fUf5PXGVqsI/eg=;
        b=GyPOHTfEdcRE45yypwwcNikwcr2ljNllxYs26b6Xiody3T38R7ssrVjUE9sA0X/iIn
         eTbMEHBwy8hhhAy6RSz6MjN3YluqSZppo2ctrY6mSVcz1NvvMuaCzIBHgKRJhdXhkTza
         A+xfPJ2iX5qfN7gZ4O0W1wW8kpGndsWhdXM3z2iH5jP56FzekXJZYw+ONQSakzo4KY99
         VNIksGbPxCq0KWLYt9MXg+mxdAr+HBy5lpMPBSJP53AdXlyufqFgIfMgE9XKiOeTmgdR
         iyWTIWRZwiI2gFaMuMbXLdhfIy8SdKbjpN69rV5/P1Oe4nNlOHouc/4/1AwD+OEIYE5e
         ijaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71FA4MyfvkpynsBOY8ltXV0Fe2MI9fUf5PXGVqsI/eg=;
        b=n2pnowqZdzS1Ynw1PQq9auUjIDpSNJCQzs393v3pl/4VIoYfZrogpAmSHCaYHnyXxE
         JXQSEeWHgxWNcNuiD24B54Au9Bn6hnFazkynl4Kt9rTxrsHpoAwYVKIEcABcikSwMATZ
         dGhoacRLSWU/8RBrmeBot5Aj8jKAbmwRTTYoZhkJ3bnkl/ndzwHc9x/gwQVizaom+IdN
         fsQX+GtZqwLvBNo1+eqDVJcTvhkauhwgdkC0tiR7hx8rdGh5DcGC4nFpSzLTcbbEP9C5
         2yX/564ooa9eyTaVEolnuNAYTG0NI1gP1P/9bd7bUIsOHBQ0quvrWNiA6dt79TDzr5aA
         LqSw==
X-Gm-Message-State: AOAM530KBojzoH1BYofIDBHPQUr19ShwkS0EexYdZ/VbKoQCUUohaZtv
        fOXjHD8iAwuMe/bdD0ytrRNFfSXkgkn/uQ==
X-Google-Smtp-Source: ABdhPJws8B6NstpuKP0c96RMGskw7Uvxd8JKIw0IZD56Ne4BVGMIIij9g12OPYbbKKitdmIBpm1O7A==
X-Received: by 2002:aa7:9f5e:0:b0:447:baeb:bc4e with SMTP id h30-20020aa79f5e000000b00447baebbc4emr4013970pfr.64.1633003870552;
        Thu, 30 Sep 2021 05:11:10 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id c24sm3176301pgj.63.2021.09.30.05.11.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 05:11:09 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH] receive-pack: allow a maximum input object size specified
Date:   Thu, 30 Sep 2021 20:10:58 +0800
Message-Id: <20210930121058.5771-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.0.1.g1026118a84
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

'receive.maxInputSize' help us to stop writing bytes
to disk by a global cutoff point, but sometimes we only
want to say no for large objects. Let's allow a new cutoff
point where we will stop writing big objects' bytes to disk.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/index-pack.c      |  5 +++++
 builtin/receive-pack.c    | 12 ++++++++++++
 builtin/unpack-objects.c  |  8 ++++++++
 t/t5546-receive-limits.sh | 33 +++++++++++++++++++++++++++++----
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865..0e62b356c6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -133,6 +133,7 @@ static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
+static off_t max_input_object_size;
 static unsigned deepest_delta;
 static git_hash_ctx input_ctx;
 static uint32_t input_crc32;
@@ -519,6 +520,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 		shift += 7;
 	}
 	obj->size = size;
+	if (max_input_object_size && size > max_input_object_size)
+		die(_("object exceeds maximum allowed size "));
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
@@ -1825,6 +1828,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("bad %s"), arg);
 			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
 				max_input_size = strtoumax(arg, NULL, 10);
+			} else if (skip_prefix(arg, "--max-input-object-size=", &arg)) {
+				max_input_object_size = strtoumax(arg, NULL, 10);
 			} else if (skip_prefix(arg, "--object-format=", &arg)) {
 				hash_algo = hash_algo_by_name(arg);
 				if (hash_algo == GIT_HASH_UNKNOWN)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d1f97e1ca..82ff0c61ff 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -57,6 +57,7 @@ static int advertise_push_options;
 static int advertise_sid;
 static int unpack_limit = 100;
 static off_t max_input_size;
+static off_t max_input_object_size;
 static int report_status;
 static int report_status_v2;
 static int use_sideband;
@@ -242,6 +243,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.maxinputobjectsize") == 0) {
+		max_input_object_size = git_config_int64(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.procreceiverefs") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -2237,6 +2243,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)max_input_size);
+		if (max_input_object_size)
+			strvec_pushf(&child.args, "--max-input-object-size=%"PRIuMAX,
+				     (uintmax_t)max_input_object_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -2268,6 +2277,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)max_input_size);
+		if (max_input_object_size)
+			strvec_pushf(&child.args, "--max-input-object-size=%"PRIuMAX,
+				     (uintmax_t)max_input_object_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..04d9fa918f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -22,6 +22,7 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
+static off_t max_input_object_size;
 static git_hash_ctx ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static struct progress *progress;
@@ -466,6 +467,9 @@ static void unpack_one(unsigned nr)
 		shift += 7;
 	}
 
+	if (max_input_object_size && size > max_input_object_size)
+		die(_("object exceeds maximum allowed size "));
+
 	switch (type) {
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -568,6 +572,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				max_input_size = strtoumax(arg, NULL, 10);
 				continue;
 			}
+			if (skip_prefix(arg, "--max-input-object-size=", &arg)) {
+				max_input_object_size = strtoumax(arg, NULL, 10);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 0b0e987fdb..11fd374abc 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -19,16 +19,16 @@ test_pack_input_limit () {
 	'
 
 	test_expect_success "set unpacklimit to $unpack_limit" '
-		git --git-dir=dest config receive.unpacklimit "$unpack_limit"
+		git -C dest config receive.unpacklimit "$unpack_limit"
 	'
 
 	test_expect_success 'setting receive.maxInputSize to 512 rejects push' '
-		git --git-dir=dest config receive.maxInputSize 512 &&
+		git -C dest config receive.maxInputSize 512 &&
 		test_must_fail git push dest HEAD
 	'
 
 	test_expect_success 'bumping limit to 4k allows push' '
-		git --git-dir=dest config receive.maxInputSize 4k &&
+		git -C dest config receive.maxInputSize 4k &&
 		git push dest HEAD
 	'
 
@@ -38,7 +38,32 @@ test_pack_input_limit () {
 	'
 
 	test_expect_success 'lifting the limit allows push' '
-		git --git-dir=dest config receive.maxInputSize 0 &&
+		git -C dest config receive.maxInputSize 0 &&
+		git push dest HEAD
+	'
+
+	test_expect_success 'prepare destination repository' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'setting receive.maxInputObjectSize to 512 rejects push' '
+		git -C dest config receive.maxInputObjectSize 512 &&
+		test_must_fail git push dest HEAD
+	'
+
+	test_expect_success 'bumping limit to 2k allows push' '
+		git -C dest config receive.maxInputObjectSize 2k &&
+		git push dest HEAD
+	'
+
+	test_expect_success 'prepare destination repository (again)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'lifting the limit allows push' '
+		git --git-dir=dest config receive.maxInputObjectSize 0 &&
 		git push dest HEAD
 	'
 }
-- 
2.33.0.1.g1026118a84

