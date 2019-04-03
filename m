Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F9720248
	for <e@80x24.org>; Wed,  3 Apr 2019 18:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCS6O (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 14:58:14 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:41263 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCS6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 14:58:14 -0400
Received: by mail-io1-f73.google.com with SMTP id e126so14414376ioa.8
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zd/UY979mP2/p6lXdmrhvlq3Mh1IRRijExHrTChcCt8=;
        b=TAV4oe9Kt75DXL4+M/vs3203oVPn4lTn3IgWBb+KF8d9cUtOb9NSGdtQygShmUSjg/
         IYAxv0gjf+Y5SYcBL6Db//9OtYPTwc93EDGS7PokW51w++6jj9LbILHHa3K8YfjB+RVo
         WOYKShnwK7Po6zOW9dcPwaikR1SB445w1adTBCBQAUb2ont3DGqUZc3vjjAtGgUZbnik
         1IeQbhs63iwNT1BOSxg3iStjynIL5Pxnhd7VRx9Q665MmB4i1IZ0dsgYL96wbJjo0p6f
         N9/75K/430weSJbDCWQHeSdq8+JIE2reJ+ye9NPJUsORppmU0KdodzwMDGB5pGcaFtHT
         d54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zd/UY979mP2/p6lXdmrhvlq3Mh1IRRijExHrTChcCt8=;
        b=L9iqGICG7llsQ7iRp8ATCZ36Vna+r57AwBtolxLCsGEhKSSKFWGh0mcwqB3woGI1Q/
         SXWZWawzYJw7WcJfx6p/goAQ26Isq3FL2LY26g8tzzBh0la7KL6CJ4JTjabmfS9uwZvg
         CzMTp8I7eyRrWdAglSl6Gr6eNhr7iVpIc+j2qyuKuADbYhnunpw9Fv11qK85AYfBOuGp
         QyeA8GETN6xqoJjQi/UsqFZYujrbZoHIe019qjYifXjz0X/sLOC0NmYyLrQt2weZSPyd
         HLkDZTjDRqSeJzPciTW33wt2wrQcLNYokY1TsSA8iutwRY5MOnNwzt+18+p3y8p4LpN+
         d7rg==
X-Gm-Message-State: APjAAAWo2aw31cItUdvOBbArrd18uw0cTgbFmEU7O3hvsAG2DJ3vlNsY
        SqJJShGEqdqBFtkLW5jQFTd3gSAW+s3ThCi/I/O9
X-Google-Smtp-Source: APXvYqwg8MqrSY90ngXwixGbRTIADwtrS59relizas2mfVygxvfeA9y15ytBxp+Q3MuHLcpBli5gpeRK9QiPI6fVg4em
X-Received: by 2002:a24:628b:: with SMTP id d133mr307923itc.2.1554317893724;
 Wed, 03 Apr 2019 11:58:13 -0700 (PDT)
Date:   Wed,  3 Apr 2019 11:58:10 -0700
In-Reply-To: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Message-Id: <20190403185810.8787-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: Re: [PATCH] clone: do faster object check for partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For partial clones, doing a full connectivity check is wasteful; we skip
> promisor objects (which, for a partial clone, is all known objects), and
> excluding them all from the connectivity check can take a significant
> amount of time on large repos.

Instead of "excluding them all", I would word this as "enumerating them
all so that we can exclude them" - the enumerating is the slow part, not
the excluding (which actually makes things faster).

> +	if (opt->check_refs_only) {
> +		/*
> +		 * For partial clones, we don't want to walk the full commit
> +		 * graph because we're skipping promisor objects anyway. We
> +		 * should just check that objects referenced by wanted refs were
> +		 * transferred.

The enumeration of promisor objects to be excluded is done through
for_each_packed_object() (see is_promisor_object()), not through walking
the commit graph. Maybe reword this comment to be similar to what I've
suggested for the commit message.

> @@ -46,6 +46,14 @@ struct check_connected_options {
>  	 * during a fetch.
>  	 */
>  	unsigned is_deepening_fetch : 1;
> +
> +	/*
> +	 * If non-zero, only check the top-level objects referenced by the
> +	 * wanted refs (passed in as cb_data). This is useful for partial
> +	 * clones, where this can be much faster than excluding all promisor
> +	 * objects prior to walking the commit graph.
> +	 */
> +	unsigned check_refs_only : 1;
>  };

Same enumerating vs excluding comment as before.

Aside from that: thinking from scratch, we want something that tells
check_connected() to avoid anything that enumerates the list of promised
objects, since the objects that we're checking are all promisor objects,
and thus any outgoing links are automatically promised. I would include
some of this explanation in the comment, but in the interest of trying
to avoid a bikeshedding discussion, I don't consider this necessary.
