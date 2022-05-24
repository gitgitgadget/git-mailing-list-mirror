Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C7C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiEXSym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbiEXSyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:37 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C35A168
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:34 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f1d5464c48so23394187fac.6
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gugJpDy48BPcqmPFt4PTAbwM7LzN68z05teuPcY5Kco=;
        b=z71BigBDhoVVKXO20DoKulAeCN99ePcB9nUw6iFxJPIb5sLyQTH6D+c6iHC+VkxvfX
         t3P32UDAl7U7Pc6fUAizGivBEWkxzFmTqJQ/q4yOG42i2zEyF2lLmJfWDDx8YOrAAjOg
         S6U4FkacPC+AYOPJygFKT3Un/KyjmbjIPfghNkaTTRlujqOAIv+2rNo8J11gLA0BDpbV
         TxVJ+UATfzIR6C1HLJH/+9MtCWFXbVKo1P32N5DN1wHbz/pVwTHrQCeJsbggCGMVJbjS
         j5XXPt4y5Dxpu6NnMuB5t1XUNZ9g80SRkp+8fRu7CxjZgwfKMzhiWUHWDPMaUqaCKz5w
         fq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gugJpDy48BPcqmPFt4PTAbwM7LzN68z05teuPcY5Kco=;
        b=1AUQ7CLOyTUNcA+j39kuWbRRMm3HYU1Hhom2YBFjc45yzTiagNiJw1OEKQNu5+zxcC
         ZHWVYKCoBTTqqvkYUkCJXGI7bS6zDrjSbwioLfmtYMbnCrQM/G8B4CcBQF37k5OB/mFA
         ++84sxNBeiCdLmUWV+pk/cRm6eE8DnrDkxfIgdGbBgQ4CdwKkd0B6sISPr9jxkU/Nxe8
         CnksM0lvwbyORNsAykv0+VQ3pefLrBZKv4DxU5p/lcqMKA5832hrp2DMtlKNbg15XYXq
         2MHwDR360q9vjwt5Lir0UeYv+zg9Uam0+k753iCaLqhnEgvm+FJBEprDf87wdNK7+lr0
         fuwg==
X-Gm-Message-State: AOAM530Caxr3U/LWsjQtFan3xkYQsCFBfbucx6GcrVvSJ4ZsYcOabz6o
        DrMHfX367RzUuYk+0hT0QbOsBaFs+Sf37g==
X-Google-Smtp-Source: ABdhPJzIWErygw4aEbdYKUPyKWXBP+46PM4T0ZGqnbAG8LVAMeZnM63q0R5Y1ZpHsrgW4QCshqnLDw==
X-Received: by 2002:a05:6870:f225:b0:f1:fc2d:af76 with SMTP id t37-20020a056870f22500b000f1fc2daf76mr3534953oao.87.1653418474127;
        Tue, 24 May 2022 11:54:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i186-20020acab8c3000000b00325cda1ffb9sm5475326oif.56.2022.05.24.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:54:33 -0700 (PDT)
Date:   Tue, 24 May 2022 14:54:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Message-ID: <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653418457.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will teach `want_object_in_pack()` to set its
`*found_pack` and `*found_offset` poitners to NULL when the provided
pack does not pass the `is_pack_valid()` check.

The `--stdin-packs` mode of `pack-objects` is not quite prepared to
handle this. To prepare it for this change, do the following two things:

  - Ensure provided packs pass the `is_pack_valid()` check when
    collecting the caller-provided packs into the "included" and
    "excluded" lists.

  - Gracefully handle any _invalid_ packs being passed to
    `want_object_in_pack()`.

Calling `is_pack_valid()` early on makes it substantially less likely
that we will have to deal with a pack going away, since we'll have an
open file descriptor on its contents much earlier.

But even packs with open descriptors can become invalid in the future if
we (a) hit our open descriptor limit, forcing us to close some open
packs, and (b) one of those just-closed packs has gone away in the
meantime.

`add_object_entry_from_pack()` depends on having a non-NULL
`*found_pack`, since it passes that pointer to `packed_object_info()`,
meaning that we would SEGV if the pointer became NULL (like we propose
to do in `want_object_in_pack()` in the following patch).

But avoiding calling `packed_object_info()` entirely is OK, too, since
its only purpose is to identify which objects in the included packs are
commits, so that they can form the tips of the advisory traversal used
to discover the object namehashes.

Failing to do this means that at worst we will produce lower-quality
deltas, but it does not prevent us from generating the pack as long as
we can find a copy of each object from the disappearing pack in some
other part of the repository.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec3193fd95..ffeaecd1d8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3201,10 +3201,8 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 				      uint32_t pos,
 				      void *_data)
 {
-	struct rev_info *revs = _data;
-	struct object_info oi = OBJECT_INFO_INIT;
 	off_t ofs;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 
 	display_progress(progress_state, ++nr_seen);
 
@@ -3215,20 +3213,25 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
 		return 0;
 
-	oi.typep = &type;
-	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
-		die(_("could not get type of object %s in pack %s"),
-		    oid_to_hex(oid), p->pack_name);
-	else if (type == OBJ_COMMIT) {
-		/*
-		 * commits in included packs are used as starting points for the
-		 * subsequent revision walk
-		 */
-		add_pending_oid(revs, NULL, oid, 0);
+	if (p) {
+		struct rev_info *revs = _data;
+		struct object_info oi = OBJECT_INFO_INIT;
+
+		oi.typep = &type;
+		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
+			die(_("could not get type of object %s in pack %s"),
+			    oid_to_hex(oid), p->pack_name);
+		} else if (type == OBJ_COMMIT) {
+			/*
+			 * commits in included packs are used as starting points for the
+			 * subsequent revision walk
+			 */
+			add_pending_oid(revs, NULL, oid, 0);
+		}
+
+		stdin_packs_found_nr++;
 	}
 
-	stdin_packs_found_nr++;
-
 	create_object_entry(oid, type, 0, 0, 0, p, ofs);
 
 	return 0;
@@ -3346,6 +3349,8 @@ static void read_packs_list_from_stdin(void)
 		struct packed_git *p = item->util;
 		if (!p)
 			die(_("could not find pack '%s'"), item->string);
+		if (!is_pack_valid(p))
+			die(_("packfile %s cannot be accessed"), p->pack_name);
 	}
 
 	/*
-- 
2.36.1.94.gb0d54bedca

