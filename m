Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B188C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiAQWQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 17:16:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51638 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiAQWQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 17:16:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27E1716070B;
        Mon, 17 Jan 2022 17:16:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bKtzZcCEed5xLRALcjrFSB1/iJSTwpPdhLdJoE
        p7KkM=; b=xUjTP96V6SVRbOa9XVhTniYWo3IJ1TGl83RlvJTU3ZyPEcd/lGkxL+
        xGa9iVenebTaCmkPz6xbympkSh+MwKbEiS1WsfW5Zri6g+DNyr4yEC6V5kCriN4h
        9ilA8BzCnYcXzwEWSUUdJQVsdqy6SEVQEmrRnk0KglKNc5j6FA9Ws=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2067A16070A;
        Mon, 17 Jan 2022 17:16:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D4FF160708;
        Mon, 17 Jan 2022 17:16:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
        <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
        <xmqqh7a2uphk.fsf@gitster.g>
        <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
Date:   Mon, 17 Jan 2022 14:16:09 -0800
In-Reply-To: <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 Jan 2022 13:21:11 -0800")
Message-ID: <xmqq35lmuhxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1340B594-77E3-11EC-AF05-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jan 17, 2022 at 11:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > In commit 8b09a900a1 ("merge-ort: restart merge with cached renames to
>> > reduce process entry cost", 2021-07-16), we noted that in the merge-ort
>> > steps of
>> >     collect_merge_info()
>> >     detect_and_process_renames()
>> >     process_entries()
>> > that process_entries() was expensive, and we could often make it cheaper
>> > by changing this to
>> >     collect_merge_info()
>> >     detect_and_process_renames()
>> >     <cache all the renames, and restart>
>> >     collect_merge_info()
>> >     detect_and_process_renames()
>> >     process_entries()
>> > because the second collect_merge_info() would be cheaper (we could avoid
>> > traversing into some directories), the second
>> > detect_and_process_renames() would be free since we had already detected
>> > all renames, and then process_entries() has far fewer entries to handle.
>> >
>> > However, this was built on the assumption that the first
>> > detect_and_process_renames() actually detected all potential renames.
>> > If someone has merge.renameLimit set to some small value, that
>> > assumption is violated which manifests later with the following message:
>> >
>> >     $ git -c merge.renameLimit=1 rebase upstream
>> >     ...
>> >     git: merge-ort.c:546: clear_or_reinit_internal_opts: Assertion
>> >     `renames->cached_pairs_valid_side == 0' failed.
>> >
>> > Turn off this cache-renames-and-restart whenever we cannot detect all
>> > renames, and add a testcase that would have caught this problem.
>> >
>> > Reported-by: Taylor Blau <me@ttaylorr.com>
>> > Signed-off-by: Elijah Newren <newren@gmail.com>
>> > ---
>>
>> Thanks.  An Ack?
>
> Taylor told me the code change fixed his case, and that he'd review my
> full patch with the testcase when I posted it.  Let's wait to hear
> from him.

Yes, I am waiting (notice who is on To: and not Cc: on the message
you are responding to ;-).

Thanks.
