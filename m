Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6B31FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdLHUOl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:14:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50479 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752464AbdLHUOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:14:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE0E0AC14E;
        Fri,  8 Dec 2017 15:14:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gq80PR6WtWH+ofS1FRKMZVgwsc4=; b=pXhgrF
        QroFeNgOWyo+VLDZkbH/qFpSeGZfxXILFhTQlmPZfFzF32yjhqd/SM4goKmAOyM/
        T8SqnSedHLF/nGygOfynHCDwDNSwUy/d9Y7Yn770MCrg+KoqQfbWD+nCvjx+rHD4
        u8zeLyJINpuEuwFmX7/S08oJB8JV2oBKZdSpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yMXtErVIDsm40KQwGwAs47Mbn3hRSwzO
        2PPOqMpoHFOWKn2dZ8DmSbo6dgdeMVbOJfqURRQhUc9BNCjbFfGhbKwqPu3Y41Kt
        Gl9115G8efGBsdc3epcsBq/LJ815yR183mCtWMwNq747fsfa2/GKsGgPWueHEnQo
        gxPSf21ke+w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3FB5AC14C;
        Fri,  8 Dec 2017 15:14:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DF1CAC14B;
        Fri,  8 Dec 2017 15:14:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] partial-clone: design doc
References: <20171208192636.13678-1-git@jeffhostetler.com>
        <20171208192636.13678-2-git@jeffhostetler.com>
Date:   Fri, 08 Dec 2017 12:14:37 -0800
In-Reply-To: <20171208192636.13678-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Fri, 8 Dec 2017 19:26:36 +0000")
Message-ID: <xmqqzi6t6kpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B2A6932-DC54-11E7-9257-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> First draft of design document for partial clone feature.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Thanks.

> +Non-Goals
> +---------
> +
> +Partial clone is independent of and not intended to conflict with
> +shallow-clone, refspec, or limited-ref mechanisms since these all operate
> +at the DAG level whereas partial clone and fetch works *within* the set
> +of commits already chosen for download.

It probably is not a huge deal (simply because it is about
"Non-Goals") but I have no idea what "refspec" and "limited-ref
mechanism" refer to in the above sentence, and I suspect many others
share the same puzzlement.

> +An object may be missing due to a partial clone or fetch, or missing due
> +to repository corruption. To differentiate these cases, the local
> +repository specially indicates packfiles obtained from the promisor
> +remote. These "promisor packfiles" consist of a "<name>.promisor" file
> +with arbitrary contents (like the "<name>.keep" files), in addition to
> +their "<name>.pack" and "<name>.idx" files. (In the future, this ability
> +may be extended to loose objects[a].)
> + ...
> +Foot Notes
> +----------
> +
> +[a] Remembering that loose objects are promisor objects is mainly
> +    important for trees, since they may refer to promisor blobs that
> +    the user does not have.  We do not need to mark loose blobs as
> +    promisor because they do not refer to other objects.

I fail to see any logical link between the "loose" and "tree".
Putting it differently, I do not see why "tree" is so special.

A promisor pack that contains a tree but lacks blobs the tree refers
to would be sufficient to let us remember that these missing blobs
are not corruption.  A loose commit or a tag that is somehow marked
as obtained from a promisor, if it can serve just like a commit or a
tag in a promisor pack to promise its direct pointee, would equally
be useful (if very inefficient).

In any case, I suspect "since they may refer to promisor blobs" is a
typo of "since they may refer to promised blobs".

> +- Currently, dynamic object fetching invokes fetch-pack for each item
> +  because most algorithms stumble upon a missing object and need to have
> +  it resolved before continuing their work.  This may incur significant
> +  overhead -- and multiple authentication requests -- if many objects are
> +  needed.
> +
> +  We need to investigate use of a long-running process, such as proposed
> +  in [5,6] to reduce process startup and overhead costs.

Also perhaps in some operations we can enumerate the objects we will
need upfront and ask for them in one go (e.g. "git log -p A..B" may
internally want to do "rev-list --objects A..B" to enumerate trees
and blobs that we may lack upfront).  I do not think having the
other side guess is a good idea, though.

> +- We currently only promisor packfiles.  We need to add support for
> +  promisor loose objects as described earlier.

The earlier description was not convincing enough to feel the need
to me; at least not yet.
