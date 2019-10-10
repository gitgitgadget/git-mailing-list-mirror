Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCF91F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 02:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfJJCmL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 22:42:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52472 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfJJCmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 22:42:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB97A1AF82;
        Wed,  9 Oct 2019 22:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sy5QDyz8Sipnzfxd5b/0dPbjKYM=; b=NnT4An
        Vof8bHkIpsjTSbUNs/qQGWU0f3iMWfYRsKYu6vLxhTPfALDO3CaaFzT7kuiYe9Fy
        1lI0W4nj5DTTJJVaipcmelxL/X0VP6xbiQOTAKyyCqJItAAhWsy8Y5szVEdFrCKc
        k+7UoXHIhDI4BBEoSN0CSb93KvjnSMJyoHmgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LdAihIf2YamO2IM0YHBFn1MFCWMGyXw0
        WPMHCwvqnKVpJh7BGnbJYuUgQhZnpq+xlzeMh0xAjiLQvovwwvuY/7LTfEfEXKe8
        YoFcG7BAJpc0Eyzeq82ctYKw0b3QWtefiJ3Fxn5mghvCrIPMGsS4wG7EVJy+NFfh
        0pnuILrIKh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD82D1AF81;
        Wed,  9 Oct 2019 22:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECE431AF80;
        Wed,  9 Oct 2019 22:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git@vger.kernel.org, kernel-usp@googlegroups.com,
        rcdailey.lists@gmail.com, me@ttaylorr.com, peff@peff.net,
        matheus.bernardino@usp.br,
        =?utf-8?Q?B=C3=A1rbara?= Fernandes <barbara.dcf@gmail.com>
Subject: Re: [RFC WIP PATCH 1/3] tag: factor out tag reading from write_tag_body()
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
        <20191008184727.14337-2-lucasseikioshiro@gmail.com>
Date:   Thu, 10 Oct 2019 11:42:06 +0900
In-Reply-To: <20191008184727.14337-2-lucasseikioshiro@gmail.com> (Lucas
        Oshiro's message of "Tue, 8 Oct 2019 15:47:25 -0300")
Message-ID: <xmqqsgo1jp8h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D54BCD8-EB07-11E9-B6E5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Oshiro <lucasseikioshiro@gmail.com> writes:

> +/* 
> + * Returns the tag body of the given oid or NULL, in case of error. If size is
> + * not NULL it is assigned the body size in bytes (excluding the '\0').
> + */
> +static char *get_tag_body(const struct object_id *oid, size_t *size) 
>  {
> +	unsigned long buf_size;
>  	enum object_type type;
> +	char *buf, *sp, *tag_body;
> +	size_t tag_body_size, signature_offset;
>  
> +	buf = read_object_file(oid, &type, &buf_size);
>  	if (!buf)
> +		return NULL;
>  	/* skip header */
>  	sp = strstr(buf, "\n\n");
>  
> +	if (!sp || !buf_size || type != OBJ_TAG) {
>  		free(buf);
> +		return NULL;
>  	}

Returning early when !buf_size before even attempting to strstr
would be cleaner to read, i.e.

	buf = read_object_file(...);
	if (!buf || !buf_size) {
		free(buf);
		return NULL;
	}
	body = strstr(buf, "\n\n");

FWIW, the type check that is done after this point could also be a
part of the early return, as there is no point scanning for the end
of object header part if the object is not a tag (e.g. if it were a
blob, there is no "header part" and scanning for a blank line is
meaningless).
	
>  	sp += 2; /* skip the 2 LFs */
> +	signature_offset = parse_signature(sp, buf + buf_size - sp);
> +	sp[signature_offset] = '\0';
>  
> +	/* detach sp from buf */
> +	tag_body_size = strlen(sp) + 1;
> +	tag_body = xmalloc(tag_body_size);
> +	xsnprintf(tag_body, tag_body_size, "%s", sp);

Isn't this essentially

	tag_body = xstrdup(sp);
        tag_body_size = signature_offset;

(my arith may be off by one or two, but does a separate
tag_body_size need to exist?)

>  	free(buf);
> +	if (size)
> +		*size = tag_body_size - 1; /* exclude '\0' */
> +	return tag_body;
> +}
> +
> +static void write_tag_body(int fd, const struct object_id *oid)
> +{
> +	size_t size;
> +	const char *tag_body = get_tag_body(oid, &size);
> +
> +	if (!tag_body) {
> +		warning("failed to get tag body for %s", oid->hash);

I do not think the original gives any such warning.

 - Do we want to be unconditionally noisy this way?
 - Should this be a fatal error?  If not, why?
 - Should the message be translatable?

As an interface, is it sensible to force any and all callers of
get_tag_body() to supply a pointer to &size?  Is the returned value
always a NUL-terminated string?  I suspect that people would find it
a more natural interface if its were like:

	const char *body = get_tag_body(oid);

	if (!body)		
		...;

	if (this caller needs size) {
		size_t body_size = strlen(body);
		... use both body and body_size ...
		write_or_die(fd, body, body_size);
	} else {
		... just use body ...
		printf("%s", body);
	}
	
> +		return;
> +	}
> +	printf("tag_body: <%s>\n", tag_body);
> +	write_or_die(fd, tag_body, size);

WTH is this double writing?

>  }
>  
>  static int build_tag_object(struct strbuf *buf, int sign, struct object_id *result)
