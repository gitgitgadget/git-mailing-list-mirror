Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56DB51F5A1
	for <e@80x24.org>; Wed, 13 Nov 2019 02:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKMCuy (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:50:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfKMCuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:50:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ABC49908F;
        Tue, 12 Nov 2019 21:50:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IZ/H3/hlk1HcZtRZx5WqXXC3Wu8=; b=Ggw1gq
        1KHbNVHtEu+pepBRIgAwbaiKt7QY18QDpd7bO2QyiuemJlUVSuuYOXA8gCtyqhNT
        3Kj+v5yWRFIIIpxKhkI6RW2kdmUC7BND4EbNENbHCFx2+f0Cx1MhPDb+nqixjQzN
        X8o2bLGjPPef7Kj+/ITqy4IhxUahs/hAkcruc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4fnXBgHOwaJ1rkjHeoXtpOnWw75O6Fk
        pqYmUih4xEE55SIcJ6GZkd20vk+4W1QmLxJeZIHbmBfSfG2COeN8A9F7f53iOCru
        kX++doF31sjf2XuAWS3jBQGI/PCB5B4WOscGkJHC+IHWiA39j6YcAjcSpyBkq+BB
        wHELP2a+B2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54B7C9908E;
        Tue, 12 Nov 2019 21:50:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 842AC9908D;
        Tue, 12 Nov 2019 21:50:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] clone: remove fetch_if_missing=0
References: <cover.1573604516.git.jonathantanmy@google.com>
        <84d8cee52e7c1dc030826c8caa0e107f80783b9c.1573604516.git.jonathantanmy@google.com>
Date:   Wed, 13 Nov 2019 11:50:47 +0900
In-Reply-To: <84d8cee52e7c1dc030826c8caa0e107f80783b9c.1573604516.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 12 Nov 2019 16:34:19 -0800")
Message-ID: <xmqqtv78bibc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 664010BA-05C0-11EA-885B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/connected.c b/connected.c
> index 36c4e5dedb..c337f5f7f4 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -62,7 +62,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		 * received the objects pointed to by each wanted ref.
>  		 */
>  		do {
> -			if (!repo_has_object_file(the_repository, &oid))
> +			if (!repo_has_object_file_with_flags(the_repository, &oid,
> +							     OBJECT_INFO_SKIP_FETCH_OBJECT))

Wow, good find.  Really good find.  I guess the exercise to see if
we can get rid of (or at least use less of) the big knob was a good
idea.

Thanks, will queue.


>  				return 1;
>  		} while (!fn(cb_data, &oid));
>  		return 0;
