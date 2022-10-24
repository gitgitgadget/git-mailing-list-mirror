Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0DDC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiJXU7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiJXU7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D61958C3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:05:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B617F1CAFFB;
        Mon, 24 Oct 2022 15:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q1xni537Jn/R7/o6xmfWuJWU+b3RfaueHYrHNH
        TkprQ=; b=CmTuXfY+DvIw0wVnHTPexec3zKQCCxZAjcJeN821SbV/aomdF4a35e
        1h+D7Lmot9EU+RCOwpwGy5DE0L06y/yCk0a/r/zSAGPgxgaEI466LQ9YrlQFrwBH
        wkuD6M41o9sCPPEGzfap0lbTPegs2Qw3VppW/ypmoybCiQs1ELzL4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE75E1CAFFA;
        Mon, 24 Oct 2022 15:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB31E1CAFF9;
        Mon, 24 Oct 2022 15:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to
 run_processes_parallel_opts
References: <20221020232532.1128326-2-calvinwan@google.com>
        <xmqq4jvxpw46.fsf@gitster.g>
        <CAFySSZABaWSKw_OxyPEU=C_iLOmPa=pPahWaeta=JaAf2q_GEg@mail.gmail.com>
Date:   Mon, 24 Oct 2022 12:04:36 -0700
In-Reply-To: <CAFySSZABaWSKw_OxyPEU=C_iLOmPa=pPahWaeta=JaAf2q_GEg@mail.gmail.com>
        (Calvin Wan's message of "Mon, 24 Oct 2022 10:00:56 -0700")
Message-ID: <xmqqilk9rqkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4AAF2C4-53CE-11ED-9130-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> In my review of one of the previous rounds, I asked which part of
>> this functionality fits the name "pipe", and I do not think I got a
>> satisfactory answer.  And after re-reading the patch in this round,
>> with the in-header comments, it still is not clear to me.
>>
>> It looks more like sending the duplicate of the normal output to a
>> side channel, somewhat like the "tee" utility, but I am not sure if
>> that is the intended way to be used.
>>
>
> In this case, I was hoping "pipe" would refer to the redirection of
> output from the child processes to a separate custom function, but
> I can see that duplication != redirection. Maybe something like
> "parse_child_output" or "parse_output" would make sense, however,
> I didn't want to imply with that name that the only functionality is to
> parse output. Besides that, I don't really have any other ideas of
> what I can name it...

Yeah, parsing is not to the point.  Sending a copy of output to
elsewhere is, so redirect is a better word than parse.  And piping
is not the only form of redirection, either.  If duplication is
really the point, then either giving it a name with a word that
signals "duplication" would make more sense.  "send_copy_fn"?  I am
not good at naming.

As a name that is not end-user facing, it is tempting to assume that
the readers have basic knowledge of Unix concepts and call it
"tee_fn", but it would be way too cryptic to uninitiated, so I would
not recommend it.

Hmm...
