Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1262C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbhKYWKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245089AbhKYWIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:08:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF62C0613F8
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so14457916wrb.2
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Otz5S4e+/cXMRwJHA4WlIlp371bii8Gked2RAaRCypI=;
        b=f7EHv9gL+2xjPlSGfkNlnCd0cJKaXsM+4UCQ/AqTKmNZBVK5bEfqarr2DdwmikR9YJ
         Dl2cEKkJ91ZMYg3vx70h/Kz8PFPOYl9M1wkiOFFMQ7ri42joxqeUdROkqQC65QZENyTF
         bYY1uo/0g85RYuOTP2PecafPPiQT5TMsImJGSMQ0l4wivDwcC/wq9C/lKm3K0sQbp7iE
         1bkM1ls7vPV17sA8rxboR3AFYUV26HFOTH+DLM8nXtLKYNZQSdICBKpS93Q7eeczB21s
         C153/r2XUz4jMC/FexyTzFVXu0TzGFQrR9dls+zX7FrQBCbbZ3YzCht6Z2eEPzgfvfIN
         81kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Otz5S4e+/cXMRwJHA4WlIlp371bii8Gked2RAaRCypI=;
        b=Y8OmKaWN1OaDJcqlCbx6ivD1hdvV/wpDMI4WrYNjeSK7ORT+3bFpyKcBZkxqJyx2fu
         UdfXcjzEM/ED62MVuxDG+/t22liX48zzDamzlxtoVNB0ZEIuPA9rIHr6znvObOeiv5zo
         5xopzPHlW//kk0vXrgBtf5dYMFI6hUuFY+2qbHyWbJOvjEjSE+lDY5sndKdJf/8xNG4X
         THZwg81RDVEp47fylrEvKVGyxPm1sVsjGPefPGAByRl7zRV3eMZAEboQrqQsB5D0LiGF
         3Jq9dWb+jk0DQ+prMS3vBlQOM6wZjhTzDmSZwaFw6bonGyTB+vJG7hfiov+g87H8jfhI
         OG1Q==
X-Gm-Message-State: AOAM530kcV/fLD+QrltAgNUMis71TU3i1MMIMA2FFwzV4pnIQLnZuerC
        xibhMGj44Yyy3rjnj4BNa1ASou5t3GqK+g==
X-Google-Smtp-Source: ABdhPJzwPf1FCZI8JWLMm3IIuHiGvue6Hobujx1ThAgUUX0N1cp9xjMURP86sO3CX+Ny+xA0GX7ZQA==
X-Received: by 2002:adf:a193:: with SMTP id u19mr10298266wru.563.1637877831116;
        Thu, 25 Nov 2021 14:03:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/6] object-name: iterate ambiguous objects before showing header
Date:   Thu, 25 Nov 2021 23:03:43 +0100
Message-Id: <patch-v5-5.6-8880c283559-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
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
index 707480ed191..fd8b9244b5e 100644
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
@@ -442,7 +449,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * TRANSLATORS: This is line item of ambiguous object output
 	 * from describe_ambiguous_object() above.
 	 */
-	advise(_("  %s"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
@@ -541,6 +548,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		struct ambiguous_output out = {
+			.ds = &ds,
+			.advice = STRBUF_INIT,
+		};
 
 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
@@ -553,13 +564,21 @@ static enum get_oid_result get_short_oid(struct repository *r,
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
index f1948980dff..9e67231cdbf 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -73,7 +73,6 @@ test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
 
 	cat >expect <<-\EOF &&
 	error: short object ID bad0... is ambiguous
-	hint: The candidates are:
 	fatal: invalid object type
 	EOF
 	test_cmp_failed_rev_parse blob.bad bad0
@@ -95,11 +94,11 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 
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
2.34.1.838.g779e9098efb

