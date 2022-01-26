Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767FC5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiAZUXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:23:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51724 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZUXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:23:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D16D6177F82;
        Wed, 26 Jan 2022 15:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ft6JmuH1sXNIAmmzkL1KgVpAwE7G7nRjRHt3Mm
        iR4zI=; b=tayIOrPGMkF7UuG6JBvNyTUZvzIkCQIWW3pnIoq7RrEg8DrCKFH/Ql
        XtAZI8Lb/+/JNFK4XawjbqqED6u0o9VTC7jXUKvyHKAVvv/71ydmC81Fh2dQS4jt
        qcUWHSTR1cMD9/rhrV2Nqg4mY7bfSo5bR6BWZayAF/TU9JoH0F/sw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA185177F81;
        Wed, 26 Jan 2022 15:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 158AF177F7E;
        Wed, 26 Jan 2022 15:23:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
Date:   Wed, 26 Jan 2022 12:23:17 -0800
In-Reply-To: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
        (yuri@rawbw.com's message of "Tue, 25 Jan 2022 09:13:33 -0800")
Message-ID: <xmqq4k5qqma2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCD8C74A-7EE5-11EC-B730-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> Ctrl-C was pressed in the middle. git creates the stash record and
> didn't update the files.

If you kill a program in the middle, bad things can happen ;-)

In this case, however, recovery is very easy.

Because you know that a stash entry was created that records the
local changes, if you want to finish "git stash push" (in other
words, if you wish you didn't kill "git stash push" in the middle),
you can "git reset --hard" yourself, because by definition, after
"git stash push" records all the local changes, it would have
cleared any and all local changes.  Or if you truly regret you
started "git stash push" in the first place, then you can still "git
reset --hard" and then "git stash pop".  The first step will let the
"git stash push" to "finish", and then popping the local changes
recorded in there will restore the state before you started running
"git stash push".

