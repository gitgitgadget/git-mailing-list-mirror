Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EACC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E4761430
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhEKEKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 00:10:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61776 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKEKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 00:10:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FA1C137327;
        Tue, 11 May 2021 00:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ldWkaD0snlJN6Sc0WyexwSVkCYQtudsVi2Xa8x
        polqQ=; b=shT0M8om61nLwyHHbYQ+yqA1369suUXv096cyvq7dZXN1bx0LojG3s
        2ipW7LzEajJiJf47Ccy2lKJAe+0AtzVSaeyNlJoL4QleAp+0aogwI0Ek9LZaLwBs
        vo/Oao8S/k6w6Smiq+nJ85nyqVBkNZk/Qb77uBoVhJj84Fey6h4iA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88328137326;
        Tue, 11 May 2021 00:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFFB2137325;
        Tue, 11 May 2021 00:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] diff-merges: move specific diff-index "-m" handling
 to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-3-sorganov@gmail.com>
Date:   Tue, 11 May 2021 13:09:33 +0900
In-Reply-To: <20210510153451.15090-3-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 10 May 2021 18:34:47 +0300")
Message-ID: <xmqqwns5oqrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1D8EFFA-B20E-11EB-B509-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>  int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info rev;
>  	unsigned int option = 0;
> -	int i;
>  	int result;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
> @@ -27,17 +53,16 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  	rev.abbrev = 0;
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
>  
> +	/*
> +	 * It's essential to parse our distinct options before calling
> +	 * setup_revisions(), for the latter not to see "-m".
> +	 */
> +	argc = parse_distinct_options(argc, argv, &rev, &option);
>  	argc = setup_revisions(argc, argv, &rev, NULL);

This change is risky, as the loop below (which this patch moves to
parse_distinct_options()) has no knowledge of other options that
setup_revisions() helper is prepared to handle and that takes an
argument.  When parsing "git cmd --opt --cached A", setup_revisions()
may know that --opt takes an argument and eat both (i.e. the
"--cached" is not an option but an arg given to "--opt"), but the
new parse_distinct_options() helper does not; it will happily skip
"--opt" and leave it in, mistake "--cached" as an option and remove,
and instead make "A" the arg given to "--opt".

Picking up the remnant _after_ setup_revisions() ate what it
understands would not have such a downside, as long as none of our
"distinct options" take any argument.

Can't we make "-m means something special for diff-index" without
butchering the command line processing in this step?  diff-index
does not care about --diff-merges, so letting setup_revisions()
remember only the fact that "-m" was given while parsing, and then
postprocess what "-m" means depending on the command (i.e. everybody
else would treat it as a short-hand for "--diff-merges=m" plus "we
need some form of diff output, while allowing "diff-index" to treat
it differently) should not be rocket science.

Thanks.
