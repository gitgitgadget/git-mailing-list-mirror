Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiBWWEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWWEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:04:01 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C54B1DF
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:03:32 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 988BE18B83C;
        Wed, 23 Feb 2022 17:03:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xe/XX3M9kyk4
        EFHdogETayhD1oqT71QSg/zmrPtiNPo=; b=OkMefS0YmH9j32drHQgG+O+KSKHF
        DggR6+aG9yTEyYx/TxDa793lp7w18UduOzeWRVl4a17nBLPwlrT/B+6dVj4sDezU
        Uy2/EwJZsllfqatv+0O9CMJ/gtGMnHi68iT8bDIeFadjKDya+qh/ckHYsn5t1YyV
        SHwnwHnUehktVOY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DDDD18B83A;
        Wed, 23 Feb 2022 17:03:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D253D18B839;
        Wed, 23 Feb 2022 17:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 4/9] help.c: split up list_all_cmds_help() function
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-4.9-f9c4d5e2d28-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:03:28 -0800
In-Reply-To: <patch-v2-4.9-f9c4d5e2d28-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:47
        +0100")
Message-ID: <xmqqbkyxs0jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F1D7810-94F4-11EC-BA5E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -void list_all_cmds_help(void)
> +static void list_all_cmds_help_external_commands(void)
>  {
>  	struct string_list others =3D STRING_LIST_INIT_DUP;
> -	struct string_list alias_list =3D STRING_LIST_INIT_DUP;
> -	struct cmdname_help *aliases;
> -	int i, longest;
> -
> -	puts(_("See 'git help <command>' to read about a specific subcommand"=
));
> -	print_cmd_by_category(main_categories, &longest);
> +	int i;
> =20
>  	list_all_other_cmds(&others);
>  	if (others.nr)

Let's note that in the body of this new helper function, we still
use the printf("\n%s\n", _("group header")) pattern, not putchar('\n')
followed by puts().

> @@ -449,6 +444,13 @@ void list_all_cmds_help(void)
>  	for (i =3D 0; i < others.nr; i++)
>  		printf("   %s\n", others.items[i].string);
>  	string_list_clear(&others, 0);
> +}
> +
> +static void list_all_cmds_help_aliases(int longest)
> +{
> +	struct string_list alias_list =3D STRING_LIST_INIT_DUP;
> +	struct cmdname_help *aliases;
> +	int i;
> =20
>  	git_config(get_alias, &alias_list);
>  	string_list_sort(&alias_list);

And this helper, too.

> @@ -474,6 +476,17 @@ void list_all_cmds_help(void)
>  	string_list_clear(&alias_list, 1);
>  }
> =20
> +void list_all_cmds_help(void)
> +{
> +	int longest;
> +
> +	puts(_("See 'git help <command>' to read about a specific subcommand"=
));
> +	print_cmd_by_category(main_categories, &longest);
> +
> +	list_all_cmds_help_external_commands();
> +	list_all_cmds_help_aliases(longest);
> +}

This does make sense ;-)
