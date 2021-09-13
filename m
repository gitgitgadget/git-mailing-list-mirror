Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E347C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 22:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2528760F51
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 22:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbhIMXAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:00:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51711 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350364AbhIMW7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 18:59:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2E14140C64;
        Mon, 13 Sep 2021 18:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=melo04RVgtkC
        ayMDkGee2QzhA4MNb7+xij69zXU936g=; b=f0PQoxluowO5FKAc8/LC9N7lw2uL
        m1ov8uZ6+3t3ahb8vdXDhQ2tx4c4GPhNfUegN3JUMwNaYGT/qP9nTIB4rh7Q8Tii
        P/hx6nB4EShTesA8RFbpRc8V6LpXYYB90YEZQwBTHJtEjauTull3Nl+k/bq9haMf
        Q7h+9exROuST/FA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB23A140C63;
        Mon, 13 Sep 2021 18:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23E7F140C62;
        Mon, 13 Sep 2021 18:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:58:23 -0700
In-Reply-To: <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 13 Sep 2021 15:19:22
        +0000")
Message-ID: <xmqq5yv4ccc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 19ECAD72-14E6-11EC-A3B0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
> should checkout the commit pointed to by <tag-object>. Instead it gives

I am not sure if "should checkout the commit pointed to by." is a
good description.  It does not seem to be sufficiently justified.

Did we auto-peel in scripted version of "git rebase" and is this a
regression when the command was rewritten in C?

If that is not the case, this topic is perhaps slightly below
borderline "meh" to me.  The optional "first switch to this <branch>
before doing anything" command-line argument in

    git rebase [--onto <there>] <upstream> [<branch>]

was meant to give a branch, and because we treat detached HEAD as
almost first-class citizen when dealing with branch-ish things, we
allowed

	git rebase master my-topic^0

to try rebasing my-topic on detached HEAD without losing the
original.  In other words, you had to be explicit that you meant the
commit object, not a ref that points at it, to trigger this "rebase
detached" feature.  The same thing for tags.

	git rebase master v12.3^0

would be a proper request to rebase the history leading to that
commit.  Without the peeling, it appears the user is asking to
update the ref that can be uniquely identified with "v12.3", but we
do not want to rebase a tag.

It would have been a different story if we had a problem when a tag
is given to "--onto <there>", but I do not think this topic is about
that case.

Having said that, even if we decide that we shouldn't accept the tag
object and require peeled form to avoid mistakes (instead of
silently peeling the tag ourselves), I do agree that

>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': =
trying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec=
07447e0 to branch 'HEAD'
>

is a bad error message for this.  It should be something like

	error: cannot rebase a tag

perhaps.

But if we auto-peeled in an old version, I do not mind this series
(but let's drop pointless "clean-up" that is not, like what was
pointed out by R=C3=A9ne).  In such a case, the first paragraph should
say, instead of "should checkout", that "we used to do X, but commit
Y broke us and now we die with an error message".

Thanks.
