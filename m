Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9DAC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB56610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEaFGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:06:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhEaFGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:06:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0C0612C920;
        Mon, 31 May 2021 01:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OWmYOlyhzNITxWx/AWlgeBwpCRq7pYDzBvR00Ou6ycM=; b=Q3Qd
        2zq8mGKaWciq8S1y4iB8R4dZOuK77X6FWUhSHK13YKEldVOmTdmcSymsgwPW9BKg
        GJUr2HrbXsNSLf7Sk6iutRC3sbWGTHcCa3T70ebMboGUuOUVgauoo3LeBdopqVVf
        TfkGKZ2vx+5aJKaegUKn80fRmNzrs8y/W0ncfYs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8F8D12C91F;
        Mon, 31 May 2021 01:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 080CF12C919;
        Mon, 31 May 2021 01:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 4/6] push: simplify setup_push_simple()
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529071115.1908310-5-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 14:04:57 +0900
Message-ID: <xmqq1r9nxzly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF841886-C1CD-11EB-BE4E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's a safety check to make sure branch->refname is not different
> from branch->merge[0]->src, otherwise we die().
>
> Therefore we always push to branch->refname.
>
> Suggestions-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Simpler and nicer.  Good.


> diff --git a/builtin/push.c b/builtin/push.c
> index 9c807ed707..73fe083682 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -225,14 +225,10 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>  
>  static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
>  {
> -	const char *dst;
> -
>  	if (!branch)
>  		die(_(message_detached_head_die), remote->name);
>  
> -	if (triangular) {
> -		dst = branch->refname;
> -	} else {
> +	if (!triangular) {
>  		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
>  			die(_("The current branch %s has no upstream branch.\n"
>  			    "To push the current branch and set the remote as upstream, use\n"
> @@ -248,10 +244,8 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
>  		/* Additional safety */
>  		if (strcmp(branch->refname, branch->merge[0]->src))
>  			die_push_simple(branch, remote);
> -
> -		dst = branch->merge[0]->src;
>  	}
> -	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
> +	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
>  }
>  
>  static int is_workflow_triangular(struct remote *remote)
