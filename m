Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399D620899
	for <e@80x24.org>; Thu, 27 Jul 2017 19:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdG0TRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 15:17:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751461AbdG0TRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 15:17:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0086B9FD77;
        Thu, 27 Jul 2017 15:17:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6uH2Rcs7vSNwlElspxqZP6F+R+0=; b=WoP22X
        4PO/IcVgB0Dv0u6IQPCOLOvx9OpTzHxdJcDRsUCSTsFi48i5QFIGj83JGXVddBgX
        VwFJm4MRawW4lCNwnlHMy5fWdpTsq+O/a70aCiMbKcJrAfqXkykBp8DynbJigf/p
        aTnlyetTdfXJ389Bu5k7J/S1FsQEDSiX0SvJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uu0cioMFrcquBptxRkrcA+aTt/y2LH4x
        cHntWbBlqouZzXpVZW4XK9qDX2frKbvNsPK4XzeUqFPlmvcXmGfwLWU+wyKpLB+r
        XilQ35It5Pd//tdjKJv9zLOv2ZntVBqBbW3PsYo0JDK+YyjsHeeMXoPl/+VWQlrS
        /tYI4JpGaTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED3E39FD75;
        Thu, 27 Jul 2017 15:17:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61B219FD74;
        Thu, 27 Jul 2017 15:17:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 3/4] fsck: support referenced lazy objects
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
Date:   Thu, 27 Jul 2017 12:17:37 -0700
In-Reply-To: <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 26 Jul 2017 16:30:01 -0700")
Message-ID: <xmqqpocln0z2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40E6BAD0-7300-11E7-84BA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach fsck to not treat missing objects indirectly pointed to by refs as
> an error when extensions.lazyobject is set.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fsck.c         | 11 +++++++++++
>  t/t0410-lazy-object.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index e29ff760b..238532cc2 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
>  		return 0;
>  	obj->flags |= REACHABLE;
>  	if (!(obj->flags & HAS_OBJ)) {
> +		if (repository_format_lazy_object)
> +			/*
> +			 * Return immediately; this is not an error, and further
> +			 * recursion does not need to be performed on this
> +			 * object since it is missing (so it does not need to be
> +			 * added to "pending").
> +			 */
> +			return 0;
> +

The same comment as 2/4 applies here.

> @@ -212,6 +221,8 @@ static void check_reachable_object(struct object *obj)
>  	 * do a full fsck
>  	 */
>  	if (!(obj->flags & HAS_OBJ)) {
> +		if (repository_format_lazy_object)
> +			return;
>  		if (has_sha1_pack(obj->oid.hash))
>  			return; /* it is in pack - forget about it */
>  		printf("missing %s %s\n", printable_type(obj),

Also this reminds as a related issue.  Imagine:

 - An object X was once retrieved, perhaps but not necessarily
   lazily, together with another object Y that is referred to by X
   (e.g. X is a tree, Y is a blob in the directory at path D, which
   is represented by X).

 - The same blob Y is added to the index in a different directory at
   path E.

 - The user decides to make this a slimmed-down "narrow clone" style
   repository and tells Git that path D is not interesting.  We lose
   X, but not Y because Y is still referenced from the index.

 - "git reset --hard" happens, and there no longer is any reference
   to Y.

Now, when we run fsck, should we diagnose Y as "unreachable and/or
dangling"?
