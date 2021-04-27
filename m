Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6BC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BE261078
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhD0G3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 02:29:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63821 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhD0G3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 02:29:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDE94C03E4;
        Tue, 27 Apr 2021 02:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rZo8GnbRj+L8mWIe7IO2h7YG7uzJkTjq58czMY
        JIGBE=; b=Fvu6/fPT/Y9pjXRoPxrjZ3hxBmCxX/GyA/y15eScoqoLAjPW95SzhW
        Hd90+VW8sOaissMVKOCzd7lyEE8nSJHXawJOzrmO21VzR8kU1GiJrAyJWAkR7TXP
        2cyWFCAgfX3SYgGsJFoP97dJbChUtE1PeOoh2hILyHuyHVevkscl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5669C03E3;
        Tue, 27 Apr 2021 02:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F9D5C03E2;
        Tue, 27 Apr 2021 02:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jerry Zhang <jerry@skydio.com>, git@vger.kernel.org,
        ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: allow empty patch text
References: <20210427011246.28054-1-jerry@skydio.com>
        <20210427054632.GA31347@dcvr>
Date:   Tue, 27 Apr 2021 15:28:47 +0900
In-Reply-To: <20210427054632.GA31347@dcvr> (Eric Wong's message of "Tue, 27
        Apr 2021 05:46:32 +0000")
Message-ID: <xmqq7dkofdgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D31FE260-A721-11EB-B775-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I fear this change can cause errors in pipelines to go
> undetected (since "set -o pipefail" is not POSIX).
> In my experience, zero-byte files is also a common failure mode
> for some filesystems, even after fsck marked them as clean.

Thanks for saving me time to say it.

It would be a grave regression to any workflow automation to change
the behaviour to silently succeed a non-patch application as a
noop.  And it does not take filesystem corruption.

Some people seem to gpg sign their patches sent to the list, which
is not very useful at this point as I don't bother to collect their
public keys anyway, but feeding such a piece of e-mail from GNUS to
"git am -s" takes "\M-i r |" prefix instead of the regular "|" to
"pipe the message to an external command" to properly get it
processed.  I was saved by the "empty input is wrong" behaviour a
number of times.
