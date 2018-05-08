Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C761F42E
	for <e@80x24.org>; Tue,  8 May 2018 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeEHKKZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 06:10:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754341AbeEHKKY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 06:10:24 -0400
Received: (qmail 25458 invoked by uid 109); 8 May 2018 10:10:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 10:10:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2570 invoked by uid 111); 8 May 2018 10:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 06:10:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 06:10:22 -0400
Date:   Tue, 8 May 2018 06:10:22 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, jamill@microsoft.com
Subject: Re: [PATCH v2 13/13] alloc: allow arbitrary repositories for alloc
 functions
Message-ID: <20180508101022.GA17501@sigill.intra.peff.net>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
 <20180507225916.155236-14-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180507225916.155236-14-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 03:59:16PM -0700, Stefan Beller wrote:

> @@ -501,9 +509,31 @@ void raw_object_store_clear(struct raw_object_store *o)
>  void parsed_object_pool_clear(struct parsed_object_pool *o)
> [...]
> +	for (i = 0; i < o->obj_hash_size; i++) {
> +		struct object *obj = o->obj_hash[i];
> +
> +		if (!obj)
> +			continue;
> +
> +		if (obj->type == OBJ_TREE) {
> +			free(((struct tree*)obj)->buffer);
> +		} else if (obj->type == OBJ_COMMIT) {
> +			free_commit_list(((struct commit*)obj)->parents);
> +			free(&((struct commit*)obj)->util);
> +		}
> +	}

Coverity complains about this final free(). I think the "&" is doing an
incorrect extra level of indirection?

That said, I'm not sure if it is safe to blindly free the util field. We
don't necessarily know what downstream code has pointed it to. It may
not be allocated memory[1], or it may even be a more complicated data
structure that has sub-components that need freeing[2].

In the long run, it may be worth trying to get rid of this util field
completely, in favor of having callers use a commit_slab. That has
better memory-ownership semantics, and it would save 8 bytes in struct
commit.

[1] Grepping for "commit->util =", sequencer.c seems to assign pointers
    into other arrays, as well as the "(void *)1".

[2] Most assignments seem to be flex-structs, but blame.c assigns a
    linked list.

-Peff
