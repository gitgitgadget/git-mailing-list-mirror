Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEFC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07CF207DE
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jF6TqE9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgIGQQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:16:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgIGQOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 12:14:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1341E340B;
        Mon,  7 Sep 2020 12:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=u6eoNJD+px0ItmC2VsgBG4Jo9GU=; b=jF6TqE9WiSE8KwtswWBl
        Y1HGucr3iu3S4AUc2e0H8NmNm2QWypY+CX4sy08SRnaUyAEVHfYDBqL96HlloQFZ
        22+gj6TnTklpLYEZsjuTCsMpZrIekkQCDFCt/G1VEUV+sYtWnD2IUqOG0Cddmm6A
        U3/OTQDFNElr6/FAoUqs/M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=bcw1EI/8CguWymEmBtP+Y6hyhx9McH5uhzI7tlHkTRkvOM
        tDHwfR7K2YDaJB8kBNcEcBPZDPcMCcXigZD3kuPrcQ7XxCpvzSd36UAztKw9zlUJ
        b9sIlfVeOLs3LqcPM3kEqnPuiyilaot8Iy5Sl+Sw+S/3o2a1Cek+x4t4eDx4g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA40DE340A;
        Mon,  7 Sep 2020 12:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB780E3409;
        Mon,  7 Sep 2020 12:14:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
Date:   Mon, 07 Sep 2020 09:14:36 -0700
Message-ID: <xmqqmu211s43.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A24E11C-F125-11EA-A0E8-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> The `--force-with-lease` option in `git-push`, makes sure that
> refs on remote aren't clobbered by unexpected changes when the
> "<expect>" ref value is explicitly specified.
>
> For other cases (i.e., `--force-with-lease[=<ref>]`) where the tip
> of the remote tracking branch is populated as the "<expect>" value,
> there is a possibility of allowing unwanted overwrites on the remote
> side when some tools that implicitly fetch remote-tracking refs in
> the background are used with the repository. If a remote-tracking ref
> was updated when a rewrite is happening locally and if those changes
> are pushed by omitting the "<expect>" value in `--force-with-lease`,
> any new changes from the updated tip will be lost locally and will
> be overwritten on the remote.

Hmph, I am not sure if we are on the same page as the problem with
the form of force-with-lease without <expect>.

In this sequence of end-user operation

    $ git checkout --detach origin/target
    ... edit working tree files ...
    $ git commit --amend -a
    $ git push origin +HEAD:target

the user wanted to fix the topmost commit at the 'target' branch at
the origin repository, and force-update it.

The --force-with-lease is a way to make sure that the only commit
being lost by the force-update is the commit the user wanted to
amend.  If other users pushed to the 'target' branch in the
meantime, the forced push at the last step will lose it.

    $ git checkout --detach origin/target
    $ TO_LOSE=$(git rev-parse HEAD)
    ... edit working tree files ...
    $ git commit --amend -a
    $ git push origin --force-with-lease=target:$TO_LOSE HEAD:target

So we say "I knew, when I started working on the replacement, I
started at the commit $TO_LOSE; please stop my forced push if the
tip of 'target' was moved by somebody else, away from $TO_LOSE".

The force-with-lease without the exact <expect> object name, i.e.

    $ git push origin --force-with-lease=target HEAD:target

would break if 'origin/target' was updated anytime between the time
when the first "git checkout --detach" step finishes and the time
the last "git push" is run, because 'origin/target' would be
different from $TO_LOSE and things that were pushed to 'origin/target'
by others in the meantime will be lost, in addition to $TO_LOSE commit
that the user is willing to discard and replace.

> This problem can be addressed by checking the `reflog` of the branch
> that is being pushed and verify if there in a entry with the remote
> tracking ref.

Sorry, but it is unclear how reflog would help.

Before the "git checkout" step in the example, there would have been
a "git fetch" from the origin that brought the remote-tracking
branch 'origin/target' to the current state with a reflog entry for
it.  If an automated background process makes another fetch while
the user is editing files in the working tree, such a fetch may also
add another reflog entry for that action.

Unless you make a snapshot of the reflog state immediately after you
do "git checkout" in the example, you wouldn't know if there were
unexpected updates to the remote-tracking branch even if you check
the reflog.

Besides, you do not control the parenthood relationship between the
commits _other_ people push and update to 'target' branch at the
'origin' repository, so you cannot rely on the topology among them
to make any decision.  Other people may be force pushing to the
branch while you are preparing the commit to replace $TO_LOSE by
force pushing.

> +	The check ensures that the commit at the tip of the remote-tracking
> +	branch -- which may have been implicitly updated by tools that fetch
> +	remote refs by running linkgit:git-fetch[1] in the background -- has
> +	been integrated locally, when holding the "lease".

The problem with "expect-less" form is that it does not hold the
lease at all.  The point of "hold the lease" by giving an explicit
$TO_LOSE is to force a push that does not fast-forward, so if you
iterate over the remote-tracking branch at the time of "push", if
you find more commits built on top of $TO_LOSE because a background
fetch updated the branch, or if you find NO commits on top of $TO_LOSE
because no background fetch happened in the meantime, what would be
pushed would not fast-forward.  So I am not sure what the point of
iterating over reflog.

If we want an option to force a safer behaviour, I think adding a
configuration variable to forbid the form of force-with-lease
without <expect> would be one way to help.  Perhaps make it the
default, while allowing those who want to live dangerously to
explicitly turn it off.

Thanks.

