Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF41C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiCWUtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbiCWUtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:49:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59713CF7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:48:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A365917AF12;
        Wed, 23 Mar 2022 16:48:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aeKWZwkLLOWpXk/b5gkjJBm41Hil/AwJ5hIQ9P
        ZDKUc=; b=UC27QH9iMFScW6crQmFn3M3dQg7saXMrbwU9yLLJ+N5fppZeICzcK3
        CIDj1EVzDVTyzfKd7ivL3jVhGvRjzWIxtK9YA9wP7MxCEQ2U565gSSQ3KnevkM3L
        XYE9njT7RmVhpgXiZfWo0T5Y4yJGLJH0x3/YXd9i4B9gbarPLZw+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CA2517AF10;
        Wed, 23 Mar 2022 16:48:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 042D417AF09;
        Wed, 23 Mar 2022 16:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How to determine the number of unique recent committers on a
 branch?
References: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
Date:   Wed, 23 Mar 2022 13:48:12 -0700
In-Reply-To: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
        (Sebastian Schuberth's message of "Wed, 23 Mar 2022 11:23:07 +0100")
Message-ID: <xmqqy210qttf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E6EB3C6-AAEA-11EC-9599-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> I'm trying to determine the number of unique committers who have
> recently committed to a branch. "Recently" should be configurable, but
> for my example I'll use a period of 3 months.
>
> At first, I thought the [<refname>]@{<date>} syntax [1] in conjunction
> with git "shortlog -s" could be helpful here, like
>
> $ git shortlog -s main@{3.months.ago} | wc -l

As reflog is pretty much the local matter, this is "find out the
commit _I_ happened to have seen at the tip of 'main' in _this_
repository 3 months ago, and count all commits before that one".

If you were taking 6 months sabbatical, not fetching the repository
during that time, and then you fetched to become up to date with the
upstream, you may have had a copy of the shared project history only
as of 6 months ago with that notation, even though the syntax is
asking for "3 months ago", simply because that was the commit your
repository had 3 months ago at the tip of the branch.

    $ git log --until=3.months.ago

would instead look at the timestamp recorded in commit objects,
which would probably be more relevant to project participants.
