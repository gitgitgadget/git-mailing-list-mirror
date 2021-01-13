Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E33C433E6
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D02312E
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 00:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393762AbhAMAnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 19:43:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54684 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392286AbhAMAOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 19:14:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7CE6101C6A;
        Tue, 12 Jan 2021 19:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G+2L53V1aO5wkXvvrJBdCYmKYqA=; b=FxoO2y
        DN1gv0ACxiDHw82Jtn3fojklHHXyfCBUAhFt8IlgN0g/Z2nriFKz+gVai9ra+2Wm
        eafCS+tuLqssuwtCO7ThgDsncyesjt/stWSpo1L1DBDVZnvC08dnIm0m4j3VQvfq
        /Ib32dJP7dVMwkYoW5ZscSPTVbRrVj+MNHWHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HfZq+669/flG2TLYxJZOImTdy6omqUFS
        Pjnk5ZqbF7KQUN/lzfInhCoyFrRoevCNj2z4734YXOXCVZzIZWoki6sn5l0lOZg2
        1Mv5WA5qOnnZeSe/1MsK0Qq+RnB/elPG0sH4HKPlOxXA2GY2DtWlP5MQiJv9gYkY
        4A7Xn4JHHMw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D08FA101C69;
        Tue, 12 Jan 2021 19:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20DDC101C67;
        Tue, 12 Jan 2021 19:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <xmqq5z4153gq.fsf@gitster.c.googlers.com>
        <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
Date:   Tue, 12 Jan 2021 16:13:29 -0800
In-Reply-To: <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 12 Jan 2021 18:25:20 -0500")
Message-ID: <xmqqo8htzoba.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE8C6B4-5534-11EB-A8B1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On Windows a local named pipe is created by the server side.  It rejects
> remote connections.  I did not put an ACL, so it should inherit the
> system default which grants the user RW access (since the daemon is
> implicitly started by the first foreground client command that needs
> to talk to it.)  Other users in the user's group and the anonymous
> user should have R but not W access to it, so they could not be able
> to connect.  The name pipe is kept in the local Named Pipe File System
> (NPFS) as `\\.\pipe\<unique-path>` so it is globally visible on the
> system, but I don't think it is a problem.

It is not intuitively obvious why globalluy visible thing is OK to
me, but I'll take your word for it on stuff about Windows.

> On the Unix side, the socket is created inside the .git directory
> by the daemon.  Potential clients would have to have access to the
> working directory and the .git directory to connect to the socket,
> so in normal circumstances they would be able to read everything in
> the WD anyway.  So again, I don't think it is a problem.

OK, yes, writability to .git would automatically mean that
everything is a fair game to those who can talk to the daemon, so
there is no new issue here, as long as the first process that
creates the socket is careful not to loosen the permission.

Thanks.
