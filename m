Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B563BC1975A
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870AF2071B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vYW39wNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCOBru (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:47:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62576 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCOBru (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:47:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 697F04065E;
        Sat, 14 Mar 2020 13:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pZtPf2vIODhk9dVnZi4MwdRLCpY=; b=vYW39w
        NMrOOvqkcnD7MfT4FkX+n2v7XKq12dQHWbLXizv40trJrOhWPezWrX9PWSs4QDBW
        /N/EJ4JNTxbadK6QaHuvAIwOLeToTVLFQ/0EV74T1mLpmQx+eFV05VohWlQkbys2
        Ke2+tJaInM3C1Z1XijfbEeq5SloF4n+AJ4WGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FlCnFlWdE9INpreDF56Re1tvqNKRLZvb
        uLOo71zSZL+bP816PqVRJlIDvTuuVQV6l0gmtUFRknfWApppRrzYVJ04gbN47UOU
        kgnBAqK/KsCxt+MrSBMlTpPleyCrhB/sGZ/hDYLatSobVw6tYVctmZgNRnLj2Hze
        ouF941t10E0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6205C4065C;
        Sat, 14 Mar 2020 13:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E01DE4065B;
        Sat, 14 Mar 2020 13:10:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clone: use --quiet when stderr is not a terminal
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 10:10:15 -0700
In-Reply-To: <pull.581.git.1584133742475.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 13 Mar 2020 21:09:02
        +0000")
Message-ID: <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC9A6018-6616-11EA-89C4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> "git clone" is used by many build systems to download Git code before
> running a build. The output of these systems is usually color-coded to
> separate stdout and stderr output, which highlights anything over stderr
> as an error or warning. Most build systems use "--quiet" when cloning to
> avoid adding progress noise to these outputs, but occasionally users
> create their own scripts that call "git clone" and forget the --quiet
> option.
>
> Just such a user voiced a complaint that "git clone" was showing "error
> messages" in bright red. The messages were progress indicators for
> "Updating files".
>
> To save users from this confusion, let's default to --quiet when stderr
> is not a terminal window.

This is the kind of behaviour change that makes me (and probably
others who have been with the project long enough) to say "it is
certain that some other users and tools are relying on the current
behaviour and their expectation, when explained, would look just as
sensible, if not more, than 'any output to the standard error stream
is an error', which is the justfication given for this change."

I would not be surprised if a GUI program is counting the bytes
coming to the progress output to show the equivalent with bits on
the screen, for example.  They would say "Git has always given
progress output to the standard error stream.  We, as any other
sensible folks, know that they are not errors and won't give a
misleading and alarming messages in red.  We could change our
program to pass --progress but why should we be the one who are
forced to do such a change", and I do not have *any* excuse I find
sensible enough to give them.

I do not mind queuing this (or any similar backward compatibility
breaking changes) and merging it down to 'next', but if we were plan
to have it in a tagged release, I'd prefer to keep it in 'next' for
at least a few releases before doing so, and under three conditions:
major organizations and those who build tools around Git promise me
that they adopt 'next' for their developers and users early, and
that they actively measure and report potential damages before it is
advanced to 'master', and that they won't let their users complain
after it hits a tagged release.

If the world and userbase were like today back when "clone" learned
the --quiet option and showing the progress meter 15 years ago, I
suspect that we may have chosen this way from the beginning, though.
