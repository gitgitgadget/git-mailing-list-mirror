Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiDVWgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiDVWgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:36:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6C2F7E30
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:50:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 839D712BD11;
        Fri, 22 Apr 2022 17:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5OzWzHTUSvRdXl6D64lk2JDFTWbBlrf9ogH14j
        QCYwA=; b=FdrasVv6eG/CeTs0ZVjp6FvlRFVEZ89HDwUDMs4W37mOtMZMC9rk36
        Jb84RGhT2v9wsHeP2EzrMQtT+fQkxVltghkRAKOs1tKCDEBQ11UisX+p0ZzmO7VA
        /ta5bWYA3LeKo2j0VYB5OPtleo63w2GRtFkcF8T3AOSMeddQjj2k4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AD3612BD10;
        Fri, 22 Apr 2022 17:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAD2D12BD0F;
        Fri, 22 Apr 2022 17:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] rebase - recycle
References: <20220422183744.347327-1-eantoranz@gmail.com>
Date:   Fri, 22 Apr 2022 14:50:30 -0700
In-Reply-To: <20220422183744.347327-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Fri, 22 Apr 2022 20:37:44 +0200")
Message-ID: <xmqqsfq46b4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B5F6DD4-C286-11EC-AB31-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

>  builtin/rebase.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 229 insertions(+), 1 deletion(-)

Hmph, somebody other than myself would have a nice thing to say
about this.  I have a feeling that this case is too narrow to be
worth adding 230 lines, if it requires end-user intervention.

Without any additional end-user input like "--recycle", is it
possible to dynamically and cheaply tell if the recycle mechanism
can be silently and transparently usable as a more efficient
alternative that would produce exactly the same result as the normal
rebase mechanism?  Using

 (1) the range being rebased,
 (2) the tree of the "onto" commit, and
 (3) the desired shape of the resulting history

as input, wouldn't you be able to tell?  IOW, with

	$ git rebase --onto=A B C 

if there is no clear bottom of the range being rebased (i.e. "git
merge-base B C" may have multiple commits), or if the bottom of the
range being rebased has a tree different from that of commit A, then
we know "recycle" would not work even without trying.

Also, when the range B..C is not a single strand of pearls and we
ended up choosing REBASE_APPLY due to what the command line or
configration variable said, we cannot use recycle even if the tree
of the bottom of the range matches the tree of A, because
REBASE_APPLY wants to lineralize the history, while recycle
mechinery is about replanting the whole bush structure verbatim, so
it is a bad match.

But when (i) there is a clear single bottom of the range B..C (let's
call that X), and (ii) the tree of that bottom matches the tree of A
(i.e. X^{tree} == A^{tree}) and (iii) either we are asked to do
REBASE_MERGE or the history being rebased B..C is linear, then

              B
             /
        o---X---M---N---Q---C
         \       \     /
          \       O---P
           \
            A

we should be able to exercise the recycle engine _without_ even
telling the user that we did, and the only visible effect to the
end-user and to the resulting history is that we (hopefully) did a
better job with smaller amount of CPU cycles, no?

              B
             /
        o---X
         \ 
          \
           \
            A---M'--N'--Q'--C
                 \     /
                  O'--P'

Without thinking too much about it, I do not think there is any case
where you cannot tell mechanically that recycle would be usable as a
pure optimization.  And if that is the case, forcing end-user to say
"try recycle, it might work, and otherwise fall-back" does not help
anybody.  If it is automatable easily, we should spend extra brain
cycles to automate it and not bother the users.

That way, you do not even need to add a single line of
documentation, even though you still need to have tests.

> This is the rebase-based implementation of my original
> git replay concept.
> 
> Decided to change the name to "recycle" because there is already
> code that relates to "replay" in rebase... and we are "recycling"
> trees so the name sounds appropriate (but might consider other
> proposals if they gather steam).

I saw "recycle commit" in the code, but you are indeed recycling
trees.  But I prefer to see us think it through---I have this
feeling that we do not have to expose any of the candidate words
recycle, replay, replant, ... to end users and just use the new code
as a special codepath that does not call out to the true merge
engine.

> There are things that are missing like documentation
> and I will gladly add them (along with correcting anything
> coming from code review) if this feature is interesting enough
> for inclusion in the main line.

The last thing I want to hear from contributors in the open source
development setting: I'll polish it more if you promise this will be
included.

If it is NOT even interesting and useful enough to make you want to
polish and perfect it, even when you were the only user, why should
we be interested?  Even if your userbase starts at zero (or one,
counting yourself), if you make it so good, other people will come
to you, begging you to add that to the public tool.
