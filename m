Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E11C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHVTTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiHVTTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:19:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5F50072
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:17:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F0CE1BC61C;
        Mon, 22 Aug 2022 15:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U+9mNUh5qe1e
        fPMP/gLpduGyRSmAZoQIkIygi4poSrk=; b=acOukGZVmfNUnSP+iCWY0iKH4IZf
        ktsRswGP+YZiSZqP8cg5J7uQy052TXVxALXQ3rRwC7SKgE6ebo804bTR8rZx7xI1
        xgWqoEbfOTTkLFPcXTd/XNWWvV0myyT0iCqsmoiWLOeKsk53rvCMMHvSdMZUflzX
        m3wHWFpS45VUcHY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 470851BC61B;
        Mon, 22 Aug 2022 15:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9AB01BC61A;
        Mon, 22 Aug 2022 15:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/7] bundle-uri: create "key=value" line parsing
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 12:17:45 -0700
In-Reply-To: <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason via GitGitGadget"'s message
 of "Mon, 22 Aug
        2022 15:12:50 +0000")
Message-ID: <xmqqo7wccckm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1AFFE55E-224F-11ED-8D75-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason via GitGitGadget"  <gitgitgadget@=
gmail.com>
writes:

> +/**
> + * General API for {transport,connect}.c etc.
> + */
> +int bundle_uri_parse_line(struct bundle_list *list, const char *line)
> +{
> +	int result;
> +	const char *equals;
> +	struct strbuf key =3D STRBUF_INIT;
> +
> +	if (!strlen(line))
> +		return error(_("bundle-uri: got an empty line"));
> +
> +	equals =3D strchr(line, '=3D');
> +
> +	if (!equals)
> +		return error(_("bundle-uri: line is not of the form 'key=3Dvalue'"))=
;
> +	if (line =3D=3D equals || !*(equals + 1))
> +		return error(_("bundle-uri: line has empty key or value"));

The suggestions implied by my asking fall strictly into the "it does
not have to exist here at this step and we can later extend it", but
for something whose equivalent can be stored in our configuration
file, it is curious why we _insist_ to refuse an empty string as the
value.

I do not miss the "key alone without even '=3D' means 'true'"
convention, personally, so insisting to have '=3D' is OK, but the
inability to have an empty string as a value looks a bit disturbing.

This depends on how the helper gets called, but most likely the
caller has a single line of pkt-line that it GAVE us to process, so
it sounds a bit wasteful to insist that "line" to be const to us and
force us to use a separate strbuf, instead of just stuffing NUL at
where we found '=3D' and pass the two halves to bundle_list_update().

Not a huge deal, it is just something I found funny in the "back in
the days we coded together, Linus would never have written like
this" way.

Other than that small detail, the code looks OK to me.

> +	strbuf_add(&key, line, equals - line);
> +	result =3D bundle_list_update(key.buf, equals + 1, list);
> +	strbuf_release(&key);
> +
> +	return result;
> +}
> diff --git a/bundle-uri.h b/bundle-uri.h
> index 6692aa4b170..f725c9796f7 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -76,4 +76,16 @@ int for_all_bundles_in_list(struct bundle_list *list=
,
>   */
>  int fetch_bundle_uri(struct repository *r, const char *uri);
> =20
> -#endif
> +/**
> + * General API for {transport,connect}.c etc.
> + */
> +
> +/**
> + * Parse a "key=3Dvalue" packet line from the bundle-uri verb.
> + *
> + * Returns 0 on success and non-zero on error.
> + */
> +int bundle_uri_parse_line(struct bundle_list *list,
> +			  const char *line);
> +
> +#endif /* BUNDLE_URI_H */
