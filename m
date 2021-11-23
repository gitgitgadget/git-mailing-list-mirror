Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A5C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhKWRNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:13:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61050 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhKWRNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:13:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8DEFCA21;
        Tue, 23 Nov 2021 12:10:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fL0W5w1GwklXDh4kPU1D7DzJMcrSts+hW4ShqA
        zVzLA=; b=d7MQ+Pk9LIOaUDiHPL2mvg/dwPS9On85L0KnLMRa7vH2BfR9K3DWc6
        ueMZcx3z15CHd+TXxtYf5EyQpS573k6usE53aGWjJzaFwtf+ISxx2WAozEoYThL/
        dxUmEl+ChPDHDRrdOtGwDk7at3IXFSUT4BSSdGxxYxipKs9ZnAgdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24554FCA1F;
        Tue, 23 Nov 2021 12:10:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49A2EFCA1E;
        Tue, 23 Nov 2021 12:10:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
Date:   Tue, 23 Nov 2021 09:09:59 -0800
In-Reply-To: <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 23 Nov 2021 17:35:52 +0100")
Message-ID: <xmqqczmqajdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3230EA7A-4C80-11EC-AB89-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Nov 22, 2021 at 11:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If this were truly "user-provided", then I'd argue that all backends
>> should follow whatever the files backend has been doing forever---if
>> the files added LF implicitly, others should, too, because that is
>> pretty much what these "user-provided" callbacks have been expecting
>> to see.
>
> I think it's just wrong. If you pass `msg` to a storage API, you
> should get `msg` when you read it back, not (msg + "\n").

If you give a log message "git commit -m 'single line'", you get LF
at the end of the commit message for free.  This is no different.
And you know that this is not a "storage API" that stores the input
in verbatim after looking at refs.c::copy_reflog_msg().

>> Ah, the $RUN is hiding what is really going on; it is running the
>> "test-tool ref-store" helper, and we did not adjust that helper.  So
>> if we make a compensating change to the test-tool then we do not
>> have to have these changes at all?  But that point may be moot.
>>
>> In any case, in order to lose 5 lines from show-branch.c, and 2
>> lines from reflog-walk.c, I see that we had to touch 30+ lines in
>> refs/files-backend.c.  I find it a bit hard to sell this as an
>> improvement to the API, to be honest.
>
> The test-tool ref-store adds its own '\n', so you always get a blank
> line in the output. That serves no purpose, and leads to the

But that is only because test-tool is wrong, no?  If we know that
the API gives the trailing LF, what purpose does it serve to add
another one?

>   tail-n2  | head -n1
>
> in order to read the last log line. I think it's silly, and should be dropped.

Yes, it is silly and should be dropped, but if you drop it on the
tool side, then it may become even easier to do the "instead of
reading from .git/refs/logs files, have the tool dump and inspect
that" step, no?

This being test-tool, I do not mind losing backward compatibility
that forces us a silly "tail -n 2 | head -n 1" pipeline at all.  But
if silliness comes from the test-tool thta does not work well with
the internal API, that is what should be fixed.  Surely you can
change the API and its current callers to compensate for its silliness,
but I do not think that is a good direction to go in.

Thanks.

