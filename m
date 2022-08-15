Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1851EC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 05:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiHOFcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFcT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 01:32:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E471582B
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 22:32:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57D30198224;
        Mon, 15 Aug 2022 01:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=c2G8YP2N2Jgs/3k568TqftAI/DNgf3dEjJAZgBWJfXo=; b=TnjB
        gYjhHAXoJYD77eG2Jo86hgXv34ZGdFbIS9dV4M+OvuWWYm6BkgDBl/FESHmnSKEe
        FWVdJBBkkaFyqrDZRNTZu9DILt/RwgiUFtqE03eKYWKa0hNftMt6hjE3LnQth9LL
        QTzwy2L0MUuJWF0z4IiWaz6xuKvmE3zb2WAq0Xk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50C13198223;
        Mon, 15 Aug 2022 01:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01F0519821F;
        Mon, 15 Aug 2022 01:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Olsen <andrew.olsen@koordinates.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] is_promisor_object(): fix use-after-free of tree buffer
References: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
        <YvS50W6wku5Y/NC7@coredump.intra.peff.net>
        <YviWO9Bhz5PU1HaL@coredump.intra.peff.net>
Date:   Sun, 14 Aug 2022 22:32:12 -0700
Message-ID: <xmqqmtc63wdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E34D32A-1C5B-11ED-BDCD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This can happen during a "rev-list --missing=allow-promisor" traversal
> in a partial clone that is missing one or more trees or blobs. The
> backtrace for the free looks like this:
>
>       #1 free_tree_buffer tree.c:147
>       #2 add_promisor_object packfile.c:2250
>       #3 for_each_object_in_pack packfile.c:2190
>       #4 for_each_packed_object packfile.c:2215
>       #5 is_promisor_object packfile.c:2272
>       #6 finish_object__ma builtin/rev-list.c:245
>       #7 finish_object builtin/rev-list.c:261
>       #8 show_object builtin/rev-list.c:274
>       #9 process_blob list-objects.c:63
>       #10 process_tree_contents list-objects.c:145
>       #11 process_tree list-objects.c:201
>       #12 traverse_trees_and_blobs list-objects.c:344
>       [...]
>
> We're in the middle of walking through the entries of a tree object via
> process_tree_contents(). We see a blob (or it could even be another tree
> entry) that we don't have, so we call is_promisor_object() to check it.
> That function loops over all of the objects in the promisor packfile,
> including the tree we're currently walking.

I forgot that the above "loops over" happens only once to populate
the oidset hashtable, and briefly wondered if we are being grossly
inefficient by scanning pack .idx file each time we encounter a
missing object.  "Upon first call, that function loops over
... walking, to prepare a hashtable to answer if any object id is
referred to by an object in promisor packs" would have helped ;-). 

> It may also be a good direction for this function in general, as there
> are other possible optimizations that rely on doing some analysis before
> parsing:
>
>   - we could detect blobs and avoid reading their contents; they can't
>     link to other objects, but parse_object() doesn't know that we don't
>     care about checking their hashes.
>
>   - we could avoid allocating object structs entirely for most objects
>     (since we really only need them in the oidset), which would save
>     some memory.
>
>   - promisor commits could use the commit-graph rather than loading the
>     object from disk
>
> This commit doesn't do any of those optimizations, but I think it argues
> that this direction is reasonable, rather than relying on parse_object()
> and trying to teach it to give us more information about whether it
> parsed.

Yeah, all of the future bits sound sensible. 

Will queue.

Thanks.
