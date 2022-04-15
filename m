Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF6C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiDOUfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDOUfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 16:35:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0B4D9CA
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:33:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9934F10BED0;
        Fri, 15 Apr 2022 16:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z7jo4b+OHrQAF4SmlZ68kDC9Ak23/Z7khHks73
        TEmBo=; b=Xowydsn0JbQWhdGBL4p+Je2MxszvuYsktuoyD1TsSMxxGx8YhnlKlD
        /JRwbDo5RkeoUlH6H7uXDp6VpDyZ/qnjtT1SXje+0LveD9HBkvTsuMNC0Rsp0YKj
        cYXUmHModEDqsR9FGB9NhDrWoto9nx/ee7o0WD8CmM/HzhoQkyJDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90F4010BECF;
        Fri, 15 Apr 2022 16:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBC6310BECE;
        Fri, 15 Apr 2022 16:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
        <xmqq4k2wap8g.fsf@gitster.g>
        <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
Date:   Fri, 15 Apr 2022 13:33:19 -0700
In-Reply-To: <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Fri, 15 Apr 2022 20:46:12
        +0200")
Message-ID: <xmqqbkx2ccj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A3B5AF6-BCFB-11EC-BE5A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> But I am probably wrong in terms of what I understand that you meant.
> Can you expand a little bit, if you don't mind?

What I had in mind is what I have to do every day multiple times.
'master'..'seen' is a series of merges of tips of different topic
branches.

                 ---T topic
                     \
       \    \    \    \
  --M---o----o----o----S seen
    ^
    master


Some of the topic branches may get updated and 'master' may gain
more commits by merging some topics.  Now it is time to update the
'master'..'seen' chain.

                 ---T---P topic (updated)
                     \
       \    \    \    \
  --M---o----o----o----S seen
     \
      o
       \
        N
       master

It would be wonderful if a single command like replay can be used to
say "In the old history master..seen I have bunch of merges.  master
used to be M but now it is at N.  Rebuild M..S on top of N _but_
with a bit of twist.  Some of the topics in M...S may have been
merged to 'master' between M..N and the replayed history on top of N
does not want to have a merge from such 'already graduated' topics.
Many topics are updated, either by adding a new commit on top or
completely rewritten, and we want an updated tip of these topic
branches, not the old tip that I merged when I created M..S chain,
when replaying the history on top of N."

That kind of operation is quite different from what "rebase" does,
and deserves to be under a different name.

Compared to that, "replay exactly the same set of commits in the
same shape on top of a different commit whose tree happens to be the
same as the original", is a mere special case of "rebase" that is
not all that interesting.  It may be a worthwhile thing to do to
teach "rebase" capable of doing so reliably and more efficiently,
but that still falls into "improving rebase" category, not meriting
a separate command.


