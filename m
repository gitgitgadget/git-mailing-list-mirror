Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3701AC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 05:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20762071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 05:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fmco7Kti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfKYFmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 00:42:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54918 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYFmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 00:42:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BD872CCAC;
        Mon, 25 Nov 2019 00:42:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aBJxbua28F/GxR4Xbw3LgH4SlVA=; b=Fmco7K
        tiPYluawGFzMrGkf5JEb3FMXDnLwjkBKSzNt1MAjxFCwzTmgXQcJmk+04olkKA2e
        EJDLse3wlVKYBRboqDqCMl/F0biM1P5MLK2b6eSXZWFfcWKOZre9jeNP+VfsyHKH
        bLPY++HTGORqVkIz4+SdAM4xgH91YWy374c7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rKTpiICCEL8HzfpLaUonBJ6LHlZj6EHQ
        tOLoAi21eMvOQmegR8JLPiECl3sqIJ1gCznufKxx6BkkjA0WYcVz26aheWWlJSF3
        K5ZjiTXHQ7v2ha4xiyPSEvqKctdxVMVXApp0yc04XrEJUat+VjhVf9nDFLPAqdVn
        QIpNkT/pjQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D00152CCAB;
        Mon, 25 Nov 2019 00:42:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEC2C2CCAA;
        Mon, 25 Nov 2019 00:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] On Windows, limit which file handles are inherited by spawned child processes
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 14:42:02 +0900
In-Reply-To: <pull.670.git.git.1574433665.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 22 Nov 2019 14:41:01
        +0000")
Message-ID: <xmqqimn8y0k5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F361C7C-0F46-11EA-8EC0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The problem to be solved: files cannot be deleted on Windows when even one
> process has an open file handle to it. So when a process opens a temporary
> file, then spawns a child process that inherits that file handle by mistake,
> and then the parent process tries to delete the temporary file while the
> child process is still running, the deletion will fail. (This description is
> slightly simplified, see the commit message "spawned processes need to
> inherit only standard handles" for more detail.)

Makes me wonder if we should be marking these fds with FD_CLOEXEC to
solve the issue in a way that is platform agnostic.  It may turn out
that we'd be better off to make it an explicit choice by the parent
when it leaves a FD open while spawning a child process (and by that
spawned child when it runs another executable---but I undertand that
it is a single-step operation, not a two-step one, on Windows).

In any case, synchronizing the differences in compat/ between our
trees is good.  Queued.

