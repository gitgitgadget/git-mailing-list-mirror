Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F14C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhL1OfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhL1OfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E678C06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so38742694wrc.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0YVjcnMv7yKTeg6jJkQ3Frb6ojD+9Hm2HK8NFlIvKE=;
        b=iMx/KyUdCZEhvUJLsbiHZql24PImcv1PUmGqm48929/fOLyNj2y42pkmwhPujPOvLa
         9gKX2Y7c/GodW+5z8wWqisRx3W2xAhhTn/6liGibjVHGV0iNsIVDRk9YedPV15xuiVU0
         y8rq9hu4W8BDWXNORXTEdeTJVn763eR7+LiV07TapdQvl58xGU9B1tWN+KRV17hdolL8
         tYww36IhCPCarlwsj0YaWIC5HXTW9nFaSZztZGnmevuezyt7YKCKBADtc0tpl16elv2o
         ieKWv4kYchIpNG8FNjjYoueboVANboj+Hu4ldLfB5IpbMFCvJ3s/DtcihjjQYQW28ZzR
         Xi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0YVjcnMv7yKTeg6jJkQ3Frb6ojD+9Hm2HK8NFlIvKE=;
        b=n5geQe8Zs1fI09lWfRULwor5rc5Ga5Pej1WLkSvqokRQwy0PcmE+jHGu+SSKbxwtLQ
         jE573eN/FHsPzHb1ycgjNFIUxVLyWMbhMika7pivA4uLD6Sg9zuUvaxMtQmiafQczWYe
         gnKHNH8oWhl2LuUXGq7zJm91KFVMpgCZuNRYmlpQS9s+GbRKUHOZRWRYiauuLzyzvVlY
         Hz03S95OAGXLv/7y0NZMSLjn/k9/95K6bX4+U12SYZVakT4ZMeGVkhplUSmu371YwrNh
         YDseoeQDAmev2LrLOZ5pUnrlM4IzSBtGGocJFOlIh/luruI7iev/rqyC/EfXtbvK+UkH
         Vzzw==
X-Gm-Message-State: AOAM530+qKQKDxeS8FFiPQEizeaieAMYOpG91Xa4542WvE5jFLuj8BPD
        AJSbADV2QPUqhcQJCtoI1q83wWzY3au4EJXD
X-Google-Smtp-Source: ABdhPJxnq6b+nPFYrF/uoNqsFvhjc25ACvjcQnEwyWRPXt2iOUXPEUEkvlctnYm78BDGnEUxmjxIZw==
X-Received: by 2002:a05:6000:148:: with SMTP id r8mr16654202wrx.333.1640702117430;
        Tue, 28 Dec 2021 06:35:17 -0800 (PST)
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
Subject: [PATCH v6 6/6] object-name: re-use "struct strbuf" in show_ambiguous_object()
Date:   Tue, 28 Dec 2021 15:35:02 +0100
Message-Id: <patch-v6-6.6-6a31cfcfc29-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
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
 object-name.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index 743d272800d..2d60e5177d3 100644
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
@@ -427,7 +428,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * object.c, it should (hopefully) already be
 		 * translated.
 		 */
-		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+		strbuf_addf(sb, _("%s tag %s - %s"), hash,
 			    show_date(tag_date, 0, DATE_MODE(SHORT)),
 			    tag_tag);
 	} else if (type == OBJ_TREE) {
@@ -435,13 +436,13 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
 
 
@@ -450,9 +451,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * TRANSLATORS: This is line item of ambiguous object output
 	 * from describe_ambiguous_object() above.
 	 */
-	strbuf_addf(advice, _("  %s\n"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), sb->buf);
 
-	strbuf_release(&desc);
+	strbuf_reset(sb);
 	return 0;
 }
 
@@ -551,6 +552,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		struct oid_array collect = OID_ARRAY_INIT;
 		struct ambiguous_output out = {
 			.ds = &ds,
+			.sb = STRBUF_INIT,
 			.advice = STRBUF_INIT,
 		};
 
@@ -580,6 +582,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 		oid_array_clear(&collect);
 		strbuf_release(&out.advice);
+		strbuf_release(&out.sb);
 	}
 
 	return status;
-- 
2.34.1.1257.g2af47340c7b

