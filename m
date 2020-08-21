Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66EC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EA42075E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUTW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:22:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUTWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:22:25 -0400
Received: (qmail 19919 invoked by uid 109); 21 Aug 2020 19:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 19:22:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31476 invoked by uid 111); 21 Aug 2020 19:22:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 15:22:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 15:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Message-ID: <20200821192224.GC1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b295e9393a8998b3b9263ab7cd195907d4002e36.1598035949.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b295e9393a8998b3b9263ab7cd195907d4002e36.1598035949.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:25PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> The existence of hashmap_free() and hashmap_free_entries() confused me,
> and the docs weren't clear enough.  I had to consult other source code
> examples and the implementation.  Add a brief note to clarify,
> especially since hashmap_clear*() variants may be added in the future.

Thanks, I think this is worth doing and the text looks clear and correct
to me.

>  /*
> - * Frees a hashmap structure and allocated memory, leaves entries undisturbed
> + * Frees a hashmap structure and allocated memory for the table, but does not
> + * free the entries nor anything they point to.
> + *
> + * Usage note:
> + *
> + * Many callers will need to iterate over all entries and free the data each
> + * entry points to; in such a case, they can free the entry itself while at it.
> + * Thus, you might see:
> + *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
> + *      free(e->somefield);
> + *      free(e);
> + *    }
> + *    hashmap_free(map);
> + * instead of
> + *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
> + *      free(e->somefield);
> + *    }
> + *    hashmap_free_entries(map, struct my_entry_struct, hashmap_entry_name);
> + * to avoid the implicit extra loop over the entries.  However, if there are
> + * no special fields in your entry that need to be freed beyond the entry
> + * itself, it is probably simpler to avoid the explicit loop and just call
> + * hashmap_free_entries().

A minor nit, but a blank line between the code snippets and the text
might make it a little more readable.

-Peff
