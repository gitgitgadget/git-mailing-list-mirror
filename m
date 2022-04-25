Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79027C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 23:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiDYXN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiDYXN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 19:13:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A46032065
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 16:10:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5112E18A2DD;
        Mon, 25 Apr 2022 19:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n55Q7iHVaiWo9P3r2WzVpUMrWGaHGuXZGuipmG
        2/YEk=; b=dF9y0WaRCseM9/ubMtPhBlhYvnxWej1Mct2C8EJJKe0F+t1fSvm8Sr
        U4q1T5wylcYw1/PbjPej/H9yLodsoDVu+0nIcwbOOZ3eTvxjHNCv1Td6WW25nQXQ
        wmFczNkazf8W10cMdtLjWJhy7sFEumi0mAS5RAN1xWAxGqT7liDY8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48FA318A2DB;
        Mon, 25 Apr 2022 19:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAC7818A2DA;
        Mon, 25 Apr 2022 19:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillaume Cogoni <cogoni.guillaume@gmail.com>
Cc:     Jonathan <git.jonathan.bressat@gmail.com>,
        Jonathan.bressat@etu.univ-lyon1.fr,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>, git@vger.kernel.org,
        guillaume.cogoni@gmail.com
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge
 conflicts
References: <xmqqfsmg97ac.fsf@gitster.g>
        <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
        <xmqqczh4vp6e.fsf@gitster.g>
        <CAA0Qn1u50ncejNtWs1AV5tcXjFC-jnmnvjFkBDQyqU4Wcvoy0g@mail.gmail.com>
Date:   Mon, 25 Apr 2022 16:10:45 -0700
In-Reply-To: <CAA0Qn1u50ncejNtWs1AV5tcXjFC-jnmnvjFkBDQyqU4Wcvoy0g@mail.gmail.com>
        (Guillaume Cogoni's message of "Tue, 26 Apr 2022 00:28:57 +0200")
Message-ID: <xmqqee1ku5ca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F088E1B4-C4EC-11EC-81C8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillaume Cogoni <cogoni.guillaume@gmail.com> writes:

>> So, I am not sure if this is really a good idea to begin with.  It
>> certainly would make it slightly simpler in a trivial case, but it
>> surely looks like a dangerous behaviour change, especially if it is
>> done unconditionally.
>
> Can we create a configuration variable to avoid this problem?
> We keep the old behavior by default, and make a configuration variable
> for people who wants to have this new behavior, but if the user set the variable
> a message informs it about the problem that you mention.
>
> Or, we add an option like git pull --doSomething.

Probably a command line option ("git merge" would probably want the
same one) plus a configuration varaible to give it the default (the
latter is optional).

> Maybe, we can think about another behaviour.
> When the user git pull and this error occurs:
> error: The following untracked working tree files would be overwritten by merge:
> file1.txt
> file2.txt
> Please move or remove them before you merge.
> Aborting
> We don't abort, but we prompt a yes/no for each file, if the user
> wants to remove it.

I doubt this would fly as-is.  Especially if the action that is
offered by the prompt is "remove", not "move", as that implies we
are not prepared against loss of information.

There is no indication whether the untracked file1.txt matches the
contents we are pulling in.  Most of the time, it is very unlikely
that the contents being lost is identical to what the other side
has, so answering "yes" to the prompt means "No, I do not care about
my garbage, and it is OK that it will forever be lost."  I do not
think we want to be encouraging people to habitually make such a
statement.  If we move (instead of removing) them away to somewhere,
and give users to easily recover them after running "git pull", it
might become more palatable.

I wonder if this whole thing is an attempt to work around whatever
"stash --untracked" fails to do well (or perhaps there are no such
shortcomings, but just the users are not made aware of the command
enough).  If you have these two untracked files (file1.txt and
file2.txt) are "in the way" for a merge to succeed, I have to wonder
if "Please move or remove" message that was introduced by 23cbf11b
(merge-recursive: porcelain messages for checkout, 2010-08-11) is
still giving a good piece of advice to users today.

Would "git stash push -u file1.txt file2.txt" be an easier and safer
alternative that lets you take these files back later?  Back in
2010, when 23cbf11b was current, "git stash" was a shell script and
it seems there was no "untracked" option, so from that point of
view, "move or remove" may have been the best they could do.

Note that I never use "git stash" with "untracked" option, so I do
not know if it works well in this context already, or we need more
work before it becomes usable in this scenario.  But it smells like
it is exactly what we might want to use in such a situation to stash
away these untracked file1.txt and file2.txt while running the
merge, while allowing us to recover them after running the merge or
discarding it.  I dunno.
