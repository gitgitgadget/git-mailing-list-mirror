Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8776E8FDBB
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjJCV0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCV0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:26:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E4AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:26:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 850D91B8D30;
        Tue,  3 Oct 2023 17:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UkFaxqV/khVc5DO5EOMvXNl1PpNjgNHhqWZN7Z
        76ygI=; b=HjKK9Yz2lMjqm/QxW2LDyti96W4FcCPP9LbakxsMfTkHNx7BmGA8WJ
        GmRWXRXnQ3N19EHp4i8LdOd8cgZZ4QLj2rhs9MC299fLLwWM+xFDg3JMP5rPlqcf
        kA1fpGC5UaTfOTaiATDfzZr9bj0uUpPBQW0lOH4/27VIfqOVYuWw8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C75F1B8D2F;
        Tue,  3 Oct 2023 17:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA5C91B8D2E;
        Tue,  3 Oct 2023 17:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [silly] loose, pack, and another thing?
In-Reply-To: <20231003190955.GA1562@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Oct 2023 15:09:55 -0400")
References: <xmqqbkdometi.fsf@gitster.g>
        <20230928214010.3502838-1-jonathantanmy@google.com>
        <20231003190955.GA1562@coredump.intra.peff.net>
Date:   Tue, 03 Oct 2023 14:26:41 -0700
Message-ID: <xmqqo7hfwg6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C2471E4-6233-11EE-9FD4-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One thing that scares me about a regular "ln" between the worktree and
> odb is that you are very susceptible to corrupting the repository by
> modifying the worktree file with regular tools. If they do a complete
> rewrite and atomic rename (or link) to put the new file in place, that
> is OK. But opening the file for appending, or general writing, is bad.

Very true.

> You can get some safety with the immutable attribute (which applies to
> the inode itself, and thus any path that hardlinks to it). But setting
> that usually requires being root. And it creates other irritations for
> normal use (you have to unset it before even removing the hardlink).

As a regular user, "chmod a-w" has the same characteristics (works
at the inode level) but without "cannot remove it" downside.  It
used to be sufficient in RCS and CVS days, though, as a signal that
you are only to look at it without touching it, to "chmod a-w" a
path that is checked out but not for modifying.  Some editors even
offer to do chmod u+w for you when saving, so if we want absolute
safety, it may not be enough.

> It would be nice if there was some portable copy-on-write abstraction we
> could rely on, but I don't think there is one.

;-)
