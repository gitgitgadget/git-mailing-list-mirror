Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F3C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EC26109E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFUDpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:45:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65345 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhFUDpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 23:45:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F7CF14C111;
        Sun, 20 Jun 2021 23:43:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=VKYgAbW5oLOJN2N9dQ3Hwe+R2kkK8kxByGCK/+ZlUtU=; b=fuTg
        3o5eiw069c93S6fstUtbkDvr16DlBD3HhNffwJIr1bKl5uFIHmqLavnEOneD4Qwt
        l8ueTlDreZFErVvicxtRceI2N9U+d+n10/fH5CHR7xpU+FfFa0oGbtS2nvP/iqLX
        lxzy6ueok0nTzjpVhicJrsuG+Jccbc20OadwU+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 384CB14C110;
        Sun, 20 Jun 2021 23:43:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D85514C10F;
        Sun, 20 Jun 2021 23:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     git@vger.kernel.org, Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
References: <20210620213836.10771-1-rhi@pengutronix.de>
X-Gnus-Delayed: Mon, 21 Jun 2021 16:09:03 +0900
Date:   Mon, 21 Jun 2021 12:43:32 +0900
Message-ID: <xmqqy2b3j317.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DACA3A1E-D242-11EB-9744-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roland Hieber <rhi@pengutronix.de> writes:

> Currently, calling 'git bisect' from a directory other than the top
> level of a repository only comes up with an error message:
>
>     You need to run this command from the toplevel of the working tree.
>
> After a glance through the bisect code, there seems to be nothing that
> relies on the current working directory, and a few hours of bisect usage
> also didn't turn up any problems. Set the appropriate flag for
> git-sh-setup to remove the error message.

Try to find a history in which to run a bisect that

 (1) has a directory T in the recent part of the history, and

 (2) does not have that directory in the older part of the history.
     Better yet, if the older part of the history has T as a regular
     file, that would be ideal.  Even better, if that old regular
     file T was added, then removed, and then recreated, before it
     got turned into a directory.

Now, using the two commits you used to satisfy conditions (1) and
(2) as "bad" and "good", and using "bad - has T as a directory" and
"good - does not have T as a directory", as the bisection criterion,
try to find where "good" turns "bad"---in other words, find the
commit that either creates T as a directory or turns the regular
file T into a directory.

Perform that bisect from the subdirectory T.  Would that work?  I
suspect it wouldn't; when trying to check out an old version that
does not have T in the directory, either the checkout would fail
because it cannot remove T which has an active process (i.e. your
terminal session) in it, or your process sitting in an orphaned
directory (i.e. your ".." may still be the original top-level
directory that used to have T subdirectory, but "cd T" from the
top-level will not reach where you are).  All sorts of things can
go wrong and that is why we forbid it.  Just a single "cd" upfront
would save the user a lot of headache.

This does not depend on "do we have T as a directory?" being the
bisection criteria.  The important thing is that the current
directory would appear and disappear as the bisection process makes
you jump around in the history.

Hope this helps understanding the issue.
