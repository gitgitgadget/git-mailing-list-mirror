Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7472D1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKFK7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:59:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFK7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:59:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B30A4101;
        Wed,  6 Nov 2019 05:59:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gir+MRr3PAMZwjcrdUDtniiXtjw=; b=HQcXMh
        cFKVWQAXQrytfd4JJVwDLBBB0iWEPkFkJmAHHSoMsFAUSBz1ynt1p8xaoAq/QpXR
        afpLLi1NGBn6TC1oSdRnlGc3IOAYbZrciv77zkLmmdfymbKoi8fJ56f/RSeKkhmR
        T3UvRY6VBWAZ2EEhvZbtZyma9Wcc4htDrbOgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rrL5gO1yvD5sU7pjfcylRLbMVGAE3wIJ
        6WddoX7PVLdWD+SGDzQXbU4OsNTq048dplZP/xlLSUw+NquR0ghkpwoGUnPS1kkp
        HQ4iSyGfk9unat3arA39SvSnxIVtxLpUZiVmS47A/7yD9Xr39dEi+atNYMMwOa46
        qa0RDhkwvE0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCF25A4100;
        Wed,  6 Nov 2019 05:59:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 023F2A40FE;
        Wed,  6 Nov 2019 05:59:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH 1/1] refactor: rename is_directory() to dir_exists() and use it in clone.c
References: <pull.271.git.1573025315.gitgitgadget@gmail.com>
        <b36fdf6a92b3e5392ae45bf5e8a9132c54675d27.1573025315.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 19:59:27 +0900
In-Reply-To: <b36fdf6a92b3e5392ae45bf5e8a9132c54675d27.1573025315.git.gitgitgadget@gmail.com>
        (John Lin via GitGitGadget's message of "Wed, 06 Nov 2019 07:28:35
        +0000")
Message-ID: <xmqqbltptgmo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81B857E4-0084-11EA-A2F2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Lin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Lin <johnlinp@gmail.com>
>
> The original is_directory() checks whether the given path exists as
> a directory, which makes dir_exists() a more suitable name.

Why?  For a function that takes a path and asked "is this a
directory" that returns "yes/no", "is_directory(path)" is just as a
natural name as, if not more than, "dir_exists(path)".

IOW, "a more suitable name" needs a lot stronger justification than
"it subjectively sounds better to me".

> However, there is already an existing function called dir_exists(),
> while it doesn't check if the path is a directory.

Have you considered the possibility that it is deliberate (iow,
making it check may break the existing callers)?

bultin/clone.c wants to use its dir_exists() to see if *anything*
exists at the path already, so that it can issue an error message
and die when there is a non directory (e.g. a regular file), or a
non-empty directory, when it is told to create a repository.

It is a misnomer, sure, but that does not mean it is OK to break the
existing callers by suddenly saying "no there is not" when a user
tries to say "git clone $URL ~/.bashrc" (which used to fail because
the given destination is a file and it's "dir_exists()" said "oh,
there is something there already so you cannot mkdir there", but
with this patch it would say "nah, that thing is a file, so there is
no directory tehre").

> We decided to do the following:
> - remove the original dir_exists()
> - rename the original is_directory() to dir_exists()
> - use the new dir_exists() where the original dir_exists() is called

For a patch that touches all over the code like this, a summary of
what was done, like the above, is useful in evaluating how sensible
it is that the author wanted to do.  But it should also need to come
with "WHY".  Why does this patch do these three things?  Or, why
"we" (who are they?) decided to do so?

"We decided to do the following" does not answer that question, and
we can see from the patch text that the author decided to do them;
otherwise this patch would not exist ;-).

Thanks.
