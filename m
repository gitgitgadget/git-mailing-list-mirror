Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095FC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiF3XWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiF3XWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:22:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00568599DA
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:22:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65FAE1A93B6;
        Thu, 30 Jun 2022 19:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SMXuY8Wl2Rez4fdYRtmpayYWg+mGMVOXgPgwyh
        M4jqA=; b=Rk56yzDpt2x7tcBbCutlwpP8PLQ2E+Sko8MAxobN34gPRywhcsTKze
        siBiC//2hhvijqcx+kshdAAqAzGDSSSd/PEAvM0AmTv04iPV4que3LtqEMnKT7ee
        RByFrFZZi/mNw/L9taygXf29zPtzFmG5aT+ecYPuv5degk0assues=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5ECE61A93B5;
        Thu, 30 Jun 2022 19:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE0471A93B3;
        Thu, 30 Jun 2022 19:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] ident: move commit_rewrite_person() to ident.c
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220630142444.651948-2-siddharthasthana31@gmail.com>
Date:   Thu, 30 Jun 2022 16:22:06 -0700
In-Reply-To: <20220630142444.651948-2-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 30 Jun 2022 19:54:42 +0530")
Message-ID: <xmqqo7y9buu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75CA9BF8-F8CB-11EC-865F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +/*
> + * Given a commit or tag object buffer, replaces the person's

I do not think you should refer to "or tag" at this point.  It is
not designed to be used by anything other than a commit, and nobody
passes a tag in the original code, or even after this patch is
applied.

> + * (author/committer/tagger) name and email with their canonical
> + * name and email using mailmap mechanism. Signals a success with

"using" -> "using the"

> + * 1 and failure with a 0.

I do not think 0 signals a failure.  If it makes changes, then the
function returns a non-zero value.  0 only indicates "we made no
modification to the buffer".

> +int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
> +{
> +	char *person, *endp;
> +	size_t len, namelen, maillen;
> +	const char *name;
> +	const char *mail;
> +	struct ident_split ident;
> +
> +	person = strstr(buf->buf, what);
> +	if (!person)
> +		return 0;

I do not think it is a good idea to expose this as a public function
as is, especially given that what you have to pass in "what" is a
bit awkward.  The function is designed to find and replace an ident
string in the header part, and the way it avoids a random occurence
of author Siddharth Asthana <si...@gmail.com> in the text, not
nececessarily in the header, is by insisting "author" to appear at
the beginning of line by passing "\nauthor " as "what".

Also as you can see, the implementation does not make *any* effort
to limit itself to the commit/tag header by locating the blank line
that appears after the header part and stopping the search there.
That may not be *your* bug, but should be fixed before exposing it
as a public function and inflicting its bug to more callers.

Also the interface forces the caller to make multiple calls if it
wants to rewrite idents on multiple headers.  It shouldn't be the
case.

To support the existing caller better, it should be updated to

 * take one or more header names (like "author", "committer"), make
   a single pass in the input buffer to locate these headers and
   replace idents on them;

 * stop at the end of header, ensuring that nothing in the body of
   the commit object is modified.

Alternatively, it may not be a bad idea to simplify the interface so
that _all_ headers are subject to be rewritten, without any need to
the "what" parameter.  If you want to go that route, then you would
probably have a loop over buf->buf that iterates one line at a time,
stopping at the first empty line that denotes the end of header. For
each line, you'd skip to the first SP that is past the header name,
see if split_ident_line() thinks the line it got indeed has an
ident, and use map_user() to the ident if it found.  Do that for
each line and you are done when you reached the end of the header.

Once we fix the external interface like so while being a static
function inside revision.c and update its two callers (which will
become just a single caller), we can move and expose it as a public
function.

Thanks.
