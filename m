Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhKWRap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:30:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54467 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhKWRam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:30:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F9FDF0D09;
        Tue, 23 Nov 2021 12:27:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tw1YlqKwn2dfJX9P+Xd3wnRN7ZNWr88QY8fDPO
        QePWE=; b=kBBXsJSMQR/WgJe7HTBSvlKWRvpmlKoLZMQn8dkF+uxo6JiXWo4FGx
        RdcSvR3yvhsn+/pXVXQXVorPqriC43mgykaldrRnVs16Q6DfCInMEm1RV9HGPv3G
        qvXlyMHIXJIObIV3yedq+AJ713FhN/+d17yZdl07u3AIpg8z023cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35C1AF0D08;
        Tue, 23 Nov 2021 12:27:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E394F0D07;
        Tue, 23 Nov 2021 12:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com>
        <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
Date:   Tue, 23 Nov 2021 09:27:31 -0800
In-Reply-To: <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com> (Phillip Wood's
        message of "Tue, 23 Nov 2021 11:05:16 +0000")
Message-ID: <xmqqy25e93zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4D6F02C-4C82-11EC-886A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Checking if stdout is a terminal fixes the Eclipse case where stdout
> is a pipe or /dev/null but if git is started in the background from a 
> terminal then calling isatty() will not prevent git from receiving
> SIGTTOU. For example if the user is using a gui editor then the 
> following used to work
>
> GIT_EDITOR=gedit git commit&

It is a good one ;-)

> Now git receives SIGTTOU when the editor exits because we call
> tcsetattr() from a background process group. One can argue it does not 
> make much sense to be starting git in the background but it did work
> before these changes. I think a combination of isatty() and
> tcgetpgrp() is probably the best solution.

If we are not foreground, we can and we should just skip doing this
whole save/restore thing, no?  The "editor might screw up the stty
setting so we restore to help the buggy editor" is releavant only
when the said editor actually uses the terminal, and it would get
TTOU if it tries to do so from the background.

So, I agree it would be a good thing to do, if we still want to do
it.  In the meantime, I've reverted the offending change from 'master'
and am planning to merge it down for 2.34.1 but I do not mind taking
a corrected change (not incremental on top of the broken 2.34.0) for
future releases.

jgit stopped doing 'GIT_EDITOR=echo git config --system --edit' thing,
but not everybody will upgrade immediately.
