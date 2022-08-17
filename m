Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F533C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiHQOnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiHQOnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922214B0EF
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:43:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35D8413E514;
        Wed, 17 Aug 2022 10:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4vXlcZHRsmDK2snYxZTeTRkVNww0g0XfUbSXemZdJmk=; b=g4u/
        FaVo+/Vwh5whCcpO4EFy4qxN7m+9337I5/3wwTOYiMN+3JPDm+xNqWE3z0rqh49P
        2fNXnkhzLoJmadzs36CJp7pAZXO1dK/h1Vltlji6gTcWZ/dyAMXaxY0DAniuhD05
        Q31sIBdXfiZ5lCwMPEM64pfgH9Ux077A6DOqiGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C7B913E513;
        Wed, 17 Aug 2022 10:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C93D13E512;
        Wed, 17 Aug 2022 10:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 07:43:25 -0700
Message-ID: <xmqqy1vnylpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3D3F118-1E3A-11ED-9FB6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static int start_fsmonitor_daemon(void)
> +{
> +	assert(fsmonitor_ipc__is_supported());
> +
> +	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
> +		return run_git("fsmonitor--daemon", "start", NULL);
> +
> +	return 0;
> +}

The function got ultra simple ;-).

> @@ -247,6 +265,9 @@ static int register_dir(void)
>  	if (toggle_maintenance(1))
>  		return error(_("could not turn on maintenance"));
>  
> +	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
> +		return error(_("could not start the FSMonitor daemon"));
> +
>  	return 0;
>  }

As long as it is done consistently, I do not think it makes a huge
difference between the "call it only when supported" and "when asked
to do what we do not support, silently succeed without doing
anything".  It however makes the code appear to be more in control
to do it this way, I think, which is good.

