Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5B91F461
	for <e@80x24.org>; Sun, 25 Aug 2019 07:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfHYHKh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 03:10:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725767AbfHYHKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 03:10:36 -0400
Received: (qmail 9433 invoked by uid 109); 25 Aug 2019 07:10:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 07:10:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9899 invoked by uid 111); 25 Aug 2019 07:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 03:11:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 03:10:35 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] notes: avoid leaking duplicate entries
Message-ID: <20190825071035.GB23806@sigill.intra.peff.net>
References: <20190825051818.9621-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825051818.9621-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:18:18PM +0900, Mike Hommey wrote:

> When add_note is called multiple times with the same key/value pair, the
> leaf_node it creates is leaked by notes_tree_insert.

Makes sense.

> diff --git a/notes.c b/notes.c
> index 75c028b300..ec35f5b551 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -269,8 +269,10 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
>  		case PTR_TYPE_NOTE:
>  			if (oideq(&l->key_oid, &entry->key_oid)) {
>  				/* skip concatenation if l == entry */
> -				if (oideq(&l->val_oid, &entry->val_oid))
> +				if (oideq(&l->val_oid, &entry->val_oid)) {
> +					free(entry);
>  					return 0;
> +				}

"entry" is passed in by the caller. Does anybody try to insert, and then
after the insertion continue to access the entry?

The only case I could find is this one in load_subtree():

        if (note_tree_insert(t, node, n, l, type,
                             combine_notes_concatenate))
                die("Failed to load %s %s into notes tree "
                    "from %s",
                    type == PTR_TYPE_NOTE ? "note" : "subtree",
                    oid_to_hex(&l->key_oid), t->ref);

If we fail to insert, we'll try to access the key_oid of the entry we
passed in, which might have been freed. But your patch is OK, because it
only touches a code path where we always return success.

Curiously, I think the existing case a few lines below your patch is
wrong, though:

        ret = combine_notes(&l->val_oid,
                            &entry->val_oid);
        if (!ret && is_null_oid(&l->val_oid))
                note_tree_remove(t, tree, n, entry);
        free(entry);
        return ret;

If combining the notes fails, we'll free the entry and return an error
code, and then load_subtree() will access the freed memory. I think we
could just object_oid instead.

-Peff
