Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0FC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHKVsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjHKVsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:48:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB732722
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:48:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5fc972760eso2525232276.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691790489; x=1692395289;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tg2SXLfKWONlHGAeefAWonh6HEUpNECllqT8Nq099Us=;
        b=XRRpRAxMfs294Y5Bsz8VBB/cWVgkGbryNLgvw860Jmq3t9xO2n/2qZxe252QXn/UNo
         DKu8xHTuSywq2H7A7XfDDfRkI5EtWWa8cnHqS5/+lPNoQzwf1VxNn3mlP1DyngjDKB/W
         gR5fdRsDJu/nSXbkIudKgB71BNzcqYBneBQUCrOwU+t5vVnnTbk3FOwsCAEyuUSjEQV6
         MAt2HyEj6u0VRxFwIUdpsG8JsD0b/Fqe1do7fQ3wXQTBe90uspzyLhciAS8AkDqyQWsb
         TyJ5vjGjJuvRQw0vfrIWoGoH4xCSXI4sFa0ifRV1WmWZ2O2RnGOPL4NZyZzXcQ5hmT84
         j1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790489; x=1692395289;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tg2SXLfKWONlHGAeefAWonh6HEUpNECllqT8Nq099Us=;
        b=avWKbFeaOkdkdWvXh9p/qMUddc+/sq3L+Lu0vIqZzrpcrOuVBYFwv+6zTZuopRkn4y
         VKoOiVx3cUhz1fnsvEvTosdROYKXMgyyp1e9V2ZicuESjt6G2SatyqLm9IQbOiT6z41D
         mBnO9U4Vc+J1lWGwBNp8pr7Zgpz+S96lNFqqesK7Og+j/ecNhOkiB9me/zaKDmR3jefi
         N1rEyBuyrHYWNnYVYy/WLGIhIlgE20hIDrRotjmnGLaRy3hW90RMNkyumg1X0OFeCozi
         5T2cdaf+MX/+c1QHnCL6RQodMTFfmCUFFwPcGtgvT8yPxdvtMMA362tuhWUTjuA1VHQH
         4OPA==
X-Gm-Message-State: AOJu0Yw3YjBYSu+HvgplDnS1ftxhQa9msWowGGqgJmV9OomzwKm465El
        yP8T1rSZhjknRgvh8oBHS8uhASFg/d9vNjlDQnJ1
X-Google-Smtp-Source: AGHT+IEOP0YyjEA60VlxwZbSLT4zl7SXe0F4InqFk2Tgddk//GuBQcVdMNR7XJkRYCQ+nxAaiuQSLwBFRo4N4+76jUIK
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ce53:0:b0:d4f:22c:69a3 with SMTP
 id x80-20020a25ce53000000b00d4f022c69a3mr45549ybe.10.1691790489214; Fri, 11
 Aug 2023 14:48:09 -0700 (PDT)
Date:   Fri, 11 Aug 2023 14:48:06 -0700
In-Reply-To: <a4cb5fe69247ba737a8373948c1f4ff8a150d283.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811214806.3326560-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom filters
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
> diff --git a/bloom.h b/bloom.h
> index 330a140520..2b1c124bb5 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  						 const struct bloom_filter_settings *settings,
>  						 enum bloom_filter_computed *computed);
>  
> -#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
> -	(r), (c), 0, NULL, NULL)
> +/*
> + * Find the Bloom filter associated with the given commit "c".
> + *
> + * If any of the following are true
> + *
> + *   - the repository does not have a commit-graph
> + *   - it has a commit-graph, but reading the commit-graph is disabled
> + *   - the given commit does not have a Bloom filter computed
> + *   - there is a Bloom filter for commit "c", but it cannot be read because
> + *     disabled

s/disabled/version incompatibility/, I think.

> + *
> + * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
> + * Bloom filter will be returned.
> + *
> + * For callers who wish to inspect Bloom filters with incompatible hash
> + * versions, use get_or_compute_bloom_filter().
> + */
> +struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);

