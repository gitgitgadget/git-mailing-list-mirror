Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC7C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiA0F1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiA0F1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:27:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF307C061753
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:27:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso5131479wmj.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ai+ih22iBD5qC48HisB1B/JYAgHQ50xFUtHNTcqIMI8=;
        b=hCiNsZ61GaQnqfytdYFt5NTUbz7oMvMHQVFPeyZhK3wC6vGZMl2BP/bRzwMZoNIl1Q
         ROYFQCVsiQishAWK2y27yEshglPKfesUm4OEGTcmPv9k0jhuAsyxjAeAqFj4MbE/RP/x
         N0mi+sJY9Ne3LO2Eb0xKnQVy8+bQXULZ3rsMp8B6pJ0SU/Y4lPpNEkW19L3hv+IjfGuT
         jPx0QHpyiLziPC2xzSEO8iuAHe6viT4P882E0DWMPVKNRjLBJ6rEpETy+CSUSIyMNL9k
         p20whIVeFdF239a/IKjq0/BFo8FC5/iA79FEPQP6neXIUzXPYUdTZmh3XvjjvKEr6NxA
         qaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ai+ih22iBD5qC48HisB1B/JYAgHQ50xFUtHNTcqIMI8=;
        b=2YqYSa7O9NKVME2TV31sfGj3YLCHufDBefWdlf+qGgIPYgCBiAnl3dFWIJnAnJr2Hh
         5fYw2fgK8bu4PsTFILx0Yfr0D8M06Niq36GUPYUX0A5IO0pke8Z9sXAEvEQXoEMm9ome
         qtB6EoUhIWzV+UWasPYTQDsGVVaf8W9y9JDgLyCQemp/AMLeku23eZ1GGf8oc2BuXgPe
         hAdLO5YkIG58MZrgFWEgYr/EOlccLIduA3fPKGpsPFngIR1LKWXckmOCppyVWoB5J9JS
         /DiQ8JLqz44klscLDWoBYuC7u7yPSQs3xpn9MorQtbzbyWvpYFGfmo8hX38e2pSJrFTs
         YwzQ==
X-Gm-Message-State: AOAM533NjN+FiEztfiABQXdOSXRgCzXwuX6UxXilNWWl+O7BBrVw66jQ
        UFtsuYeaj4pEAQbEtah1W0+5kvlpjcmqSQ==
X-Google-Smtp-Source: ABdhPJw8+EVrZ5ERC/hBFwez8ixSFEKYetCah1vknepZJ9i31wx1m18/5izhXxTwlQmNsORqkLWwvQ==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr10227115wmj.61.1643261219008;
        Wed, 26 Jan 2022 21:26:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 6/7] object-name: iterate ambiguous objects before showing header
Date:   Thu, 27 Jan 2022 06:26:48 +0100
Message-Id: <patch-v8-6.7-57336c67dd2-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
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
index cbf459f5664..6154e1ec6f8 100644
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
@@ -452,7 +459,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * you'll probably want to swap the "%s" and leading " " space
 	 * around.
 	 */
-	advise(_("  %s"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
@@ -551,6 +558,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		struct ambiguous_output out = {
+			.ds = &ds,
+			.advice = STRBUF_INIT,
+		};
 
 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
@@ -563,13 +574,21 @@ static enum get_oid_result get_short_oid(struct repository *r,
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
index 80102cc43a3..98cefe3b703 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -73,7 +73,6 @@ test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
 
 	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
 	error: short object ID bad0... is ambiguous
-	hint: The candidates are:
 	fatal: invalid object type
 	EOF
 '
@@ -94,11 +93,11 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 
 	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
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
2.35.0.890.gd7e422415d9

