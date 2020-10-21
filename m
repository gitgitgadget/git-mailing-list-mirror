Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F46FC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC44521531
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q92NWdu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440761AbgJUTxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:53:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62984 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410391AbgJUTxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 15:53:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E2477EF5E;
        Wed, 21 Oct 2020 15:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mhAmIhf6kMc439G2vdQ87K55GCE=; b=Q92NWd
        u8slLhqVuNcW8gD6DlZKRXs1LiRBo+cvYdBzaiBcogZ0nvA3/9e1fD1xEGevRuHv
        /GL3CPcuSpchkTb1zg5HWd4oFjyWWCxgd736gu9RjTF28GLOMDSZ81Z0EEr6QW2V
        i2B/tCn9kZ/cZwtdILnMBAejovBpgnt3JnnZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bewDOKKiF8DeQgJ0HsSgP2viUVoZnfHb
        GHKz9Pvuqsv9ttS9/kWja1HfGezmSND4fkpZraf7KGxGQMpzbtUzyt2CGyTs20lF
        xepC9qLB8guo2tHUFGHYNj/nNpWoPJHUWVQ0VxMAEmBgqGxcY/Q5XqCZqalZ1iR8
        Y0O1XcoexNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 863577EF5C;
        Wed, 21 Oct 2020 15:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 102FE7EF5B;
        Wed, 21 Oct 2020 15:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
        <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
        <20201021162044.GB111581@nand.local>
Date:   Wed, 21 Oct 2020 12:53:09 -0700
In-Reply-To: <20201021162044.GB111581@nand.local> (Taylor Blau's message of
        "Wed, 21 Oct 2020 12:20:44 -0400")
Message-ID: <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BBE3A4C-13D7-11EB-AE92-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'm not sure that that's the case: Junio pointed out a while[1] ago that
> we'd have to answer the question of "what happens if I'm in a
> subdirectory that goes away during some point of the bisection?". I
> think that you could probably find an answer to that question, but the
> fact that there isn't an obvious one seems to indicate that we're going
> down the wrong path.
>
> I agree that it would be nice to run bisect from any directory, but it
> may not be as easy as I'd hope.

True.

I would not mind all that much a single "git checkout ancient" that
makes the $cwd go away and confuse the user.  But a bisect session
would jump around versions randomly (eh, logarithmically?) and you'd
end up switching out of a version in a non-existing $cwd to another
version that has the directory (created internally by mkdir(2)), and
I'm fairly certain that your phantom $cwd that is not connected to
any other filesystem entity and the directory that should be at the
same path in the newly checked-out version are different filesystem
entities.  I'd rather not have to think about the interaction
between git and the system after that point.

Thanks.
