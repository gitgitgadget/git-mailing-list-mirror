Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002D51F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 04:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfJHEKX (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 00:10:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51094 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHEKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 00:10:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82ED399763;
        Tue,  8 Oct 2019 00:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cpni2hbPqPOjmIq7s70H3bV7i6w=; b=XHIYSq
        cJdMde66o3ySi394k/sC5JfGFu0wuCP/Z/IjqEfvjREXbyZ/AFoBq3rhYG6f8Wuo
        mq8tZgQTsKA9TNW2axw64ZJhQAr4SXtUim5aC8jpwuo2a05KpNRk+LGPlLJ0Jg8z
        1MGJRgAfubkrRRHbm/vAVYLN1kVribSY93U3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CpWJyJ7cAykICmVDbvmBzuDsxCOUpe1F
        /kML3VEUxuXijn3I0/k55C8MLQ5ra/2fB4JtHvAf/SL6asHZrrDJIX93oLZjusDd
        Xt0MU5s1fKSNQ9brHY7yM98++8ROxhGA866I0OjB1ZprsG6OiGNqXWX2FAcok9jS
        vTu4EtJydvg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CAF299761;
        Tue,  8 Oct 2019 00:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE94399760;
        Tue,  8 Oct 2019 00:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-pack: never fetch when checking exclusions
References: <20191007213839.233451-1-jonathantanmy@google.com>
Date:   Tue, 08 Oct 2019 13:10:17 +0900
In-Reply-To: <20191007213839.233451-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 7 Oct 2019 14:38:39 -0700")
Message-ID: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A9FC438-E981-11E9-8E1A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When building the packfile to be sent, send_pack() is given a list of
> remote refs to be used as exclusions. For each ref, it first checks if
> the ref exists locally, and if it does, passes it with a "^" prefix to
> pack-objects. However, in a partial clone, the check may trigger a lazy
> fetch. Ensure that this lazy fetch does not occur.

Is there any effect worth describing here, other than the obvious
"we do not lazily fetch from within the has_object_file() function"?

For example, would this change mean that the resulting pack may
include stuff that are reachable from the (missing) negative objects
that would not otherwise have to be sent if these objects were
available (or made available by the lazy fetching), and we are
making a trade-off to send possibly more in order for not fetching?
Have we laid enough on the table to help readers if such a trade-off
(if we are making one, that is) strikes the right balance?

Thanks.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  send-pack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index 6dc16c3211..34c77cbb1a 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -40,7 +40,8 @@ int option_parse_push_signed(const struct option *opt,
>  
>  static void feed_object(const struct object_id *oid, FILE *fh, int negative)
>  {
> -	if (negative && !has_object_file(oid))
> +	if (negative &&
> +	    !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
>  		return;
>  
>  	if (negative)
