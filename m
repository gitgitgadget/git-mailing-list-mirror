Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E2AC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiA0F1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiA0F1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:27:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5785C061756
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:27:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h21so2586161wrb.8
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwmKH+/tC/y3j1tXfXqbMnfEEdAmWmYKuabbCHRQdms=;
        b=AFB5HUwbgJzS2w4owAhN+dW4JwEAEHSWuqR+quWCYDbt2aMuQW9DLV1K7P7mzEeaPa
         fgpMKAN3EriSjwOd9iSW2ldEiaZEgqzYNPEVz3pND8IBcRFtLSEy1tUNSbdhalwIp3ww
         6R87lmgs8c4Kn/LWSV/kRPl/ON6ntF8ttVnJ6M3sE41mg50OFEynYOmq7Te/B945QjOi
         L0hsex1xnePB5i+9qQLqqvVuMbn1LQKTYyGwSblx6dbzmznb0nzJEDGVYCGSUP3iRODB
         Ay7ZTvc0qBsbjbt6TDUor6YFOYT4+AxfW+ZMRv0sGQx1hcuTv1m87CGMeczGMtkkMS6i
         csUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwmKH+/tC/y3j1tXfXqbMnfEEdAmWmYKuabbCHRQdms=;
        b=dtU9We8580sXcufUMyt8rG+4IqI27O0W5MYT02BrMtp+ImICX5A6P+P8DROFC12nqc
         +PC1BG28HiBN8mJuwplkUyGTTDGBUGG/qvhMfeMMKhiBLFh+R+Ww2F53nra0yW7Wq4Ve
         VejtTd2dWlQvAEVM0ftzOSSlwhiPnWWEx89DGyEdUSp+vn2B1b2rYfzJ8/OUKCLKTqd+
         MG5PS8QxmpDBuXyiwtd42d0eUAItxmKY1KJyFJsTnl9XmbWhCLi+Pfh6DaiMrhl29hRF
         fZIJZlfhl1H29LRxSJyUPO2AHdA0Zw6ww/CuXSGYtZuNs9oCzCVM15+SxjcFKfPq2T39
         0LoA==
X-Gm-Message-State: AOAM533CKEzSfps7wQvUasZGpY96SFP7S02h2qBWOViUlgg10naG/+Mi
        BsCWUAY1Lxz1atkeVUbQ1Ql7k1swoDxPAg==
X-Google-Smtp-Source: ABdhPJyFOqHWoF70ibtTmtfNtIp4LZYr4njesJNTdfm/09Gq9h6PJo6BxaPOrBhlj4w5+11rp5h2Nw==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr1591081wrv.246.1643261219983;
        Wed, 26 Jan 2022 21:26:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 7/7] object-name: re-use "struct strbuf" in show_ambiguous_object()
Date:   Thu, 27 Jan 2022 06:26:49 +0100
Message-Id: <patch-v8-7.7-1f0e1053918-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the allocations done by show_ambiguous_object() by moving the
"desc" strbuf into the "struct ambiguous_output" introduced in the
preceding commit.

This doesn't matter for optimization purposes, but since we're
accumulating a "struct strbuf advice" anyway let's follow that pattern
and add a "struct strbuf sb", we can then strbuf_reset() it rather
than calling strbuf_release() for each call to
show_ambiguous_object().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index 6154e1ec6f8..61b58a2f292 100644
--- a/object-name.c
+++ b/object-name.c
@@ -354,6 +354,7 @@ static int init_object_disambiguation(struct repository *r,
 struct ambiguous_output {
 	const struct disambiguate_state *ds;
 	struct strbuf advice;
+	struct strbuf sb;
 };
 
 static int show_ambiguous_object(const struct object_id *oid, void *data)
@@ -361,7 +362,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct ambiguous_output *state = data;
 	const struct disambiguate_state *ds = state->ds;
 	struct strbuf *advice = &state->advice;
-	struct strbuf desc = STRBUF_INIT;
+	struct strbuf *sb = &state->sb;
 	int type;
 	const char *hash;
 
@@ -377,7 +378,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * output shown when we cannot look up or parse the
 		 * object in question. E.g. "deadbeef [bad object]".
 		 */
-		strbuf_addf(&desc, _("%s [bad object]"), hash);
+		strbuf_addf(sb, _("%s [bad object]"), hash);
 		goto out;
 	}
 
@@ -402,8 +403,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 *
 		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
 		 */
-		strbuf_addf(&desc, _("%s commit %s - %s"),
-			    hash, date.buf, msg.buf);
+		strbuf_addf(sb, _("%s commit %s - %s"), hash, date.buf,
+			    msg.buf);
 
 		strbuf_release(&date);
 		strbuf_release(&msg);
@@ -423,7 +424,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			 * The third argument is the "tag" string
 			 * from object.c.
 			 */
-			strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+			strbuf_addf(sb, _("%s tag %s - %s"), hash,
 				    show_date(tag->date, 0, DATE_MODE(SHORT)),
 				    tag->tag);
 		} else {
@@ -434,7 +435,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			 *
 			 *    "deadbeef [bad tag, could not parse it]"
 			 */
-			strbuf_addf(&desc, _("%s [bad tag, could not parse it]"),
+			strbuf_addf(sb, _("%s [bad tag, could not parse it]"),
 				    hash);
 		}
 	} else if (type == OBJ_TREE) {
@@ -442,13 +443,13 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * TRANSLATORS: This is a line of ambiguous <type>
 		 * object output. E.g. "deadbeef tree".
 		 */
-		strbuf_addf(&desc, _("%s tree"), hash);
+		strbuf_addf(sb, _("%s tree"), hash);
 	} else if (type == OBJ_BLOB) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
 		 * object output. E.g. "deadbeef blob".
 		 */
-		strbuf_addf(&desc, _("%s blob"), hash);
+		strbuf_addf(sb, _("%s blob"), hash);
 	}
 
 
@@ -459,9 +460,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * you'll probably want to swap the "%s" and leading " " space
 	 * around.
 	 */
-	strbuf_addf(advice, _("  %s\n"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), sb->buf);
 
-	strbuf_release(&desc);
+	strbuf_reset(sb);
 	return 0;
 }
 
@@ -560,6 +561,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		struct oid_array collect = OID_ARRAY_INIT;
 		struct ambiguous_output out = {
 			.ds = &ds,
+			.sb = STRBUF_INIT,
 			.advice = STRBUF_INIT,
 		};
 
@@ -589,6 +591,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 		oid_array_clear(&collect);
 		strbuf_release(&out.advice);
+		strbuf_release(&out.sb);
 	}
 
 	return status;
-- 
2.35.0.890.gd7e422415d9

