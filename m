Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E2C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiGRRDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGRRDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:03:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B6B2A409
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:03:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D72931BE1C0;
        Mon, 18 Jul 2022 13:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=efn0EY1I6cV1
        xJKlTvCxAaJclrF+LuVakA5pTkILKcE=; b=pY9lcp+EW1NKaAfTfVAPmhBN1CXQ
        k1tkZQD2CmOaGPLShnNA8XdxrAWs8fsoT8lLclTPflOQ/XzSZ/nTQOUKi9mulIh6
        kawqhU+TT4sQrovHi2RYa4DdvVJVK6ZBXdfEYm2EHX+EVwrq2BIpU+n6aWCpfdq/
        dLI4JKV7dSgCXhM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF13C1BE1BF;
        Mon, 18 Jul 2022 13:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6AF2A1BE1BD;
        Mon, 18 Jul 2022 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 1/8] help.c: BUG() out if "help --guides" can't
 remove "git" prefixes
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
        <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
        <patch-v4-1.8-4428f0a6fb1-20220718T132911Z-avarab@gmail.com>
Date:   Mon, 18 Jul 2022 10:03:07 -0700
In-Reply-To: <patch-v4-1.8-4428f0a6fb1-20220718T132911Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 18 Jul
 2022 15:29:27
        +0200")
Message-ID: <xmqqr12iqrp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F68687C-06BB-11ED-BFC3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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

The observation is good.

>  	if (skip_prefix(name, "git-", &new_name))
>  		return new_name;
> -	if (category =3D=3D CAT_guide && skip_prefix(name, "git", &new_name))
> +	switch (category)
> +	{
> +	case CAT_guide:
> +		if (!skip_prefix(name, "git", &new_name))
> +			BUG("category #%d but no 'git' prefix?", category);
>  		return new_name;
> +	}
>  	return name;
> -
>  }

If we were to use "switch", can we have the opening brace on the
same line, like all other switch statements?

I suspect that we should avoid losing information, perhaps the most
straight-forward implementation would be without "switch", like so

	if (category =3D=3D CAT_guide) {
		if (skip_prefix(name, "git", &new_name))
			return new_name;
		BUG("CAT_guide category but no 'git' prefix? '%s'", name);
	}
	return name;

even if we plan to add more categories that would remove the prefix
and we insist the prefix to be there?

>  static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
