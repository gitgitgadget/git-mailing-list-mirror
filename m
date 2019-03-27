Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A396F20248
	for <e@80x24.org>; Wed, 27 Mar 2019 13:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfC0NyI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 09:54:08 -0400
Received: from mail.javad.com ([54.86.164.124]:44126 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfC0NyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 09:54:08 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D08F440E7B;
        Wed, 27 Mar 2019 13:54:06 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=PqyVH/zy;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553694847;
        bh=89LVHEJXEBxg6FWBOB9irlcSKyK7L6RbXz62J+st7EU=; l=5176;
        h=Received:From:To:Subject;
        b=PqyVH/zyqFHWyyxr0T593TDqMEdSN/KWiRXENCXXhVeakhgcmh4Adq2UxXhPbdFED
         vgfaOZ1IzHg+kJWGWxaWfCAIz02Go+MVzq8Wt8UwDA3EjEnzVfbGuG8TtIe+hkTXtj
         6QplIj05Lot1ER82kqRslHqsS2x/UmoOrTf09ljc=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h990H-0003zW-9F; Wed, 27 Mar 2019 16:54:05 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <8736nj2jcl.fsf@javad.com>
        <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
        <87h8bra1z6.fsf@javad.com>
        <20190326163204.GC29627@sigill.intra.peff.net>
Date:   Wed, 27 Mar 2019 16:54:05 +0300
In-Reply-To: <20190326163204.GC29627@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 26 Mar 2019 12:32:04 -0400")
Message-ID: <878sx0xw1u.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 25, 2019 at 09:43:09AM +0300, Sergey Organov wrote:
>
>> How about changing "git show -p M" to output "diff -p M^ M" rather than
>> "diff-tree --cc M" for merge commits? It's really surprising specifying
>> -p has no visible effect.
>
> That's because "-p" is already the default, and the format selection is
> orthogonal to the handling of merge commits.

Seems to be more convoluted than that. If "-p" were simply default, then
"git show --raw" and "git show -p --raw" would output the same thing.
They don't.

That said, does "-p" select a format, or not? Should it? For me,
"--patch" sounds specific enough to expect it to select the format that
is most close to what "patch" utility is able to apply, that would still
be "diff -p M^ M" format, universally, be it merge commit or not.

> Providing "-m" would actually override the "--cc" default (though
> "--first-parent -m" is likely to be less noisy, per this discussion).

Right, but "--first-parent" (while accepted) even is not documented for
"git show", and it could be argued if history traversal option has any
sense for a command that shows separate commits.

Further, even in "git log", having the "--first-parent" change the way
diffs are output is, strictly speaking, violation of orthogonality (that
nobody seems to care about).

> As far as defaults go, I dunno.

I'm not after changing the default behavior. I'm rather after making the
whole system of options somewhat more logical, self consistent, and thus
less confusing.

> The idea is that "--cc" would give you a nice summary of what the
> merge _itself_ had to touch. I think that's valuable, too.

I'm not against "--cc" either, be it a default or not, even though
personally for me it's not very useful, as it shows how merge (the
operation) supposedly went, when I'm usually interested in how merge
(the resulting commit) affects the mainline, no matter how this result
has been achieved.

Another thought about "--cc" is that it's in fact a case of "merges are
symmetric" approach to the UI that is supposedly shifting to "mainline
is special" one.

> If we were starting from scratch, I think there could be
> a discussion about whether one default is better than the other. But at
> this point I have a hard time finding one so much obviously better than
> the other to merit changing the behavior.

I'm yet to figure what exactly the best set of options would be, even
personally for me, even in the "start from scratch" case, so, for now,
I'm basically just gathering relevant information and opinions.

>> Also, is current output of "git log -m", being extremely confusing,
>> suitable for anything? Maybe consider to change it to output diff with
>> respect to the first parent only? Though it's then a pity "-m" lacks
>> argument here, similar to what it has in cherry-pick.
>
> I've used "-m" without "--first-parent" sometimes in order to track down
> mis-merges manually.

Have you been interested specifically in diffs with respect to side
branches in these cases, I wonder, or did you actually look only at "-m
1" part of the whole "-m" output?

When I tried "-m", I found it rather difficult to even visually find the
margin between diffs to different parents, that confused me and forced
to resort to other methods. Besides, it didn't appear to me at that time
that there is "--first-parent" that might "help", so as I recall I ended
up using "diff -p M~1 M" for the merge in question.

> It's not usually a big deal to say "--first-parent" if that's what you
> want. But one thing I don't think is currently possible is to ask only
> for the first-parent diff, but _not_ restrict the actual traversal.

That's due to "--first-parent" breaking orthogonality. It should rather
only affect graph traversal, I'd expect.

Admittedly, it may imply some other option(s) for convenience (say, such
option could have been "-m 1", if it existed), but then there /must/
exist the option(s) it implies in the first place. Currently,
"--first-parent" behaves as if it implies some nonexistent option, so
the user has no way indeed to provide the latter without the former.

> If that's what you mean by giving an argument to "-m", then yeah, I
> think that would be a useful addition.

I thought that maybe the part of "-m" that outputs diffs to side
branch(es) is in fact useless feature when result is to be directly
consumed by human beings. Then, if we decide to change it to output diff
to single parent for porcelain command(s), it may be useful to be able
to explicitly ask for other parents than the default, the first one.

It also strikes me as inconsistent that "-m" in log/show on one hand,
and "-m" in cherry-pick on the other, being essentially the same thing,
are so different in appearance and description.

Unfortunately, adding an argument to "-m" bumps either into generic
evilness of optional arguments for options, or into backward
incompatibility (if the argument to "-m" becomes mandatory), so it
doesn't seem to be such a good thing to do after all.

-- Sergey
