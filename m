Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E4C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6F760EB4
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhJLMGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 08:06:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55021 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhJLMGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 08:06:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD989FE2AF;
        Tue, 12 Oct 2021 08:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=U7aZ7z2OV2FxLVal3ChUNnjt/
        BEE836PkADyXrx4+6s=; b=HlvoUoKErGnkmmERvBXKLcJ4Cjyv2tcpMu4Eyn+QX
        6BNuRaXyNs/0dWl67lD4xH+7pau16c6JiyZyPV5HA/EMmrUcPgjr1pYN3kNFAY7D
        j8/P1VKY3K1s6ivGBFqSrgarqPDCZvI+atZEt4o/WiChJcC7PFBDhjlGzNPdryR2
        pE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3C1EFE2AE;
        Tue, 12 Oct 2021 08:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3462BFE2AD;
        Tue, 12 Oct 2021 08:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
Date:   Tue, 12 Oct 2021 05:04:31 -0700
Message-ID: <xmqqa6je8n5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F41D33E-2B54-11EC-BFE4-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The one thing I'm a bit iffy on is if this is consistent with the
> --staged options in other commands (with some taking --cached and/or
> --staged), I think so, and this is a good name.

We clearly define contrasts between "--cached" and "--index", but
the "--staged", which is a confusing synonym for nothing, does not
get in the contrast between the two, so I do not think you need to
worry about "which one is it?" in this case.

If something works only on the contents in the index, then it should
use "--cached".  If it works both on the index and the working tree,
then it should use "--index".  If you call it "--staged", it is
whatever it means ;-)

More importantly...

Whenever I think about a new "feature", I try to come up with a
story in which the feature effectively improves the end-user's life,
how it fits in the larger picture, and enables something that is
hard to do by combining other tools.

The kind of "story" I would aim for is like this.  Suppose we were
selling not "git stash -S" but "git stash -k".  The story would go
like this:

  Imagine that the change you have been working on started to take
  shape, and you estimate it would be a three-patch series in the
  end.  You also guess that so far you have enough to finish the
  first step fully, perhaps 40% of the second step and a little bit
  of the third step, all mixed together.

  You started to sifting the changes into the first step material
  and the rest, by using "add -p" etc., and you are reasonably sure
  that what you have in the index is in a good shape for the first
  commit.  But it is not easy to be sure, because what you can test
  is only in the working tree, so a mistake like having all the code
  already added in the index but forgetting to add to the index a
  declaration for a variable the code uses that is in the working
  tree is easy to make.  With "git stash -k", you can materialize
  only what is in the index to the working tree, while stashing away
  the changes in the working tree that haven't been added yet.  By
  checking the resulting working tree, you can be sure.

  - If the resulting working tree after "git stash -k" tests out
    OK, then you can make a commit and the "git stash pop" will
    give you the material for the second and the third step.
    You'd work to produce the remaining 60% of the second step and
    do "git stash -k" dance again before recording it.

  - It is possible that the resulting working tree does not work
    OK.  You may find that you forgot to "add -p" the declaration
    of a variable you used in the code that you already "add"ed.
    After "stash -k", the former is stashed away while the latter
    appears in the working tree, and the compiler complains.  In
    such a case, you can "git commit" the slightly broken state,
    "git stash pop" to recover the missed declaration, together
    with the material for the second and third step, into the
    working tree, use "add -p" and "stash -k" to prepare and
    verify the "fixup" commit for the first step.  Later you can
    "rebase -i" the first step into shape.

I unfortunately am coming up empty for "git stash -S".  And I do not
see a beginning of a good story at the stackoverflow entry you had
the URL for, either.  If we had one to support this feature, that
would help very much.

While I failed to come up with a good story for this new feature, I
however did come up with possible confusion and frustration that
end-users may feel while trying to use it:

 - I thought the result of "git add -p" was good, so I did "git
   stash -S", then after working further on, did another "git stash
   -S" a few times.  Now I have a handful of stash entries, but
   because all I can do is "git stash pop" them one by one,

   - I need to make commits for real, and=20

   - because I wasn't given a chance to, these stash entries do not
     record material to write good log messages and I forgot why I
     did some of the changes in the way I did so.

   - My "add -p" seem to have missed some stuff that should have
     been added, but it is too late to correct, especially given
     that these stash entries cannot be "rebase -i"ed or "commit
     --amend"ed.

 - Also, how would I reorder these steps?  If I made real commits,
   instead of "stash -S", I am familiar with "rebase -i" to reorder,
   combine or split them, but because these are not real commits, I
   cannot use "rebase -i".

 - After making these "stash -S" entries, I popped a wrong one.  If
   I recorded them as real commits on a temporary work branch, its
   reflog would have helped me to recover from such a mistake, but
   because stash does not mix well with reflog, I am lost.

And I do not want to see us respond to these future end-user gripes
with "don't worry, we'll extend 'git stash save [-S]' with the '-e'
option to let you describe the change in detail, and enhance 'git
stash pop' with the '--commit' option to directly create a commit
using the message you wrote when you created the stash", or "don't
worry, we'll enhance 'rebase -i' to be capable of working on series
of stash entries".  These all look like complexity that only became
necessary because we added "git stash -S"---if the user committed
incrementally on a temporary work branch, none of the complication
would have been needed.

I think it is very possible that an answer to the above possible
end-user gripes is "no, this feature is not about sifting a big and
mixed changes in the working tree into multiple steps recorded in
the stash entries (instead of a series of commits on a branch), so
all the above end-user gripes are the result of using the tool for a
wrong job", and that is why I wanted to come up with a story in
which this feature effectively improves the end-user experience.
IOW, with the "frustration" story in the previous paragraph, I might
have been trying to drive screws into wood with this new feature,
which is a hammer and not a screwdriver.  If that is the case, then
I would want to see a story where the hammer is used to drive nails
instead, and nails do something good that screws don't.

I have a suspicion that this _might_ be coming from a hesitancy to
commit (e.g. a draconian commit hook that always pushes things out
immediately a commit is made), and somehow creating stashes is used
as a way to sidestep the real source of the problem (e.g. in Git,
commits on temporary branches are designed to be useful lightweight
tools to help advance the history recorded in the real branch, but
misguided hooks and policies prevent your branches to be used as
such).  I dunno.
