Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B241F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfIER4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:56:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59046 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfIER4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:56:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D7C08439E;
        Thu,  5 Sep 2019 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vc3qzOXJujVa3BO/aHrRQh0nIQE=; b=xZ7atD
        6Q6mLYaaEdjlivyTeVCYDR13SG5zM5C2M6TJ03GPPH2sFQ8gj/EwUo2Xq2GP/ZGL
        ebbYvT1mx3qHkgNIYeRN1VT7lQbxbuKg1AWtUbONvhEJ5shznlygWyTHfxXH05Ma
        7CfEgFI9Yna3kURvUuHiHN0qbr8mGFqIpbq6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oFqK+vmT0//na398CXuY7QFm7psDilnA
        tajnkKzZf5tJsD5Eo8N2G1ZufhCVXOxxhTwy/TPjAw7lsEu9biSMvy2rx558U787
        uZpd2/AYJqPKkAcPfhFQX7yGw5hwTb24cJQOkopL32fbZ/Cz4O4I8Z+RVO9oAE04
        VfWRp/jZ78o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FCE58439D;
        Thu,  5 Sep 2019 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72FB28433E;
        Thu,  5 Sep 2019 13:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
References: <20190905082459.26816-1-s-beyer@gmx.net>
Date:   Thu, 05 Sep 2019 10:56:12 -0700
In-Reply-To: <20190905082459.26816-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Thu, 5 Sep 2019 10:24:59 +0200")
Message-ID: <xmqqd0ger5j7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73EE8CE0-D006-11E9-A27C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 7e79b555de..ef0963e2f4 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -4,7 +4,7 @@
>
>  int cmd__read_cache(int argc, const char **argv)
>  {
> -	int i, cnt = 1, namelen;
> +	int i, cnt = 1, namelen = 0;
>  	const char *name = NULL;
>
>  	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
		namelen = strlen(name);

The above is the only assignment to namelen in this function, and
namelen is used like so:

		if (name) {
			...
			pos = index_name_pos(&the_index, name, namelen);

So somebody does not realize that skip_prefix() returns true only
when it touches name.  But skip_prefix() is inline and visible to
the compiler, and it is quite clear that name is only touched when 
the function returns non-zero.

static inline int skip_prefix(const char *str, const char *prefix,
			      const char **out)
{
	do {
		if (!*prefix) {
			*out = str;
			return 1;
		}
	} while (*str++ == *prefix++);
	return 0;
}

So it looks like it is another case of compiler getting confused.
