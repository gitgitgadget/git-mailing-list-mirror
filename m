Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F5F1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbfIMViB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:38:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63382 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfIMViB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:38:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF1772F01A;
        Fri, 13 Sep 2019 17:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hlw/q5TKtUstpRP8PS9eqWLIkh8=; b=c8PELE
        jQYBuhzRJMPmmSIDXM+W+VPcDn434yJ76IThi+E7C5aXZvxKzw8XwBkUUuMIKWaE
        Sa9IuSPA9PXoHThj0xHBcJZMhnlPXgDjJDWw+sygDXqG8Pem9sE+9rpFnCzqYQhU
        KDT/C9+rEfsQLhSpck9kWLCpFV5o1A99sBdNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PTA69x6139h2yd3GxUQYdB/4j6dbdYeH
        CkxuAaIm0U6VOxdqWCFQHfFFTN4RU/r3KeTKOdhn4+IN8VLkuY1bWxrSvpf+YGMM
        dLgu5ffWJ88uG9QYLR9nlsnOhTU1+FSnkt6Y/PJXUz4O7ah2OANngJL7REuvyaUj
        QwqNo2ghNT4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C69D92F019;
        Fri, 13 Sep 2019 17:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3991E2F018;
        Fri, 13 Sep 2019 17:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 08/10] pack-objects: introduce pack.allowPackReuse
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
        <20190913130226.7449-9-chriscool@tuxfamily.org>
Date:   Fri, 13 Sep 2019 14:37:54 -0700
In-Reply-To: <20190913130226.7449-9-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 13 Sep 2019 15:02:24 +0200")
Message-ID: <xmqqd0g3dgi5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF1BC6B0-D66E-11E9-A75B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Let's make it possible to configure if we want pack reuse or not.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/pack-objects.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c11b2ea8d4..1664969c97 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -96,6 +96,7 @@ static off_t reuse_packfile_offset;
>  
>  static int use_bitmap_index_default = 1;
>  static int use_bitmap_index = -1;
> +static int allow_pack_reuse = 1;
>  static enum {
>  	WRITE_BITMAP_FALSE = 0,
>  	WRITE_BITMAP_QUIET,
> @@ -2719,6 +2720,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  		sparse = git_config_bool(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "pack.allowpackreuse")) {
> +		allow_pack_reuse = git_config_bool(k, v);
> +		return 0;
> +	}
>  	if (!strcmp(k, "pack.threads")) {
>  		delta_search_threads = git_config_int(k, v);
>  		if (delta_search_threads < 0)
> @@ -3063,7 +3068,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
>  	if (!(bitmap_git = prepare_bitmap_walk(revs)))
>  		return -1;
>  
> -	if (pack_options_allow_reuse() &&
> +	if (allow_pack_reuse &&
> +	    pack_options_allow_reuse() &&

It somehow looks strange to have this code check for both
allow_pack_reuse and pack_options_allow_reuse().  I would have
expected that the referene to the new variable to be contained in
the existing helper function, so that any future code that wants to
ask "are we allowed to reuse?" would get the same answer from the
helper consistently, without having to check the new variable.

>  	    !reuse_partial_packfile_from_bitmap(
>  			bitmap_git,
>  			&reuse_packfile,
