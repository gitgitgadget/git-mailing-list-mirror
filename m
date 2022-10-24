Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A4ECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 19:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJXTDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiJXTDA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 15:03:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9EC97DC
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:42:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A77E51B5BB6;
        Mon, 24 Oct 2022 13:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bicLjlG2tOy4vjLNSqyg72ebrEep3+emvcEYi
        dFqMg=; b=QoH5CgaNrRHrqQaqJteYiFoxcU6i2ocvEv/fvUlWg/kLwuS/yzoCBE
        6gitMbFiQ/WV4AmNyCOkIrurswjQ8oVbzHW30DxtoeoRE+V64bcyNzIJjpXtF3Sa
        QT8ucaQepOeG2OTtNpvqC3cc9PlhYS6w82ca34bIdKzkVV5bLfzKQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A07111B5BB5;
        Mon, 24 Oct 2022 13:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3B691B5BB4;
        Mon, 24 Oct 2022 13:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] fsck: document msg-id
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <3aec3d2c9ca65a37a367c3a7c9081bbd4cd44ae0.1666623639.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 10:33:41 -0700
In-Reply-To: <3aec3d2c9ca65a37a367c3a7c9081bbd4cd44ae0.1666623639.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Mon, 24 Oct 2022 15:00:38
        +0000")
Message-ID: <xmqq8rl5t9ca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 014AB568-53C2-11ED-A2F1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The git-config documentation lacks mention of specific <msg-id> that
> are supported. While git-help --config will display a list of these options,
> often developers' first instinct is to consult the git docs to find valid
> config values.

Good observation.  "help --config" only gives names and no
description, so maintaining the description like this new file does
make sense.

Can you also add a referencing comment to fsck.h to tell that folks
who add a new error type that they need to update the -msgids.txt
file as well?

Does this list in the new file cover all existing messages, by the
way?

I also wonder if the order of the entries in this file should be
alphabetical, unlike the entries in fsck.h where more severe ones
come earlier than the less severe ones.  In a sense, matching the
order of two lists makes it easier to maintain, and grouping by
severity in the doc might or might not find it easier to scan and
find what they are, but one of the biggest reason why users will
come to this list is when they see a particular error message and
want to understand what that means, no?  At that point it would be
easier to look things up if 

 (1) the list contains EVERYTHING, even the ones that you are not
     supposed to configure away.

 (2) the list is sorted alphabetically, regardless of the severity.

The first point suggests that it may be a mistake to have the main
list appear in the "what configuration knobs are available for
squelching fsck error messages".  It is OK to refer from there to
the main list, but the main list should list everything, with
comments like "(this error cannot be configured away)", no?

In other words, I think it is better to have a master list of
everything, with their message ID and textual description, which
essentially is your fsck-msgids.txt but additionally mention which
ones are by default FATAL and cannot be configured away (even
better, we can mention what severity level each of them is by
default, by mirroring that is in fsck.h).

And that master list should NOT be made a part of fsck.<msg-type>
configuration item, like this patch did.  It should be a separate
section in "git fsck --help" output whose section title is "Fsck
errors" or something.  

Then the existing description of fsck.<msg-type> configuration can
refer to that "Fsck errors" section for what msg types exist.

Another thing that I noticed while thinking about the patch, but is
better left outside the scope of this patch, is that an attempt to
configure fatal ones away is prevented by fsck.c::fsck_set_msg_type() 
but "git help config | grep '^fsck\.'" lists them.  I think the
"help config" should be fixed.

I almost suggested to extend the FOREACH_FSCK_MSG_ID() definition in
fsck.h so that fsck-msgids.txt gets auto-generated (what is missing
in fsck.h that prevents us from doing so is the textual explanation
you added in the new file in your patch---they could come from
comments on the same line, for example, and can be extracted via a
Perl or sed script at build time).  I do not know if it is a good
idea, especially if we forsee a future in which we may be
translating the documentation, so decided against making such a
suggestion.

But at least, we could _lint_ the manually curated fsck-msgids.txt
using what is in fsck.h to see if a new MSG_ID added to fsck.h is
missing from the doc, or a MSG_ID whose default severity is updated
in fsck.h is stale in the doc, etc.  That can be left for the future
updates, but we should at least instruct developers to keep them in
sync in fsck.h by adding a comment.

Thanks.
