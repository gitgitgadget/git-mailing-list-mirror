Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BBC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669DF61A0D
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhCXUSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:18:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64363 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbhCXUSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:18:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8B86BF396;
        Wed, 24 Mar 2021 16:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+PC1phef0+F1
        yh8YR1qQKFjuLLE=; b=XkiXhPlBFA1LczO3SKb+75cJd00AM88+pDabwhODrkkV
        gtoySZFrn3C3tb2LsB8aUCnE/F643w/2zhdUE0WOgDfMNpQstxRgeEZdW3/dXsLn
        NKiHPJnJfFIAvLgNrUzVaWur0sHxZ0cuxn+zqkJOovvvcNqc8aZWS2w7NIET2Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XMicgr
        g3Y5xt0Cm1pyXD+lXTiRB8A6EMzpHTwQnr298+/gkkejnUF9aZJhgL9Dt1uJ4Bnn
        HWlNvwAwp9reFZaIVV6YNTzRSpr46OeqQFYAH+E5Ig7lWZeYk7NMEutUqMPPoeU7
        HcP4jfIy+M2/Gz42cVCIfpTLjHzCS/E9hT8uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4F1BF395;
        Wed, 24 Mar 2021 16:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A00A6BF393;
        Wed, 24 Mar 2021 16:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC]trailer: pass arg as positional parameter
References: <pull.913.git.1616511182942.gitgitgadget@gmail.com>
        <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 13:18:01 -0700
In-Reply-To: <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Wed, 24 Mar 2021 15:42:35 +0000")
Message-ID: <xmqqft0kxq4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0905E41E-8CDE-11EB-83B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In the original implementation of `trailer.<token>.command`,
> use `strbuf_replace` to replace $ARG in the <value> of the
> trailer, but it have a problem: `strbuf_replace` replace the
> $ARG in command only once, If the user's trailer command have
> used more than one $ARG, error will occur.
>
> If directly modify the implementation of the original
> `trailer.<token>.command`, The user=E2=80=99s previous `'$ARG'` in
> trailer command will not be replaced. So now add new
> config "trailer.<token>.cmd", pass trailer's value as
> positional parameter 1 to the user's command, users can
> use $1 as trailer's value, to implement original variable
> replacement.
>
> Original `trailer.<token>.command` can still be used until git
> completely abandoned it.

Sorry, but that's quite an ungrammatical mess X-<.

>  1:  abc5b04d152f ! 1:  185356d6fc90 [GSOC]trailer: change $ARG to envi=
ronment variable
>      @@ Metadata
>       Author: ZheNing Hu <adlternative@gmail.com>

As this is completely a different design and does not share anything
with the earlier round, the range-diff is merely distracting and
useless.

>  Documentation/git-interpret-trailers.txt |  7 +++++++
>  t/t7513-interpret-trailers.sh            | 22 +++++++++++++++++++-
>  trailer.c                                | 26 +++++++++++++++++-------
>  3 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/g=
it-interpret-trailers.txt
> index 96ec6499f001..38656b1b3841 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -252,6 +252,13 @@ also be executed for each of these arguments. And =
the <value> part of
>  these arguments, if any, will be used to replace the `$ARG` string in
>  the command.
> =20
> +trailer.<token>.cmd::
> +	Similar to 'trailer.<token>.command'. But the difference is that
> +	`$1` is used in the command to replace the value of the trailer
> +	instead of the original `$ARG`, which means that we can quote the

"quote"?

> +	trailer value multiple times in the command.
> +	E.g. `trailer.sign.cmd=3D"test -n \"$1\" && echo \"$1\" || true "`

This needs to explain what happens if the user gives both .cmd and
.command to the same token.  Is it an error?  Is the newly invented
.cmd takes precedence?  Something else?

Whatever the answer is, the reasoning behind reaching the design
must be explained and defended in the proposed log message.


> diff --git a/trailer.c b/trailer.c
> index be4e9726421c..80f47657ff1a 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -14,6 +14,7 @@ struct conf_info {
>  	char *name;
>  	char *key;
>  	char *command;
> +	int is_new_cmd;

Poor naming.  The .cmd thing may be "new" right now in your mind,
but how would you transition out of it when design flaws are
discovered in it and replace it with yet another mechanism?

Add a new "char *cmd" field, and at the using site, define the
precedence between the two when both cmd and command members of the
structure are populated, perhaps?
