Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0970120A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbdASSkY (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:40:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55182 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753542AbdASSkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:40:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34967613AA;
        Thu, 19 Jan 2017 13:39:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wEYGNrwbHwKpxwZ1QLttE3D6BVM=; b=ppWOPZ
        AEnobXS20UejQR6E5XWNtLVZvwvgPWIKpcGHCfy0HEKyB5rC2NSupxjDE8V9DFB2
        vcK+UTtpqwsjk7G+aAjD/deYtiKoFUl/aoY9bLXZxntpcDGrSVUAe8NOKZoXlE+p
        RTfJGCSCtmTHfYnENSncAVRu+WvWyw8SkYnfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=og8y0bb//GLygAQIWAgDiKz5DYSDjU+q
        ijw9XbS7dj1CGGhFZb+8g5h8jBsKtKHBLkJEeSfMmQ6wrOl6OvcWsF8sEVe3QYap
        rWTeuVVEglvaxCqwPrluNOoZz1QDW1KwAsWe2PZEbKTf23GxOYQOVrP0+L9DScBu
        NGV6niZulcw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 290B0613A7;
        Thu, 19 Jan 2017 13:39:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F430613A1;
        Thu, 19 Jan 2017 13:39:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
References: <20170119150347.3484-1-stefanha@redhat.com>
        <20170119150347.3484-2-stefanha@redhat.com>
Date:   Thu, 19 Jan 2017 10:39:02 -0800
In-Reply-To: <20170119150347.3484-2-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Thu, 19 Jan 2017 15:03:46 +0000")
Message-ID: <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D17B59A-DE76-11E6-A280-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> git-grep(1) output does not follow git's own syntax:
>
>   $ git grep malloc v2.9.3:
>   v2.9.3::Makefile:       COMPAT_CFLAGS += -Icompat/nedmalloc
>   $ git show v2.9.3::Makefile
>   fatal: Path ':Makefile' does not exist in 'v2.9.3'
>
> This patch avoids emitting the unnecessary ':' delimiter if the name
> already ends with ':' or '/':
>
>   $ git grep malloc v2.9.3:
>   v2.9.3:Makefile:       COMPAT_CFLAGS += -Icompat/nedmalloc
>   $ git show v2.9.3:Makefile
>   (succeeds)

I am mildly negative on this one.  I suspect that the above example
is a made-up one and you might have a more compelling real-world use
case in mind, but at least the above does not convince me.

The end-user explicitly gave the extra ':' because she wanted to
feed the tree object, not a tag that leads to the tree, for some
reason.  I think the output should respect that and show how she
spelled the starting point.  IOW, it is not "':' added unnecessarily
by Git".  It is ':' added by the end-user for whatever reason.

>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  builtin/grep.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 462e607..3643d8a 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -490,7 +490,11 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>  		strbuf_init(&base, PATH_MAX + len + 1);
>  		if (len) {
>  			strbuf_add(&base, name, len);
> -			strbuf_addch(&base, ':');
> +
> +			/* Add a delimiter if there isn't one already */
> +			if (name[len - 1] != '/' && name[len - 1] != ':') {
> +				strbuf_addch(&base, ':');
> +			}
>  		}
>  		init_tree_desc(&tree, data, size);
>  		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
