Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1989C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 23:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiHBXCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 19:02:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA63024F28
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 16:02:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D800145A01;
        Tue,  2 Aug 2022 19:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IoY/PSbAsRaa
        JM9TfJmerMJO8T8BrA7qqubWL3Zc1DQ=; b=koGvPa/c8/kJEv5eMgi3K7vZgK44
        NG/phkspy6dQzGLcS/u3ezN08j2lDUbL5wXQkaKTmRLBquAAF4iBsVAQb/BbOxS+
        p3iGEcs4a5oQ2R7SEskPD5h0PJV9yDOvAMyvbRZhrfs076eHe2+CpjDRF8jwP9Tj
        U/0pP5Vo0/Y4IPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51951145A00;
        Tue,  2 Aug 2022 19:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AD081459FF;
        Tue,  2 Aug 2022 19:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 01/10] help.c: refactor drop_prefix() to use a
 "switch" statement"
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-01.10-2665148f45b-20220802T125258Z-avarab@gmail.com>
Date:   Tue, 02 Aug 2022 16:01:58 -0700
In-Reply-To: <patch-v7-01.10-2665148f45b-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:50
        +0200")
Message-ID: <xmqqo7x2dzbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D72114C-12B7-11ED-AA68-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the drop_prefix() function in in help.c to make it easier to
> strip prefixes from categories that aren't "CAT_guide". There are no
> functional changes here, by doing this we make a subsequent functional
> change's diff smaller.
>
> As before we first try to strip "git-" unconditionally, if that works
> we'll return the stripped string. Then we'll strip "git" if the
> command is in "CAT_guide".

OK.  From the code structure's point of view, it somehow not exactly
satisfactory that we still need two "skip and then if skipped yield
the remainder" in this function.  Especially because we only strip
once.

> This means that we'd in principle strip "git-gitfoo" down to "foo" if
> it's in CAT_guide. That doesn't make much sense, and we don't have
> such an entry in command-list.txt, but let's preserve that behavior
> for now.

I am not sure if that is what the code means.

"git-gitfoo" will become "gitfoo" regardless of what category we are
calling drop_prefix() for, because we will return the resulting name
without falling through to the new switch statement, if the first
"strip 'git-'" succeeds, no?

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
> index 41c41c2aa11..7e594d291b0 100644
> --- a/help.c
> +++ b/help.c
> @@ -44,13 +44,19 @@ static struct category_description main_categories[=
] =3D {
>  static const char *drop_prefix(const char *name, uint32_t category)
>  {
>  	const char *new_name;
> +	const char *prefix =3D NULL;
> =20
>  	if (skip_prefix(name, "git-", &new_name))
>  		return new_name;
> -	if (category =3D=3D CAT_guide && skip_prefix(name, "git", &new_name))
> +	switch (category) {
> +	case CAT_guide:
> +		prefix =3D "git";
> +		break;
> +	}
> +	if (prefix && skip_prefix(name, prefix, &new_name))
>  		return new_name;
> -	return name;
> =20
> +	return name;
>  }

The diff algorighm made an interesting choice as to which line to
consider common here.  I would have expected to see

		return new_name;
+
	return name;
-
    }

especially after reading the last paragraph of the proposed log
message.
