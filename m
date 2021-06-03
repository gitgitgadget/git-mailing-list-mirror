Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D5C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41052613F8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFCVg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 17:36:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFCVg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 17:36:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90380CAD19;
        Thu,  3 Jun 2021 17:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s2Gi4KAlbo7mhHZWZbNWZjo5aNdO9C0D5qtQHd
        gGdh8=; b=Zy9zWkgmR+FSjcray/UrjIHOsZr9xbZw8wTfRw5GthKNDXkAU6Cdxa
        IOlw+jY0cu9E5Hqrq3uzYlJL/oz6c8tl2k9psHRScixC41/PfzjMOLeV5i+FHWRA
        14Vo+GZ52CatLoz+tShDv2TKYczB2U4APzfUjEB5+OjjtnjoaV6eQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DABBCAD17;
        Thu,  3 Jun 2021 17:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14D61CAD12;
        Thu,  3 Jun 2021 17:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
        <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
        <xmqqsg1z65b8.fsf@gitster.g>
        <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
Date:   Fri, 04 Jun 2021 06:35:06 +0900
In-Reply-To: <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 3 Jun 2021 13:36:21 +0800")
Message-ID: <xmqq35ty6391.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91FE18C4-C4B3-11EB-87CA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>>  * We do have enumerated constants for each atom types, but this
>>    early check and return does string comparison.
>>
>
> Note that at this time we must compare strings... parse_ref_filter_atom()
> passes string form of the atom. Code block A also requires comparing strings.
>
> -------------------
> Code block A:
>
>         for (i = 0; i < used_atom_cnt; i++) {
>                int len = strlen(used_atom[i].name);
>                if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
>                        return i;
>        }
> -------------------

The point is that you can piggyback existing string comparison
(which is called "parsing") and use the parsed result (i.e. if you
can compare with ATOM_RAW instead of adding another strcmp(), that
can be a better solution).

> All the following replies are based on such a fact:
> We will reuse used atoms as much as possible.
>
> Think about this situation:
>
> $ git for-each-ref --format="%(raw)" --sort="raw" --python
>
> Since we specified --sort="raw",`parse_sorting_atom()`
> will be called in parse_opt_ref_sorting(), but at this time
> we haven't parsed --<lang> yet.

That only says using parse_sorting_atom() and relying on the check
in the function is still too early, and does not necessarily support
the posted patch that redundantly runs strcmp().

After parsing all the command line options, we have used_atom[]
fully populated and we know what host language we are quoting the
result for---and that makes a good place to check for comflicting
requests.

>> +static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
>> +                               const char *arg, struct strbuf *err)
>> +{
>> +       if (!arg)
>> +               atom->u.raw_data.option = RAW_BARE;
>> +       else if (!strcmp(arg, "size"))
>> +               atom->u.raw_data.option = RAW_LENGTH;
>> +       else
>> +               return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
>> +
>> +       if (atom->u.raw_data.option == RAW_BARE && format->quote_style)
>> +               return strbuf_addf_ret(err, -1,
>> +                                      _("--format=%%(raw) cannot be used with ...")...);
>> +
>> +       return 0;
>> +}
>
> It's same, "*.parser()" is below Code Block A.
>
> After all, the reason why this must be done here is the ref-filter
> original logic
> has not considered rejecting a format atom and an option.

That is something you can fix to make the code easier to follow, no?
