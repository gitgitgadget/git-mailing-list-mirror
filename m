Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03931C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC50A6115A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhHYQcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:32:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59579 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbhHYQcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 12:32:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 897DB14CE88;
        Wed, 25 Aug 2021 12:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8qXju+7i7YbZOWB9P7IWjxrJAqA8l5mJSYtLrLbgnVo=; b=wXsA
        04VIc4VMRbvENWhvK8Q8ECO1JrfbTkEJ4fSY+Ji252eJ/22ahxXJufjseAXnXVp/
        xLO4mryC23p2vDSb4VOdZTtgLoGl0/skpF3b36NK3/R+7kkoshDZ4F8vWs19dsrE
        dumoFK+Fub6Ods+QKGXoFuNMIM0/N54F7bOMHvc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8194D14CE87;
        Wed, 25 Aug 2021 12:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C385D14CE85;
        Wed, 25 Aug 2021 12:32:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
Date:   Wed, 25 Aug 2021 09:31:59 -0700
Message-ID: <xmqqeeahjxj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9B9B276-05C1-11EC-8F84-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We feed the encoding "HTML" to iconv_open(), which of course has no idea
> what that is. It's unfortunate, though, that we don't even print a
> warning, and instead just quietly leave the text intact. I wonder if we
> should do something like:
>
> diff --git a/pretty.c b/pretty.c
> index 535eb97fa6..708b618cfe 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -672,7 +672,11 @@ const char *repo_logmsg_reencode(struct repository *r,
>  	 * If the re-encoding failed, out might be NULL here; in that
>  	 * case we just return the commit message verbatim.
>  	 */
> -	return out ? out : msg;
> +	if (!out) {
> +		warning("unable to reencode commit to '%s'", output_encoding);
> +		return msg;
> +	}
> +	return out;
>  }
>  
>  static int mailmap_name(const char **email, size_t *email_len,

This addition sounds quite sensible to me.

"git log --encoding=bogus" would issue this warning for each and
every commit and that may be a bit irritating, but being irritating
may be a good characteristic for a warning message that is given to
an easily correctable condition.

I originally thought that the warning would be lost to the pager,
but apparently I forgot what I did eons ago at 61b80509 (sending
errors to stdout under $PAGER, 2008-02-16) ;-).
