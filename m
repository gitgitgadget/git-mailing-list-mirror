Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BA71F453
	for <e@80x24.org>; Thu, 27 Sep 2018 05:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeI0Lus (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 07:50:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726469AbeI0Lus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 07:50:48 -0400
Received: (qmail 10098 invoked by uid 109); 27 Sep 2018 05:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 05:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27886 invoked by uid 111); 27 Sep 2018 05:33:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 01:33:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 01:34:19 -0400
Date:   Thu, 27 Sep 2018 01:34:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with
 a hashmap
Message-ID: <20180927053418.GB14178@sigill.intra.peff.net>
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 02:28:28PM -0700, Junio C Hamano wrote:

> In find_non_local_tags() helper function (used to implement the
> "follow tags"), we use string_list_has_string() on two string lists
> as a way to see if a refname has already been processed, etc.
> 
> All this code predates more modern in-core lookup API like hashmap;
> replace them with two hashmaps and one string list---the hashmaps
> are used for look-ups and the string list is to keep the order of
> items in the returned result stable (which is the only single thing
> hashmap does worse than lookups on string-list).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Just to remind ourselves that we talked about getting rid of
>    string-list used as look-up tables by replacing them with hashmap
>    but haven't seen much effort expended on it.  I think this is my
>    first semi-serious use of hashmap, and the code is expected to be
>    full of newbie mistakes, inefficiencies and ignorance of idioms;
>    pointing out any of which is much appreciated.

As you probably noticed, there's a bit of boilerplate required to use a
hashmap. I had figured we could replace most of these with a single
"strmap" API to map a string to a void pointer (which is basically
what string-list gives you).

That would save on the boilerplate. But your solution here replaces a
"void *" pointer with an actual "struct object_id" member, which
improves type-safety. It also removes questions about memory lifetimes
(at the minor cost of copying the oids). So this path is probably better
if we don't mind a little extra code.

I do note that your struct just has the same information as "struct
ref":

> +struct refname_hash_entry {
> +	struct hashmap_entry ent; /* must be the first member */
> +	struct object_id oid;
> +	char refname[FLEX_ARRAY];
> +};

So yet another alternative here is to just define a single hashmap that
stores void pointers. That also throws away some type safety, but is
maybe conceptually simpler. I dunno. It's actually a pain to do that
with "struct hashmap" because it requires the caller to handle
allocation. An open-addressed hash table, as we use elsewhere (and in
khash.h) is a bit simpler, since it doesn't need to do any per-entry
malloc.

To be clear, I'm perfectly happy with the approach in your patch here.
I'm just musing on what might might be the least painful thing for doing
more of them.

-Peff
