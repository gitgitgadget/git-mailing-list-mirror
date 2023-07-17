Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FFEB64DD
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 02:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGQC5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 22:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQC5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 22:57:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32010D
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 19:57:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 628C926B4E;
        Sun, 16 Jul 2023 22:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M6vAQzJZ3lkOk7KuDuRvRp8hpiupgj9FSMGwBQ
        y7igI=; b=pnHzA2IXid2m7m7xr9yiFvytwdHfzhulbKnattwN1+dQAGQiNrGoG+
        0qnZfS2kiY0sk+kIRjF1ZPBcfuSY/mclRemuPmkH1FItKM1Zq25UUWRttnBe/yhO
        qACW9KYRUfnGBSGQad3ML1l5DaWjCDzflE0B3tW16VSJFZdMWPgq4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BB1C26B4D;
        Sun, 16 Jul 2023 22:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 075BB26B4C;
        Sun, 16 Jul 2023 22:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     nick <nick@nicholasjohnson.ch>, git@vger.kernel.org
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
        <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
        <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
        <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
        <xmqqsf9njmc9.fsf@gitster.g>
Date:   Sun, 16 Jul 2023 19:57:39 -0700
In-Reply-To: <xmqqsf9njmc9.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        16 Jul 2023 19:36:22 -0700")
Message-ID: <xmqq5y6jjlcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1E0C62C-244D-11EE-866F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> and just use them), we should NOT be adding a "--privacy" option
> that picks rand(24)*60 as UTC offset and pretends that it the
> timezone of the author, and picks some random timestamp between the
> timestamp of the latest commit in the repository and the actual
> wallclock timestamp and pretends that is the author time.  After
> all, our project is not about coming up with a quality time
> obfusucation.

We could go to the extreme in the complete opposite, if we do not
care about the quality of the "privacy" feature, and you could
probably talk me into adopting below as long as the option or the
configuration are not named with the word "privacy" in them (a
"--useless-time" option, or a "core.uselesstime" configuration
variable, are OK).

When the feature is in effect, all timestamps in commit and tag
objects pretend to be in UTC timezone, and

 (1) the commits record the Epoch as its timestamps if there is no
     parent;

 (2) the commits record one second after the largest of the
     timestamps as its timestamps of all its parents;

 (3) in any case, the same (phoney) timestamp is used for author and
     committer.

 (4) the tags record the Epoch as its timestamp if they point at
     trees or blobs.

 (5) the tags record one second after the largest timestamp of
     pointee as their timestamp, if they point at tags or commits.

 (6) as the reflog is a local matter, its timestamp may be local,
     but it is OK if it ends up being just a useless number if that
     is more convenient to implement.

The resulting history will be shouting that "I am privacy conscious
and hiding my activities behind a fake clock" in capital letters,
which I would not call a quality design of a privacy feature, but it
does completely dissociate the wallclock time from the recorded
history without breaking the monotonicity of timestamps in the
recorded history.

When the useless-time feature is in use, you cannot expect features
like "git log --since" would work sensibly, but that is a given, I
would guess.
