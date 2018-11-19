Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3201F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 16:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeKTCpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 21:45:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:44622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729979AbeKTCpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 21:45:44 -0500
Received: (qmail 14086 invoked by uid 109); 19 Nov 2018 16:21:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 16:21:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19364 invoked by uid 111); 19 Nov 2018 16:21:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 11:21:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 11:21:38 -0500
Date:   Mon, 19 Nov 2018 11:21:38 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
Message-ID: <20181119162137.GA10621@sigill.intra.peff.net>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 10:40:53AM -0500, Derrick Stolee wrote:

> > 2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash,
> > base_sha1);
> > 2fa233a554 builtin/pack-objects.c 1513) if
> > (!in_same_island(&delta->idx.oid, &base_oid))
> > 2fa233a554 builtin/pack-objects.c 1514) return 0;
> 
> These lines are inside a block for the following if statement:
> 
> +       /*
> +        * Otherwise, reachability bitmaps may tell us if the receiver has
> it,
> +        * even if it was buried too deep in history to make it into the
> +        * packing list.
> +        */
> +       if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, base_sha1))
> {
> 
> Peff: is this difficult to test?

A bit.

The two features (thin-packs and delta-islands) would not generally be
used together (one is for serving fetches, the other is for optimizing
on-disk packs to serve fetches). Something like:

 echo HEAD^ | git pack-objects --revs --thin --delta-islands

would probably exercise it (assuming there's a delta in HEAD^ against
something in HEAD), but you'd need to construct a very specific scenario
if you wanted to do any kind of checks no the output.

> > 28b8a73080 builtin/pack-objects.c 2793) depth++;
> > 108f530385 builtin/pack-objects.c 2797) oe_set_tree_depth(&to_pack, ent,
> > depth);
> 
> This 'depth' variable is incremented as part of a for loop in this patch:
> 
>  static void show_object(struct object *obj, const char *name, void *data)
> @@ -2686,6 +2706,19 @@ static void show_object(struct object *obj, const
> char *name, void *data)
>         add_preferred_base_object(name);
>         add_object_entry(&obj->oid, obj->type, name, 0);
>         obj->flags |= OBJECT_ADDED;
> +
> +       if (use_delta_islands) {
> +               const char *p;
> +               unsigned depth = 0;
> +               struct object_entry *ent;
> +
> +               for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
> +                       depth++;
> +
> +               ent = packlist_find(&to_pack, obj->oid.hash, NULL);
> +               if (ent && depth > ent->tree_depth)
> +                       ent->tree_depth = depth;
> +       }
>  }
> 
> And that 'ent->tree_depth = depth;' line is replaced with the
> oe_set_tree_depth() call in the report.
> 
> Since depth is never incremented, we are not covering this block. Is it
> possible to test?

Looks like t5320 only has single-level trees. We probably just need to
add a deeper tree. A more interesting case is when an object really is
found at multiple depths, but constructing a case that cared about that
would be quite complicated.

That said, there is much bigger problem with this code, which is that
108f530385 (pack-objects: move tree_depth into 'struct packing_data',
2018-08-16) is totally broken. It works on the trivial repository in the
test, but try this (especially under valgrind or ASan) on a real
repository:

  git repack -adi

which will crash immediately.  It doesn't correctly maintain the
invariant that if tree_depth is not NULL, it is the same size as
the main object array.

I'll see if I can come up with a fix.

-Peff
