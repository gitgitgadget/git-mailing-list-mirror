Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228FCA0ECD
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 03:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjILDMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbjILDMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 23:12:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E77D4BA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 15:30:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84A572C1D3;
        Mon, 11 Sep 2023 18:20:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=o68CixIDk2gHVU9VLfXq1hXZBBzUDQmcmwscYx
        Yctcw=; b=qD0PQH5kejytBFuWCCv9guD8tINrVHWByty1esnSKjznzXqnRSTtMW
        FWxO1La5jdp2NDU7r316j9AUaMNhRAz5dRbNI9WcqdgSGfpQ/Qhb2Fpw6bngnzhZ
        hwGOnKedCZxlLaPCz+uOMMHsa5MqgKxj/PhW1VJ2wNUOXMdh0u/PI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D8302C1D2;
        Mon, 11 Sep 2023 18:20:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF0EA2C1CF;
        Mon, 11 Sep 2023 18:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
In-Reply-To: <c64cd85f-f14c-46b7-a0d3-b8e0bfc60053@gmail.com> (Phillip Wood's
        message of "Mon, 11 Sep 2023 10:50:33 +0100")
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
        <xmqqedj8vfht.fsf@gitster.g>
        <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
        <xmqqmsxwtyy3.fsf@gitster.g>
        <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>
        <xmqq8r9gtviv.fsf@gitster.g>
        <c64cd85f-f14c-46b7-a0d3-b8e0bfc60053@gmail.com>
Date:   Mon, 11 Sep 2023 15:20:40 -0700
Message-ID: <xmqqa5tstkqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71B3180E-50F1-11EE-9DBD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> 	Preserve the set of ignored signals so that running git via a
> 	wrapper like nohup works as the user expects

OK.

> The other thing is that we have some instances where we ignore SIGPIPE
> before calling start_command() which means we're ignoring it in the
> child process as well. For example in gpg-interface.c we have
> ...
> rev-list does not check for errors when writing to stdout unless
> GIT_FLUSH is set in the environment so if parent process exits early
> rev-list will keep going until it thinks it has printed everything.

Ahh, yeah, that is bad.  Thanks for pointing them out.

> I think adding a flag to struct child_process to ignore SIGPIPE in the
> parent is probably the best way to avoid problems like this.

OK.  SIGPIPE is special enough that it may deserve to be singled
out.  A pager reading from us quitting does not have to be "we
wanted to write more but got an error" but just "ok, if the user
does not want any more output, that is fine".

THanks.

