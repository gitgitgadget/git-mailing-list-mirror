Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE99A1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbcLDTI6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 14:08:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751195AbcLDTI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 14:08:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C9B554D20;
        Sun,  4 Dec 2016 14:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O2VS4df429M3tSaBeZHzn2hf4WE=; b=QQlFSQ
        tPrIRiBPO/H8K95IlbdY8QWjDyx706xDmsPnACNHQ6pY7x/CZkhD58OKS3BSkncj
        zfhEjYRRYo4ofr2OhXTRbGfwYvqkO4utR1u4P8ZRGYjyWeRJ2UfmKj+yfEX+/L7u
        TGUholnPS5EAvHlMRPeDDe8IBKAhiH95vv0po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fZj64FxpoKRjq8MvXaA0gFXUIYmYq29u
        krICzc5mL5YmkmrIEnb3FK8Qv0MfL4b9yuQsa3YQTE2ZAAY+AHDW/O4oJPrPjt2Y
        ukCgGzjJo6pWBc9Jnvk3/lKkWeOVeSxqV+hQ9+QbaqxsZ6Xb+7Gv3avEe5lh1LSL
        9UmOa/Dku4c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1290C54D1F;
        Sun,  4 Dec 2016 14:08:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38E9F54D1E;
        Sun,  4 Dec 2016 14:08:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julian de Bhal <julian.debhal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git reset --hard should not irretrievably destroy new files
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
Date:   Sun, 04 Dec 2016 11:08:54 -0800
In-Reply-To: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
        (Julian de Bhal's message of "Sat, 3 Dec 2016 15:04:40 +1000")
Message-ID: <xmqq1sxn7bqx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19FEFD56-BA55-11E6-A6CF-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julian de Bhal <julian.debhal@gmail.com> writes:

> The behaviour that would make the most sense to me (personally) would be
> for a hard reset to unstage new files,...

I think _sometimes_ that may be useful.  I haven't thought things
through yet to arrive the final decision, but one thing that must be
kept in mind by anybody who wants to move this topic forward is that
a path that does not exist in the HEAD commit MUST be removed from
the index and the working tree upon "git reset --hard" when the path
resulted from a mergy operation.  I.e. in this sequence:

    $ git merge other-branch ;# or git cherry-pick one-commit
    ... try to resolve conflicts, make a mess, decide
    ... to try it again from scratch
    $ git reset --hard
    $ git merge other-branch ;# or git cherry-pick one-commit

the "reset --hard" step MUST remove new paths that existed only on
the other-branch (or in one-commit), which by definition would have
auto-resolved cleanly, from the index and the working tree.  There
are other commands (e.g. "git am -3", "git apply -3", "git rebase")
that are "mergy" and their intermediate states must be handled the
same way.

If a very simple to explain and understand rule can be used to tell
if a new path (i.e. a path that exists in the index and in the
working tree, but is not in the HEAD commit) is what was created
manually by the end user without any other copy (i.e. "create
newfile && edit newfile && git add newfile") and is not a result of
a mergy operation being abandoned, then I think it is OK to allow
"reset --hard" to leave the working tree files untracked, but if the
rule becomes anything complex to understand for the users, I think
it would make the behaviour of "reset --hard" hard to explain,
understand AND anticipate---and at that point, we would be better
off keeping the "You said 'hard', we clean 'hard' to match HEAD"
behaviour of "reset --hard" and EDUCATE users not to say 'hard' too
casually. There may be a room for new option that unconditionally
leave the new working tree files untracked so that users can choose
between the two, if we end up going that route.



