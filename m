Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B808C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C85721823
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4LpzvAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDVvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:51:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60347 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDVvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:51:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F6D199EE6;
        Wed,  4 Dec 2019 16:51:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V3pcio+LKoAHaE/E9XdD1YrfXUM=; b=D4Lpzv
        AuMnvGygK0xA73ESn6xNRw10hddkCKe+JVnAcuyut5L6MToME7ZKs7Vyg4b+tQwZ
        VXs2vlICqG0sdRrFzzFK4kQQsTu9kifMfXgzLA46TY2SdeVQ6fhbZXuCRSVjuBab
        /bRKeFq3k2r/NH1DdtHc+7YtJl+d9hntOPlpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gSD2oymw2dx02CZ2s1s6h+4IcrOYZuNE
        JZod+caL/XtSTvd2YUx+R/K9OvTLstuWGGHqRpqNCzsgWiaZGmwbXKrLYDlqKJR2
        EPB2ADsz/2AQ0mmPcx7LIdrP9+q+8JeUFWua324Ab9e6grfgnez9AFngyH4vlGdY
        ZvrVUE6CjVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 184ED99EE5;
        Wed,  4 Dec 2019 16:51:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 404F299EE4;
        Wed,  4 Dec 2019 16:51:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/2] rebase -i: extend rebase.missingCommitsCheck
References: <20191104095449.9964-1-alban.gruin@gmail.com>
        <20191202234759.26201-1-alban.gruin@gmail.com>
Date:   Wed, 04 Dec 2019 13:51:36 -0800
In-Reply-To: <20191202234759.26201-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 3 Dec 2019 00:47:57 +0100")
Message-ID: <xmqqmuc73gk7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 402398E4-16E0-11EA-BD6D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> To prevent mistakes when editing a branch, rebase features a knob,
> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
> Unfortunately, this check is only effective for the initial edit, which
> means that if you edit the todo list at a later point of the rebase and
> drop a commit, no warnings or errors would be issued.
> ...
>  rebase-interactive.c          | 57 ++++++++++++++++++++----
>  rebase-interactive.h          |  2 +
>  sequencer.c                   | 53 ++++++----------------
>  sequencer.h                   |  1 -
>  t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
>  5 files changed, 147 insertions(+), 49 deletions(-)

This passes the self-test when tested by itself, but when merged
near the tip of 'pu', it breaks t3404.116, it seems.
