Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F269C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209E460FF2
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhHNSVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 14:21:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53216 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbhHNSVL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 14:21:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 574D2E66C1;
        Sat, 14 Aug 2021 14:20:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y2MxKpDWSZvRBOtn9U251KOYVsnXRY6yNzZJlr
        IEtvc=; b=qNz/aSkqlYmkQb3jAstfKyKyPTJeCb+3Ys16l7P5vYRwY0EjlZv6Nc
        qLq4tjKWhRw0d+JXjN2ih9CjSdevBW0jmWDxy1dM80J4ARZ7m0YtS5h/9vkmxVac
        nWOaxC5LIDos040bKi7QqpHNv479DUgL0u8MSiWf7y1n9DYCNyA2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CDB7E66C0;
        Sat, 14 Aug 2021 14:20:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C078FE66BF;
        Sat, 14 Aug 2021 14:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Barr <b@rr-dav.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>
Subject: Re: [PATCH v2] help.c: help.autocorrect=prompt waits for user action
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
        <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 11:20:40 -0700
In-Reply-To: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com> (Azeem
        Bande-Ali via GitGitGadget's message of "Sat, 14 Aug 2021 05:11:12
        +0000")
Message-ID: <xmqqmtpjubuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5565E854-FD2C-11EB-A6B0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -618,7 +628,17 @@ const char *help_unknown_cmd(const char *cmd)
>  				   _("Continuing under the assumption that "
>  				     "you meant '%s'."),
>  				   assumed);
> -		else {
> +		else if (autocorrect == AUTOCORRECT_PROMPT) {
> +			char* answer;

Some people seem to make an asterisk stick to types like this, but
in our codebase written in C, an asterisk sticks to the identifier
that it makes into a pointer, i.e.

			char *answer;

This is because doing so differently would confuse novices with
constructs like this:

			int* a, b;

where only 'a' is a pointer, and 'b' is not.

> +			struct strbuf msg = STRBUF_INIT;
> +			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
> +				    assumed);

I think these should be kept on a single line for readability, i.e.

			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);

as I see a fairly long line after this block already.

	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);


Other than these cosmetic bits, this round looks good to me,
including the documentation update.

Thanks.
