Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356CC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2967613CB
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbhDFRtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:49:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhDFRtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:49:02 -0400
Received: (qmail 8318 invoked by uid 109); 6 Apr 2021 17:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:48:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30719 invoked by uid 111); 6 Apr 2021 17:48:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:48:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:48:53 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 6/8] pack-bitmap: implement object type filter
Message-ID: <YGyfBc9I6YtyDWSr@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <8073ab665b07cf653478482f801a06e072233230.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8073ab665b07cf653478482f801a06e072233230.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:55PM +0100, Patrick Steinhardt wrote:

> The preceding commit has added a new object filter for git-rev-list(1)
> which allows to filter objects by type. Implement the equivalent filter
> for packfile bitmaps so that we can answer these queries fast.

Makes sense. The implementation looks pretty sensible. One observation:

> +static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
> +				      struct object_list *tip_objects,
> +				      struct bitmap *to_filter,
> +				      enum object_type object_type)
> +{
> +	enum object_type t;
> +
> +	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
> +		BUG("filter_bitmap_object_type given invalid object");
> +
> +	for (t = OBJ_COMMIT; t <= OBJ_TAG; t++) {
> +		if (t == object_type)
> +			continue;
> +		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, t);
> +	}
> +}

The OBJ_* constants are a contiguous set between COMMIT and TAG, and it
has to remain this way (because we use them to decipher the type fields
in pack files). But I don't think we've generally baked that assumption
into the code in this way.

Writing it out long-hand would be something like:

  if (t != OBJ_COMMIT)
	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_COMMIT);
  if (t != OBJ_TREE)
	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TREE);

and so on, which isn't too bad. I dunno. That may be overly picky.

-Peff
