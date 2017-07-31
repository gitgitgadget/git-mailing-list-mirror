Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1801F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdGaV3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:29:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57689 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751017AbdGaV3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:29:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E406CA638E;
        Mon, 31 Jul 2017 17:29:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uUy0uzjgBZgVGm9Z6BH8MnA/DOk=; b=dVOr3V
        i8WdcIlCq8cWoEv3karEtkHOM8S6sAf02NMw5fCNpa9GvHkFYZyRnCc7rqIC9EHW
        fwXHEMyjob8SlRX9GEf/xdgAdJoxv2ZVKklslSurTU/oL6aqoib4Xrhl6CKgKRS1
        JDgQjb/xJtPHePpfoa6kTOitudE34a5fMHmSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPeHptHRyc5Xgm6JBf8OllHRugQP1bsG
        rNhYb5XTGXyCa+XfaKSQkGuQS9OxtN1468RA4D7k/n+W/9U4HY3V0qgYtB3OCZFl
        CzwMg/ZHqtmgH3bsDpCNITP7HcUF6pFeLLEdI+INEjO7IYM1W+f0+CYMpicaxlMf
        +NyyEc9HkNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC7BDA638C;
        Mon, 31 Jul 2017 17:29:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33817A6389;
        Mon, 31 Jul 2017 17:29:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 5/5] sha1_file: support loading lazy objects
References: <cover.1501532294.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com>
Date:   Mon, 31 Jul 2017 14:29:21 -0700
In-Reply-To: <eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 31 Jul 2017 14:02:47 -0700")
Message-ID: <xmqqzibkgury.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 523A5D52-7637-11E7-9442-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach sha1_file to invoke the command configured in
> extensions.lazyObject whenever an object is requested and unavailable.
>
> The usage of the hook can be suppressed through a flag when invoking
> has_object_file_with_flags() and other similar functions.
>
> This is meant as a temporary measure to ensure that all Git commands
> work in such a situation. Future patches will update some commands to
> either tolerate missing objects (without invoking the command) or be
> more efficient in invoking this command.
>
> In order to determine the code changes in sha1_file.c necessary, I
> investigated the following:
>  (1) functions in sha1_file that take in a hash, without the user
>      regarding how the object is stored (loose or packed)
>  (2) functions in sha1_file that operate on packed objects (because I
>      need to check callers that know about the loose/packed distinction
>      and operate on both differently, and ensure that they can handle
>      the concept of objects that are neither loose nor packed)
>
> (1) is handled by the modification to sha1_object_info_extended().
>
> For (2), I looked at for_each_packed_object and at the packed-related
> functions that take in a hash. For for_each_packed_object, the callers
> either already work or are fixed in this patch:
>  - reachable - only to find recent objects
>  - builtin/fsck - already knows about missing objects
>  - builtin/cat-file - warning message added in this commit
>
> Callers of the other functions do not need to be changed:
>  - parse_pack_index
>    - http - indirectly from http_get_info_packs
>  - find_pack_entry_one
>    - this searches a single pack that is provided as an argument; the
>      caller already knows (through other means) that the sought object
>      is in a specific pack
>  - find_sha1_pack
>    - fast-import - appears to be an optimization to not store a
>      file if it is already in a pack
>    - http-walker - to search through a struct alt_base
>    - http-push - to search through remote packs
>  - has_sha1_pack
>    - builtin/fsck - already knows about promised objects
>    - builtin/count-objects - informational purposes only (check if loose
>      object is also packed)
>    - builtin/prune-packed - check if object to be pruned is packed (if
>      not, don't prune it)
>    - revision - used to exclude packed objects if requested by user
>    - diff - just for optimization
>
> An alternative design that I considered but rejected:
>
>  - Adding a hook whenever a packed object is requested, not on any
>    object.  That is, whenever we attempt to search the packfiles for an
>    object, if it is missing (from the packfiles and from the loose
>    object storage), to invoke the hook (which must then store it as a
>    packfile), open the packfile the hook generated, and report that the
>    object is found in that new packfile. This reduces the amount of
>    analysis needed (in that we only need to look at how packed objects
>    are handled), but requires that the hook generate packfiles (or for
>    sha1_file to pack whatever loose objects are generated), creating one
>    packfile for each missing object and potentially very many packfiles
>    that must be linearly searched. This may be tolerable now for repos
>    that only have a few missing objects (for example, repos that only
>    want to exclude large blobs), and might be tolerable in the future if
>    we have batching support for the most commonly used commands, but is
>    not tolerable now for repos that exclude a large amount of objects.
>
> Helped-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Even though I said a hugely negative thing about the "missing
objects are always OK" butchering of fsck, I do like what this patch
does.  The interface is reasonably well isolated, and moving of the
long-running-process documentation to a standalone file is very
sensible.

