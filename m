Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469BAC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJIMHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIMHj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 08:07:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5F2D762
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 05:07:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46B9F1C313C;
        Sun,  9 Oct 2022 08:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=VxqYmmi+93AioTMMf8qY4+DziTC+s/lHYbz3ymJvOgs=; b=eX6R
        hegN5im9m3gm6BvnIYvfxKuA3Tl8ljJRaUGdsRLtLfKB4Pv1d6fblnlPbi24CyKu
        OzacdxoZNYQPGm2rJzHNxtcDQdOwr3mBjB+NUlBEQXFZg142ZJppj4mOhQTftkmS
        nQQtuLDkxvKPvlEY1qzRrd7iuQYvaDJ55PyE/4M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E3F21C313B;
        Sun,  9 Oct 2022 08:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 476671C313A;
        Sun,  9 Oct 2022 08:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
        <86355292-cb54-32c8-abf5-542fb4cf9ade@iee.email>
Date:   Sun, 09 Oct 2022 05:07:31 -0700
Message-ID: <xmqqfsfx8akc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4205170-47CA-11ED-8027-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Is there also a need to update SubmittingPatches to clarify the
> distinctions between the generic name 'maint', the specific `maint-xx`
> branches, and the symbolic ref linkages from `maint`.

Not at all.  Perhaps you are thinking about MaintNotes, but even
there, general public do not have to be concerned about maint-xx
most of the time.  I myself would not be keeping branches for
ancient maintenance tracks anywhere.  As the older maintenance
tracks, other than the most recent ones, do not get topics graduated
to 'master' merged down by me (even though topic branches that fix
notable bugs may fork from an older version to allow motivated third
party maintainers to merge them down to older maintenance releases),
there is not really a reason to keep branches like maint-2.15 for
daily operation.  Only when we need security updates that go back to
older maintenance tracks, I may do

    $ git checkout -b maint-2.30 v2.30.5
    $ git merge cve-something-fix
    ... edit release notes etc. ...
    $ git commit -m 'Git 2.30.6'
    $ git tag -s -m 'Git 2.30.6' v2.30.6

but after that is done, there is no reason to keep an old branch
like maint-2.30 lying around, other than to make it easier to
prepare for v2.30.7 (as maint-2.30 will remember what tag was the
latest on that particular maintenance track).

> The descriptions give the impression there is just a single main branch,
> with a singular name, and that was the end of it.

And that is the correct world view for most of the  general public.

    https://github.com/git/git/

shows 'maint', 'master' ('main'), 'next', and 'seen' from the
project code, plus 'todo' which holds an unrelated history that
keeps track of maintenance tools and misc stuff.

By the way, I do not personally have 'main' in my working
repository.  The only trick I have to help folks who expect to see
'main' instead of 'master' is the push refspec to distribute the
integration results to various repositories.  My 'master' is pushed
to both 'master' and 'main' in destination repositories.

The mirror/backup repository of my private working repository does
have tentive branches, like the broken-out topic branches that are
still active, which are pruned when they no longer are needed.
Some maint-xx branches are also there but they are there not because
they are necessary but because I just haven't bothered to clean them
up ;-)

