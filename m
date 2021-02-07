Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6136BC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2715964DAF
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGTbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:31:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGTbi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:31:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D39F11A429;
        Sun,  7 Feb 2021 14:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5/VJkIoV0sJE0r4bml09vn6z4Ig=; b=Q6Y1rM
        ukuR8qdKKcLY7/M9WQ0NU41vetqYN+A4VKtuyL9A9dqmqy5CXRTZIkVE7R5nHqK5
        UC80VPZMnsJNgBpr0m83AGLq4Z/SvEImEfFEZ6E8bAeTplAfIP2PskU840EpBbiP
        iZRUy640LKYHhleNGAi+kpTllZ9hjtocrwIac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kHaDk+6VP5U2+yiTLyL/yn8f0BQtxS+c
        cqtWdpMtpxBNKJMlkNcNYgwjZ3cSg1JvKh8qJvzkaArjMkrGgoYVsmymeEhfc7UX
        YxEoQm3WSo2NI8ds/K0vGxt0nuQVJeNt8aar0z5rhARUVM9/OqqqhRVxvrPqLmXH
        feSrtX7QrYk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56AC911A428;
        Sun,  7 Feb 2021 14:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4218A11A427;
        Sun,  7 Feb 2021 14:30:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules
References: <20210207144144.GA42182@konoha>
Date:   Sun, 07 Feb 2021 11:30:49 -0800
In-Reply-To: <20210207144144.GA42182@konoha> (Shourya Shukla's message of
        "Sun, 7 Feb 2021 20:11:44 +0530")
Message-ID: <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCC88D9A-697A-11EB-8944-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> So, my question is, do we need to fix this to make sure that the changed
> '.gitmodules' is staged?

When "--cached" is given, the user is asking the module to be
removed ONLY from the index, without removing it from the working
tree, no?

So I think ".gitmodules" in the working tree should not be touched
at all.

Removing the entry for the module from the ".gitmodules" registered
in the index, when a submodule registered in the index, might be
desirable, and what you say here

> And its entry is not removed from the file. What should be done about
> this? I would appreciate your opinions.

may be related to it.

But I doubt it is a good idea to let "git rm" be the one touching
".gitmodules" either in the index or in the working tree for that to
happen.

The reason I am hesitant to teach anything about ".gitmodules" to
the basic level tools like "add", "rm" is because I consider, while
the "gitlink" design that allows the tip-commit from a submodule in
the superproject is a good thing to be done at the structural level
in the core part of Git, administrative information stored in the
".gitmodules" is not part of pure "Git" and alternative designs on
top of the core part of Git that uses different strategy other than
what we have are possible and they could even turn out to be better
than what we currently have.  In other words, I have this suspicion
that the ".gitmodules" based submodule handling we currently have,
done using "git submodule" command, should not be the only and final
form of submodule support Git would offer.

That leads me to think that anything that touch ".gitmodules" should
be done with "git submodule" suite of commands, not by the low level
"add", "rm", etc.  Such a separation of concern would allow a new
"git submodule2" design that may be radically different from the
current ".gitmodules" one to be introduced, possibly even replacing,
or living next to each other, the current "git submodule" together
with ".gitmodules" file, without affecting the low-level "add", "rm"
tools at all.

So from that point of view, if we were to fix the system, it may be
preferrable to make "git rm [--options] <submodule>" only about the
submodule in the working tree and/or the index, without touching
".gitmodules" at all, and let "git submodule rm [--cached]
<submodule>" be the interface on top.  The implementation of "git
submodule rm [--cached]" may use "git rm [--cached]" internally as a
building block to deal with the index and/or the working tree, but
the info kept in ".gitmodules" for administrative reasons should be
dealt within "git submodule" without exposing any such policy to the
lower level tools like "git rm" and "git add".

Having said all that, please do not take anything I say about
submodule design as the final decision.  It is just an opinion by
one development community member (i.e. me) and there are a lot more
people who are heavily invested in the current design and interested
in improving it than I am.

Thanks.
