Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1EC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIVSkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIVSkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:40:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345D57264
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:40:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23F5814A160;
        Thu, 22 Sep 2022 14:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BoXd3FZCjUpKEHbqKQUptgbvKYD1erZ+ZJiquL
        l2Y5Y=; b=p1bQvMkzcNA4cS3TpEE7WMjeq+183tu6I/BowMySvwgQ4YsJu9cLKl
        Z7rYqr5PmtfDx72ZPWWpcP/fIkPYZ8dJx/WDtSS4fBjyHyKog3IOEzW0BfLdQcHC
        h2a267bbLyJM6xlDxf0flSLMll4HVwU5tAGZi5WfHz4bGycc8K8hQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74ED414A15F;
        Thu, 22 Sep 2022 14:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAA2014A15B;
        Thu, 22 Sep 2022 14:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] fsck: free tree buffers after walking unreachable
 objects
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
        <Yyw031PqCyYlEqCX@coredump.intra.peff.net>
Date:   Thu, 22 Sep 2022 11:40:05 -0700
In-Reply-To: <Yyw031PqCyYlEqCX@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 22 Sep 2022 06:11:43 -0400")
Message-ID: <xmqqa66rz20q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB408FEC-3AA5-11ED-8125-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After calling fsck_walk(), a tree object struct may be left in the
> parsed state, with the full tree contents available via tree->buffer.
> It's the responsibility of the caller to free these when it's done with
> the object to avoid having many trees allocated at once.
>
> In a regular "git fsck", we hit fsck_walk() only from fsck_obj(), which
> does call free_tree_buffer(). Likewise for "--connectivity-only", we see
> most objects via traverse_one_object(), which makes a similar call.
>
> The exception is in mark_unreachable_referents(). When using both
> "--connectivity-only" and "--dangling" (the latter of which is the
> default), we walk all of the unreachable objects, and there we forget to
> free. Most cases would not notice this, because they don't have a lot of
> unreachable objects, but you can make a pathological case like this:
>
>   git clone --bare /path/to/linux.git repo.git
>   cd repo.git
>   rm packed-refs ;# now everything is unreachable!
>   git fsck --connectivity-only
>
> That ends up with peak heap usage ~18GB, which is (not coincidentally)
> close to the size of all uncompressed trees in the repository. After
> this patch, the peak heap is only ~2GB.
>
> A few things to note:
>
>   - it might seem like fsck_walk(), if it is parsing the trees, should
>     be responsible for freeing them. But the situation is quite tricky.
>     In the non-connectivity mode, after we call fsck_walk() we then
>     proceed with fsck_object() which actually does the type-specific
>     sanity checks on the object contents. We do pass our own separate
>     buffer to fsck_object(), but there's a catch: our earlier call to
>     parse_object_buffer() may have attached that buffer to the object
>     struct! So by freeing it, we leave the rest of the code with a
>     dangling pointer.
>
>     Likewise, the call to fsck_walk() in index-pack is subtle. It
>     attaches a buffer to the tree object that must not be freed! And
>     so rather than calling free_tree_buffer(), it actually detaches it
>     by setting tree->buffer to NULL.
>
>     These cases would _probably_ be fixable by having fsck_walk() free
>     the tree buffer only when it was the one who allocated it via
>     parse_tree(). But that would still leave the callers responsible for
>     freeing other cases, so they wouldn't be simplified. While the
>     current semantics for fsck_walk() make it easy to accidentally leak
>     in new callers, at least they are simple to explain, and it's not a
>     function that's likely to get a lot of new call-sites.
>
>     And in any case, it's probably sensible to fix the leak first with
>     this simple patch, and try any more complicated refactoring
>     separately.
>
>   - a careful reader may notice that fsck_obj() also frees commit
>     buffers, but neither the call in traverse_one_object() nor the one
>     touched in this patch does so. And indeed, this is another problem
>     for --connectivity-only (and accounts for most of the 2GB heap after
>     this patch), but it's one we'll fix in a separate commit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index f7916f06ed..34e575a170 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -228,6 +228,8 @@ static void mark_unreachable_referents(const struct object_id *oid)
>  
>  	options.walk = mark_used;
>  	fsck_walk(obj, NULL, &options);
> +	if (obj->type == OBJ_TREE)
> +		free_tree_buffer((struct tree *)obj);
>  }

Unlike codepaths like mark_object(), which uses the REACHABLE bit to
avoid the walker coming into an already marked objects, we have no
protection that says "this tree is already marked as USED, so lets
not go into its contents" (it would be a disaster if we free tree
buffer here and then later end up calling the function on the same
tree), but it is OK because this is an unreachable object nobody
points at and we will never come back?
