Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E381F462
	for <e@80x24.org>; Wed, 12 Jun 2019 17:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409043AbfFLRgT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 13:36:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56300 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405127AbfFLRgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 13:36:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6454152002;
        Wed, 12 Jun 2019 13:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x9OcL/x/7ZRp
        oB+OW22b8xxbKfA=; b=gsb+W2QQtSLtUndWSZSI4vPb0yk1ev5FwBPa96gzoaSz
        w/2lckpca1gqed0z+93OctURh9tfl8mZIoS3YePW5YPDgIzfd+YBFupUXABZ5O+1
        zaNozklxneg95oWWFlNINOkECnuTeukYkluSaljXYnX/mozAp7ua6ryikj0lfFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L9pmN1
        FgLoMxOCKW78/sGHgpY/uVTZeQiJ9XnKps4kP4WF1OmUD21GCPJzee0/+TQddbM6
        yAVsfBfQ/LmeplC100G1vDqP13IzShalqiRRIbYf+Eq598TMOn2xZxKXFo9HUTkx
        /S/hU7l3Ef5leQTNF5ZYjl0LC4c0d0KayA+M8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEF51152001;
        Wed, 12 Jun 2019 13:36:13 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C4C2152000;
        Wed, 12 Jun 2019 13:36:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2] completion: do not cache if --git-completion-helper fails
References: <20190607093034.816-1-pclouds@gmail.com>
        <20190612085606.12144-1-pclouds@gmail.com>
Date:   Wed, 12 Jun 2019 10:36:12 -0700
In-Reply-To: <20190612085606.12144-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 12 Jun 2019 15:56:06 +0700")
Message-ID: <xmqqa7emk8oj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92DED922-8D38-11E9-8420-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "git <cmd> --git-completion-helper" could fail if the command checks fo=
r
> a repo before parse_options(). If the result is cached, later on when
> the user moves to a worktree with repo, tab completion will still fail.
>
> Avoid this by detecting errors and not cache the completion output. We
> can try again and hopefully succeed next time (e.g. when a repo is
> found).
>
> Of course if --git-completion-helper fails permanently because of other
> reasons (*), this will slow down completion. But I don't see any better
> option to handle that case.
>
> (*) one of those cases is if __gitcomp_builtin is called on a command
>   that does not support --git-completion-helper. And we do have a
>   generic call
>
>     __git_complete_common "$command"
>
>   but this case is protected with __git_support_parseopt_helper so we'r=
e
>   good.
>
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  v2 simplifies the code. $nocache in v1 was overkill.

Nicely done.  Thanks, all.  Will queue.


>
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 9f71bcde96..8c6b610a24 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -400,7 +400,8 @@ __gitcomp_builtin ()
>  	if [ -z "$options" ]; then
>  		# leading and trailing spaces are significant to make
>  		# option removal work correctly.
> -		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) "
> +		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) " || r=
eturn
> +
>  		for i in $excl; do
>  			options=3D"${options/ $i / }"
>  		done
