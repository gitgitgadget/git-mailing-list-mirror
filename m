Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC837C6FA91
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiITUk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiITUkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:40:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFEB4E61E
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:21 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mi14so2852594qvb.12
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XeZXw4J0gYy1aXXQEH2CQlSG0s7J8Ct8t7vJZ4DH23I=;
        b=QL/IOksJ5+lNc9wrULo1CgJ53YQSXztwHdyjIsUL9KZCKwLaqSXR4Z6Y+imnYPb/wp
         TvWBJfgepdynrh0ejfitYSNFdnoBb/IUObh+6t7SAnbszVRT7o205T+rIc5fGTbZCPBX
         sVWv4gPZLWssqn92tL9VfZb857Ux225UwSY76XP2dfMZ+zkDqmi+zNoPV2xS9C76T1cm
         WfwOlUtifAFszrUfd2L8spfGgCSMIDB8hyiLySo+mUH65BUdx7nrt9urJdunqVkTBRVW
         B5MTwZ+odH1oycK4TlBWSADGLXNKLbM1o8gv1FdfxYob6bdQNtcg9vYuBf8Y2ki9HU4p
         KZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XeZXw4J0gYy1aXXQEH2CQlSG0s7J8Ct8t7vJZ4DH23I=;
        b=2VmJ0j8Q83ajMZToEyaxHZXdLyChgRW7AZCrnuwpU2PwVm4cn9+sDojb3jbrE4yS3J
         drBERT8PIS+QOGyDlkhmw8h65hb4JLEXYTFFUUhVl0V6vMIXhNK3AyBxOGzWQPgvXkHE
         liSx/TV5z+ZDd/Ra/8LDAJg+NuRTOEZSQ3aG93bBWdGJ6sK8PNU60QlvvpWApusk0yGi
         lO4VTnS47TeVcCEsuDcA2GaksBf5UrhdIkI6pAx/Bz2nzDPFINzRNg7My//LkhrzH4BC
         +hF6eLRe8wJCKQqBWbgSU3h7D5/Kuncb1qpQ7tHBWdYIfg2/Mr4gkOwOrHgT4Tiw6lMB
         m8QQ==
X-Gm-Message-State: ACrzQf1fpAiN+OME+DQMSTFMWv4wEuc9YEzrtkaUVpK6EEGclqq0VEli
        yZrzDy7XNnq3Efk8aGcNHlzH0X6oiXfVFg==
X-Google-Smtp-Source: AMsMyM6jex2D/4eCFm+D7xGPg60082jB0rlZCjC2ZyZW0QGz8zmwVk7zhVpZBYfCFluGjTFBMc9m5g==
X-Received: by 2002:a05:6214:c29:b0:4aa:b050:5ed7 with SMTP id a9-20020a0562140c2900b004aab0505ed7mr20705589qvd.15.1663706420744;
        Tue, 20 Sep 2022 13:40:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d21-20020ac84e35000000b00359961365f1sm379061qtw.68.2022.09.20.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:40:20 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:40:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH v2 2/3] midx.c: use `pack-objects --stdin-packs` when
 repacking
Message-ID: <4218d9e08aba629d8f64b5a999f60d12e5d8785b.1663706401.git.me@ttaylorr.com>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663706401.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git multi-pack-index repack` command aggregates all objects in
certain packs contained in the MIDX, largely dictated by the value of
its `--batch-size` parameter.

To create the new pack, the MIDX machinery spawns a `pack-objects`
sub-process, which it feeds the object IDs in each of the pack(s) that
it wants to aggregate.

This implementation, which dates back to ce1e4a105b (midx: implement
midx_repack(), 2019-06-10), predates the `--stdin-packs` mode in
`pack-objects`. This mode (which was introduced a couple of years later
in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs' option,
2021-02-22)) allows `pack-objects` callers to specify the contents of
the output pack by indicating which packs to aggregate.

This patch replaces the pre-`--stdin-packs` invocation (where each
object is given to `pack-objects` one by one) with the more modern
`--stdin-packs` option.

This allows us to avoid some CPU cycles serializing and deserializing
every object ID in all of the packs we're aggregating. It also avoids us
having to send a potentially large amount of data down to
`pack-objects`.

But more importantly, it generates slightly higher quality (read: more
tightly compressed) packs, because of the reachability traversal that
`--stdin-packs` does after the fact in order to gather namehash values
which seed the delta selection process.

In practice, this seems to add a slight amount of overhead (on the order
of a few seconds for git.git broken up into ~100 packs), in exchange for
a modest reduction (on the order of ~3.5%) in the resulting pack size.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index db0a70c5af..5fbf964bba 100644
--- a/midx.c
+++ b/midx.c
@@ -1955,6 +1955,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct strbuf base_name = STRBUF_INIT;
+	struct strbuf scratch = STRBUF_INIT;
 	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 	struct repack_info *pack_info = NULL;
 
@@ -1996,7 +1997,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
 
-	strvec_push(&cmd.args, "pack-objects");
+	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", NULL);
 
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
@@ -2025,17 +2026,19 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	cmd_in = xfdopen(cmd.in, "w");
 
-	for (i = 0; i < m->num_objects; i++) {
-		struct object_id oid;
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+	for (i = 0; i < m->num_packs; i++) {
+		struct repack_info *info = &pack_info[i];
 
-		if (!include_pack[pack_int_id])
-			continue;
+		strbuf_reset(&scratch);
 
-		nth_midxed_object_oid(&oid, m, i);
-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+		strbuf_addstr(&scratch, m->pack_names[info->pack_int_id]);
+		strbuf_strip_suffix(&scratch, ".idx");
+		strbuf_addstr(&scratch, ".pack");
+
+		fprintf(cmd_in, "%s%s\n", include_pack[info->pack_int_id] ? "" : "^", scratch.buf);
 	}
 	fclose(cmd_in);
+	strbuf_release(&scratch);
 
 	if (finish_command(&cmd)) {
 		error(_("could not finish pack-objects"));
-- 
2.37.0.1.g1379af2e9d

