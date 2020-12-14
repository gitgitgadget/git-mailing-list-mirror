Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E9BC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D283C22510
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502646AbgLNTuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:50:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63734 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502796AbgLNTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:49:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61A8811A00F;
        Mon, 14 Dec 2020 14:49:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uUPJiHXI8XAyAiher6G5UCiYybE=; b=fzsdnG
        thGrq9OgmnmhYMLuv7yg7OmDwQWaFa95uGQtaQOu7FJ94RlHxmO5T7qY+pxu0Qht
        eWf5e4lyX2t+snW/b8uMLNbSd2/JIB9l0oEqDmGGqMLGY4Y6aHES6b1eeN+DDcN2
        ogusynUobEDp0G8T1hXMONeKFSyj0KRP1XSKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=omPZPDoK50cvwOUbPVMDFW1Z4Tr7w/Ok
        3S2605p5VrRRjKBwD6VjQXuR2xQDBDVfKuavvCyzb2MiiRrsGelJyw062VpQIIvT
        2Fj8JIoOI6j4F0wMCocuqBIivfFXjhSU5gGB0bhRWHCXor1jVWposK3wvdykPKYm
        SB2emy0PSaI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A2D311A00E;
        Mon, 14 Dec 2020 14:49:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A907311A00D;
        Mon, 14 Dec 2020 14:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected behavior on diff -I<regex> --name-only
References: <20201214190054.lrdllbpf6jfrz573@gmail.com>
Date:   Mon, 14 Dec 2020 11:49:06 -0800
In-Reply-To: <20201214190054.lrdllbpf6jfrz573@gmail.com> (Johannes
        Altmanninger's message of "Mon, 14 Dec 2020 20:00:54 +0100")
Message-ID: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E2D795C-3E45-11EB-8EE6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> Since v2.28.0-2-g296d4a94e7 (diff: add -I<regex> that ignores matching changes)
> diff -I<regex> can be used to suppress hunks of only matching lines.
> This interacts in a surprising way with --name-only, which lists
> all changed files, regardless of whether they are filtered out by -I<regex>:
>
> 	git diff HEAD~ -I ''			# always empty
> 	git diff HEAD~ -I '' --name-only	# not empty, "-I" does nothing
>
> It could be nice to only show names of files with matching hunks
> (or reject this combination of options?).

Interesting.  

This is not a new issue limited to -I at all.  If you did this:

	$ echo "hello" >world
	$ git add world ; git commit -m 'add world'
	$ echo " hello" >world ; git add world
	$ git diff -w --cached
	$ git diff --name-only --cached
	world
	$ git diff --name-only -w --cached
	world

I think "--name-only", and perhaps other options, has too aggressive
an optimization that takes advantage of the fact that we can tell if
a path has changed or not without looking at the contents at all by
looking at the object name recorded.  That optimization may have
been valid until many newer and more expensive features came around,
but not anymore.

I think diff.c::flush_one_pair() needs to learn to pay attention to
opt->diff_from_contents in its third branch where DIFF_FORMAT_NAME
is handled.  I do not offhand remember if -I flips diff_from_contents
bit, but I wouldn't be surprised if the recent change added the
support for -I forgot to do so.

Thanks.









