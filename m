From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 23:34:42 -0700
Message-ID: <xmqqbn3m7n25.fsf@gitster.mtv.corp.google.com>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 08:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dGl-0008KF-PW
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbcEaGex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:34:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291AbcEaGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:34:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D5DA19C07;
	Tue, 31 May 2016 02:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJlm4wDcDjqYm81Qr8lmjJtxF3o=; b=Kiohey
	uPMvqq6tI9g4dGPv9joITfhH6spsy2y1jmqIGOseMJWthrpQKEU3qlZTdMouIqUz
	MoZr9EvStIPC7yxsOcrBTs63Nl2+Mc63FQB1nsB2WEC0RTAbxD4X0TDE/btvPXJG
	MZmJxa97oVXZ0QzY8A1wRuYpyOA50xe+H6qF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WX5XX/r0F5y79nD+29/uCmDGvTLf7+31
	Wg6gCh7VMBOvqIMgnlxggnfXnufbnQmpblgQ6ceP07nYDyRtHluHSVDHVYa0B9Cj
	osh3QCBtlYXcfKLxCsaH5NYpCX5mwp0LjAxhtW9+nds4znVmU+z6BLMFmccQoWXh
	xiiHoKXsFoY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4456419C06;
	Tue, 31 May 2016 02:34:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B358519C05;
	Tue, 31 May 2016 02:34:43 -0400 (EDT)
In-Reply-To: <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 30 May 2016 12:36:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2CA374C-26F9-11E6-BCF9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295957>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> The API contract is still respected:
>
> - The API users may peek strbuf.buf in-place until they perform an
>   operation that makes it longer (at which point the .buf pointer
>   may point at a new piece of memory).

I think the contract is actually a bit stronger; the API reserves
the right to free and reallocate a smaller chunk of memory if you
make the string shorter, so peeked value of .buf will not be relied
upon even if you didn't make it longer.

> - The API users may strbuf_detach() to obtain a piece of memory that
>   belongs to them (at which point the strbuf becomes empty), hence
>   needs to be freed by the callers.

Shouldn't you be honuoring another API contract?

 - If you allow an instance of strbuf go out of scope without taking
   the ownership of the string by calling strbuf_detach(), you must
   release the resource by calling strbuf_release().

As long as your "on stack strbuf" allows lengthening the string
beyond the initial allocation (i.e. .alloc, not .len), the user of
the API (i.e. the one that placed the strbuf on its stack) would not
know when the implementation (i.e. the code in this patch) decides
to switch to allocated memory, so it must call strbuf_release()
before it leaves.  Which in turn means that your implementation of
strbuf_release() must be prepared to be take a strbuf that still has
its string on the stack.

On the other hand, if your "on stack strbuf" does not allow
lengthening, I'd find such a "feature" pretty much useless.  The
caller must always test the remaining capacity, and switch to a
dynamic strbuf, which is something the caller would expect the API
implementation to handle silently.  You obviously do not have to
release the resource in such a case, but that is being convenient
in the wrong part of the API.

It would be wonderful if I can do:

	void func (void)
        {
		extern void use(char *[2]);
		/*
                 * strbuf that uses 1024-byte on-stack buffer
                 * initially, but it may be extended dynamically.
                 */
		struct strbuf buf = STRBUF_INIT_ON_STACK(1024);
		char *x[2];

		strbuf_add(&buf, ...); /* add a lot of stuff */
                x[0] = strbuf_detach(&buf, NULL);
		strbuf_add(&buf, ...); /* do some stuff */
                x[1] = strbuf_detach(&buf, NULL);
		use(x);

                strbuf_release(&buf);
	}

and add more than 2kb with the first add (hence causing buf to
switch to dynamic scheme), the first _detach() gives the malloc()ed 
piece of memory to x[0] _and_ points buf.buf back to the on-stack
buffer (and buf.alloc back to 1024) while setting buf.len to 0,
so that the second _add() can still work purely on stack as long as
it does not go beyond the 1024-byte on-stack buffer.

> +/**
> + * Flags
> + * --------------
> + */
> +#define STRBUF_OWNS_MEMORY 1
> +#define STRBUF_FIXED_MEMORY (1 << 1)

This is somewhat a strange way to spell two flag bits.  Either spell
them as 1 and 2 (perhaps in octal or hexadecimal), or spell them as
1 shifted by 0 and 1 to the left.  Don't mix the notation.

> @@ -20,16 +28,37 @@ char strbuf_slopbuf[1];
>  
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> +	sb->flags = 0;
>  	sb->alloc = sb->len = 0;
>  	sb->buf = strbuf_slopbuf;
>  	if (hint)
>  		strbuf_grow(sb, hint);
>  }
>  
> +void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
> +			      size_t path_buf_len, size_t alloc_len)
> +{
> +	if (!path_buf)
> +		die("you try to use a NULL buffer to initialize a strbuf");

What does "path" mean in the context of this function (and its
"fixed" sibling)?
