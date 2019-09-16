Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9A01F463
	for <e@80x24.org>; Mon, 16 Sep 2019 04:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfIPEe4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 00:34:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:51128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbfIPEe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 00:34:56 -0400
Received: (qmail 4636 invoked by uid 109); 16 Sep 2019 04:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Sep 2019 04:34:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2637 invoked by uid 111); 16 Sep 2019 04:37:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Sep 2019 00:37:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Sep 2019 00:34:55 -0400
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] fetch: Cache the want OIDs for faster lookup
Message-ID: <20190916043454.GA18026@sigill.intra.peff.net>
References: <20190915211802.207715-1-masayasuzuki@google.com>
 <20190915211802.207715-2-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915211802.207715-2-masayasuzuki@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 15, 2019 at 02:18:02PM -0700, Masaya Suzuki wrote:

> During git-fetch, the client checks if the advertised tags' OIDs are
> already in the fetch request's want OID set. This check is done in a
> linear scan. For a repository that has a lot of refs, repeating this
> scan takes 15+ minutes. In order to speed this up, create a oid_set for
> other refs' OIDs.

Good find. I was curious why nobody noticed it sooner, but I think a key
element in your chromium example is the use of "--mirror", which brings
in a bunch of refs which would not normally be grabbed. There are only
about 17k heads and tags, but over 1.5M entries in refs/changes.
Quadratically speaking, that's almost 8000 times worse, so your
15-minute delay is only 1/10th of a second in the non-mirror case.

Mostly I was wondering if this might have been a recent regression. But
it looks rather old:

> -static int will_fetch(struct ref **head, const unsigned char *sha1)
> +static void create_fetch_oidset(struct ref **head, struct oidset *out)
>  {
>  	struct ref *rm = *head;
>  	while (rm) {
> -		if (hasheq(rm->old_oid.hash, sha1))
> -			return 1;
> +		oidset_insert(out, &rm->old_oid);
>  		rm = rm->next;
>  	}
> -	return 0;
>  }

This function comes from cf7f929a10 (Teach git-fetch to grab a tag at
the same time as a commit, 2008-03-02). As explained in that commit
message, this technique can't actually get all the tags we're looking
for. It was around the same time, in 348e390b17 (Teach
fetch-pack/upload-pack about --include-tag, 2008-03-03), that we added
an extension to do this reliably.

So it _might_ even be possible to get rid of this code entirely, if we
don't care about pre-2008 versions of Git (we'd still get the right
answer from them; it would just take an extra round-trip).

That said, it seems like a good idea to do this obvious and safe
conversion in the near term, and we can look at removing it entirely as
a separate topic. The cost of the oidset isn't too bad (~30MB, I guess
even for that pathological chromium case).

> @@ -324,6 +324,7 @@ static void find_non_local_tags(const struct ref *refs,
>  
>  	refname_hash_init(&existing_refs);
>  	refname_hash_init(&remote_refs);
> +	create_fetch_oidset(head, &fetch_oids);
>  
>  	for_each_ref(add_one_refname, &existing_refs);
>  	for (ref = refs; ref; ref = ref->next) {
> @@ -340,9 +341,9 @@ static void find_non_local_tags(const struct ref *refs,
>  			if (item &&
>  			    !has_object_file_with_flags(&ref->old_oid,
>  							OBJECT_INFO_QUICK) &&
> -			    !will_fetch(head, ref->old_oid.hash) &&
> +			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
>  			    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
> -			    !will_fetch(head, item->oid.hash))
> +			    !oidset_contains(&fetch_oids, &item->oid))
>  				clear_item(item);
>  			item = NULL;
>  			continue;

One thing to check is whether the list we feed to will_fetch ever gets
updated in the loop that checks it (i.e., do we need to be adding or
clearing elements in the oidset).

I _think_ the answer is no, because we modify only the "refs" list in
that loop (via clear_item()), but the will_fetch() check is on the
head/tail we receive (which isn't updated until later). Both of those
lists are passed into the function, but I didn't trace it all the way up
to make sure they are not aliases.

-Peff
