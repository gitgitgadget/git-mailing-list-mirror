Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76654202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdJ3C0v (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:26:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751310AbdJ3C0v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1F8BADA4;
        Sun, 29 Oct 2017 22:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rP5h2nvfJqdHnKyVBR4z4/Uk7F0=; b=HOiQsY
        nu6D1PSl95Zs8jzvuz+Ex0xVfASjFm+HdqdRLbJIrbBNmtTKmuGFcQ28bpg2i7jC
        81DRgGIRvSi1Zh1W9glkoSiIja10m5zq6GUAi9nS+/smQdNuhSx/DroLz80wEOxM
        RbpHDkVaYfbIoCpSLb7Ezz+9KGCcBbuMEte+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h2zaNWEt3jExAlntqe/eRIB9ojvTPRCR
        zgOCBB9LsSV4rBl5Db3dggPMr40M6z7Ddx+ZwbzxCpO3eircmVy7ntwGSJ4GsIE9
        V9b2IJI96bz/qPcSUXCNwQkjvp50A2T5UIrrVItwwNdbeCdjSTgyz9iI0lSeqU7u
        CmFoR3p+3hg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63B26BADA3;
        Sun, 29 Oct 2017 22:26:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC886BADA2;
        Sun, 29 Oct 2017 22:26:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
        <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
        <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
Date:   Mon, 30 Oct 2017 11:26:48 +0900
In-Reply-To: <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net> (Phillip
        Wood's message of "Sun, 29 Oct 2017 18:34:29 +0000")
Message-ID: <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8C8D6B4-BD19-11E7-9662-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Just clearing GIT_DIR does not match the behavior of the shell version
> (tested by passing -p to avoid rebase--helper) as that passes GIT_DIR to
> exec commands if it has been explicitly set. I think that users that set
> GIT_DIR on the command line would expect it to be propagated to exec
> commands.
>
> $ git rebase -px'echo $GIT_DIR' @
>
>                                                             Merge commit
> '7c2f1abd64' into phil
> Executing: echo $GIT_DIR
>
> Successfully rebased and updated refs/heads/phil.
>
> $ env GIT_DIR=.git git rebase -px'echo $GIT_DIR' @
>
>                                                             Merge commit
> '7c2f1abd64' into phil
> Executing: echo $GIT_DIR
> /home/phil/Documents/src/git/.git/worktrees/git-next
> Successfully rebased and updated refs/heads/phil.

Hmmm, I do not mess with GIT_DIR at all in my workflow, so I am
having a bit of hard time judging if this regression is serious
enough to be a release blocker.  

I'd prefer to avoid reverting the whole js/rebase-i-final topic from
'master' this late in the game, even though I do not expect we would
see the remainder of the system gets broken due to hidden dependency
on the topic, because the changes on the topic are relatively well
isolated.


570676e011
d1114d87c7
2f0e14e649
5f3108b7b6
