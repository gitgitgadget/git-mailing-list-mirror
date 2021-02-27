Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EAC433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 21:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C258C64E55
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 21:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhB0VH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 16:07:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56757 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB0VH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 16:07:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 755E912C0EE;
        Sat, 27 Feb 2021 16:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K4cJgV5Ng9oodSrGOYJfVFEBWuw=; b=H4RAGD
        fGObUTaHtVOd/FT7h+bGCzXmgK/xn5eHRAervkcfICI2tT/vXqB4Kl96DLPcwrfJ
        2ic/jChKmipbt/aN6KL4PY+h8sAZbBSeXUXocfFUo6r95aygcQrx3pRFNhlDtZ3T
        0QVFjqbhjKDjSxpS+/SXe4Xd71/WK9niuTGM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UScd91apFRZP5KNd0S70f0FSPoNQdU/Y
        wAAhJhff3XPfvIjwNEuFqSgATbfA06LbeplM5RFy37XZ7LPtFjRKgfYgpGQF5PqZ
        /8xdc7dKluKIccvWGvSmZPKgFxOHl2irJMitBvJ6zdAXoY+wjOO0YmIXntfutY4X
        IZnyrlA9KeA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DED912C0ED;
        Sat, 27 Feb 2021 16:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 917B012C0EC;
        Sat, 27 Feb 2021 16:06:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org
Subject: Re: bug: setting GIT_DIR to $(git rev-parse --git-dir) changes
 behavior
References: <alpine.LSU.2.20.2102260846280.20742@cpza.bfz-tzou.qr>
Date:   Sat, 27 Feb 2021 13:06:36 -0800
In-Reply-To: <alpine.LSU.2.20.2102260846280.20742@cpza.bfz-tzou.qr> (Martin
        Nicolay's message of "Fri, 26 Feb 2021 08:54:59 +0100 (CET)")
Message-ID: <xmqq35xhte3n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEB7C984-793F-11EB-BB02-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Nicolay <m.nicolay@osm-ag.de> writes:

> On Thursday 2021-02-25 19:29, Junio C Hamano wrote:
>> The root of the working tree is at /tmp/t/, the repository at
>> /tmp/t/.git/, and you are in the foo/ subdirectory.  When you ask
>> "where is the top level of the working tree in this state, because
>> you do not have GIT_DIR or GIT_WORK_TREE environment variables, you
>> are asking Git to "discover" both the .git/ directory and the top of
>> the working tree, by starting at the current directory,
>> i.e. /tmp/t/foo, which is where you are.
>
> *facepalm* The part about GIT_DIR setting the work-tree in addition to
>  the repository I hadn't read. How embarrasing.
>
> I apoligize for my bad reading skills and wasting you time.

We would love to hear observations on which part of the
documentation was misleading and suggestions on how to make it
harder to misinterpret it.

No need to apologize, and thanks for reporting.
