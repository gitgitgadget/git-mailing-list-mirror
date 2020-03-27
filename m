Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5708C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4020658
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYFLNzRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0VEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:04:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59636 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0VEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:04:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 430C155171;
        Fri, 27 Mar 2020 17:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MJIMvZirATmhN1MHaOSp/tMZ154=; b=ZYFLNz
        RUdCf08hrT9TWURuHVCv8D1ru05CrPJHYwDWpQwhoWKROVp6yKFcABqD5Ol0Tvtr
        mJmFg/FIq36fQDQJpvyiXKGKjqCOIevFzws3JCJCVPw488wfsVJtsDVqVXdUWHjD
        2OFB3tY4FSP2vRROM/5/Q6Yi0f3b+xv8bDb+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kHOysQqMSXOhQseL0OItMT280UHpJGRO
        DccHB+9aLIuNkP5VxcXceCa0jTCmj+S/dvvIrt+t3b2VDDSfJdAsFmqCS+MGWSmS
        oxJjdYzn2IiSBrWzytPhimfXHZyiP6XDQRv4yRmbHmx/kjQud/F4AGQY6BvyIjP8
        IEB1Rikj8es=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 391FE55170;
        Fri, 27 Mar 2020 17:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 662885516F;
        Fri, 27 Mar 2020 17:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/9] strbuf: provide function to append whole lines
References: <cover.1585129842.git.ps@pks.im>
        <4b0a963ea5c47a951b95aa0a03966315b3e8299d.1585129842.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 14:04:18 -0700
In-Reply-To: <4b0a963ea5c47a951b95aa0a03966315b3e8299d.1585129842.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:53:47 +0100")
Message-ID: <xmqqpncxfr1p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 868DF60C-706E-11EA-B952-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While the strbuf interface already provides functions to read a line
> into it that completely replaces its current contents, we do not have an
> interface that allows for appending lines without discarding current
> contents.
>
> Add a new function `strbuf_appendwholeline` that reads a line including
> its terminating character into a strbuf non-destructively. This is a
> preparatory step for git-update-ref(1) reading standard input line-wise
> instead of as a block.

Hmph.  If we were to gain more uses of this function over time, the
necessity for an extra strbuf_addbuf() becomes annoying.  I wonder
if we should be doing this patch the other way around, i.e. move the
whole implementation, except for the early

	if (feof(fp))
		return EOF;
	strbuf_reset(sb);

part, and call it strbuf_addwholeline(), and strbuf_getwholeline()
becomes a thin wrapper around it that resets the incoming buffer
before calling strbuf_addwholeline().  The logic to determine EOF
would need to be updated if we go that route (i.e. instead of
checking sb->len is zero in the !HAVE_GETDELIM side of the
implementation, we need to see if the number is the same as before)
but it should be minor.

There is a stale comment in the HAVE_GETDELIM side of the curent
implementation, by the way.  I think our xrealloc no longer tries
to "recover" from ENOMEM.

Having said all that, I am fine with this version, at least for now.

> +int strbuf_appendwholeline(struct strbuf *sb, FILE *fp, int term)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	if (strbuf_getwholeline(&line, fp, term))
> +		return EOF;

So, if caller wants to read the stream until it runs out, it can do

	strbuf_init(&sb);
	while (strbuf_appendwholeline(&sb, fp, '\n') != EOF)
		; /* keep going */

If the caller knows how many lines to read, EOF-return can be used
only for error checking, e.g.

	strbuf_init(&sb);
	for (count = 0; count < 5; count++)
		if (strbuf_appendwholeline(&sb, fp, '\n') == EOF)
			die("cannot grab 5 lines");

It becomes cumbersome if the input lines are terminated, though.
The caller wouldn't be using strbuf_appendwholeline() interface,
e.g.

	strbuf_init(&accum);
	while ((strbuf_getwholeline(&sb, fp, '\n') != EOF) &&
               strcmp(sb.buf, "done\n"))
		strbuf_addbuf(&accum, &sb);

Anyway, I was primarily wondering if returning EOF, which perfectly
makes sense for getwholeline(), still makes sense for addwholeline(),
and it seems that it is still useful.

> +	strbuf_addbuf(sb, &line);
> +	strbuf_release(&line);
> +	return 0;
> +}
> +
>  static int strbuf_getdelim(struct strbuf *sb, FILE *fp, int term)
>  {
>  	if (strbuf_getwholeline(sb, fp, term))
> diff --git a/strbuf.h b/strbuf.h
> index ce8e49c0b2..411063ca76 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -502,6 +502,12 @@ int strbuf_getline(struct strbuf *sb, FILE *file);
>   */
>  int strbuf_getwholeline(struct strbuf *sb, FILE *file, int term);
>  
> +/**
> + * Like `strbuf_getwholeline`, but appends the line instead of
> + * resetting the buffer first.
> + */
> +int strbuf_appendwholeline(struct strbuf *sb, FILE *file, int term);
> +
>  /**
>   * Like `strbuf_getwholeline`, but operates on a file descriptor.
>   * It reads one character at a time, so it is very slow.  Do not
