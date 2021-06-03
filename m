Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F4C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65273613E6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFCCkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:40:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCCkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:40:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9743EBCC3B;
        Wed,  2 Jun 2021 22:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mQeJz6fseiTSOuwcAV4uDPxOn4osMqUDzDd9UM
        zIwgM=; b=bnAdX6NMGET79fJHZWWzg2pvQCfT0KPZu8FpgPJt0XA3X67OWC7ku5
        VyQrsZtW+yL+PTOkBptNFC8IWZhY57yFKKiVk4hKGwng6u4W33WKRHbGuJKAe0QW
        kgGCoZ9y0Lsc9HRAG/bgFuy9aCtAtO0DHx9OS6wkzGUbNANesyW/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E0D2BCC3A;
        Wed,  2 Jun 2021 22:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EEA2BCC39;
        Wed,  2 Jun 2021 22:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
        <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Jun 2021 11:38:19 +0900
In-Reply-To: <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 01 Jun 2021 14:37:23
        +0000")
Message-ID: <xmqqsg1z65b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C232DBC8-C414-11EB-A106-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -644,13 +664,6 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
>  				       (int)(ep-atom), atom);
>  
> -	/* Do we have the atom already used elsewhere? */
> -	for (i = 0; i < used_atom_cnt; i++) {
> -		int len = strlen(used_atom[i].name);
> -		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
> -			return i;
> -	}
> -
>  	/*
>  	 * If the atom name has a colon, strip it and everything after
>  	 * it off - it specifies the format for this entry, and
> @@ -660,6 +673,17 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  	arg = memchr(sp, ':', ep - sp);
>  	atom_len = (arg ? arg : ep) - sp;
>  
> +	if (format->quote_style && !strncmp(sp, "raw", 3) && !arg)
> +		return strbuf_addf_ret(err, -1, _("--format=%.*s cannot be used with"
> +				"--python, --shell, --tcl, --perl"), (int)(ep-atom), atom);
> +
> +	/* Do we have the atom already used elsewhere? */
> +	for (i = 0; i < used_atom_cnt; i++) {
> +		int len = strlen(used_atom[i].name);
> +		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
> +			return i;
> +	}
> +

These two hunks

 - hoists up the code that sets 'arg' to optional string after
   "<atom>:" and counts how long the "<atom>" is in 'atom_len'; the
   change causes the counting done even when the same placeholder is
   already used elsewhere (in which case we do not have to do such
   counting);

 - inserts the early return to reject use of "raw" atom when
   language specific quoting is used.

It probably makes it easier to understand if the former is split
into a separate commit, but at the same time a series with too many
small steps is harder to manage, so let's keep them in a single
change.

But I do not think we want to add the new change at this location,
at least for two reasons:

 * The posted patch checks '!arg' to avoid rejecting "raw:size",
   which would not scale at all.  What if you wanted to later add
   "raw:upcase", which you must reject?

 * We do have enumerated constants for each atom types, but this
   early check and return does string comparison.

Where it belongs is either after "Is the atom a valid one?" loop
where 'atom_len' is used to locate the placeholder's atom in the
table of valid atoms [*], or inside raw_atom_parser().

    Side note: If you read the original code, you would notice that
    there already is a similar "this is a valid atom that appear in
    the valid_atom[] table, but unallowed in this situation" check
    done with .source != SOURCE_NONE conditional.  One downside is
    that until calling raw_atom_parser(), you do not know if
    RAW_BARE or RAW_LENGTH is requested.

If we do inside raw_atom_parser(), it would probably look like this:
 
+static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	if (!arg)
+		atom->u.raw_data.option = RAW_BARE;
+	else if (!strcmp(arg, "size"))
+		atom->u.raw_data.option = RAW_LENGTH;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+
+	if (atom->u.raw_data.option == RAW_BARE && format->quote_style)
+		return strbuf_addf_ret(err, -1,
+				       _("--format=%%(raw) cannot be used with ...")...);
+
+	return 0;
+}
