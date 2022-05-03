Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893BC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 00:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiECAJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 20:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiECAJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 20:09:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0E1DA5E
        for <git@vger.kernel.org>; Mon,  2 May 2022 17:05:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F532109208;
        Mon,  2 May 2022 20:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/fI5AmtQK6KWCe3XQvCivjpMaO0tI2miRGxmk2
        CDjjA=; b=i7vSXAAz+qfALLosLFeZX+hqGNiegZrypKfzCd8eIFfbI6Jv1oYRT1
        1kX8t5MFWWl15hwIsLiEvoV2L9x3OtfcXJQ0rx3fMCDGVam1QREvXJArlT2Qkh8c
        yUpl9UH7Iae5foBUPVt201bT4bDMUe6JJnWStBMCN3lY21zkVXmjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F4B0109205;
        Mon,  2 May 2022 20:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C95DD109204;
        Mon,  2 May 2022 20:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 4/8] object-info: send attribute packet regardless of
 object ids
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-5-calvinwan@google.com>
Date:   Mon, 02 May 2022 17:05:56 -0700
In-Reply-To: <20220502170904.2770649-5-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 2 May 2022 17:09:00 +0000")
Message-ID: <xmqqee1btr8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEEF7C06-CA74-11EC-981F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Currently on the server side of object-info, if the client does not send
> any object ids in the request or if the client requests an attribute the
> server does not support, the server will either not send any packets
> back or error out.

There is an early return when oid_str_list->nr (i.e. number of
objects we are queried) is zero, and we return without showing the
"size" token in the output (called "attribute").  The change in this
patch changes the behaviour and makes such a request responded with
"size" but without any size information for no objects.

It is unclear why that is a good change, though.

The loop that accepts requests in today's code sends an error when
it sees a line that it does not understand.  The patch stops doing
so.  Also, after ignoring such an unknown line, the requests that
were understood are responded to by send_info() function.  The patch
instead refuses to give any output in such a case.

It is unclear why either of these two makes it a good change,
though.

> Consider the scenario where the client git version is
> ahead of the server git version, and the client can request additional
> object-info besides 'size'. There needs to be a way to tell whether the
> server can honor all of the client attribute requests before the client
> sends a request with all of the object ids.

Yes.  If we want to learn about "size", "frotz", and "nitfol"
attributes about these objects, we can send "size", "frotz",
"nitfol", and then start feeding object names.  Then we can observe
that "frotz" were not liked to learn that this old server does not
understand it, and the same for "nitfol".  At least we would have
learned about size of these objects, without this patch.

Now, an updated server side with this patch would respond with
"size" and no other response.  Does it mean it does not understand
"frotz", it does not understand "nitfol", or neither?  Did we get no
response because we didn't feed objects, or because we asked for
something they don't know about?

How well does the current client work with today's server side and
the server side updated with this patch?  I _think_ this change is
essentially a no-op when there is no version skew (i.e. we do not
ask for anything today's server does not know about and we do not
necessarily ask today's server about zero objects).

Am I correct to assume that those who are talking with today's
server side are all out-of-tree custom clients?

I am wondering how much damage we are causing them with this change
in behaviour, especially with the lack of "You asked for X, but I
don't understand X", which is replaced by no output, which would be
totally unexpected by them.

It totally is possible that this "object-info" request is treated as
an experimental curiosity that is not ready for production and has
no existing users.  If this were in 2006, I would just _declare_
such is a case and move on, breaking the protocol for existing users
whose number is zero.  But I am afraid that we no longer live in
such a simpler world, so...

> In a future patch, if the
> client were to make an initial command request with only attributes, the
> server would be able to confirm which attributes it could return.
>
> ---
>  protocol-caps.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/protocol-caps.c b/protocol-caps.c
> index bbde91810a..bc7def0727 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -11,6 +11,7 @@
>  
>  struct requested_info {
>  	unsigned size : 1;
> +	unsigned unknown : 1;
>  };

OK.

>  /*
> @@ -40,12 +41,12 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  	struct string_list_item *item;
>  	struct strbuf send_buffer = STRBUF_INIT;
>  
> -	if (!oid_str_list->nr)
> -		return;
> -
>  	if (info->size)
>  		packet_writer_write(writer, "size");
>  
> +	if (info->unknown || !oid_str_list->nr)
> +		goto release;
> +
>  	for_each_string_list_item (item, oid_str_list) {
>  		const char *oid_str = item->string;
>  		struct object_id oid;
> @@ -72,12 +73,13 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  		packet_writer_write(writer, "%s", send_buffer.buf);
>  		strbuf_reset(&send_buffer);
>  	}
> +release:
>  	strbuf_release(&send_buffer);
>  }

OK, except for the bypass for info->unknown case, which I am not
sure about.

>  int cap_object_info(struct repository *r, struct packet_reader *request)
>  {
> -	struct requested_info info;
> +	struct requested_info info = { 0 };

Wow.  We have been using info uninitialized?  Is this a silent
bugfix?

If info.size bit was on due to on-stack garbage, we would have given
our response with "size" attribute prefixed, even when the client
side never requested it.

> @@ -92,9 +94,7 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
>  		if (parse_oid(request->line, &oid_str_list))
>  			continue;
>  
> -		packet_writer_error(&writer,
> -				    "object-info: unexpected line: '%s'",
> -				    request->line);
> +		info.unknown = 1;

