Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B7C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068BE2064B
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 23:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iep7S4We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgHaXLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:11:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57228 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaXLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 19:11:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC5D8F2DDF;
        Mon, 31 Aug 2020 19:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TSgq3BZowpYo
        AS1AuK3pyqvAzgo=; b=iep7S4WeT8qHxW2pxX+nG9FF5Z5q2CBsX8mGvfEsdpG0
        h2iY69+QzZl8eisBwNn7lVi5gEeUi+27qp0q5RQfnkyB1MRXBVKK/Ykjnv5sH7NH
        pO9fhfr+SxbKiq0BO9w3DmHWXd1ONmRDtkE11qfInUCKGm4yljpFO628rFnZxF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wcEvCf
        yLwo7TPU3oyOZaD6vsrTRAjdxVyes9uXIMytsVpzl3btHBpoKrApjJqsLOa2HVTJ
        wC6mvuQyiKMlItHUojhyetXQrucBZDMYJbl4rghGjonGpKQ6f/YZlJqGxEhZ76Rb
        vrUXeHifh3NJDNd6iCCLf1lxZ/43fxRN/ijXc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4B47F2DDE;
        Mon, 31 Aug 2020 19:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05843F2DDC;
        Mon, 31 Aug 2020 19:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas =?utf-8?Q?B=C3=A9tous?= <th.betous@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: "git reset --hard" does not cancel an on-going rebase
References: <34B7EFB9-8710-4993-ACCD-604313D543E7@gmail.com>
Date:   Mon, 31 Aug 2020 16:11:45 -0700
In-Reply-To: <34B7EFB9-8710-4993-ACCD-604313D543E7@gmail.com> ("Thomas
        =?utf-8?Q?B=C3=A9tous=22's?= message of "Mon, 31 Aug 2020 23:59:38 +0200")
Message-ID: <xmqqimcye7gu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57BBABC0-EBDF-11EA-A0C7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas B=C3=A9tous <th.betous@gmail.com> writes:

> I would like to report an inconsistent behavior of the
> rebase/reset commands. I don=E2=80=99t know whether it is an actual bug
> or something else but according to me something is not right.
> When a rebase gets paused (because of a conflict for instance) I
> would expect the command "git reset --hard" to cancel this
> on-going rebase but it does not.  I expect this because for
> instance "git reset --hard" cancels a cherry-pick in the same use
> case so I think the behavior of these 2 commands should be
> consistent.

It is reasonable and desirable for multi-commit operations like
"rebase", "cherry-pick A..B" and "revert A..B" not to abort the
entire sequence with a mere "reset --hard".  After a step resulted
in conflicts, the user may try to resolve them, getting into too
deep a hole by botching resolution, and wish to redo the current
step from scratch, and "reset --hard" can be a way to clean the
slate before recreating the same conflict.  To abort the whole
thing, "rebase --abort" and "cherry-pick --abort" would be needed
to differentiate from the "clean this single step" request made with
"reset --hard".

On the other hand, operations on a single commit like "cherry-pick
X" does not have to retain "what to do after we have dealt with the
current step", so "reset --hard" that finishes the whole thing
(after all, the whole thing is the single step that may have
conflicted) would just be a convenient short-hand.

