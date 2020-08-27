Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD6C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F7D20737
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vbOL7cEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgH0RO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:14:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50624 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgH0ROZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:14:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B1BDF545C;
        Thu, 27 Aug 2020 13:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Dm+vWd0WcB8L1AM/2hXj8Jca2Y=; b=vbOL7c
        EgE4FXls52JUAqviV/Btg8RetQXtEAQKd9y5j8emLSL2GUQ0VSYAYKQBusblgcyW
        IivcFhLBtImkaKVZXzvmPY4AySlMJcTUKaQ6Ym9sx9k6RUKgmcNoFhSzH3HdLVRC
        xT+vQHjtXdL052b1rja5PaHE45ugrStqGx638=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tiHiPJVwmeuFA7jOZ41fH5/Cv2ufOEjm
        P0YgXVD1Y5e0HWUzN/r43bttm1EqC1rDq3lkSm/atiaeX0gxXewZg6PKo35T9l3Q
        Xj0JKMOCY14xQa/pUw/gAPlQKcUA8FcxOtcIZYgg5N+V0mT7q9w+oMf8Wukig0jH
        UsVpgpMIid4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 638B5F545B;
        Thu, 27 Aug 2020 13:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A7B37F545A;
        Thu, 27 Aug 2020 13:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Henr=C3=A9?= Botha <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to worktrees
References: <20200827082129.56149-1-sunshine@sunshineco.com>
        <20200827082129.56149-4-sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 10:14:17 -0700
In-Reply-To: <20200827082129.56149-4-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Thu, 27 Aug 2020 04:21:27 -0400")
Message-ID: <xmqqh7soqady.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDE04D02-E888-11EA-9889-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The .git/worktrees/<id>/gitdir file points at the location of a linked
> worktree's .git file. Its content must be of the form
> /path/to/worktree/.git (from which the location of the worktree itself
> can be derived by stripping the "/.git" suffix). If the gitdir file is
> deleted or becomes corrupted or outdated, then Git will be unable to
> find the linked worktree. An easy way for the gitdir file to become
> outdated is for the user to move the worktree manually (without using
> "git worktree move"). Although it is possible to manually update the
> gitdir file to reflect the new linked worktree location, doing so
> requires a level of knowledge about worktree internals beyond what a
> user should be expected to know offhand.
>
> Therefore, teach "git worktree repair" how to repair broken or outdated
> .git/worktrees/<id>/gitdir files automatically. (For this to work, the
> command must either be invoked from within the worktree whose gitdir
> file requires repair, or from within the main or any linked worktree by
> providing the path of the broken worktree as an argument to "git
> worktree repair".)

Would git "work" in a corrupt worktree whose gitfile is broken, in
the sense that it notices that the cwd is the top of the working
tree of a secondary worktree?  I can imagine how it would work,
starting in one of the functioning worktrees so that git can locate
where the primary copy is, with end-user supplied path to a
directory that is supposed to be the top of the working tree of a
secondary worktree.

Hmph, if the secondary is _moved_, how would "worktree repair $path"
would know which <id> the $path corresponds to?  Would we just cull
all the <id> that do not point at working secondary worktrees and
add the $path as if it were a new one by allocating a new <id>, or
reusing a randomly chosen <id> that points at a non-existing
location?

