Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACF61F6DC
	for <e@80x24.org>; Mon, 30 Jan 2017 01:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbdA3BA1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 20:00:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750946AbdA3BA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 20:00:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 823A5648BF;
        Sun, 29 Jan 2017 20:00:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X7PT9hyekeYYJsw25UvjFJVTmfU=; b=OXrtAc
        D4iZhE7EsjYq7l1l4u7aFEXf6KrTwsaZFshg4GWeMs7iA4dU/vljLQG//KOqAh86
        9FjhiMS7OflZEXLecSAVyS1nLjLZ/DY5J11aOQG+Bh3+NRXooQXQ/rSvOJMUSqQB
        Kcn/e7nbklNaq88wErzfEQO/9NMZckVhg8JzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QS12nWY+pxVsh0w5B1FTriOoXgdZM6rO
        iTMAM0Tbk+DdZ9qHBJw6MLJbPMSfv8UMLQICWJNjAkpF7yqxTeM4Ci6d4FOvQiVE
        /FPrA1bfPVfRjrV1y6FvtKm4doiC0V6ZeQL5Ou2PDwXnPvguxPxBnIHMZ2HADXfJ
        uJDZMpQm0s8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 793C3648B7;
        Sun, 29 Jan 2017 20:00:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2F85648B2;
        Sun, 29 Jan 2017 20:00:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Wood <carlo@alinoe.com>, Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: git push failing when push.recurseSubmodules on-demand and git commit --amend was used in submodule.
References: <20170129203348.1a8c0722@hikaru>
Date:   Sun, 29 Jan 2017 17:00:22 -0800
In-Reply-To: <20170129203348.1a8c0722@hikaru> (Carlo Wood's message of "Sun,
        29 Jan 2017 20:33:48 +0100")
Message-ID: <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AF83FA6-E687-11E6-B978-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Wood <carlo@alinoe.com> writes:

> there seems to be a problem with using 'git commit --amend' in
> git submodules when using 'git push --recurse-submodules=on-demand'
> in the parent.
>
> The latter fails, saying "The following submodule paths contain changes
> that can not be found on any remote:" for such submodule, even though
> the submodule is clean, pushed and reports 'Everything up-to-date'
> when trying to push it.
>
> I believe that the reason has to be that the parent repository thinks
> that the comment that was amended, but not pushed, must be on the remote
> too, while the whole point of amend is that this commit is not pushed.

I am not super familiar with the actualy implementation of the
codepaths involved in this, so CC'ed the folks who can help you
better.

I suspect the submodule folks would say it is working as intended,
if \

 - you made a commit in the submodule;
 - recorded the resulting commit in the superproject;
 - you amended the commit in the submodule; and then
 - you did "push, while pushing out in the submodule as needed" from
   the superproject.

There are two commits in the submodule that are involved in the
above scenario, and the first one before amending is needed by the
other participants of the project in order for them to check out
what you are trying to push in the superproject, because that is
what the superproject's tree records.  You somehow need to make that
commit available to them, but after you amended, the original commit
may no longer be reachable from any branch in your submodule, so
even if you (or the "on-demand" mechanism) pushed any and all
branches out, that would not make the needed commit available to
others.  If you push your top-level superproject out in such a
situation, you would break others.

I think you have two options.

 1. If the amend was done to improve things in submodule but is not
    quite ready, then get rid of that amended commit and restore the
    branch in the submodule to the state before you amended, i.e.
    the tip of the branch will become the same commit as the one
    that is recorded in the superproject.  Then push the submodule
    and the superproject out.  After that, move the submodule branch
    to point at the amended commit (or record the amended commit as
    a child of the commit you pushed out).

 2. If the amend is good and ready to go, "git add" to update the
    superproject to make that amended result the one that is needed
    in the submodule.
