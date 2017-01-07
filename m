Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BA720756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdAGVER (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:04:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51954 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbdAGVEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:04:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 172495C89D;
        Sat,  7 Jan 2017 16:04:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gVjpNfnz4sKJ+gKEfiNsKV/dvTU=; b=rSV2MX
        YzjZMMgyZQ7E8A+6kcP+mWaMl8MeOYuSxsO/TruBcGzfZb/Ze/A6rwrfed1W2rVg
        xiwvCOxR8c5XCnU5AfeLc15Mms7K0z2cw0qfguNyW74vsmrdBFySiAZVb6bNAO/q
        5GsLi4PFwOObpkOoGfx9jQmn0qnd5lDlXejw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vqmXRdrHa4fzePu3wWH/xREpm9llBVEg
        jjE2aQ6fxd2NrwNXSXPNWuT/wCT6K2m8fHwgdcXUBM8X3RcgaR2/Xa/nSq/NMScL
        71b32xAPZSnCoaQADlmaJUXIgvhkgmWNC6PXDiuz0G8TGaBZfExPlpDxc42ELPUf
        3pWLhsSYxB4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E3495C89C;
        Sat,  7 Jan 2017 16:04:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DBE65C89B;
        Sat,  7 Jan 2017 16:04:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: --force-with-lease default behaviour
References: <CAAj3zPz-jMVoxNTRZ0iR1ZPTFh873gEo33QjynBE1vaHsMmg3A@mail.gmail.com>
        <CAAj3zPx4uMXhV7t86Cnn8SgmpXb2SGththYN7sHetOqL_JosMg@mail.gmail.com>
Date:   Sat, 07 Jan 2017 13:04:13 -0800
In-Reply-To: <CAAj3zPx4uMXhV7t86Cnn8SgmpXb2SGththYN7sHetOqL_JosMg@mail.gmail.com>
        (G. Sylvie Davies's message of "Wed, 4 Jan 2017 22:52:44 -0800")
Message-ID: <xmqq37gu4m5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D836DE6A-D51C-11E6-A514-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"G. Sylvie Davies" <sylvie@bit-booster.com> writes:

> I wonder if there's anything one could do to help those who type "git
> fetch" and still want to enjoy "--force-with-lease"...

The entire idea behind "force-with-lease" is that you plan to later
force update the tip of a branch at the remote to replace the commit
that used to be at the tip at some point, that you do not want other
people to have their own work on that branch that will be lost by
your later force-pushing, yet you cannot "lock" a branch at the
remote repository remotely because that goes against the distributed
nature of the development.  Instead of locking others out, forcing
others to wait and sit idle while you complete the material to be
force-pushed (which may never happen), you base your work on one
state of the remote branch, and make sure the remote branch hasn't
advanced in the meantime (or you redo your work)---the cost of the
extra work due to your planned force-pushing is beared by you, not
by others.

There however is no place in Git where you explicitly declare "this
is where I start working on producing a new commit.  That commit
will replace this state and will not fast-forward from it." and
store it locally.  The "--force-with-lease" was designed to take
that information from the command line, expecting that the script
that drives it does something like

	#!/bin/sh
	LEASE=$(git rev-parse --verify @{u})
	# do whatever that requires non-fast-forward push
	git commit --amend ...
	... maybe more ...
	# finally push it out
	git push --force-with-lease $LEASE ...

Lazy people decided that as long as they promise to themselves that
they are not going to do anything to cause @{u} to move, they can
use it as a lazy-man's approximate.  Perhaps that was a misguided
attempt to add convenience.

A possible answer to your wordering may be to deprecate the
defaulting to @{u} and always require the expected commit to be
specified explicitly.


