Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951AC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DB1613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhEEByn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 21:54:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50353 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhEEBym (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 21:54:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E70B11A667;
        Tue,  4 May 2021 21:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RFqofhndYm1YvXzD52wHWWG2fFghcwFX/fEaHg
        0gULQ=; b=GJotKjQ1YLH0F4VBBOlQfdyiJyOGkGbnyZwx/U5ZhHsArzrfzoPYPn
        UFO3BEYZZ8jir5CnCow8lMQxn0p6bKp6rXSG14NZ0qa1SRfhfqQ3MOkCQcXgN/Iq
        VvtQj8JRvzIgyjscyBb+iXmTdyBD5NRMPO3i1rCoYT/oZBoEUEuGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0731E11A666;
        Tue,  4 May 2021 21:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2BF111A665;
        Tue,  4 May 2021 21:53:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v2 4/5] fetch: teach independent negotiation (no packfile)
References: <cover.1617929278.git.jonathantanmy@google.com>
        <cover.1620162764.git.jonathantanmy@google.com>
        <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
Date:   Wed, 05 May 2021 10:53:40 +0900
In-Reply-To: <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 4 May 2021 14:16:01 -0700")
Message-ID: <xmqq4kfi54kb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7ECF982-AD44-11EB-ADAD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +static int add_to_object_array(const struct object_id *oid, void *data)
> +{
> +	struct object_array *a = data;
> +
> +	add_object_array(lookup_object(the_repository, oid), "", a);

Moving to lookup_object() made me look around, but at this point the
object in question (which comes from the negotiation_tips) has been
instantiated, so it is OK.

    Side note. The big difference between lookup and parse is what
    happens when this process hasn't seen the object yet---the
    former will just return NULL instead of instantiating the
    in-core copy; for that reason, it is easier on the readers to
    use parse_object() if we know we want an in-core object *and*
    when we use it we want to see it parsed already).

> +static void clear_common_flag(struct oidset *s)
> +{
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +	oidset_iter_init(s, &iter);
> +
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct object *obj = lookup_object(the_repository, oid);

This one obviously is OK ;-)  The fact we are clearing by definition
means we already do have in-core objects.

> +		obj->flags &= ~COMMON;
> +	}
> +}

Thanks.
