Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A7C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 06:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhKTGIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 01:08:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhKTGIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 01:08:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6852F5741;
        Sat, 20 Nov 2021 01:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GoICGjBgrkX/N6r/lioJJ4KCprM6LkhH9w9kfd
        cLV24=; b=HqUvDHO9qcQygv1Z9EKNUdT+1+BGdrd0ckY2YTNZxg9lc+J9NZsDVS
        eTE7ARhmnqe7m7mdf+4MTNfZQ+SBJTVcsvolC99AzoJX1v7X2/R1OBNldainqHqW
        sI7jU6zVGJ09ND+oHdflflhKq9mPvewxJ1rsGZlfGoMTWSIE9n2kE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD2D0F5740;
        Sat, 20 Nov 2021 01:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CA71F573F;
        Sat, 20 Nov 2021 01:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] single-level refs vs push --all/--mirror
References: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
        <YZLLUtPVQt2XtgQX@coredump.intra.peff.net>
        <robbat2-20211116T061554-223495439Z@orbis-terrarum.net>
        <robbat2-20211119T234158-903098822Z@orbis-terrarum.net>
Date:   Fri, 19 Nov 2021 22:05:40 -0800
In-Reply-To: <robbat2-20211119T234158-903098822Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Sat, 20 Nov 2021 00:03:36 +0000")
Message-ID: <xmqqlf1jnyyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3DF63F2-49C7-11EC-B1BB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> I didn't see response from Jeff King, so I'm wondering good next steps
> here.
>
> I'm esp. surprised that git-stash ends up using single-level refs when
> git-check-ref-format(1) says they aren't valid.

They aren't valid name to be used as regular branches, tags, etc.,
but as an implementation detail of stash, "refs/stash" is perfectly
good.  There is nothing to "fix".  You cannot and you do not want to
pretend "stash" is yet another ref in the first place.

You can "transfer" refs/stash by pushing the commit to an arbitrary
ref with a regular "three level" name, like so:

   $ git push there refs/stash:refs/my/stash

but it wouldn't be of much use to begin with.

The thing is, the "list of random quick changes stashed away" is not
something stored in the "stash" ref.  These list entries are stored
as reflog entries for the stash ref, which is *never* transferred
over the network.  So, if the higher level issue you want to address
is to allow "stash" to be shared across repositories, none of these
5 choices you listed at the end of your message helps all that much.

The single-level refs are the least of your problems.

Instead, you'd probably want to reimplement "stash" as a set of
normal refs, whose current value only matters, e.g. refs/stash/0
may be the oldest stash, refs/stash/1 is the next one, refs/stash/2
is yet another new one, etc., and have UIs like "git stash list" 
list them in a new way that is different from the current reflog
based implementation, and "git stash pop/apply" take them, e.g.

   $ git stash list
   stash/0: WIP on main: cd3e606211 Git 2.34
   stash/4: WIP on maint: Merge branch 'vd/pthread-setspecific-g11-fix' into maint
   $ git stash apply stash/0

And at that point you'd have refs/stash/* as an intermediate
hierarchy, with another level of real refs hanging there, so you can
transfer them just like refs/tags/* all you want.

> I think Git should change git-stash and start issuing warnings to users
> for single-level refs.

No, single-level refs is perfectly fine, as long as you are using
the current Git and using these refs locally.  The problem arises
only when you start wanting to share stash across repositories, and
it is not from the levels of the refname hierarchy but from the fact
that stash is implemented in terms of reflog mechanism that is not
shared across repositories.


