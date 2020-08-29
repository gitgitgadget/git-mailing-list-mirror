Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF514C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 03:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6E320714
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 03:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaU3KxDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH2DU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 23:20:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60644 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2DU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 23:20:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEB808011E;
        Fri, 28 Aug 2020 23:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qHyJiemZcsf+xiiK+NdYJx3l63U=; b=NaU3Kx
        DV/NmJdcDBzvrlqHYxifTc9nZcE821FaUB74TJxvWn3QxCLMD3l8dzLJhOBTwEzi
        kNrttvXqlHe7kiVp5nCJ8/+ixbdnRnJxvXUYumCA5zYAoIw5HeTk4+auHOkD2/2B
        M365o/H8I+ZcggaiRV6RCXHixPjpTDmwlA5pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E6bxU12uuSM/5qa4RZynwXAdMGZc+A/b
        wuNmU3JrcFSyea+1Ya/Q/KQMMT3L/1rp5IlhpY51ShqbYJwPcn8VQI38IwOIFou7
        DMZ1UWTxUOgpJJVSZSbRTiLQBENbfwuwoXEeyVuYMWaQGDDdYSiNyHZWLMZ0YKbN
        HP6sbEpMYUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E76AA8011D;
        Fri, 28 Aug 2020 23:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 770B28011C;
        Fri, 28 Aug 2020 23:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Baldo <ibaldo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fastest way to set files date and time to latest commit time of each one
References: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
Date:   Fri, 28 Aug 2020 20:20:22 -0700
In-Reply-To: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
        (Ivan Baldo's message of "Fri, 28 Aug 2020 22:36:10 -0300")
Message-ID: <xmqq8sdym93d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93664B66-E9A6-11EA-BDBF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Baldo <ibaldo@gmail.com> writes:

>   I know this is not standard usage of git, but I need a way to have
> more stable dates and times in the files in order to avoid rsync
> checksumming.

Would you care to elaborate a bit more about the use case?  From
what you wrote, I would assume:

 - The source of the rsync transfer is a git working tree.  It often
   has the checkout of the latest and greatest version, but during
   development, it may switch to older commit (e.g. to find where
   regression occurred) or not-yet-ready commit (e.g. work in
   progress that is not given to upstream).  You check out the
   version you want to sync to the destination before initiating
   rsync.

 - The destination of the rsync transfer is meant to serve as a
   back-up of the latest and greatest, periodical snapshot of a
   branch, etc., which is NOT controlled by git and transfer does
   not happen in the reverse direction [*2*]

Because the working tree of the source repository is used to check
out different versions between rsync sessions, files that did not
change between the commit you sync'ed to destination the last time
and the commit you are about to sync still may have been touched and
have different timestamp, requiring rsync to check the contents.

And as a workaround, you are willing to change the workflow to
"touch" the working tree files, immediately before you run the next
rsync, in a predictable way so that the timestamp of a file whose
contents did not change since the last rsync session would have the
same timestamp.  This may break your build next time you run "make"
in the source working tree (because your object files that are
excluded from your rsync may have newer timestamp than the
corresponding source even when they must be recompiled due to your
"touch"ing), but you are willing to pay the cost of say "make clean"
after "touch"ing.

Is that the kind of use case you have around "rsync"?

To the question "what is the time this file was last modified?",
there is no simple and cheap answer that is easy to explain to
end-users, unless your development is completely linear [*2*].

The loop you showed would be the right one in a linear history, and
with recent development to record which paths were changed in each
commit in the commit-graph data structure, the script should work a
lot faster than traditional git.


[Footnote]

*1* Otherwise, you'd be just mirror-fetching from the source
    repository.  If that can be arranged, running "git pull --ff-only"
    on the destination side to update from the source side would
    be a lot more efficient than running rsync, I would imagine.


*2* In a history with merges, because two or more branches can touch
    the file in parallel development at different times and then the
    resulting parallel histories get merged into a single history.
    When two or more of these parallel history gave the file in
    question an identical content at different times, and the merge
    result was recorded as the same content, you'd need to follow
    ALL the paths and compare the timestamp of these commits to pick
    one (which one?  the oldest one?  the newest one?  does the
    order of parents in the merge matter?)

