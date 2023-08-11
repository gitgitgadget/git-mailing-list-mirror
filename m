Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFAC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjHKWAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHKWAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:00:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFC273E
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:00:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589ac93bc6eso26236137b3.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691791233; x=1692396033;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUDrJSTNYTj/ezgbinJmagu3R+JgXST5O1R94xA/W8U=;
        b=AX8VemIB9iZuA0BwxNlHFmapUEwckXDUGIsSVnIf5FmZ2wxqLU9g0qAnhHBz94FiF0
         4uZt0EH02YALMNd2PcEb5P/yyAYHUOiQ94A3hVuHJS8j+TH5ONbsUU/L1g3Ht4N6wWfP
         w8yP18bvEKUDBzhtACOXVx7bYBeFXeEd5KPxLnuDIHpvs6tXrL++CgiDjDdcE8F03xkq
         3UBlFcvSinATrsILSMrwupMrolj0akQySztW934kPcw4GnZsYyHh4HfpU4DS5o6NIWHR
         JApXEt8LrsttA2O9wm+IvzcjOSBmd6cdkWipZq5FcnzbN5qWtmGP74CVAvdjMt1UQ8JC
         qJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791233; x=1692396033;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUDrJSTNYTj/ezgbinJmagu3R+JgXST5O1R94xA/W8U=;
        b=jmhHnz2bdg1Yd4hEw5BC8QFpecqfyWguR+hmRf73/8L7yw+7jxnXa4fBwSs3YBMKsD
         fTWA81zuu4n5lhORNf5GZELh/fUkdc3CEhlp7nsThPrAwIrxivM1jPOmBnJ6A9fRI41v
         DAnCmdQmkgoIZ0XzrEQ0bU05tvI2aqgPlSc2QxMtZYlLYhrYLauyhz6yQj1cQVgCIqoD
         K5jd7RKIOvZcyghhdD4FgXBL3oBymnZ2eT3T9wxgJ34NoITyb/gd+ksMSKPyDCWNrpT2
         OQp1Xo8/pKs67Ja3Cah7qo5VdgDY5ALQHMJf8t/mZb47B9UZK/L2gxKM9S2HUamRTRV3
         UTCg==
X-Gm-Message-State: AOJu0YxBFE2kRvh/MERXK4F/0VnAKBxC66lkTXPExHv/C7RzFo2/cmGq
        Jpr6RLWxKv1ihorXFwLwWnlwQHN3JXKmHWvv3CPV
X-Google-Smtp-Source: AGHT+IFUW4gQiQ0w4/1osUVsGM/tTzHvRAhVnT6pqf4ds5P109HRgGhZi1dhmenzN3MNiNfmhdl1qECf7YweirSORYht
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae63:0:b0:565:9bee:22e0 with
 SMTP id g35-20020a81ae63000000b005659bee22e0mr52465ywk.0.1691791232933; Fri,
 11 Aug 2023 15:00:32 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:00:30 -0700
In-Reply-To: <6676afe56db74828ba2532f3460e9b73a3ff20fd.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811220030.3329161-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 4/6] commit-graph.c: unconditionally load Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> diff --git a/commit-graph.c b/commit-graph.c
> index 38edb12669..60e5f9ada7 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -317,12 +317,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
>  	uint32_t hash_version;
>  	hash_version = get_be32(chunk_start);
>  
> -	if (*c->commit_graph_changed_paths_version == -1) {
> -		*c->commit_graph_changed_paths_version = hash_version;
> -	} else if (hash_version != *c->commit_graph_changed_paths_version) {
> -		return 0;
> -	}

Lots of things to notice in this patch, but the summary is that this
patch looks correct.

Here, we remove (1) the autodetection of changed paths version and (2)
the storage of the result of that autodetection. (1) is restored in a
subsequent code hunk, but (2) is never restored.

Prior to this patch set, we needed (2) because we only wanted to load
Bloom filters that match a given version, so if we autodetected a
version, that version must be in effect for all future loads (which is
why we needed to store that result immediately). But with this patch
set, we support the loading of Bloom filters of varying versions, so
storing it immediately is no longer needed.

(Also, I don't think we need the commit_graph_changed_paths_version
variable anymore.)

> @@ -2390,8 +2384,7 @@ int write_commit_graph(struct object_directory *odb,
>  			r->settings.commit_graph_changed_paths_version);
>  		return 0;
>  	}
> -	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
> -		? 2 : 1;
> +	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;

As stated in the commit message, normalization of the hash version is
performed later.

> @@ -2423,10 +2416,18 @@ int write_commit_graph(struct object_directory *odb,
>  		/* We have changed-paths already. Keep them in the next graph */
>  		if (g && g->bloom_filter_settings) {
>  			ctx->changed_paths = 1;
> -			ctx->bloom_settings = g->bloom_filter_settings;
> +
> +			/* don't propagate the hash_version unless unspecified */
> +			if (bloom_settings.hash_version == -1)
> +				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
> +			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
> +			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
> +			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;

Here is where the autodetection is restored.

Prior to this patch set, this part of the code does not perform
autodetection - every hash_version in memory matches the version in
commit_graph_changed_paths_version, so we're just copying over the value
in that variable. But the nature of this part of the code has changed
due to this patch set: all the g->bloom_filter_settings in memory
may not have the same hash version, and may not match what the user
specified in config. To compensate, we are more selective in what we
propagate from g->bloom_filter_settings.

> +	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;

And here we restore the normalization.

Thanks - up to here looks good.
