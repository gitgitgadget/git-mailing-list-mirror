Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A66C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663AB60E8C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUDm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhJUDmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA3C061768
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g2so24397754ild.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jnvYuC9YIyrSRrdpUg3msJq8OxB1kQRC4M327pK9p1w=;
        b=tuEpDZ5m4F0u2OFfwjmmsJc2GUwCp2uZH9Nxf+dPLWjoA6i7+phZrZxO9VJGC4LIPC
         Ee1vDfrpOQTLCI9Ir/ePeszPU5qXIIGZNNgasJBisiIbWpbFHanGOtR5TpsjuOooWsVL
         wofIQS33i7f6XKnT1Cw7i5gBNeZoPeZ/f5Om+QVnFp40rTdK+GJ3C7Cc0N7UFBMpxRKD
         bnevQ0XauZ/3edR3uT/CeKW8l9d+JQles1hgogL0ugqtFDR83JESr2+H7EsVHfnFOy7w
         1UlZVFA7N5+6DqBxqnZUEtRKJG1etcm27H9iWvq5Db62cd7Qgj4NL5f/n3b3fl4zFK5t
         QrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnvYuC9YIyrSRrdpUg3msJq8OxB1kQRC4M327pK9p1w=;
        b=7gwxEL97k1HYcmGGlzuKgydfXLGKB1N05M1EWCoCgcIxXuyT6PxOJedabjzcuj4ye+
         Sf9gR60xPzhmD04Ituzuw5XOgs03VTPJ0AF671SBbqvyRGZmlhQqWI/cY7nz43Tb5PDR
         JTvwwouIYP4DbkaE4lWGzonKRcrvHerFQuj0Tu5JsBX7tKpwGMUApbf59fYkT9Y+P5BU
         Ny2fdHPsBaI/fGhUy9FEFbGHePjc1NwmFcFXlkvrSHvecz/mnO97gl+D1tOCooPdRctQ
         gZl3zKIJuhNqmmGSX93zZvFTqFUOAVV2DLF1WFPZ1W72pKRcW5Mr1uzOGKL/06Bd7JJX
         o3zQ==
X-Gm-Message-State: AOAM533XaoXURhewdn8R2x+yo3DzLr4Z+JDPy78Y1n3nJnMQqqKUGkJF
        ljeWkuDH4me9XDPAa7YleVFMOCO+ARjhVw==
X-Google-Smtp-Source: ABdhPJyCp3FTmVEgZSSHNbz4xnsdNI7cuuDyhFHGb+jMGC+CqD+vwgjbtjbbHmI7NiDqg8Ei9mCn1A==
X-Received: by 2002:a05:6e02:1c2b:: with SMTP id m11mr2038904ilh.307.1634787596341;
        Wed, 20 Oct 2021 20:39:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w15sm2159949ill.23.2021.10.20.20.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:56 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 04/11] builtin/pack-objects.c: don't leak memory via arguments
Message-ID: <dd3b9a949ea3c8c42801e162ed9df045a1848f05.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing arguments to pass to setup_revision(), pack-objects
only frees the memory used by that array after calling
get_object_list().

Ensure that we call strvec_clear() whether or not we use the arguments
array by cleaning up whenever we exit the function (and rewriting one
early return to jump to a label which frees the memory and then
returns).

We could avoid setting this array up altogether unless we are in the
if-else block that calls get_object_list(), but setting up the argument
array is intermingled with lots of other side-effects, e.g.:

    if (exclude_promisor_objects) {
      use_internal_rev_list = 1;
      fetch_if_missing = 0;
      strvec_push(&rp, "--exclude-promisor-objects");
    }

So it would be awkward to check exclude_promisor_objects twice: first to
set use_internal_rev_list and fetch_if_missing, and then again above
get_object_list() to push the relevant argument onto the array.

Instead, leave the array's construction alone and make sure to free it
unconditionally.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f8..857be7826f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4148,11 +4148,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_packs_list_from_stdin();
 		if (rev_list_unpacked)
 			add_unreachable_loose_objects();
-	} else if (!use_internal_rev_list)
+	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
-	else {
+	} else {
 		get_object_list(rp.nr, rp.v);
-		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
@@ -4162,7 +4161,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    the_repository);
 
 	if (non_empty && !nr_result)
-		return 0;
+		goto cleanup;
 	if (nr_result) {
 		trace2_region_enter("pack-objects", "prepare-pack",
 				    the_repository);
@@ -4183,5 +4182,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			     " pack-reused %"PRIu32),
 			   written, written_delta, reused, reused_delta,
 			   reuse_packfile_objects);
+
+cleanup:
+	strvec_clear(&rp);
+
 	return 0;
 }
-- 
2.33.0.96.g73915697e6

