Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26EBEE57DF
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 05:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjIKFXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 01:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKFXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 01:23:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FF1AE
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 22:23:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2EFC1BD3B5;
        Mon, 11 Sep 2023 01:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6KB+haWmWBlblrwsA0yy4uRYL3caPCMCuC/SIH
        QT2Ng=; b=DyP1Ko7ZHPI40FFLmZDMGHQh2HPAMYg4TAcZZEBytiopY9DgYWfFzf
        V9Hh8VwexM6f2wYk88fCrdzkVpcHMvABBKlv5Hebv4KIuwx9viE3vNPXuIB7P2ot
        jJrQOh+HuMv9NjNpyxRC4FK154GLupUR3zcOk+kP6zuRt9MZzX7cI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 972021BD3B4;
        Mon, 11 Sep 2023 01:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E99011BD3B3;
        Mon, 11 Sep 2023 01:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yawar Amin <yawar.amin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Idea: indirect authorship info
In-Reply-To: <CAJbYVJJUVUPNPpGAMGZKVWxYu2PiOf_16kzts009qpeLwoim+g@mail.gmail.com>
        (Yawar Amin's message of "Mon, 11 Sep 2023 00:17:21 -0400")
References: <CAJbYVJJUVUPNPpGAMGZKVWxYu2PiOf_16kzts009qpeLwoim+g@mail.gmail.com>
Date:   Sun, 10 Sep 2023 22:23:01 -0700
Message-ID: <xmqq7coxjnbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47AF74AA-5063-11EE-8CA6-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yawar Amin <yawar.amin@gmail.com> writes:

> Apologies if this has been brought up before, but I failed to find anything
> relevant from some quick searches:
>
> - https://lore.kernel.org/git/?q=indirect+authors
> - https://lore.kernel.org/git/?q=authors+file
> - https://lore.kernel.org/git/?q=people+file

Try "mailmap+deadname".  You essentially reinvented these earlier
proposals, except that they reused the existing ".mailmap"
mechanism, and how the key is chosen.

While I do not think of any reason why the desire to achieve the end
goal of these efforts is bad, some parts of your design (and other
proposals) need rethinking.

Projects often need to know and show who did what for legal reasons.
Imagine an old commit needs to be shown to document who made the
contribution to the project.  An in-tree ".mailmap" file can give
adequate guarantee that the anatomized commit author name the commit
carries documents who it the really is in the ".mailmap" file
recorded in the tree of that partcular commit, even if some
contributors who stopped contributing and asked to go back to
anonymity have disappeared from that file.  But they may still
appear if you did "git log -p .mailmap", which would meet the needs
of these projects, but it means that you cannot be forgotten and
have to live with the consequences of what you did in the past.  On
the other hand, if there is no in-tree ".mailmap" (or "people")
file, it brings up many questions.  It becomes unclear who will keep
track of the latest version. There needs a way to guarantee that the
entries still in the mapping file can be used to verify the claim
that some person did a particular commit.  Of course, as long as it
is distributed to project participants for communication ("hey you
worked on this feature 6 months ago; can you answer a few
questions?") and verification ("yes, this commit was done by this
person who was not affiliated with company X in any way. how do you
substantiate your claim that this project stole it from the
company?")  purposes, somebody will bound to make and keep copies,
which means that you cannot become truly anonymous, after making
yourself known.

As to the choice of the anonymous key used as a stand-in value for
the author and the committer identity, using something that is not
deterministic (like uuid) is not a good idea.  If the name/address
are hashed with some algorithm that is cryptographically secure and
is one-way, it would probably suffice both for anonymity purposes
(as you need to "reverse" such a hash to get to the real author) and
allows easy verification (if you need to "prove" that an anonymised
author 9f5d8e44edfb7e1aa4dcf34acc3b4d643f83e1b6 recorded in the
commit object is an author with a known name/address, you can feed
that name/address to the hash function and if it hashes to the same
value, that claim is as good as having the name/address directly
recorded in the commit object.


