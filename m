Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1730C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3499610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhDISmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:42:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhDISmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:42:36 -0400
Received: (qmail 1149 invoked by uid 109); 9 Apr 2021 18:42:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:42:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15526 invoked by uid 111); 9 Apr 2021 18:42:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:42:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:42:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/6] tag.c: use type_from_string_gently() when parsing
 tags
Message-ID: <YHCgDm0KVygpjkNU@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-6.6-3279d67d2b-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-3279d67d2b-20210409T082935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:54AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change a series of strcmp() to instead use type_from_string_gently()
> to get the integer type early, and then use that for comparison.

The result looks much nicer.

One interesting note...

> @@ -162,23 +162,24 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
>  		return -1;
>  	bufptr += 5;
>  	nl = memchr(bufptr, '\n', tail - bufptr);
> -	if (!nl || sizeof(type) <= (nl - bufptr))
> +	if (!nl)
> +		return -1;
> +	type = type_from_string_gently(bufptr, nl - bufptr);
> +	if (type < 0)
>  		return -1;

If we got anything but the main-4 types here, we'll return an error.
So we know here:

> -	if (!strcmp(type, blob_type)) {
> +	if (type == OBJ_BLOB) {
>  		item->tagged = (struct object *)lookup_blob(r, &oid);
> -	} else if (!strcmp(type, tree_type)) {
> +	} else if (type == OBJ_TREE) {
>  		item->tagged = (struct object *)lookup_tree(r, &oid);
> -	} else if (!strcmp(type, commit_type)) {
> +	} else if (type == OBJ_COMMIT) {
>  		item->tagged = (struct object *)lookup_commit(r, &oid);
> -	} else if (!strcmp(type, tag_type)) {
> +	} else if (type == OBJ_TAG) {
>  		item->tagged = (struct object *)lookup_tag(r, &oid);
>  	} else {
>  		return error("unknown tag type '%s' in %s",
> -			     type, oid_to_hex(&item->object.oid));
> +			     type_name(type), oid_to_hex(&item->object.oid));
>  	}

That the final "else" clause can't be reached. I don't mind being
defensive, but if it _is_ reached, then we'd feed that unknown type to
type_name(), which will return NULL for unknown items (unless I guess it
has also learned about the hypothetical new type).

I think this should just be:

  else {
          BUG("type_from_string gave us an unknown type: %d", (int)type);
  }

which makes it clear we expect the code can't be reached, and doesn't
make any assumptions about what we can do with the odd value.

-Peff
