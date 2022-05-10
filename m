Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB9C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbiEJRE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbiEJREz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:04:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116302EA1F
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:00:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7594114FC9;
        Tue, 10 May 2022 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jbb2tf0H8zV5DQIRd51+zN7YuM2iU/5gOCzVSI
        5j8ZU=; b=Hh94aaE16MsJR9U3ZtHgDnEdumEtE1/dnvNj/qx6PZdQNY/ZqFsSpn
        IxKrm9ifpqMw88O6LWN88rw9NkYZqWIuPvlDsV9zpKn5kvGsNvg3fsjgvffcwdOO
        h9Fuw7srNzM8wochurj1JAcIES+i1RJ0aoxP4qJE856985aJwBpBA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5EB114FC8;
        Tue, 10 May 2022 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31FB5114FC7;
        Tue, 10 May 2022 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Addison Klinke <addison@baller.tv>
Cc:     git@vger.kernel.org, Addison Klinke <agk38@case.edu>
Subject: Re: [FR] supporting submodules with alternate version control
 systems (new contributor)
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
Date:   Tue, 10 May 2022 10:00:52 -0700
In-Reply-To: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
        (Addison Klinke's message of "Tue, 10 May 2022 10:11:48 -0600")
Message-ID: <xmqq4k1x8gqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0E50860-D082-11EC-BC90-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addison Klinke <addison@baller.tv> writes:

> Is something along these lines feasible?

Offhand, I only think of one thing that could make it fundamentally
infeasible.

When you bind an external repository (be it stored in Git or
somebody else's system) as a submodule, each commit in the
superproject records which exact commit in the submodule is used
with the rest of the superproject tree.  And that is done by
recording the object name of the commit in the submodule.

What it means for the foreign system that wants to "plug into" a
superproject in Git as a submodule?  It is required to do two
things:

 * At the time "git commit" is run at the superproject level, the
   foreign system has to be able to say "the version I have to be
   used in the context of this superproject commit is X", with X
   that somehow can be stored in the superproject's tree object
   (which is sized 20-byte for SHA-1 repositories; in SHA-256
   repositories, it is a bit wider).

 * At the time "git chekcout" is run at the superproject level, the
   superproject will learn the above X (i.e. the version of the
   submodule that goes with the version of the superproject being
   checked out).  The foreign system has to be able to perform a
   "checkout" given that X.

If a foreign system cannot do the above two, then it fundamentally
would be incapable of participating in such a "superproject and
submodule" relationship.

Everything else I think is feasible in the sense that "it is just a
matter of programming".

It is a different story how it is implemented, how much it would
cost to do so, and if it is worth maintaining it as part of Git, so
I'd stop at "is it feasible?" here, not judging "if it is realistic"
at this point ;-).

