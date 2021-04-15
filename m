Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18743C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAE461166
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhDOJ5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:57:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:53212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOJ5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:57:53 -0400
Received: (qmail 10260 invoked by uid 109); 15 Apr 2021 09:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:57:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14817 invoked by uid 111); 15 Apr 2021 09:57:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:57:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:57:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHgOCUI++AY/7zwX@coredump.intra.peff.net>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <xmqqfsztlwxb.fsf@gitster.g>
 <YHbZNL0gzw0+1k5h@ncase>
 <xmqqmtu0y3r8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmtu0y3r8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 02:07:07PM -0700, Junio C Hamano wrote:

>  * But if we look at the the hits from
> 
>     $ git grep -C2 -E -e '([.]|->)(tag|tree|blob)_objects' \*.[ch]
> 
>    it is clear that the code is (at least trying to be) prepared for
>    them to be set independently.  The .tree_objects member is often
>    checked without checking others to mark the tree objects on the
>    edge of the range uninteresting, for example.
> 
>    It of course is unknown how well the code is actually prepared
>    for these three bits to be set independently, as nobody can set
>    these bits independently.

Yeah, as somebody who has added or touched a lot of those paths, I've
often wondered this myself: what would break if you asked for blobs but
not trees? I think it does not work like you'd expect, because
list-objects.c:process_tree() will not recurse the trees at all (and
hence you'd never see any blob).

>  * Which makes a naïve reader to wonder if it would be sufficient
>    to have a silly option, like this:
> 
>  	} else if (!strcmp(arg, "--filter=object:type=tree")) {
>  		revs->tag_objects = 0;
>  		revs->tree_objects = 1;
>  		revs->blob_objects = 0;
> 
>    in the same if/else if/... cascade as the above (and other types
>    as well), in order to do the same thing as this series.
> 
> And, the above led to the question---the patches in your series
> apparently do a lot more (even if we discount the option parsing
> part), and I was wondering if that is because the independence
> between these three bits the existing code aspires to maintain is
> broken.

I don't think the code Patrick added is that much more complex. Most if
it was cleaning up rough edges in the filtering system, and making sure
that bitmaps supported this style of filtering. I _think_ the existing
bitmap code would Just Work with the example you showed above. It uses
list-objects.c to do any fill-in traversal, and then
traverse_bitmap_commit_list() uses the type-bitmaps to filter the
results.

But it would be likewise broken for the case of "no trees, just
blobs", because of the problem in list-objects.c that I mentioned (but
worse, it would only be _half_ broken; we might even produce the right
answer if we don't have to do any fill-in traversal!).

Anyway. I do think this all could be done using the existing bits in
rev_info. But there is value in making it all part of the modular
filtering system.

-Peff
