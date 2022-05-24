Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935AC433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiEXSyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiEXSyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:40 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F25A17C
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t14-20020a9d66ce000000b0060af9ed4b87so7612783otm.9
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7ITLcB0vJfRa74a/TzQmn4Qk5yV5raJ2AmNs5hd+1w=;
        b=QVeFJen9AT57R2hvxuLFX9UNC317xSov5sXkfhJjUMFTqs33d5H26P5biADsCa6iPM
         8ia4acaqudaf2BpYnAE86OBBbgJmRt9zH3DI15qQJ3FjEf2+YJ6YMpuZHzwZaBqfIbFe
         yeav4kUF7Wlkq2rQDbaFRI+0aywP/ln3cx8aSVF8rBoU4C6aXkrzCxGC+g45w74hYStR
         2uVY9hFXZDkq7B8qjFQ6Uj2jsdhqEyKcRflRc575hv2iaU1qYdnkkB7f8qsfHHCLfuYo
         V62LXwiKWY/JyP0uQcJ+6TzEbKt6sadXz+ogdiN19EOcWaoWRVHRMjkzImwB3mQha3zS
         vzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7ITLcB0vJfRa74a/TzQmn4Qk5yV5raJ2AmNs5hd+1w=;
        b=iqMktEQEWDxapt1x7x+/zsXmkp5XMBWrwBXUk8p3inphzWTs8sgRegIeIFcGZbZ3Jh
         nCELlaxY1XstIsNmGU6CFtNrCljc90QXLxS3JqAU3iu+NwNPh67YkHJJbCeY4SpvVd+m
         vtvRaVb+TaTrfm0fZIbAiUgDLuUMPTzghSl5I/dniGdSu6t2ys0tMRm0sVh2CUPYixnb
         n58HWRUvoH3epUuKoG7KS72cQfwNlDMQTQfakPxBBvtTVsG5dzNNAuqdiwV2Oyk3Dn4P
         H7lYfDUXmLFbkoSASVsWlby0EmSJbFuRJkA32Otn57NxjY9Xd48pHPwZDhOI2xMCiIv2
         WTmw==
X-Gm-Message-State: AOAM533hzs1v9KKvs97BlhYBlnjjeYZfEQvqGudfjIHtHhn2hqP6f2qq
        5ebU0qhugmN6ndM6bgs461mwmTTaxeWThw==
X-Google-Smtp-Source: ABdhPJx3oa7ClV3bNfmXp88ZJ3UCe4aCeCWKlgE6kIu1qrPE3aKXepJepxCePLJkeX93w0zefC30Sw==
X-Received: by 2002:a9d:482:0:b0:5cd:57a1:8082 with SMTP id 2-20020a9d0482000000b005cd57a18082mr11337016otm.360.1653418478839;
        Tue, 24 May 2022 11:54:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d6d99000000b0060603221280sm5380085otp.80.2022.05.24.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:54:38 -0700 (PDT)
Date:   Tue, 24 May 2022 14:54:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v2 4/4] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
Message-ID: <3fc3a95517558005b940b65d0e5357de50f81d98.1653418457.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653418457.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using a multi-pack bitmap, pack-objects will try to perform its
traversal using a call to `traverse_bitmap_commit_list()`, which calls
`add_object_entry_from_bitmap()` to add each object it finds to its
packing list.

This path can cause pack-objects to add objects from packs that don't
have open pack_fds on them, by avoiding a call to `is_pack_valid()`.
This is because we only call `is_pack_valid()` on the preferred pack (in
order to do verbatim reuse via `reuse_partial_packfile_from_bitmap()`)
and not others when loading a MIDX bitmap.

In this case, `add_object_entry_from_bitmap()` will check whether it
wants each object entry by calling `want_object_in_pack()`, which will
call `want_found_object` (since its caller already supplied a
`found_pack`). In most cases (particularly without `--local`, and when
`ignored_packed_keep_on_disk` and `ignored_packed_keep_in_core` are
both "0"), we'll take the entry from the pack contained in the MIDX
bitmap, all without an open pack_fd.

When we then try to use that entry later to assemble the actual pack,
we'll be susceptible to any simultaneous writers moving that pack out of
the way (e.g., due to a concurrent repack) without having an open file
descriptor, causing races that result in errors like:

    remote: Enumerating objects: 1498802, done.
    remote: fatal: packfile ./objects/pack/pack-e57d433b5a588daa37fbe946e2b28dfaec03a93e.pack cannot be accessed
    remote: aborting due to possible repository corruption on the remote side.

This race can happen even with multi-pack bitmaps, since we may open a
MIDX bitmap that is being rewritten long before its packs are actually
unlinked.

Work around this by calling `is_pack_valid()` from within
`want_found_object()`, matching the behavior in
`want_object_in_pack_one()` (which has an analogous call). Most calls to
`is_pack_valid()` should be basically no-ops, since only the first call
requires us to open a file (subsequent calls realize the file is already
open, and return immediately).

Importantly, when `want_object_in_pack()` is given a non-NULL
`*found_pack`, but `want_found_object()` rejects the copy of the object
in that pack, we must reset `*found_pack` and `*found_offset` to NULL
and 0, respectively. Failing to do so could lead to other checks in
`want_object_in_pack()` (such as `want_object_in_pack_one()`) using the
same (invalid) pack as `*found_pack`, meaning that we don't call
`is_pack_valid()` because `p == *found_pack`. This can lead the caller
to believe it can use a copy of an object from an invalid pack.

An alternative approach to closing this race would have been to call
`is_pack_valid()` on _all_ packs in a multi-pack bitmap on load. This
has a couple of problems:

  - it is unnecessarily expensive in the cases where we don't actually
    need to open any packs (e.g., in `git rev-list --use-bitmap-index
    --count`)

  - more importantly, it means any time we would have hit this race,
    we'll avoid using bitmaps altogether, leading to significant
    slowdowns by forcing a full object traversal

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ffeaecd1d8..0a26de166d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1357,6 +1357,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	if (incremental)
 		return 0;
 
+	if (!is_pack_valid(p))
+		return -1;
+
 	/*
 	 * When asked to do --local (do not include an object that appears in a
 	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
@@ -1472,6 +1475,9 @@ static int want_object_in_pack(const struct object_id *oid,
 		want = want_found_object(oid, exclude, *found_pack);
 		if (want != -1)
 			return want;
+
+		*found_pack = NULL;
+		*found_offset = 0;
 	}
 
 	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
-- 
2.36.1.94.gb0d54bedca
