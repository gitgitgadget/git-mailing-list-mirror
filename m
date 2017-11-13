Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BCAD201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdKMDEQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:04:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751125AbdKMDEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:04:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18D04B544D;
        Sun, 12 Nov 2017 22:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6qUCC7z56D9T5SpJE6uDTCltBs=; b=ojonZQ
        w0PevSV/ZpLsR+czbiVkiNmIp1/q5+9d8lsWcjw5fgIHoummZLf2hTtvrI7rjvRb
        xpgy9crUjju4wURHe5rGovYFvJU1RvrlgYvZUSohO1Uyl1Cv7ZkLsEPBBWLXRtr4
        CIaX8txHx3CN9cfNHj4wAhu8AFo8PT551kNV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xGfipr8cR/MYi0CJiiwh7Vn91fIcgxwl
        45yuBQaohdi02KLDdjXsfsqz/VEJ9MsgE9Fir/zG62ISARQVttrsUJNXg2gIuctP
        cXmwkWEQK681QNIZ1ou9vzShkWqqV4ZCFib6mCkA4uKKcgmXMeNjrnMrKFv13Mzm
        MEARbzX4Zmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F00B544A;
        Sun, 12 Nov 2017 22:04:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 802AEB5449;
        Sun, 12 Nov 2017 22:04:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
References: <20171112134305.3949-1-t.gummerer@gmail.com>
        <20171112134305.3949-2-t.gummerer@gmail.com>
Date:   Mon, 13 Nov 2017 12:04:11 +0900
In-Reply-To: <20171112134305.3949-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 12 Nov 2017 13:43:05 +0000")
Message-ID: <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 535003CE-C81F-11E7-9F80-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I'm a bit torn about hiding his behind an additional flag in git
> worktree add or not.  I would like to have the feature without the
> additional flag, but it might break some peoples expectations, so
> dunno.

Yeah, I agree with the sentiment.  But what expectation would we be
breaking, I wonder (see below)?

At the conceptual level, it is even more unfortunate that "git
worktree --help" says this for "git worktree add <path> [<branch>]":

    If `<branch>` is omitted and neither `-b` nor `-B` nor
    `--detach` used, then, as a convenience, a new branch based at
    HEAD is created automatically, as if `-b $(basename <path>)` was
    specified.

which means that it already does a DWIM, namely "since you didn't
say what branch to create to track what other branch, we'll fork one
for you from the HEAD, and give a name to it".  That may be a useful
DWIM for some existing users sometimes, and you may even find it
useful some of the time but not always.  Different people mean
different things in different situations, and there is no single
definition for DWIMming that would fit all of them.

Which in turn means that the new variable name DWIM_NEW_BRANCH and
the new option name GUESS are way underspecified.  You'd need to
name them after the "kind" of dwim; otherwise, not only the future
additions for new (third) kind of dwim would become cumbersome, but
readers of the code would be confused if they are about the existing
dwim (fork a new branch from HEAD and give it a name guessed by the
pathname) or your new dwim.

This also needs a documentation update.  Unlike the existing DWIM,
it is totally unclear when you are dwimming in absence of which
option.

I am guessing that, when you do not have a branch "topic" but your
upstream does, saying

    $ git worktree add ../a-new-worktree topic

would create "refs/heads/topic" to build on top of
"refs/remotes/origin/topic" just like "git checkout topic" would.

IOW, when fully spelled out:

    $ git branch -t -b topic origin/topic
    $ git worktree add ../a-new-worktree topic

is what your DWIM does?  Am I following you correctly?

If so, as long as the new DWIM kicks in ONLY when "topic" does not
exist, I suspect that there is no backward compatibility worries.
The command line

    $ git worktree add ../a-new-worktree topic

would just have failed because three was no 'topic' branch yet, no?

