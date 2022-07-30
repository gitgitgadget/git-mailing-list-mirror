Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159AC00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 00:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiG3AR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 20:17:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B6767C80
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:17:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D9B91A5FDB;
        Fri, 29 Jul 2022 20:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/VTz3Q/l8z6B
        uvoMcXZK4swBvmbPpgR0WqbXJlxXvCs=; b=sfXkfOQ7CHSMTbbT2+mbCxrKd8z1
        gxtCGg0C0f82bTaZPwEbkgM7fzFFUAaqDg0Z0rHzZWvxFJ6+th5AlwyYRRVXcxmE
        WXhfPydWTRtcJhol4uUyJz/R1OUJtTxBlYcD5DkhmBuMI0rWA/ZxJABxzD71aAFH
        UDpCISOlcvVLzDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 656541A5FD9;
        Fri, 29 Jul 2022 20:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEE861A5FD8;
        Fri, 29 Jul 2022 20:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v6 1/9] help.c: BUG() out if "help --guides" can't
 remove "git" prefixes
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
        <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <patch-v6-1.9-f3588319057-20220728T164243Z-avarab@gmail.com>
Date:   Fri, 29 Jul 2022 17:17:50 -0700
In-Reply-To: <patch-v6-1.9-f3588319057-20220728T164243Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 28 Jul
 2022 18:46:40
        +0200")
Message-ID: <xmqq35ej313l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CF3D7AA-0F9D-11ED-A27C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Adjust code added in 929d9192828 (git docs: split "User-facing file
> formats" off from "Guides", 2021-06-04) to be more strict about the
> prefix trimming of the "guides" category.
>
> There are no guides in the command-list.txt that don't start with
> "git", and we're unlikely to ever add any, if we do we can remove this
> BUG() invocation, but in the meantime this makes the intent more
> clear.

I am not sure what this buys us.  After dealing with pages that
begin with "git-", if the set of documentation we have happen to all
share "git" as their prefix, then this new BUG() does not do
anything to them, and when we ever add say "scalar-guide.txt", the
new BUG() would only force people to rewrite this part of the code.

Instead we could be more forward looking and do something like
"Yield a name without 'git' prefix if it begins with it, or the
original name", and then new guides that are outside "git" namespace
can be added without touching this part of the code again.

IOW, it is not entirely clear to me what we are adding this extra
roadblock for.


> While we're at it remove a stray newline that had been added after the
> "return name;" statement.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  help.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/help.c b/help.c
> index 41c41c2aa11..80d516abb0b 100644
> --- a/help.c
> +++ b/help.c
> @@ -44,13 +44,19 @@ static struct category_description main_categories[=
] =3D {
>  static const char *drop_prefix(const char *name, uint32_t category)
>  {
>  	const char *new_name;
> +	const char *prefix;
> =20
>  	if (skip_prefix(name, "git-", &new_name))
>  		return new_name;
> -	if (category =3D=3D CAT_guide && skip_prefix(name, "git", &new_name))
> +	switch (category) {
> +	case CAT_guide:
> +		prefix =3D "git";
> +		if (!skip_prefix(name, prefix, &new_name))
> +			BUG("'%s' in category #%d should have '%s' prefix",
> +			    name, category, prefix);
>  		return new_name;
> +	}
>  	return name;
> -
>  }
> =20
>  static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
