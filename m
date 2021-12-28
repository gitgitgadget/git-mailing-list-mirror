Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50057C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhL1OfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhL1OfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583FC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so38766303wrg.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMLCAUFZK27WsuKjnyU637fftccsdQpdFhy4Zv1ZkEU=;
        b=YtMsbSnqeSE+InQFPuh706dUfp8Ew2ZhKV/uorb5xbtvvryO2BSJz8iecRsCih6po8
         cHtq4XkxI0R58kGF96iBlCdvVtkrTgeb+L5zMNIOoCUrIG5j6wYjOi3uoGcU8kTsuas+
         5i+HDs2xvE+0YpYYLXLgVhRQ9jCYBELjGmctmc1sS/2Q4v+jFtol+Z3IwVNHniNKWchp
         5FrWqTYv7M7F7aSVQzevPge5jPV+NIhEbgmhSAaFy2bWsE3jzEKV5OdBJ/gS+YXOVLoz
         qWT0XIcCjQDdEU9Twv0dx6Dy0Sgq7/SUlqBKD5FzG9Bo6s0VwqSQprWqoGil53QMnOY3
         TPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMLCAUFZK27WsuKjnyU637fftccsdQpdFhy4Zv1ZkEU=;
        b=C834LrGI6ZyWvDEMSFKmAyD0up5melwrZ/eiQF8K4YSQ9nPJmfG2UbSuCAQ3FamI++
         YDAiJ3DIMsJk/oaEN8FCntWPN8rtjL/szSZkjscjpu0dSUJxFJz5xBSfIDieKjqfR95/
         mw6LM9jqSM+ofRpR7gAkwTxIoar1sknCGICOMKzyhcXnET5cqySQtNJP2OII4JQQHfzb
         zzoVqFEdyLR9roDXMyGt/EN+x9lGOzSB3B3j0mRkaxm+VeMJjo0peqSos7qlfIJQwjt5
         939nEW8+5Hw2hNNHvxzlHtQm6Oa95e3mFAuMxnCPZ5VFv/ifEroLldmQrNHM/SNlnGFz
         hxuQ==
X-Gm-Message-State: AOAM532Um39MFps/0xlVlMnLSmfV0mjCVu2k4lTKYjAbZ+5qpBzlyxRz
        lPIZ05nN2dGujVVNGkE8d85leckDSWoyA1ny
X-Google-Smtp-Source: ABdhPJz0QUhVurDVSP2ZtiOOSOhbqUjy2zWt7/4N+Y1dqx7Ku4ZvxrMayX3Iv1I4Fd7qh1UPsPjseA==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr17162130wrt.382.1640702116662;
        Tue, 28 Dec 2021 06:35:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 5/6] object-name: iterate ambiguous objects before showing header
Date:   Tue, 28 Dec 2021 15:35:01 +0100
Message-Id: <patch-v6-5.6-644b076b2a6-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "The candidates are" header that's shown for ambiguous
objects to be shown after we've iterated over all of the objects.

If we get any errors while doing so we don't want to split up the the
header and the list as a result. The two will now be printed together,
as shown in the updated testcase.

As we're accumulating the lines into as "struct strbuf" before
emitting them we need to add a trailing newline to the call in
show_ambiguous_object(). This and the change from "The candidates
are:" to "The candidates are:\n%s" helps to give translators more
context.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c                       | 27 +++++++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh |  3 +--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 990f384129e..743d272800d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -351,9 +351,16 @@ static int init_object_disambiguation(struct repository *r,
 	return 0;
 }
 
+struct ambiguous_output {
+	const struct disambiguate_state *ds;
+	struct strbuf advice;
+};
+
 static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
-	const struct disambiguate_state *ds = data;
+	struct ambiguous_output *state = data;
+	const struct disambiguate_state *ds = state->ds;
+	struct strbuf *advice = &state->advice;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 	const char *hash;
@@ -443,7 +450,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * TRANSLATORS: This is line item of ambiguous object output
 	 * from describe_ambiguous_object() above.
 	 */
-	advise(_("  %s"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
@@ -542,6 +549,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		struct ambiguous_output out = {
+			.ds = &ds,
+			.advice = STRBUF_INIT,
+		};
 
 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
@@ -554,13 +565,21 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		if (!ds.ambiguous)
 			ds.fn = NULL;
 
-		advise(_("The candidates are:"));
 		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
 		sort_ambiguous_oid_array(r, &collect);
 
-		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
+		if (oid_array_for_each(&collect, show_ambiguous_object, &out))
 			BUG("show_ambiguous_object shouldn't return non-zero");
+
+		/*
+		 * TRANSLATORS: The argument is the list of ambiguous
+		 * objects composed in show_ambiguous_object(). See
+		 * its "TRANSLATORS" comments for details.
+		 */
+		advise(_("The candidates are:\n%s"), out.advice.buf);
+
 		oid_array_clear(&collect);
+		strbuf_release(&out.advice);
 	}
 
 	return status;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index d68c411bfc7..cb8ee3d65ed 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -74,7 +74,6 @@ test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
 
 	cat >expect <<-\EOF &&
 	error: short object ID bad0... is ambiguous
-	hint: The candidates are:
 	fatal: invalid object type
 	EOF
 	test_cmp_failed_rev_parse blob.bad bad0
@@ -96,11 +95,11 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 
 	cat >expect <<-\EOF &&
 	error: short object ID cafe... is ambiguous
-	hint: The candidates are:
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
+	hint: The candidates are:
 	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
-- 
2.34.1.1257.g2af47340c7b

