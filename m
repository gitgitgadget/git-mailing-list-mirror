Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A361F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 04:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKRECZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 23:02:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52153 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKRECY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 23:02:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2BAA8E366;
        Sun, 17 Nov 2019 23:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCI2tLieaxpi159VtFz5raBZ1WI=; b=u5b4/Z
        k+LKyH/rVVG6c+8SFXF7jcOn9r4z7rIaKBM/WDGraVB8e2EME8zHUCkLmfxb6fMm
        P0G1sspyZwQJleyUlqXzMxPrz5URx/GauTBFgULuIPttigL7ShgyneVs2bVwEQgr
        gnPvklzh5oZAWy+pR78QL765r/8z3yqH5CYUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CHyjA6+s4FfRjbgLeaPZ6DE4kiS6nUDM
        YGhSBVomflQ7wMqK5YdoECIPRWYQXkLA0CoZn6LWGVed47SqhKFi6LOfsIVDosHe
        K5rX6lEceUS6WsXxY5MiJ1KXsO+DTSa6K/7MXUZr5jVKuMCW/d6Sl2pPRkA/tJAI
        MrzJO0u9oio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB9DF8E365;
        Sun, 17 Nov 2019 23:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA34C8E362;
        Sun, 17 Nov 2019 23:02:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC PATCH] wt-status: show amended content when verbose
References: <20191116161856.28883-1-me@yadavpratyush.com>
        <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 13:02:14 +0900
In-Reply-To: <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 18 Nov 2019 12:36:20 +0900")
Message-ID: <xmqq4kz13k8p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35D18FCA-09B8-11EA-81FD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Pratyush Yadav <me@yadavpratyush.com> writes:
>
>> I am working on a simple little feature which shows the "amended
>> content" when running 'git-commit -v'. Currently, only the changes in
>> the _entire_ commit are shown. In a large commit, it is difficult to
>> spot a line or two that were amended. So, show just the amended content
>> in a different section.
>
> [jc: even though the diff generation is done before the final commit
> is made, let me refer to the commits with refs _after_ the amend is
> done].
>
> You want to show changes between HEAD@{1}..HEAD (which is what the
> "amend" did) in addition to changes between HEAD^..HEAD (which is
> what the "amended commit" does) separately.
>
> The reason why "git commit -v" lets you see the diff since HEAD^ is
> to help you write the commit log message.  So it is wrong to show
> only "what the amend did", as the message you would be writing while
> amending is to explain the entire "why the amended commit does what
> it does" and by definition the log message for "amend" should not
> talk about "why the amend did what it did"---the readers would not
> even have access to the older version before the amend.
>
> It too makes quite a lot of sense to allow readers to see what the
> 'amend' did, but that is not something that would help write the log
> message.  And that is why "git commit -v --amend" does not show it.
> It should be inspected even _before_ the user contemplates to run
> "git commit --amend" (e.g. "git diff HEAD" before starting to amend).
>
> So, I am not enthused with this change---it sends a wrong message
> (i.e. what the diff in the editor "commit -v" gives the user for).

Having said that, I also wonder two things.  Assuming that it may be
a good idea to show "what the amend does" in addition to "what the
amended commit does",

 1. would it make sense to show a combined diff to show the
    differences among the state being recorded in the amended commit
    as if it were a merge between the state in the original commit
    and the state in the parent commit?

 2. would it make sense to show the differences between
    HEAD^..HEAD@{1} and between HEAD^..HEAD using the range-diff
    machinery.

I think #1 may turn out to be more useful (I haven't tried it,
though) because we already show a moral equivalent elsewhere, namely
in "git stash show".

Conceptually, it would be similar to showing a stash entry that
records the state where some changes have been already added to the
index and some other changes are still in the working tree---the
base commit of such a stash entry corresponds to the parent commit
of the commit being amended, the contents from the index of such a
stash entry corresponds to the commit being amended, and the
contents from the working tree of such a stash entry corresponds to
the final contents you are trying to record as an amended commit.

