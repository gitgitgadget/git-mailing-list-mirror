Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329ECC43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B6923122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407018AbhALVhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62161 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436904AbhALUXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:23:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1820DFFED8;
        Tue, 12 Jan 2021 15:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7c4GP/nBP4RCxftexq/GkCcDQKQ=; b=ivPlXz
        dwOLbZQG7qoJr6E+t6AY9b/hcnC795KWwR1fuXMbNX5znZAcnZXv9mNcb9p8jZrP
        dyfhgYeHtU4LTJ3LMPg+qUfC5xorI//OSa/UQLNxvVoj/uz0k30htvg55dd4TkXz
        r3WxpE6DsSvPzsobQYlNW9a3kDyp6R7Sz1llE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G9vPKcZN3Hok9FfApq+Wz2tXzG2SItjH
        3z0fIdcRNvSUYINEGG5PX/vY8KwOVAkdo255yWY5geltNxx9xTUerehQp82GX78j
        ZME/QrH7hF4ysvGklDUijubEQFlunoRZnJV9vwmmZFg2q2RbSBBsjV78HEx7jgar
        /bPl5vYU3aw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11276FFED7;
        Tue, 12 Jan 2021 15:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38335FFED6;
        Tue, 12 Jan 2021 15:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: refactor writing promisor file
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
        <20210112082159.2277214-2-chriscool@tuxfamily.org>
Date:   Tue, 12 Jan 2021 12:22:26 -0800
In-Reply-To: <20210112082159.2277214-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Jan 2021 09:21:59 +0100")
Message-ID: <xmqq1rep52il.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3F96170-5513-11EB-A841-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Let's replace the 2 different pieces of code that write a
> promisor file in 'builtin/repack.c' and 'fetch-pack.c'
> with a new function called 'write_promisor_file()' in
> 'pack-write.c' and 'pack.h'.
>
> This might also help us in the future, if we want to put
> back the ref names and associated hashes that were in
> the promisor files we are repacking in 'builtin/repack.c'
> as suggested by a NEEDSWORK comment just above the code
> we are refactoring.

As soon as you say "might", my reading goes "Meh", but the real
issue/question I have about this is 

> +void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> +{
> +	int i;
> +	FILE *output = xfopen(promisor_name, "w");
> +
> +	for (i = 0; i < nr_sought; i++)
> +		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> +			sought[i]->name);
> +	fclose(output);
> +}

If this function is so useful to be factored out, it must have
potential use cases where callers would want to write out the
promisor file [*1*].  Is it reasonable to assume that all of these
callers have an array of refs, or even _know_ about what "ref" is?
There still is just one "real" caller to this helper after this
patch, so it is too early to tell.

Seeing that the declaration (below) is made in <pack.h>, I think it
is fair to assume all the callers would know what "struct oid" is,
but I do not get the feeling that "an array of ='struct ref' pointers"
is something we can expect callers to have commonly.  And expecting
and/or requiring the potential callers to have its data in an unusual
shape would be a barrier for the helper's adoption.

Let's not do this change (yet) before we see a new potential caller
or two and know what kind of API they want this helper to have.
Without knowing them, my gut reaction is that it would be more
widely usable if it took an array of "struct object_id" pointers,
but if we make this function to take "struct object_id **sought"
plus "int nr_sought", it would mean that the only real caller that
currently exists needs to prepare a separate array out of the array
of "struct ref" poihtners it has.  That is way too premature
generalization.


> diff --git a/pack.h b/pack.h
> index 9fc0945ac9..9ae640f417 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -87,6 +87,10 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
>  void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
>  char *index_pack_lockfile(int fd);
>  
> +struct ref;
> +
> +void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
> +
>  /*
>   * The "hdr" output buffer should be at least this big, which will handle sizes
>   * up to 2^67.


[Footnote]

*1* The "we just make sure the file exists by calling this function
with no information about any objects" case I do not count as an
interesting caller---it could just have been done with a simple
"touch".


