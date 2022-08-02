Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665FC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHBPk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHBPkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:40:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C712AAB
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:40:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 395241299FA;
        Tue,  2 Aug 2022 11:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImM3lDjUOWZW/eAMUsBftpQ+DQAIW1At8o7EUt
        GDjRg=; b=FGzK7A99Ju27vO3utFglPbVl+1340x0uqVQLsZzXef55AiDFlmk/ES
        +Y46KlcPoxIjbJ/cse7c6F+avV56jtzybEEcRZl4+/2CSHaIHjwjliAjtEag3c/I
        gque9S7WcZ5OoMpWos3KK98QNO+HCsP6izR3tu3NIq+sU9AUuwgDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 307A51299F7;
        Tue,  2 Aug 2022 11:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 994A81299F5;
        Tue,  2 Aug 2022 11:40:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
Date:   Tue, 02 Aug 2022 08:40:19 -0700
In-Reply-To: <20220802075401.2393-1-vegard.nossum@oracle.com> (Vegard Nossum's
        message of "Tue, 2 Aug 2022 09:54:00 +0200")
Message-ID: <xmqqczdiirh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A8EEA38-1279-11ED-AD3F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Notes are currently always fetched from the current repo. However, in
> certain situations you may want to keep notes in a separate repository
> altogether.
>
> In my specific case, I am using cgit to display notes for repositories
> that are owned by others but hosted on a shared machine, so I cannot
> really add the notes directly to their repositories.

My gut reaction is that I am not interested at all in the above
approach, even though the problem you are trying to solve is
interesting.  Mostly because notes are not the only decorations your
users may want.  What if you want to "log --decorate" their
repository contents with your own tags that annotate their commits?
A notes-only approach to mix repositories is way too narrow.

A usable alternative _might_ be to introduce a way to "borrow" refs
and objects from a different repository as if you cloned from and
continuously fetching from them.  We already have a mechanism to
borrow objects from another repository in the form of "alternate
object database" that lets us pretend objects in their repository
are locally available.  We can invent a similar mechanism that lets
any of their ref as if it were our local ref, e.g. their "main"
branch at their refs/heads/main might appear to exist at our
refs/borrowed/X/heads/main.  

Once the mechanism for doing so is in place, setting up such a
parasite repository might be

    $ git clone --local-parasite=X /path/to/theirs mine

which would create an empty repository 'mine' that uses
/path/to/theirs/.git/objects as one of its alternate object store,
and their refs are borrowed under our refs/borrowed/X/.

Then you can tell your cgit to show refs/borrowed/X/{heads,tags}
hierarchies as if they are the branches and tags, and use your own
refs/notes/ hiearchy to store whatever notes they do not let you
store in theirs.
