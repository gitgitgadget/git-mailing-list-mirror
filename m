Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B8C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC161104
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhKPIce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:32:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55736 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhKPIcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 03:32:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F7FC15C55A;
        Tue, 16 Nov 2021 03:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dGeS3cVCTENE4wFL9/QynyxpEZSx6uUMhNeptznD/80=; b=V3CI
        3a7Z8a94Tdmag8c+XVtl5M9zwgXL4M0V0eoQ04OOvOSEoGWmZvdmHdQuMV03zEKb
        OgQWYyodOYeB5UWYsx8MOmw1f5YMRoBElApihDN4wSC7K0ug2mP5PXHJn0uKevvQ
        9onnkYPivMemQiL/dShxZzWB/XB/iOiY2C1SK/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A85D15C559;
        Tue, 16 Nov 2021 03:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BA1715C557;
        Tue, 16 Nov 2021 03:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <junio@pobox.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] per signal_struct coredumps
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        <871r3uy2vw.fsf@disp2133>
        <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
        <xmqqbl2nmemx.fsf@gitster.g>
        <87pmr2k68f.fsf@email.froward.int.ebiederm.org>
Date:   Tue, 16 Nov 2021 00:29:11 -0800
Message-ID: <xmqq8rxobj1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 470BB1C4-46B7-11EC-BFA5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> make that a "merge".  If it is "fake", I guess that any random point
> in Linus's history would do, but I can understand that the maintainer
> would complain about such a seemingly unnecessary (back) merge.

Having thought about it a bit more, I am not sure if these merges
are truly "fake", or just a normal part of distributed development.

As a degenerated case, first I'd imagine you have a patch series
that focuses on a single "theme".  You perfect the patches, you fork
a topic branch from an appropriate "public" commit of your upstream
(e.g. the last stable release from Linus), you add a signed tag at
the tip of that topic branch, and you ask a (subsystem) maintainer
to pull from you.  The subsystem maintainer's tree will have series
of merges to collect work from other people working in the subsystem
('x'), and the pull from you will create a merge whose first parent
is one of these 'x' (i.e. the work by the maintainer so far), and
the second parent of it is the tip of your work.  The merge commit M
gives a detailed description of what happend on the side branch and
its mergetag header carries the contents of the tag you created for
the pull request.

      \   \
    ---x---x---M
              / Subsystem maintainer pulls from you
             /
  ...---o---o (your work)

Your next topic, which is a chunk of the same larger theme, may
depend on what you did in the commits in this initial series 'o'.


      \   \       \   \
    ---x---x---M---x---x---N
              /           / Subsystem maintainer pulls from you again
             /           /
  ...---o---o---p---p---p (your second batch)


Eventually, this will be pulled into Linus's tree when the subsystem
maintainer is ready to send the whole thing.

                              Y--- (Linus's tree)
                             / Linus pulls from subsystem maintainer
      \   \       \   \     /
    ---x---x---M---x---x---N (Subsystem maintainer's tree)
              /           /
             /           /
  ...---o---o---p---p---p (Your tree)

The above picture only depicts two topics, one directly building on
top of the other, from you, but that is simplified merely for
illustration purposes.  The real history may have more topics, some
are dependent on others, while some are independent.

Now, if you have many related but more or less independent topic
branches that will support a larger theme, it would be quite natural
if you acted as your own "subsystem" maintainer, in other words, in
the above picture:

 . you are in control of not just the bottom line, but in the middle
   line of development;

 . you do not have 'x' that merges from other people;

 . but you do have M and N, and use these merges just like a
   subsystem maintainer would use to describe the work done in the
   side branches.

and offer 'N' as the tip of a "larger" topic that has internal
structure, not just a single strand of pearls, by adding a signed
tag on 'N' and throwing a pull request at Linus (or whoever is
immediately above your level).

Is that what happened (as I said, I lack context)?  If so, I do not
see much problem in the situation.  But this assumes that these so
called "fake" merges are merging into right first parents.


