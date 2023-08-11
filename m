Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0619C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjHKWGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjHKWGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:06:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE730D2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:06:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d61e9cb310dso2393164276.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691791599; x=1692396399;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6DspOfK0rFww0GKdyov9Fd7U6QasA/pObelp2UvWEH8=;
        b=HQwU3XWoEVKq8f2YngbS+hMSRT5oUGkSam1M+9ip74lEEf867EZXavU4vZZT39s/qj
         Y5uQdkALsUBOwQ3J52K/4FZKLIpj5GQHIpWUsFAbmZN497qWhBXpSFO2Bk+j/AEdyAQx
         IYnFQ6Mq9fWChx5ATeZQE/b8DVAtJslkao7CMbVeo/WaqPX7RMDdNlVhDRBMMhr4Fnm5
         LkBZnGiXmnHzPH2mtkQlix7T612nRNcMVymx+N3iW0WQmeBO7FYRxMz1Rj2rBG5xC58B
         SAbTaT/8IUGstC36tM0BOETfNGRVWFqA6tBTP/Dmn33ejPSfGQ7ri7bysjsfoZbZdvvT
         ei8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791599; x=1692396399;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DspOfK0rFww0GKdyov9Fd7U6QasA/pObelp2UvWEH8=;
        b=CNdI16Hx5OXAIA+xcObV44Z92f9CxIjB/GeXO/OBgiYAl3qldpn/eRRGS3QeETAiJp
         g2RNpagRDhSLjpXVBViSgGzKkVGFBttYBv6jKSPGd6Ux+8CmhZYr74fRuIiMdX4Tykhy
         RGKZ/faCyb3gaRfDWUydp3fga82ZjTqKY/eJWxn0UtRUqqf2N+z6cYB8obNxdqjn3akp
         USJKCQhun1T9RfbFaWQwa5pqjmYJ4+mMgiV/igWeLCSnQIfLIItzYrUUHVOzYPGzaZ5L
         5H08mRymZLJjdhN0Ati4JOiS0ZTBhmfRW044xvsP/ZoO3OIDT8RZ9LwwKsJyBSFyzvge
         Kv8Q==
X-Gm-Message-State: AOJu0Yw4wAy0csm/o3gBszpaupV87rpBGCy8DCEh0wkF5k6M35B/dOmg
        1TPoIxbXbkEz9FB3LHe/cDalHKgW/01fYDxJyt4w
X-Google-Smtp-Source: AGHT+IHt+1S+WRsR4hCN5eJ1GOaTEJtSS2c0TqqVANDo2p4LhjP8r3zC8fcNa+XwXKM51Fm68zN4/svoCRJKdMhRhfaH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e097:0:b0:d11:6816:2d31 with
 SMTP id x145-20020a25e097000000b00d1168162d31mr50806ybg.7.1691791599386; Fri,
 11 Aug 2023 15:06:39 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:06:37 -0700
In-Reply-To: <93f830ca61d17bb20f63c6a4254fe95816ae1cbe.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811220637.3330277-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 6/6] commit-graph: reuse existing Bloom filters where possible
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
> @@ -292,9 +362,23 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  						     filter, graph_pos);
>  	}
>  
> -	if ((filter->data && filter->len) &&
> -	    (!settings || settings->hash_version == filter->version))
> -		return filter;
> +	if (filter->data && filter->len) {
> +		struct bloom_filter *upgrade;
> +		if (!settings || settings->hash_version == filter->version)
> +			return filter;
> +
> +		/* version mismatch, see if we can upgrade */
> +		if (compute_if_not_present &&
> +		    git_env_bool("GIT_TEST_UPGRADE_BLOOM_FILTERS", 1)) {
> +			upgrade = upgrade_filter(r, c, filter,
> +						 settings->hash_version);
> +			if (upgrade) {
> +				if (computed)
> +					*computed |= BLOOM_UPGRADED;
> +				return upgrade;
> +			}
> +		}
> +	}
>  	if (!compute_if_not_present)
>  		return NULL;

There's a part in this function that's untouched by the diff that
computes and stores a new Bloom filter if it was not possible to upgrade
the filter (look at the part where filter->data is calloc-ed). That
part unconditionally overrides the existing filter->data, which may at
that point contain genuine data (a Bloom filter that does not match the
version we want). Right now this is fine because all overrides that we
do involve overriding references to existing buffers, so we do not need
to free anything.
