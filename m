Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422AC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711846197F
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVSDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:03:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64344 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhCVSCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:02:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D390B1753;
        Mon, 22 Mar 2021 14:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AICHpddQtTP4C8ksaSp7lT2G3qs=; b=hp+2lq
        HtzlKlLO3fdDwZyNbR//gRkckIUwCONWDmYvTL5V8U/UJQJU58DfeVuuyyHkjU5l
        NfO5BqI+bSNa5qaMtglP+RtF4ra4ayJ9NIA32m3T9yC3h9yfBLlE02604ekP+Tb1
        r1AFBT3l7I9aNIy1grTTTaJeq6uFV3GlDU5NY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QOxek7gfDVtuQAqkeDj0qdiFo/NfI2W9
        Pm2GBrkOR0up8JRubXGcT7lrg+4ZLRkibr834G5Ky8w/VviI6AZ6Fr/bCHscEQ11
        3Aqwzdkp2T57bKHKsLqgqfr5Kp9+Mt80IU7QgMZaiSDWIo7hmUxeZwOwo+aQWZsT
        6a8D3/5xx6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3444AB1751;
        Mon, 22 Mar 2021 14:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1122B174F;
        Mon, 22 Mar 2021 14:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Madhu <enometh@meer.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <xmqq1rc89nk7.fsf@gitster.g>
        <20210322.081043.1437207928602570397.enometh@meer.net>
        <xmqq7dlz94by.fsf@gitster.g>
        <20210322.143437.212295420302618690.enometh@meer.net>
Date:   Mon, 22 Mar 2021 11:02:42 -0700
In-Reply-To: <20210322.143437.212295420302618690.enometh@meer.net> (Madhu's
        message of "Mon, 22 Mar 2021 14:34:37 +0530 (IST)")
Message-ID: <xmqqr1k76p8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCEC6D5A-8B38-11EB-A983-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Madhu <enometh@meer.net> writes:

> *  Junio C Hamano <gitster@pobox.com> <xmqq7dlz94by.fsf@gitster.g>
>> ...
>> And the symlink check is never done in "reinit" case, so perhaps
>> when "git init" is run again in an already functioning repository,
>> we should not muck with the filemode, either.
>
> I'd think so (on the last point)....

So, assuming that you are with me to think that reinit should not
touch the filemode thing, ...

>> A natural conclusion of the line of thought is that we can move the
>> "check filemode trustability" block (from the comment to concluding
>> git_config_set()) inside the "if (!reinit)" that happens a bit later
>> and we'd be fine---as an existing normal repository, as well as what
>> new-workdir creates, won't have to do the "let's chmod +x/-x the
>> config file and see what happens" code at all (perhaps the attached
>> patch, which hasn't even been compile tested).
>> ...

... wouldn't the illustration patch I gave, which removed the "check
filemode" bit from the main codepath and moved it to inside an if
block that is executed only when "if (!reinit)" is true, "skip" the
problematic "check if config is a regular file whose executable bit
can be flipped and flopped" code in your use case, i.e. in an existing
repository?

> I don't think the posted patch (snipped) would work as reinit is
> always 1 and we are always a candidate for reiniting - I may be
> missing something.

In other words, yes, the illustration patch you are responding to
assumes that the "reinit" variable is set correctly (i.e. the HEAD
exists and sensibly readable if you run "git init" in an already
functioning working tree) and we can use it to avoid the filemode
check.

> Using a new file for the filemode test would be a natural
> improvement. 

That becomes necessary only if we want to futz with core.filemode
while doing "reinit", as .git/config can be a symlink.  When we are
creating a repository from scratch, we always create a regular file
to prepare .git/config, and there is no need to do that, if we are
happy to set core.filemode the same way as core.symlinks, i.e. only
check once when the repository is created.  No?

Thanks.


