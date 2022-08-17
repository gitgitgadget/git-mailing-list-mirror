Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B4CC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbiHQTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbiHQTM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 15:12:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF47A1D71
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:12:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0046714106F;
        Wed, 17 Aug 2022 15:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dkjHUKH2hFDTwasq5chANXl5IXIdopry02HKkva5R88=; b=VfU/
        CaxHJ0UNVUOv5mA/ZUWUeZ+us1wQsGpM/cbWuuz2alTcVLqjMnrQSNmNs79L6jjt
        ezxSaacD4jz2i+AxRPg0DuUH2QUyxeZi6bB81szpQAGH3yQpl+u8oj2pwQN3ToHF
        0kPN22RgVCvVBjryEyppDy0VQso2IbsOz3WIT+w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED70A14106E;
        Wed, 17 Aug 2022 15:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E7CC14106D;
        Wed, 17 Aug 2022 15:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
        <xmqqilmzkd7p.fsf@gitster.g>
        <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
        <xmqqedxgt1zx.fsf@gitster.g>
        <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
Date:   Wed, 17 Aug 2022 12:12:54 -0700
Message-ID: <xmqqbksivg3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 992F7248-1E60-11ED-9DF4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To reiterate why reducing the reliance on POSIX shell scripting is a good
> thing:
>
> - we pay a steep price in the form of performance issues (you will recall

Irrelevant.  Who uses resolve these days?

> - have you ever attempted to debug a Git invocation that involves spawning
>   a shell script that in turn spawns the failing Git command, using `gdb`?

Remember, I have been doing this longer than you have, so of course
I have, but I do not think it is relevant.  An external program as a
merge strategy does not have to be written in shell, but third-party
strategies can be written in anything, so some who choose to do so
may still have to.  There is no avoiding that.

What our contributors, new and old, need to do is to maintain the
codepath that spawns these third-party strategy programs working.

There were two steps I gave review messages to, and the one I had
more trouble with was actually not the [08/14] you are making big
fuss about.  It was the "we no longer spawn resolve or octopus"
step(s).  If we really want to rewrite "resolve" in C, while I think
there are better ways to use our resources, rewriting it by itself
would not _hurt_ the project all that much, as long as we keep it an
external program.

And by "maintain the codepath working", we would want to catch silly
mistakes while "refactoring", like the one we had when we changed
the underlying machinery to spawn hooks in a recent release, without
caring (I wouldn't say "without knowing"; those who did and reviewed
the change including me didn't even think about how the standard I/O
streams are seen by hook scripts and how they react to them).  Just
like tests around small toy sample hooks did not catch the
regression, "a small toy sample that is only spawned in a test piece
or two to pretend to be a merge strategy program" would not be a
good substitute for running something real.


