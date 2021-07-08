Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D443C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32D46141E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGHWNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 18:13:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63725 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHWNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 18:13:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F2781403DD;
        Thu,  8 Jul 2021 18:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tZUXx1QUys8s
        LWCXH4EVFgN5wqnCN7VZXRTL955pX8k=; b=gK0fT7cJMHi+9ZvteRV0xTW/DfOP
        ojO624rB0fGCU8BaNn+cwn0J2FLU5LKGp9oQhnaz24iZAUYXAsjuF7ZJGeutvckY
        4tbt7sgW+Qpai8mF9l7DQKaOKC+GIaV9vYrfFdBBZsl7lKgbDUSy9x+EsX/YZGds
        4g5JTYkQiZ+MDdw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 583A51403DC;
        Thu,  8 Jul 2021 18:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A248C1403DB;
        Thu,  8 Jul 2021 18:10:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/4] revision.h: refactor "disable_stdin" and
 "read_from_stdin"
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
        <patch-2.4-6f69644b808-20210621T150651Z-avarab@gmail.com>
Date:   Thu, 08 Jul 2021 15:10:12 -0700
In-Reply-To: <patch-2.4-6f69644b808-20210621T150651Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Jun
 2021 17:10:14 +0200")
Message-ID: <xmqqwnq0a24b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4562F7C2-E039-11EB-9921-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the two "disable_stdin" and "read_from_stdin" flags to an enum,
> in preparation for a subsequent commit adding more flags.
>
> The interaction between these is more subtle than they might appear at
> first sight, as noted in a12cbe23ef7. "read_stdin" is not the inverse
> of "disable_stdin", rather we read stdin if we see the "--stdin"
> option.
>
> The "read" is intended to understood as "I read it", not "you should

"I've read it already" would have been easier to understand.

>  			if (!strcmp(arg, "--stdin")) {
> -				if (revs->disable_stdin) {
> +				switch (revs->stdin_handling) {
> +				case REV_INFO_STDIN_IGNORE:
>  					argv[left++] =3D arg;
>  					continue;
> +				case REV_INFO_STDIN_CONSUME_ON_OPTION:
> +					if (revs->consumed_stdin++)
> +						die("--stdin given twice?");
> +					read_revisions_from_stdin(revs, &prune_data);
> +					continue;
>  				}

More importantly, consumed_stdin will start at zero and if it is
found to be non-zero here, it is an immediate error, hence ...

> +	/*
> +	 * Did we read from stdin due to stdin_handling =3D=3D
> +	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
> +	 * option?
>  	 */
> -	int read_from_stdin;
> +	int consumed_stdin;

... it does not have to be a full integer.
Just a single-bit would do.

But none of the above is grave enough to require an update.
