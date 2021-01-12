Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6509C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A4D23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437975AbhALVhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406942AbhALUCn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:02:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6887FFD4C;
        Tue, 12 Jan 2021 15:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwdB+aeUSu9EpFbPs7DwrTFxrfo=; b=GhYBsc
        GZbt4kDp9f78EGIS7TktFCaD9ZXhTIEdXHYfCZFDHTMhk/EzUs0ClMngqnoLAH3x
        9okPdb8dZ9Gp99hT/gdXFSlJ6QVomUSwZdRjPXh1xgwyEab+a3bEs9idGzqpnhbA
        T2W+ryBPeHzbpRWfcIp4QHItOHUGdUjZDIRU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x4IM7ww7nSYGi05vBEm8TMUlcIcqlyIN
        gQCxK0XYso506sVmsR0OPfdg9P2XyDwP5z731vBo6EJiVa91GU65Y4p4Lghf+g7i
        mT3BXbQqMh/1sn4CIPyefUK9gcAsepQr9ELM9yij/cVmsxw+mxW5vQgPzXJoH4G8
        4gdth9hnCVs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF61BFFD4B;
        Tue, 12 Jan 2021 15:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C0C2FFD49;
        Tue, 12 Jan 2021 15:01:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 12:01:57 -0800
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com> (Jeff Hostetler
        via GitGitGadget's message of "Tue, 12 Jan 2021 15:31:22 +0000")
Message-ID: <xmqq5z4153gq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 075300C0-5511-11EB-8C3F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series introduces a multi-threaded IPC mechanism called "Simple IPC".
> This is a library-layer feature to make it easy to create very long running
> daemon/service applications and for unrelated Git commands to communicate
> with them. Communication uses pkt-line messaging over a Windows named pipe
> or Unix domain socket.
>
> On the server side, Simple IPC implements a (platform-specific) connection
> listener and worker thread-pool to accept and handle a series of client
> connections. The server functionality is completely hidden behind the
> ipc_server_run() and ipc_server_run_async() APIs. The daemon/service
> application only needs to define an application-specific callback to handle
> client requests.
>
> Note that Simple IPC is completely unrelated to the long running process
> feature (described in sub-process.h) where the lifetime of a "sub-process"
> child is bound to that of the invoking parent process and communication
> occurs over the child's stdin/stdout.
>
> Simple IPC will serve as a basis for a future builtin FSMonitor daemon
> feature.

What kind of security implications does this bring into the system?

Can a Simple IPC daemon be connected by any client?  How does the
daemon know that the other side is authorized to make requests?
When a git binary acting as client connect to whatever happens to be
listening to the well-known location, how does it know if the other
side is the daemon it wanted to talk to and not a malicious MITM or
other impersonator?

Or is this to be only used for "this is meant to be used to give
read-only access to data that is public anyway" kind of daemon,
e.g. "git://" transport that serves clones and fetches?

Or is this meant to be used on client machines where all the
processes are assumed to be working for the end user, so it is OK to
declare that anything will go (good old DOS mental model?)

I know at the Mechanism level we do not yet know how it will be
used, but we cannot retrofit sufficient security, so it would be
necessary to know answers to these questions.

Thanks.
