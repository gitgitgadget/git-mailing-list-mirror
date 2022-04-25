Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF8C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 21:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbiDYVUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245722AbiDYVUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 17:20:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1883E0DF
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 14:17:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55CB211D2A7;
        Mon, 25 Apr 2022 17:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iKK2iotqVxiLlt20jbp9b5O/Z2TAcSXQoklm3F
        KhAx4=; b=TICYINU05JW0PUhrEHfp5LUUul3E0VL2lJP4maa8MGaeRHG1UiJL7e
        GLyHQssJKvbBYDUsmELj/R742tntaOmhnH6bPn5Fc9Z2wTB/0ba72guBs2t0sQ9p
        3TeUsEj59e1JY0CX4iLiGGeCs3h/x+cj+YQblpOK+l0zohymD5Yfs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E3ED11D2A6;
        Mon, 25 Apr 2022 17:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4DFA11D2A5;
        Mon, 25 Apr 2022 17:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan <git.jonathan.bressat@gmail.com>
Cc:     Jonathan.bressat@etu.univ-lyon1.fr, Matthieu.Moy@univ-lyon1.fr,
        cogoni.guillaume@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge
 conflicts
References: <xmqqfsmg97ac.fsf@gitster.g>
        <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
Date:   Mon, 25 Apr 2022 14:16:57 -0700
In-Reply-To: <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
        (Jonathan's message of "Mon, 25 Apr 2022 22:27:19 +0200")
Message-ID: <xmqqczh4vp6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AADB6D8-C4DD-11EC-A616-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan <git.jonathan.bressat@gmail.com> writes:

> Because with this merge still fail for unstaged file that has the same
> content, because unstaged file are not exactly treated the same way.

Correct.  If you want to do this correctly, you'd need to make sure
that you'd clobber untracked files ONLY when you are not losing any
information.

And even with that, I think some existing users will be hurt with
this change in a huge way.  They may have untracked change locally
because they are not quite done with it yet, and somebody else
throws a pull request at them that has the same change as the local
modification.

They make a trial merge, look at the result, and discard it because
there are also unwanted changes in the branch they pulled into.

    $ git pull $URL $branch ;# responding to the pull request
    ... examine the result, finding it unsatisfactory ...
    $ git reset --hard ORIG_HEAD
    ... now we are back to where we started; well not really ...

Now, without this change, "git pull" used to stop until they stashed
away the untracked change safely.  But with this change, "git pull"
will succeed, and then "reset --hard" will discard it together with
other changes that came to us from $URL/$branch.  They lost their
local, uncommitted change.

And "but you can pull the equivalent out of $URL/$branch" is not a
good excuse.  They may not notice the lossage long after having
dealt with this pull request (there are busy people who are handling
many pull requests from many people) and they have been relying on
"git pull" that never clobbers their local uncommitted changes.  And
when they noticed the lossage, they may not even remember which one
of pull requests happened to have an identical change as their local
change to cause this lossage, simply because "git pull" that used to
stop just continued without a noise.

So, I am not sure if this is really a good idea to begin with.  It
certainly would make it slightly simpler in a trivial case, but it
surely looks like a dangerous behaviour change, especially if it is
done unconditionally.

> Our patch broke some test in t6436-merge-overwrite.sh so we think that
> we need to modify those tests to make them follow the patch.

Wait.  Isn't it backwards?  The existing tests _may_ be casting an
undesirable current behaviour in stone, but most of the time it is
protecting existing user's expectations.  If you have an untracked
file, you can rest assured that they won't be clobbered by a merge.

So we'd need to think twice and carefully examine if it makes sense
to update the expectations.  I haven't read the change to the tests,
so I cannot tell which case it is.

Thanks.
