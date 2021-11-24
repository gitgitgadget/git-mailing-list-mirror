Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CEC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbhKXTaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:30:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55539 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbhKXTaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:30:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55FB11669A6;
        Wed, 24 Nov 2021 14:27:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=luaJjhpUJZDPkiPlZHaRE8q7oNEnTtj5ab7mkH
        B06vE=; b=Cn5JbNRp4yfONlkzke/FiWLWCO5wPknT05mcgj72IqXEPvE4cfOZSM
        25rcJ/v0W0GpoK7TpscPiZyYrhxgfDeZaxMpjTA9q2vr+dOcoMgy5uFHo8Wr0faa
        ItHVmSVN5GAICb8mmJ6Buud8ChcRVAkSe7Z6g3eS4KOroyPC9zOJA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E2B61669A5;
        Wed, 24 Nov 2021 14:27:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE6AB1669A1;
        Wed, 24 Nov 2021 14:27:00 -0500 (EST)
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
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g>
        <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
Date:   Wed, 24 Nov 2021 11:26:59 -0800
In-Reply-To: <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 24 Nov 2021 12:17:04 +0100")
Message-ID: <xmqq1r352w3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F2817F4-4D5C-11EC-8BB0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> $ GIT_TRACE_REFS="1" git branch -m bla blub
> ..
> 12:03:59.408705 refs/debug.c:162        rename_ref: refs/heads/bla ->
> refs/heads/blub "Branch: renamed refs/heads/bla to refs/heads/blub": 0
>
> $ GIT_TRACE_REFS=1 git reflog show refs/heads/blub
> 12:04:23.277805 refs/debug.c:294        reflog_ent refs/heads/blub
> (ret 0): cd3e606211bb1cf8bc57f7d76bab98cc17a150bc ->
> cd3e606211bb1cf8bc57f7d76bab98cc17a150bc, Han-Wen Nienhuys
> <hanwen@google.com> 1637751839 "Branch: renamed refs/heads/bla to
> refs/heads/blub
> "
>
>> I think the rule for "msg" is that:
>>
>>    a multi-line message, or a message on a single incomplete-line,
>>    are normalized into a single complete line, and callback gets a
>>    single complete line.
>>
>
> That is not how it works today. The files backend verbatimly dumps the
> message supplied to it. (Maybe it should crash if there is a '\n' in
> the message).

I still am puzzled what you wanted to illustrate with the "git
branch -m bla" trace.  The call graph into the refs API looks like
this:

builtin/branch.c::cmd_branch()
 -> branch.c::create_branch()
    -> refs.c::ref_transaction_update()
       -> refs.c::ref_transaction_add_update()
    -> refs.c::ref_transaction_commit()

and the message the user gave is passed through in "msg" variable
without modification, when calling ref_transaction_update(), which
in turn makes a call to ref_transaction_add_update().  It does this:

    struct ref_update *ref_transaction_add_update(
                    struct ref_transaction *transaction,
                    const char *refname, unsigned int flags,
                    const struct object_id *new_oid,
                    const struct object_id *old_oid,
                    const char *msg)
    {
            struct ref_update *update;

            if (transaction->state != REF_TRANSACTION_OPEN)
                    BUG("update called for transaction that is not open");

            FLEX_ALLOC_STR(update, refname, refname);
            ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
            transaction->updates[transaction->nr++] = update;

            update->flags = flags;

            if (flags & REF_HAVE_NEW)
                    oidcpy(&update->new_oid, new_oid);
            if (flags & REF_HAVE_OLD)
                    oidcpy(&update->old_oid, old_oid);
            update->msg = normalize_reflog_message(msg);
            return update;
    }

And normalize_reflog_message() calls copy_reflog_msg() to squash
runs of isspace() bytes (note: that class includes LF) into a single
space, and runs rtrim(), so update->msg will get a single incomplete
line.  As I suspected in a separate message, I think my notion of
what happens in the ref API implementation common to all backends
and what happens in each backend, and hence my statements about the
distinction, were much fuzzier than yours, so I should say that I
consider that all of the above is happening in the common part
across all backends.  If normalize happens in ref-files, it should
happen in reftable backend, too, automatically.

The files-backend has no chance to even see an embedded LF in the
message when the transaction gets committed and the backend is
called, does it?  So I am not sure why we should crash upon seeing a
LF in the message.

In any case, it seems that as a comment to clarify the end-user
facing each_reflog_ent_fn() parameters, what you quoted above from
my message seems correct to me, after following the callgraph like
the above.  A 0-line (i.e. incomplete, like your 'bla' given to "git
branch"), 1-line (i.e. a single complete line, like the message I
gave to "update-ref -m" in my earlier illustration), or multi-line
message given when a reflog entry is created, is normalized and when
the each_reflog_ent_fn() callback is called, it is shown to the
callback function as a single complete line, with a LF at the end.

Phrased without the explanation specific to this discussion, but
with a bit more detail:

  The message given when a reflog entry was created, is normalized
  into a single line by turning each LF into a space, squeezing a
  run of multiple whitespaces into one space, and removing trailing
  whitespaces. The callback gets a single complete line in the 'msg'
  parameter.

perhaps?
