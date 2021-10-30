Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB256C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B2760720
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ3V1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:27:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57664 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJ3V1p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:27:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE163152AFE;
        Sat, 30 Oct 2021 17:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AvPqJpSADBWDGylPMM6skbUe9m5OQ9CmAUfq6y
        LC9kQ=; b=bhDFnE9I1qLEEtKIt/VAOCzj2d2nuZeXx1VjyKmquVreBSsckumBbH
        yJiOz2Zv5jjv77U/RXYRacnzYYT+zPxZwPtuWauZWVllXiaI/MjXNsn9HdgMiE3r
        wRu2DFUtrS4oar+TO9/Wc881yJhe7a5pjKrOlirfhpxtRdvKnDaho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5BB5152AFD;
        Sat, 30 Oct 2021 17:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A23C152AFC;
        Sat, 30 Oct 2021 17:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Peter Hunkeler <phunsoft@gmx.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailinglist <git@vger.kernel.org>
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
        <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
        <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
        <c5507ba6-6e31-b143-9791-0bcff54acb64@gmx.net>
        <4c88e2ae-e42f-491a-2b97-aa1f92c392d5@kdbg.org>
Date:   Sat, 30 Oct 2021 14:25:09 -0700
In-Reply-To: <4c88e2ae-e42f-491a-2b97-aa1f92c392d5@kdbg.org> (Johannes Sixt's
        message of "Sat, 30 Oct 2021 18:44:54 +0200")
Message-ID: <xmqqlf2adx3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCB592D2-39C7-11EC-A2A0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Even though the documentation does not say explicitly that the commit
> must not be changed, it is implicit in the stated intent (that the
> commit is only checked). Depending on that some particular behavior
> works for you sometimes is then your own business, and when it breaks
> you get to keep both parts.

The above matches my _intention_ for the pre-commit hook when I
added it in 2005, but there were enough people who wanted to abuse
the interface that it no longer exactly matches the reality.  It has
been made usable to inspect the changes (which is the original
purpose of the hook) and in addition, apply mechanical fixes on top,
before making the commit.

The story so far, however, is that the scenario that started this
thread is not even that, if I understand it correctly.  The question
is: what should happen when *nothing* is different between the HEAD
and the index, the user types "$ git commit" (no pathspec, no
nothing, commit the index as-is, no --allow-empty option), and the
pre-commit mucks with the index to "fix" the content in the index.

Because we check if there is anything to commit before we invoke the
pre-commit hook and then reject an empty commit based on that, we
successfully reject the attempt to commit.  This is in line even
with the modern intention, as the mucking done by the hook cannot be
"fixes" based on the observation of the changes made to the index by
the user (e.g. "The user tries to add changes, with whitespace
breakages, and then pre-commit hook notices.  Instead of rejecting,
it fixes the whitespace issues for the user" is the justifying use
case behind the looser than the original "check only, no touching"
definition).  So ...

> In conclusion, the pre-commit hook behaves as designed and nothing has
> to be changed.

... in conclusion, pre-commit is *not* a place to make such a change
that may be created by a script even when there is no human
initiated change, and "git commit" is behaving as designed.

But there are two things that are not solved yet.

 * It is *not* the ultimate goal of the OP to "use" pre-commit
   hook.  The goal of OP is to find a workflow ingredient where
   changes other than human initiated ones are committed at the same
   time human user tries to commit changes created by human.  So if
   pre-commit is the wrong tool to use for that purpose, what is it?

   I suspect that there is no built-in way to do this, and I am not
   sure if it is a good idea to add such a feature to the tool---as
   some have already noted in the discussion, it may encourage a bad
   workflow to include such non-human-created artifacts to human
   initiated commit.  I don't know.

 * If we do not consider changes made by pre-commit hook to count as
   "without --allow-empty, an empty commit is rejected" logic, why
   do we even call the hook in the first place in such a case?  I
   think there is a room for improvement on our side---perhaps we
   can make "git commit" fail much earlier in such a case without
   calling the pre-commit hook.

Thanks for the discussion so far.

