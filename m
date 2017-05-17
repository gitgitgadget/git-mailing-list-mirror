Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7210B2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdEQAIC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:08:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33775 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEQAIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:08:01 -0400
Received: by mail-lf0-f67.google.com with SMTP id m18so1504173lfj.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=mEqaDckDA99FkYONXGsuLkZG3FNM490Q6waqPWpJot8=;
        b=u5ubXkxUl0/HwtqF1atA6/wpqgNyy3qcCavbS5+38WmgCC7H5olcWHg26lw5wBfQmZ
         CKocet3llQVsh8ZgirgWvnTKczk7udoRo0z2pApz6x1YcEgf/8kVjpmEnKUAkaW/2wjH
         rS4mVAStI1fhHFuw4nPURoHp8xCJpdQehYjzQ5AZiRJVaD79A9SDhB4LNIAQ5wbFZk8P
         a7EOUYia476G9cmCSCnmQUmFrVsxEPZyMojsiAAXOKfSjm2icUayqooaBPZdoo7sw5k9
         K5veB6Ja5bchpLSmw0YAT6EXCbeqXlzXquDjduC+0nkCbacExK0HJLFnZEIawFPVlQ5z
         zsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=mEqaDckDA99FkYONXGsuLkZG3FNM490Q6waqPWpJot8=;
        b=V6b61QR540iBIgUOxIXVHjbIGAE3CQTN6aNNUq3STYLMgdAjQNJQ9I+tpUQ+r6sGCl
         /pWB5pVVHLESWj9yLEeHX8mP5EPnHQI5lrO3ha3ZXPERNOzmhPxew1LFw/u2OjVABu1I
         fTjR0xzfcd7qKsGvhc/MqAFK8/VEkFS7ozULkbnzJnNffSQd280b9gVSlqmzw54wTJvJ
         4bqX9Zd0yDpkV55OvNpWuh4rx6znGht3RyLFmeYGCzbT3GZBPOXCQ4iNUljMduOCCIWe
         ixnUMQBNKaGt8ECvvy8llRSm8ajFzaLrCUW5bmylmh18dw5l1YKqofqasmTCitbk7ovA
         iUoA==
X-Gm-Message-State: AODbwcALSwJ0si/FsoyIspIm/2GIr0y5/Cxs3IzHkpDvPZKnjSB2Pyze
        DeZ9PGotGhgkRnOEIroak6aewfrqdQ==
X-Received: by 10.25.160.75 with SMTP id j72mr151360lfe.97.1494979679897; Tue,
 16 May 2017 17:07:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Tue, 16 May 2017 17:07:39 -0700 (PDT)
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Tue, 16 May 2017 17:07:39 -0700
X-Google-Sender-Auth: DcYXG5wtqGqJ-VKIP6YsH2zBGfk
Message-ID: <CACpkpxn4zSdUMT-i6XWBR77sQTpr5-vudbLVTCs1_hiv7a2t_w@mail.gmail.com>
Subject: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over all
 worktree HEADs
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git prune will happily delete commits checked out in other worktrees.
This is probably not desired.

(Tabs have been converted to spaces in this email sadly, because GMail
garbles these. This should suffice for review, and I'll send the patch
as an attachment or in some other form when done so that it can be
cleanly applied. Let me know if this won't work.)


Thanks!

Patch 1/2 follows (based on maint)

-----

From c3657cd0bb61921053fad4dd669589780881c574 Mon Sep 17 00:00:00 2001
From: Manish Goregaokar <manishearth@gmail.com>
Date: Tue, 16 May 2017 16:46:00 -0700
Subject: refs: Add for_each_worktree_ref for iterating over all worktree HEADs

To ensure that `git prune` does not remove refs checked out
in other worktrees, we need to include these HEADs in the
set of roots. This adds the iteration function necessary
to do this.

Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
---
 refs.c | 16 ++++++++++++++++
 refs.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/refs.c b/refs.c
index 2d71774..27e0b60 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */

 #include "cache.h"
+#include "commit.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
@@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
     return head_ref_submodule(NULL, fn, cb_data);
 }

+int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
+{
+    int i, flag, retval;
+    struct object_id oid;
+    struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
+    for (i = 0; worktrees[i]; i++) {
+        struct commit* commit =
lookup_commit_reference(worktrees[i]->head_sha1);
+        oid = commit->object.oid;
+        if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
+            if (retval = fn("HEAD", &oid, flag, cb_data))
+                return retval;
+        }
+    }
+}
+
 /*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
diff --git a/refs.h b/refs.h
index 9fbff90..425a853 100644
--- a/refs.h
+++ b/refs.h
@@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
  * stop the iteration.
  */
 int head_ref(each_ref_fn fn, void *cb_data);
+int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
-- 
2.10.1
