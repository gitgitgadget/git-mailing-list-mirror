Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF563C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiITCIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITCIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:08:38 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1E05723B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:08:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id w4so1115416qvp.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=NoCPVBGoravtNsLmucOXm/BXiMkQ/I2XUkeBxuF555Y=;
        b=eZET5VRVNWgspS0uAUvE20nvSgR9qztGMFSw1bWq8WV3Z/uH4ZKZaj7gWwjqVqukBc
         wvKG3KfzpsT42Jn5b7lLYHmc1HTgPjDvuA8132SVIlZwZ2+9WsJM79UtD/uZqiH44ZYA
         p3KGdzq1CA8rRygGVs9NSjTUax1KMPkbCLCIrgxpUXr5UyT2N1Wl34E6UJ8geZUH9ntG
         sRTn2WzekNm397xKPrQNq6LRUIlpDF700eoUwW5LR3WtuqUPAYvIkz/ey6XscPHLC7vE
         g40VKGxaIJuaXKsQBqwtwvFp7EtWhrTdH3f7keElSOL9kgRMgGKfFIhXhHFkpL36rixo
         5cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NoCPVBGoravtNsLmucOXm/BXiMkQ/I2XUkeBxuF555Y=;
        b=7fx6cxVuxAFejSf4aGYDY+my+1D7LNpv0HZzsGo36nTlAWnlIwNi/1+/dpL7DspUE5
         lEjLULTqBAFmWPBC87uffpX2/mZJeBdxQWBFNipPP9H5f9UcQh9Qv5eT+uXfHd/1tg43
         s3dGJcxby9wD4gd+xGd0fQFmYwnUy3hh1P4DkF2b3FyAHluYVe8qmk9SXV93DDd22k//
         wf1exBTwLjgfgbtEjKUPxE+jGHPaa17Ma4wj/l0hPx3WXpWXmxoOfZoywMakFuT7uuNn
         4V0W3FWj4U/eMFJ+EB7QM6k4QdN+ud2y9PGCgPrJb+ydBtENVdWZzc6YR/Ct6hUmwEwv
         oY1g==
X-Gm-Message-State: ACrzQf26uiuHHEhF8Knam3Wh0gMCAAFkJY0PpbFNYxy87gPR0/cD8OXS
        8U2tPEGVg1bJNQKo0fO6g8qDk0slS/GHrA==
X-Google-Smtp-Source: AMsMyM59VyiEuVC5Dlkvn32qnB5FJdaFXrgCbLztSqPXRfYFqLseIprDynoOT6qIhxuaIilPgqTaNA==
X-Received: by 2002:a05:6214:238b:b0:48a:f607:c4e0 with SMTP id fw11-20020a056214238b00b0048af607c4e0mr17390177qvb.44.1663639716874;
        Mon, 19 Sep 2022 19:08:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i185-20020a3754c2000000b006cec8001bf4sm113404qkb.26.2022.09.19.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 19:08:36 -0700 (PDT)
Date:   Mon, 19 Sep 2022 22:08:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Noticed this while working on a semi-related series in:

  https://lore.kernel.org/git/cover.1663638929.git.me@ttaylorr.com/T/

the savings here are pretty modest, but this is in line with the
strategy we use in the `--geometric` repack mode, which performs a
similar task.

 midx.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index c27d0e5f15..c06f0f00e6 100644
--- a/midx.c
+++ b/midx.c
@@ -1973,6 +1973,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct strbuf base_name = STRBUF_INIT;
+	struct strbuf scratch = STRBUF_INIT;
 	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);

 	/*
@@ -1997,7 +1998,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);

-	strvec_push(&cmd.args, "pack-objects");
+	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", NULL);

 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
@@ -2026,17 +2027,17 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,

 	cmd_in = xfdopen(cmd.in, "w");

-	for (i = 0; i < m->num_objects; i++) {
-		struct object_id oid;
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+	for (i = 0; i < m->num_packs; i++) {
+		strbuf_reset(&scratch);

-		if (!include_pack[pack_int_id])
-			continue;
+		strbuf_addstr(&scratch, m->pack_names[i]);
+		strbuf_strip_suffix(&scratch, ".idx");
+		strbuf_addstr(&scratch, ".pack");

-		nth_midxed_object_oid(&oid, m, i);
-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+		fprintf(cmd_in, "%s%s\n", include_pack[i] ? "" : "^", scratch.buf);
 	}
 	fclose(cmd_in);
+	strbuf_release(&scratch);

 	if (finish_command(&cmd)) {
 		error(_("could not finish pack-objects"));
--
2.37.0.1.g1379af2e9d
