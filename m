Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1900AC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E170D611CA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhEaGqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:46:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63515 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaGqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:46:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4383513B0A3;
        Mon, 31 May 2021 02:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MTbpFdztBnr4HWzn99xPSrbmVD2FzYvVbBQ2MDfPD3w=; b=gxCU
        aqN9tW9mxf4aYLAiiMi/UNYXNmaYeAZ9yXZhc93UGxNsco0ASnrh/nmlzIWV/tCJ
        b/TYH4j54gl4IK5lr4MDO6mxNwUHwF74vlArUpjHM1JGfWWCV4413TqSCFIGelXP
        xiRYwLULbwNWDoh26wD6BDwdAyQnP/Zay4mswKY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D3F713B09F;
        Mon, 31 May 2021 02:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8429413B09E;
        Mon, 31 May 2021 02:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/15] push: only get the branch when needed
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-6-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 15:44:51 +0900
Message-ID: <xmqq8s3vwgf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B48562E2-C1DB-11EB-80ED-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/builtin/push.c b/builtin/push.c
> index a2abacf64d..4b3a14278a 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -243,7 +243,7 @@ static int is_workflow_triangular(struct remote *remote)
>  
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
> -	struct branch *branch = branch_get(NULL);
> +	struct branch *branch;
>  	int triangular = is_workflow_triangular(remote);
>  
>  	switch (push_default) {
> @@ -258,6 +258,7 @@ static void setup_default_push_refspecs(struct remote *remote)
>  	default:

Not a fault of this step, but please make it a habit to have
"break;" here.  case label with absolutely no body just looks
strange and is distracting to the eyes.

>  	}
>  
> +	branch = branch_get(NULL);
>  	if (!branch)
>  		die(_(message_detached_head_die), remote->name);

This step is the true justification for the splitting of a single
switch into two switches done in [03/15].  Makes quite a lot of
sense.

