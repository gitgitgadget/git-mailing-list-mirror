Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1ADC41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E176D206FC
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aC9Qf1xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgJGQrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:47:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57631 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJGQrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:47:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E48B8F041E;
        Wed,  7 Oct 2020 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DpFUylcnv3hzR2VFc3U/F3oStBI=; b=aC9Qf1
        xZZgZ2Xb31WDSd7XhE8bfLFEDQjSKXUn/FIasLtFG4DRe2xIlgo6qbhRytN2bjcC
        uAEGjUj2MdHDvVk3FfXTbzL4Na26lVAuJfOEU8JxFXoVYgvCOqoYIgdnBMnljxYl
        QgI+qfQxgxKJx+/eKiesiBfmdvQqIM8RCx8Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlPeWnnQfXnpuw0caWTJ1GxDW5kP7lV1
        teTxjjP6URCg+PFOMipolUxrQjaRZ3y2JrHBWcv9gOeeU4W9kV/rkcgPcsG/080k
        t+kOdJx3ef29baJ+B02b6z2qSLHc/0cffsZIVYWc+AHC4g0B/b5xTI3hmZuShNhC
        1Xp2Zi5pSfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBAE6F041D;
        Wed,  7 Oct 2020 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AB44F041A;
        Wed,  7 Oct 2020 12:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] checkout: learn to respect checkout.guess
References: <cover.1601810233.git.liu.denton@gmail.com>
        <cover.1602047333.git.liu.denton@gmail.com>
        <2678680a08e025e9652c6769501dbc604560394b.1602047333.git.liu.denton@gmail.com>
Date:   Wed, 07 Oct 2020 09:47:41 -0700
In-Reply-To: <2678680a08e025e9652c6769501dbc604560394b.1602047333.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 6 Oct 2020 22:09:09 -0700")
Message-ID: <xmqqy2ki2daq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1D02BD0-08BC-11EB-AE21-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index afa5c11fd3..28f656d04e 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -193,6 +193,9 @@ branches from there if `<branch>` is ambiguous but exists on the
>  linkgit:git-config[1].
>  +
>  Use `--no-guess` to disable this.
> ++
> +The default behavior can be set via the `checkout.guess` configuration
> +variable.
>  
>  -l::
>  	Create the new branch's reflog; see linkgit:git-branch[1] for
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
> index 3759c3a265..5c438cd505 100644
> --- a/Documentation/git-switch.txt
> +++ b/Documentation/git-switch.txt
> @@ -103,6 +103,9 @@ ambiguous but exists on the 'origin' remote. See also
>  `checkout.defaultRemote` in linkgit:git-config[1].
>  +
>  `--guess` is the default behavior. Use `--no-guess` to disable it.
> ++
> +The default behavior can be set via the `checkout.guess` configuration
> +variable.

Contrasting the above two, one cannot help but notice that it is
totally unclear how "git checkout" that is not explicitly told by
command line or configuration behaves.  Perhaps "`--guess` is the
default behaviour." needs to be transplated from the description
for "git switch" to clarify?

This is not a new issue, but is made stand out even more prominently
due to the addition.

Thanks.
