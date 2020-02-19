Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E6C5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADEB24670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSeNnueL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBSWJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:09:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53919 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBSWJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 17:09:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCB9C3ECDB;
        Wed, 19 Feb 2020 17:09:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hLvR75bAX3bx2nUx9MOgn7728PU=; b=MSeNnu
        eLRhu2xMCuRIjaT3yukB3LWl3mOHWUpbboWS7COHMAGQzGraqRN8F/DkEkTGKEqT
        eJuTClnCjueysY8swYQdVf7XJoSnq2ELQTu76G+266BZJKvT17nOFlfEjVEnlPTI
        dNcE40HmoBYgz5CbndP5k+K27h+txjEjnML8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JYNq6R5omO70Rb/CI7msXCCupMGDnXuY
        82Y5WRzgyym+lRMPAAdoWCen6HLFqJKNpjFl4w1jSGfPETgAQZUNgmSp8h84L4x2
        xvGK6m1/vjnNBQww/l7+owEwo+K6AYzagolOkNpZFdRPzuPXHiqY4wKHip9/F2lA
        gjrG79031+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4BD43ECD9;
        Wed, 19 Feb 2020 17:09:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 283303ECD8;
        Wed, 19 Feb 2020 17:09:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-4-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet>
        <xmqq7e0ih5zr.fsf@gitster-ct.c.googlers.com>
        <20200219215231.GA26221@google.com>
Date:   Wed, 19 Feb 2020 14:09:48 -0800
In-Reply-To: <20200219215231.GA26221@google.com> (Emily Shaffer's message of
        "Wed, 19 Feb 2020 13:52:31 -0800")
Message-ID: <xmqqtv3mcjpv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C2CE73E-5364-11EA-9988-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> launch_specified_editor() has a handful of exit points, of three kinds:
>  1. return error(something)
>  2. raise(sigsomething)
>  3. return 0
>     a. when the editor process closed happily, but the user supplied
>        NULL instead of a buffer. That is, the user didn't want the
>        contents of the editor given back to them in a strbuf.
>     b. when the editor process closed happily and the user's supplied
>        buffer was filled with the file's contents with no issue.
>
> So I think we can check "yes" here.

Heh.  If we raised a signal to kill ourselves, then we won't be
returning a value from launch_editor() anyway.  That case won't
affect the "between returning negation or !!, which is more
appropriate?" discussion, I think.

>>  - we MUST NOT care to differenciate different error codes returned
>>    from launch_editor().  IOW, we must be fine to give the invoker
>>    of the program only 0 (success) or 1 (unspecified failure).

I actually think this holds for the codepath.  A failure from
start_command() returns error(), and finish_command() that waits for
the spawned editor process to complete yields the exit status from
the editor, but unless we re-raise the signal that killed the editor
process to ourselves, we just turn any non-zero exit into "return
error()", so it is safe to say launch_editor() can return either 0
or -1 and nothing else.  Would we later want to tell callers of
launch_editor() how/why the editor session failed by returning
something else?  I do not offhand think of any---we do not even
differenciate between failure to start (e.g. misspelt command name
for the editor) and other failures WITH the return value and
consider it sufficient to tell the user with different error
message right now.

So in practice returning -launch_editor() and !!launch_editor()
would not make any difference, I would think.

