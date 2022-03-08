Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6AAC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 16:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiCHRAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiCHRAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 12:00:16 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630352E34
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 08:59:18 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2125118070;
        Tue,  8 Mar 2022 11:59:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J065rLn3XrjwcJ94FhyMkyFdlxtkzciLQazOgE
        aUxUk=; b=kOP3vkRgEu/BO0VMSpqVDQOXpSDKMpNjXNXwd9Qcok/3llU2h7N57W
        KU+Yr7zKhI4qh/SUBO8ibcCtwHrxq3uAB2sjN6xGvDZLWdMHDf34I6rhrrfOJ1cT
        B5fPjeNWUOyYJIcAgtgGAFr+btgmxiv1EiVBvhhRoGX5B0KOdbLys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C823711806F;
        Tue,  8 Mar 2022 11:59:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C4A011806C;
        Tue,  8 Mar 2022 11:59:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
        <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 08:59:16 -0800
In-Reply-To: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 08 Mar 2022 02:54:23 +0000")
Message-ID: <xmqqmti0nzx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1714AB5E-9F01-11EC-A8A8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950ec..ab9a49e13a4 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -351,6 +351,14 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  	}
>  }
>  
> +static int print_default_format(char *buf, int len, struct expand_data *data)
> +{
> +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
> +		 data->info.type_name->buf,
> +		 (uintmax_t)*data->info.sizep);
> +
> +}

OK.  We want size and type if we were to show the default output out
of the object-info API.

>  /*
>   * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
>   * which the object may be accessed (though note that we may also rely on
> @@ -363,6 +371,11 @@ static void batch_object_write(const char *obj_name,
>  			       struct packed_git *pack,
>  			       off_t offset)
>  {
> +	struct strbuf type_name = STRBUF_INIT;
> +
> +	if (!opt->format)
> +		data->info.type_name = &type_name;

And at this point, !opt->format means we would use the default
format, so we cannot leave .type_name member NULL.  That is OK
but puzzling.  Why didn't we need this before?

If the caller is batch_objects(), there is the "mark_query" call to
strbuf_expand() to learn which field in data->info are needed, so
it seems that this new code should NOT be necessary.

    Side note.  I briefly wondered if this expand is something you
    would want to optimize when the default format is used, but this
    is just "probe just once to ensure various members of data->info
    are populated, to prepare for showing hundreds of objects in the
    batch request", so it probably is not worth it.

I am guessing that this is for callers that do not come via
batch_objects() where the "mark_query" strbuf_expand() is not made?
If so,

 * why is it sufficient to fill .type_name and not .sizep for the
   default format (i.e. when opt->format is NULL)?

 * why is it OK not to do anything for non-default format?  If no
   "mark_query" call has been made, we wouldn't be preparing the
   .type_name field even if the user-supplied format calls for
   %(objecttype), would we?

Looking at the call graph:

 - batch_object_write() is called by
   - batch_one_object()
   - batch_object_cb()
   - batch_unordered_object()

 - batch_one_object() is called only by batch_objects()
 - batch_object_cb() is used only by batch_objects()

 - batch_unordered_object() is called by
   - batch_unordered_loose()
   - batch_unordered_packed()
   and these two are called only by batch_objects()

And the "mark_query" strbuf_expand() to probe which members in
expand_data are are necessary is done very early, before any of the
calls batch_objects() makes that reach batch_object_write().

OK, so my initial guess that the new "we need .type_name member to
point at a strbuf" is because there are some code that bypasses the
"mark_query" strbuf_expand() in batch_objects() is totally wrong.
Everybody uses the "mark_query" thing.  Then why do we need to ask
type_name?

Going back to the new special case print_default_format() gives us
the answer to the question.  It expects that data->info already
knows the stringified typename in the type_name member.  The
original slow code path in expand_atom() uses this, instead:

	} else if (is_atom("objecttype", atom, len)) {
		if (data->mark_query)
			data->info.typep = &data->type;
		else
			strbuf_addstr(sb, type_name(data->type));

Which makes me wonder:

 * Is calling type_name(data->type) for many objects a lot less
   efficient than asking the stringified type_name from the
   object-info layer?  If that is the case, would you gain
   performance for all cases if you did this instead

	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
-			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
+		if (data->mark_query) {
+			data->info.typep = &data->type;
+			data->info.type_name = &data->type_name;
+		} else {
+			strbuf_addstr(sb, data->type_name);
+		}

   in expand_atom()?

	Side note: I am keeping data->info.typep because a lot of
	existing code switches on data->type, which is an enum.

   We may have to keep the strbuf_release() at the end of this
   function this patch added, to release data->info.type_name, if we
   go that route, but we wouldn't be dealing with an on-stack
   type_name in this function.

 * If it does not make any difference between calling type_name() on
   our side in expand_atom() or asking object-info API to do so,
   then would it make more sense to lose the local type_name strbuf
   and print type_name(data->type) in print_default_format() instead?

Other than that, this looks good to me.

Thanks.
