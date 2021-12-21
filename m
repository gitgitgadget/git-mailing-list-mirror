Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6282C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 07:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhLUHa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:30:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61747 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLUHa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 02:30:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6303517D999;
        Tue, 21 Dec 2021 02:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4hdOGFCNqW1UXM07H+PHjUkWa4JcCdyRvHV+GZ
        yFoNE=; b=UxaiRwqVdyIdmRGSSMc7UqROt06dR/R04d+YWHy7ym1BdJ5zaLe8q7
        l2+6mIfTNFjsw6GWH6dNsCcjnzcwT8VBqagsq6JVO/5s/ftGHkCXyqSOJrtnGiS6
        l5P+yu8nFJzU6iFeslPKY0tRIdj2Jrh1T6oQE6AJjK2tGLFc2RHR0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CF9A17D998;
        Tue, 21 Dec 2021 02:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93DE317D997;
        Tue, 21 Dec 2021 02:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 23:30:52 -0800
In-Reply-To: <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 20 Dec 2021
        15:01:03 +0000")
Message-ID: <xmqqlf0equs3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDEACE42-622F-11EC-89A4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Defer freeing of the Trace2 thread CTX data until program exit.
> Create a global list of thread CTX data to own the storage.
>
> TLS CTX data is allocated when a thread is created and associated
> with that thread.  Previously, that storage was deleted when the
> thread exited.  Now we simply disassociate the CTX data from the
> thread when it exits and let the global CTX list manage the cleanup.

By the way, TLS CTX sounds embarrassingly close and confusing to
some function that we may find in say openssl or some crypto stuff
X-<.  Was there a strong reason to avoid calling these functions and
types something like tr2_thread_ctx instead of tr2tls_thread_ctx?

