Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2447AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 01:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiBDBRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:17:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51468 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBDBRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 20:17:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE6601127F5;
        Thu,  3 Feb 2022 20:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J3LmichZzko8MFdPLH0ctKCv1NUHz5AeFANeid
        tieHM=; b=FUgPwS8BJPvmxaEuxbqDlGv41s3dudRkf7btM2qL1TDRYatLZB+59m
        U/7PQyLwmw8LDSKrrBRDnxxq7kyLnr5rVd83aHM0hiy1Jh0NcaPM8+R/3x+FS8v/
        xnJ/bOYdhVVYOGss72ML5OZ0aDyQpj70gdFqQhjB7ctz/2rIJw/DE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4ABA1127F4;
        Thu,  3 Feb 2022 20:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A7811127F3;
        Thu,  3 Feb 2022 20:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen BoJun <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
        <20220129063538.24038-1-bojun.cbj@gmail.com>
Date:   Thu, 03 Feb 2022 17:17:44 -0800
In-Reply-To: <20220129063538.24038-1-bojun.cbj@gmail.com> (Chen BoJun's
        message of "Sat, 29 Jan 2022 14:35:38 +0800")
Message-ID: <xmqq5ypvpgzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42908D2E-8558-11EC-86AD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen BoJun <bojun.cbj@gmail.com> writes:

> +	/*
> +	 * If there is no command ready to run, should return directly to destroy
> +	 * temporary data in the quarantine area.
> +	 */
> +	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
> +		; /* nothing */
> +	if (!cmd)
> +		return;
> +
>  	/*
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.

One thing I notice is that the first thing we do, after making the
new objects available to us, is to check if we are making any
conflicting update, e.g.

    git push origin master:master next:master

would try to update the same ref with different objects, and will be
rejected.

This check can _almost_ be doable without being able to access the
new objects, and as a follow-on work, it might not be a bad little
project to see how we can move the call to check_aliased_updates()
before this loop we are adding in this patch (#leftoverbits).

Thanks.
