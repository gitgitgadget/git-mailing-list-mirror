Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E1C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 20:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhKWUhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:37:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59295 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhKWUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:37:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5D8D15E33A;
        Tue, 23 Nov 2021 15:34:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0OtoxpdBHxg0ADr3ADOp9TtOFnsMq/ST2gK5z
        6dVls=; b=ZN9Jw68AvUud3iXia2wuDmWtEkSIDj0vOAwToJ4XLRHl7IKo0SHeOL
        H1VDSj7nWSVeQo/DEJ83e0HsgDNklAqmAwQjY8qJoWhfWleBcjdNU0JDxVPUv1Iu
        gI+Pp7BbrUtThWdoilmFQ2tjTMZ0P0UnN3nJZ4OUf2ok1pe7r0vVI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE7EB15E339;
        Tue, 23 Nov 2021 15:34:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45D6C15E338;
        Tue, 23 Nov 2021 15:34:29 -0500 (EST)
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
Date:   Tue, 23 Nov 2021 12:34:28 -0800
In-Reply-To: <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 23 Nov 2021 18:28:24 +0100")
Message-ID: <xmqqzgpu7grv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1E13262-4C9C-11EC-8AF2-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I'm talking about refs/refs-internal.h. It seems you want to add something like
>
> /* The ref backend should add a '\n' relative to the message supplied
> to the delete/symref/update functions. */
> typedef int for_each_reflog_ent_fn(struct ref_store *ref_store,
>                                    const char *refname,
>                                    each_reflog_ent_fn fn,
>                                    void *cb_data);
>
> ?

Sorry, I do not follow.  Doesn't the ref backend already ensure that
the message is not an incomplete line?  If you feed a single
complete line when updating, I do not think the backend should add
any extra LF relative to the given message:

    $ git update-ref -m 'creating a new branch manually
    ' refs/heads/newtest master
    $ git update-ref -m 'updating a new branch manually
    ' refs/heads/newtest master~1
    $ git reflog refs/heads/newtest
    4150a1677b refs/heads/newtest@{0}: updating a new branch manually
    5f439a0ecf refs/heads/newtest@{1}: updating the reference

I think what deserves such a comment more is the prototype for
each_reflog_ent_fn describing what the parameters to that callback
function, to help the callers of the iterator what to expect.  That
is the end-user facing part.

/*
 * Callback to process a reflog entry found by the iteration functions (see
 * below)
 */
typedef int each_reflog_ent_fn(
		struct object_id *old_oid, struct object_id *new_oid,
		const char *committer, timestamp_t timestamp,
		int tz, const char *msg, void *cb_data);

Currently it only says "Callback (see below)" but "below" has only
comments about the difference between refs_for_each_reflog_ent() and
refs_for_each_reflog_entreverse() functions, and does not talk about
what "committer" looks like (i.e. does it give user.name equivalent,
user.name plus <user.email>, or something else?), and what "msg"
looks like (i.e. if a multi-line message was given when a ref was
updated or created, do we get these lines intact? if it gets
mangled, how? if the original was a single-liner incomplete line, do
we lack the final LF?), and how tz is encoded.

I think the rule for "msg" is that:

   a multi-line message, or a message on a single incomplete-line,
   are normalized into a single complete line, and callback gets a
   single complete line.

Once these rules get specified tightly and fully, it is up to the
ref(log) backends how to implement the interface.  If files-backend
wants to keep LF at the end of the message when storing (so that it
can easily use it as record delimiter), it can do so and reuse the
LF at the end of the message as part of the msg parameter to the
callback.  If another backend wants to drop LF at the end of the
message when storing (to save space), it can do so as long as the
callback function gets the LF just like the other backend.

