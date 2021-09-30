Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E490C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EC461528
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350922AbhI3NWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348765AbhI3NWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:22:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821A1C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:20:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q23so4961086pfs.9
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41GETqo2p4D6+UQAuToBeV8bf2wU4GLPW/+R6+xwDyc=;
        b=cwbGMkTMVu4gvN31yBMHwURnt/fXsTAH7lYAmQ+8tj0VZq2wepUqmVtIRd0EeCuUCC
         z4zERTHYCS9fnX+pxwHk+QsNUmpqsNYi9rwoIi3uHoo6ebRvvKbg5NKOkk94sy1zwgiI
         vOMWWcV1zoz+Z3dDXfUVYAYQ/lRPXFHcFeJHy2fY0yzLgRfw4fjFrdX0clZHN8p846Y4
         cRnvcEFcBVtJu4Ls87ojB4ha6Xihx8KB6xAHZVtM1GszmyDykVED+yHwzp8FqdylhC/g
         ckDrUb5r7SkLyDXSGnHYqT3IR6LXXtq2ktVnVKWGcM6AOIhze8FiVv9G/BSLhFUU+SvD
         Ic1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41GETqo2p4D6+UQAuToBeV8bf2wU4GLPW/+R6+xwDyc=;
        b=hZOwmlPFd7z0p4XJVD/8LLNzg7hAQtm+zgHWjFXspdckJkUVocOHZRfRa5gyJo3KQY
         3lK/blS/oviY1Pv+C+muZvXRiMvYpFTt4WYW/REpMtq6WGiwt1G/bZo/gcb3nRIM8whO
         mdnazWSGuJCmCT9Ix/HUDhpl65Ds0Rky9AuWkMBsnYWHNfo72B3tGxbgmyZJNsT5BjjN
         RUIL3/6SSlntrjYWHr/3vYAXCoen5eSvVNiWjtxSyAUSu28EKzvdIZLAyVnUhOWJ97UI
         i8dCSaD5XlFurQTTe4kY3JYki8lUbALrG7oONM1Bb5UjRJiC5MEa+tEM6jxXBCnTPVeZ
         huzA==
X-Gm-Message-State: AOAM530xG0BNtjR9SbqobsB7L6I7N07YHUWtA6eoyWTQYsqxGrU4MR5x
        dmgoR66a9PeAtIbnY41GT0s=
X-Google-Smtp-Source: ABdhPJxewb2+Hfxt101FPrYHR7AbOlFRNHNexVu1V8kzPhbKJmJctDKnT9uUTFbg7J7bqUwDDOce6Q==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr4815223pgk.171.1633008020963;
        Thu, 30 Sep 2021 06:20:20 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id qe17sm3283998pjb.39.2021.09.30.06.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:20:20 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2] receive-pack: not receive pack file with large object
Date:   Thu, 30 Sep 2021 21:20:04 +0800
Message-Id: <20210930132004.16075-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.0.1.g0542904d0a.dirty
In-Reply-To: <20210930121058.5771-1-chiyutianyi@gmail.com>
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In addition to using 'receive.maxInputSize' to limit the overall size
of the received packfile, a new config variable
'receive.maxInputObjectSize' is added to limit the push of a single
object larger than this threshold.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 Documentation/config/receive.txt |  6 ++++++
 builtin/index-pack.c             |  5 +++++
 builtin/receive-pack.c           | 12 ++++++++++++
 builtin/unpack-objects.c         |  8 ++++++++
 t/t5546-receive-limits.sh        | 25 +++++++++++++++++++++++++
 5 files changed, 56 insertions(+)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 85d5b5a3d2..4823ead8e4 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -74,6 +74,12 @@ receive.maxInputSize::
 	accepting the pack file. If not set or set to 0, then the size
 	is unlimited.
 
+receive.maxInputObjectSize::
+	If one of the objects in the incoming pack stream is larger than
+	this limit, then git-receive-pack will error out, instead of
+	accepting the pack file. If not set or set to 0, then the size
+	is unlimited.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
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
index 0b0e987fdb..52c8f1f2e8 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -41,6 +41,31 @@ test_pack_input_limit () {
 		git --git-dir=dest config receive.maxInputSize 0 &&
 		git push dest HEAD
 	'
+
+	test_expect_success 'prepare destination repository (test for large object)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'setting receive.maxInputObjectSize to 512 rejects push large object' '
+		git -C dest config receive.maxInputObjectSize 512 &&
+		test_must_fail git push dest HEAD
+	'
+
+	test_expect_success 'bumping limit to 2k allows push large object' '
+		git -C dest config receive.maxInputObjectSize 2k &&
+		git push dest HEAD
+	'
+
+	test_expect_success 'prepare destination repository (test for large object,again)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'lifting the limit allows push' '
+		git -C dest config receive.maxInputObjectSize 0 &&
+		git push dest HEAD
+	'
 }
 
 test_expect_success "create known-size (1024 bytes) commit" '
-- 
2.33.0.1.g0542904d0a.dirty

