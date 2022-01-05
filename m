Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654EC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiAENXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiAENX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:23:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A774C061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 05:23:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o3so24800745wrh.10
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8LjvRsOEVIOzxbWwmcKlMH7kUDvExtkugu5HN3e9zM=;
        b=ArFDBoc3dv7c9jIjdKgItko4JghubRgSVrMve+Ql8mpcUjxkBr2AHZcMLGTBAdbslf
         VF8tMcfl8H5ONhxEwgkhlIPr85dVk3DegPJ/gVqCfDvFwcoWRusadQBw0QUMKfuV1act
         ruzcUH9DuNweqpUrZzrNnailYMLkawDNBnvr1aMHf/oYBDtATxswNpgHQ3oVVktnisoB
         U8i1fkfzL1OU4D3s/4ay2k4xoU9TZ/QUOGaZkoxQFFj5n5P+NZ6TYL8UyzqO3R/KqnCP
         hO/IyzyiGlZh5RkFs04QyjlaUFhmngZu4IFSVke4wmqciUoEI4drl805YA0eaYgLeb22
         z9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8LjvRsOEVIOzxbWwmcKlMH7kUDvExtkugu5HN3e9zM=;
        b=VBzSNlo5X9/XFZOSd/kRlfVwmM9WmranaIWXShiHF9OgF18KmiFnj5RpmWG/lcnc9g
         5LDEKStMIA5IrnsUqyVzgiPtI29+BTA6+7Y1fXXU5u8mtqR3i2YUpI7qh4pkXXZ6gNdA
         YxvblUpjIosYF8rMSTwtkjjZya6c/OQRYVnaZA7MmY+ekePiSCPLcht7UfG9iwICfegL
         0nxk8DEiBVcgrES2SSUIOGq6G6z6FXjaNuim4e4N/orrmC0J6r8IZRKv7+PiGT11KGHv
         dj/H3gla9mFlLFuluFZWCYZyg3+s+YsTOWw5WYmmQRFYeufz5K076mALOUpfhgBxMygq
         3/jA==
X-Gm-Message-State: AOAM532NGNUZy0xJTZMG2hNut8NjNDdlC7uMxIJsLa4ssuuJjrh3Uqki
        8aZex+8SR+O64vVILoO4syyTdA==
X-Google-Smtp-Source: ABdhPJywIbMTXerNrS951gFIP7VC+DAvbNYp3JlDXePUczKow7SCpf/02EcozUpzmXSSz2up7LHigQ==
X-Received: by 2002:adf:fbcd:: with SMTP id d13mr35304717wrs.170.1641389006604;
        Wed, 05 Jan 2022 05:23:26 -0800 (PST)
Received: from Jessicas-MacBook-Pro.local (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id n12sm2864501wmq.30.2022.01.05.05.23.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jan 2022 05:23:26 -0800 (PST)
Received: by Jessicas-MacBook-Pro.local (Postfix, from userid 501)
        id 16E97B2013DD; Wed,  5 Jan 2022 13:23:26 +0000 (GMT)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     git@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH] Properly align memory allocations and temporary buffers
Date:   Wed,  5 Jan 2022 13:23:24 +0000
Message-Id: <20220105132324.6651-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git_qsort_s allocates a buffer on the stack that has no
alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
alignment for any type.

On CHERI, and thus Arm's Morello prototype, pointers are implemented as
hardware capabilities which, as well as having a normal integer address,
have additional bounds, permissions and other metadata in a second word,
so on a 64-bit architecture they are 128-bit quantities, including their
alignment requirements. Despite being 128-bit, their integer component
is still only a 64-bit field, so uintmax_t remains 64-bit, and therefore
uintmax_t does not sufficiently align an allocation.

Moreover, these capabilities have an additional "129th" tag bit, which
tracks the validity of the capability and is cleared on any invalid
operation that doesn't trap (e.g. partially overwriting a capability
will invalidate it) which, combined with the architecture's strict
checks on capability manipulation instructions, ensures it is
architecturally impossible to construct a capability that gives more
rights than those you were given in the first place. To store these tag
bits, each capability sized and aligned word in memory gains a single
tag bit that is stored in unaddressable (to the processor) memory. This
means that it is impossible to store a capability at an unaligned
address: a normal load or store of a capability will always take an
alignment fault even if the (micro)architecture supports unaligned
loads/stores for other data types, and a memcpy will, if the destination
is not appropriately aligned, copy the byte representation but lose the
tag, meaning that if it is eventually copied back and loaded from an
aligned location any attempt to dereference it will trap with a tag
fault. Thus, even char buffers that are memcpy'ed to or from must be
properly aligned on CHERI architectures if they are to hold pointers.

Address both of these by introducing a new git_max_align type put in a
union with the on-stack buffer to force its alignment, as well as a new
GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
that gets used for mem_pool_alloc. As well as making the code work on
CHERI, the former change likely also improves performance on some
architectures by making memcpy faster (either because it can use larger
block sizes or because the microarchitecture has inefficient unaligned
accesses).

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 compat/qsort_s.c  | 11 +++++++----
 git-compat-util.h | 11 +++++++++++
 mem-pool.c        |  6 +++---
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/compat/qsort_s.c b/compat/qsort_s.c
index 52d1f0a73d..1ccdb87451 100644
--- a/compat/qsort_s.c
+++ b/compat/qsort_s.c
@@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
 		int (*cmp)(const void *, const void *, void *), void *ctx)
 {
 	const size_t size = st_mult(n, s);
-	char buf[1024];
+	union {
+		char buf[1024];
+		git_max_align align;
+	} u;
 
 	if (!n)
 		return 0;
 	if (!b || !cmp)
 		return -1;
 
-	if (size < sizeof(buf)) {
-		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf, ctx);
+	if (size < sizeof(u.buf)) {
+		/* The temporary array fits in the small on-stack buffer. */
+		msort_with_tmp(b, n, s, cmp, u.buf, ctx);
 	} else {
 		/* It's somewhat large, so malloc it.  */
 		char *tmp = xmalloc(size);
diff --git a/git-compat-util.h b/git-compat-util.h
index 5fa54a7afe..28581a45c5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
 #define _ALL_SOURCE 1
 #endif
 
+typedef union {
+	uintmax_t max_align_uintmax;
+	void *max_align_pointer;
+} git_max_align;
+
+typedef struct {
+	char unalign;
+	git_max_align aligned;
+} git_max_alignment;
+#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
+
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
diff --git a/mem-pool.c b/mem-pool.c
index ccdcad2e3d..748eff925a 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p = NULL;
 	void *r;
 
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
+	if (len & (GIT_MAX_ALIGNMENT - 1))
+		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
 
 	if (pool->mp_block &&
 	    pool->mp_block->end - pool->mp_block->next_free >= len)
-- 
2.33.1

