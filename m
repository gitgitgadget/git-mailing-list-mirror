Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5CC201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdBYBQk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:16:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:33783 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdBYBQj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:16:39 -0500
Received: (qmail 28398 invoked by uid 109); 25 Feb 2017 01:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 01:16:39 +0000
Received: (qmail 29284 invoked by uid 111); 25 Feb 2017 01:16:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:16:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:16:36 -0500
Date:   Fri, 24 Feb 2017 20:16:36 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170225011636.qjlv2luj3zefmrpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFy6G1QF3Msy2DZbyhFmn974wBeXVuZK78pJ8FgkyeU85g@mail.gmail.com>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 04:39:45PM -0800, Linus Torvalds wrote:

> For example, what I would suggest the rules be is something like this:
> 
>  - introduce new tag2/commit2/tree2/blob2 object type tags that imply
> that they were hashed using the new hash
> 
>  - an old type obviously can never contain a pointer to a new type (ie
> you can't have a "tree" object that contains a tree2 object or a blob2
> object.
> 
>  - but also make the rule that a *new* type can never contain a
> pointer to an old type, with the *very* specific exception that a
> commit2 can have a parent that is of type "commit".

Yeah, this is exactly what I had in mind. That way everybody in
"newhash" mode has no decisions to make. They follow the same rules and
it's as if sha1 never existed, except when you follow links in
historical objects.

> [in reply...]
> Actually, I take that back. I think it might be easier to keep
> "object->type" as-is, and it would only show the current OBJ_xyz
> fields. Then writing the SHA ends up deciding whether a OBJ_COMMIT
> gets written as "commit" or "commit2".

Yeah, I think there are some data structures with limited bits for the
"type" fields (e.g., the pack format). So sticking with OBJ_COMMIT might
be nice. For commits and tags, it would be nice to have an "I'm v2"
header at the start so there's no confusion about how they are meant to
be interpreted.

Trees are more difficult, as they don't have any such field. But a valid
tree does need to start with a mode, so sticking some non-numeric flag
at the front of the object would work (it breaks backwards
compatibility, but that's kind of the point).

I dunno. Maybe we do not need those markers at all, and could get by
purely on object-length, or annotating the headers in some way (like
"parent sha256:1234abcd").

It might just be nice if we could very easily identify objects as one
type or the other without having to parse them in detail.

> So you will end up with duplicate objects, and that's not good (think
> of what it does to all our full-tree "diff" optimizations, for example
> - you no longer get the "these sub-trees are identical" across a
> format change), but realistically you'll have a very limited time of
> that kind of duplication.

Yeah, cross-flag-day diffs will be more expensive. I think that's
something we have to live with. I was thinking originally that the
sha1->newhash mapping might solve that, but it only works at the blob
level. I.e., you can compare a sha1 and a newhash like:

  if (!hashcmp(sha1_to_newhash(a), b))

without having to look at the contents. But it doesn't work recursively,
because the tree-pointing-to-newhash will have different content.

-Peff
