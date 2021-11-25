Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B9C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbhKYWKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbhKYWIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:08:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90528C0613F9
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c4so14412064wrd.9
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0HjMauK3uhcc0HEjoCGn4Tj/O1rG8xgRogrcu1K2m4=;
        b=W0cRhV99rSiOoEtBNCKVnyb6Lvz1Gv2/+zH7ikWGn+a/E3dpLjmeqV3afRrNuLbKY1
         f3LD1efxvVN0abByrSix9HhDo+wlk+EN52MC/gSWH6z0AjA/cYgEs10B4erZzt1ChOuf
         YWKbvkH/XjtttYwzuH8LCd7sAR/VGiY6HhlgDAREb/B4Ggq2fJiL4nVya3IrBSVjRYAE
         3TiVqAY2Qd9eNMkOF1oy/RvO0e5SFiRi3YxsL7B7E66BMYy1GVTQOhCyz0CvIGiIm7y1
         BTbXSXHixZtquUZkTejRPyuBCtqkJAfK2dj4LdY4Snf+lJXiQ+jK2Ab2YCoUcl61si/8
         bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0HjMauK3uhcc0HEjoCGn4Tj/O1rG8xgRogrcu1K2m4=;
        b=ps8CLGM8IFjV3YDW9sEdsr+g9F/k2Fs8cWLdvXCjnTup87rAINW2o7EOK9kwDnNsj5
         Lc6UoYHSFS5T3d9h08saDQ7vVVWr5tl5IpGnsT4I42rFcRSPDCM6MbfbbQq3gqcxZfh+
         dOY/DdKVOkmj3jhIREpjMvdUpnTcIsNOiHbd2b8NLiCKwkGEh9q4JmKeZrD5JcX2/k3p
         sVHHvXKUgHVau1LmBl5a8stOYWnIu8WqXpJPLF8OIB727/9ng50rqrrDaY8U0cUW9ObC
         Wxey3j8W2MkOBBD6QRI/4L1TbbXo5Lh1k6ExKSgyPdC1amgtiuPbfrm6I0rWhK/jT/Wb
         FH4w==
X-Gm-Message-State: AOAM530wy7n2VSyjJs4yfnh1jkiVVwIWkvfBIX5rfZzT3e38NM0AM4RZ
        yrdye71fmNR5HapoDI5UxpO3NlzaSB6BMw==
X-Google-Smtp-Source: ABdhPJxH+SR01BN1XH5tv3vye4qboWj1F7yYN0joMA71rE1j26OUURT86FTxlrH1OLZfBZgEkw7A3g==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr10167556wrz.133.1637877831971;
        Thu, 25 Nov 2021 14:03:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/6] object-name: re-use "struct strbuf" in show_ambiguous_object()
Date:   Thu, 25 Nov 2021 23:03:44 +0100
Message-Id: <patch-v5-6.6-78bb0995f08-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
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
 object-name.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/object-name.c b/object-name.c
index fd8b9244b5e..f96552e7af7 100644
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
 
@@ -402,7 +403,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 *
 		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
 		 */
-		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
+		strbuf_addf(sb, _("%s commit %s - %s"), hash, ad.buf, s.buf);
 
 		strbuf_release(&ad);
 		strbuf_release(&s);
@@ -426,7 +427,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * object.c, it should (hopefully) already be
 		 * translated.
 		 */
-		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+		strbuf_addf(sb, _("%s tag %s - %s"), hash,
 			    show_date(tag_date, 0, DATE_MODE(SHORT)),
 			    tag_tag);
 	} else if (type == OBJ_TREE) {
@@ -434,13 +435,13 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
 
 
@@ -449,9 +450,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * TRANSLATORS: This is line item of ambiguous object output
 	 * from describe_ambiguous_object() above.
 	 */
-	strbuf_addf(advice, _("  %s\n"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), sb->buf);
 
-	strbuf_release(&desc);
+	strbuf_reset(sb);
 	return 0;
 }
 
@@ -550,6 +551,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		struct oid_array collect = OID_ARRAY_INIT;
 		struct ambiguous_output out = {
 			.ds = &ds,
+			.sb = STRBUF_INIT,
 			.advice = STRBUF_INIT,
 		};
 
@@ -579,6 +581,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 		oid_array_clear(&collect);
 		strbuf_release(&out.advice);
+		strbuf_release(&out.sb);
 	}
 
 	return status;
-- 
2.34.1.838.g779e9098efb

