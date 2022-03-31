Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA0C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiCaTeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiCaTen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:34:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007D50444
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:32:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1B5113916;
        Thu, 31 Mar 2022 15:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RqVBZ/GNAKW5YYjxCpYwnn38j7NttOXlaZXHgb
        TXVoU=; b=oaqJh1Y9G1j4wCOWnucYySAqoUTWtycuWs+TiKIKeRPg1dYz2UUVOR
        EWvtLSpm7wOkGARCwlXKW82b3XTwbCBi4E5BJ7i2AATRlAxNku3BeOEGJGXPoHHd
        b74mK1yD4D0icY+c8jP1QouCMFcRm2YEoSQGLkmrRdeN9Vsq/jV9k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4016113912;
        Thu, 31 Mar 2022 15:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 441EA113910;
        Thu, 31 Mar 2022 15:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
        <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 12:32:52 -0700
In-Reply-To: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Thu, 31 Mar 2022 16:01:25
        +0000")
Message-ID: <xmqqpmm13okb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BC3A5AE-B129-11EC-A4CD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (!remote_find_tracking(remote, &tracking->spec)) {
> -		if (++tracking->matches == 1) {
> +		switch (++tracking->matches) {
> +		case 1:
>  			string_list_append(tracking->srcs, tracking->spec.src);
>  			tracking->remote = remote->name;
> -		} else {
> +			break;
> +		case 2:
> +			/* there are at least two remotes; backfill the first one */
> +			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
> +			/* fall through */
> +		default:
> +			string_list_append(&ftb->ambiguous_remotes, remote->name);
>  			free(tracking->spec.src);
>  			string_list_clear(tracking->srcs, 0);
> +		break;

Just to sanity check this part,

 - During the first iteration, we append tracking->spec.src to
   tracking->srcs, and set tracking->remote to remote->name;

 - In later iterations, we do not want to touch tracking->srcs, and
   want to collect remote->name.

And "backfill" assumes that tracking->spec.src at that point in the
second iteration is the same as what we got in remote->name in the
first round.  If that were a correct assumption, then it is curious
that the first iteration uses tracking->spec.src and remote->name
separately for different purposes, which makes me want to double
check if the assumption is indeed correct.

If it were tracking->remote (which was assigned the value of
remote->name during the first iteration) that is used to backfill
before we append remote->name in the second iteration, I wouldn't
find it "curious", but the use of tracking->spec.src there makes me
feel confused.

Thanks.





