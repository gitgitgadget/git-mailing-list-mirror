Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DDC19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiHMR0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiHMR0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 13:26:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE510543
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 10:26:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0769B141DEB;
        Sat, 13 Aug 2022 13:26:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iI+yVYeO4Auy
        t6DCwrVwaNBsp6fnuDXa0PtH8ZO4M/A=; b=evso3xhDycQM/mp+pOlHp6C2weO4
        WU0L6qOOxpA76DL4R5WpkaRlaNN7OhIjtg1JTcnV+nUROiL3lcLhAetXh+3VXG9Y
        PnaKubdr38dbb6PthbHWfp7zuRzTXMeBGoqoDx1dG+RW+3HR8gi3CqDB70EU7j7u
        6STN6CLn5G18+S4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0596141DEA;
        Sat, 13 Aug 2022 13:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 488E7141DE9;
        Sat, 13 Aug 2022 13:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
        <YvZnQFVMZZmz9TIX@danh.dev> <YvcdskzUkocUv/d7@pobox.com>
        <xmqqczd4ag8f.fsf@gitster.g> <YvfFUuuydtYeuvRx@danh.dev>
Date:   Sat, 13 Aug 2022 10:26:05 -0700
In-Reply-To: <YvfFUuuydtYeuvRx@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Sat, 13 Aug 2022 22:37:54 +0700")
Message-ID: <xmqqsfm08382.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05349112-1B2D-11ED-9B22-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Then, we are getting back to point #0, we don't have universally way
> to specify stdin as input file for crontab(1) and "crontab -e" is
> optional.
>
> Perhaps, FreeBSD needs to carry this patch downstream; or
> we will invent new preprocessor, let's say CRONTAB_DASH_IS_STDIN
> which is defined in FreeBSD,

Does FreeBSD offer choices of cron implementations other than Vixie,
just like some Linux distributions?  If somebody on a non-FreeBSD
platform happens to choose to use Vixie, then they would presumably
have the same problem, so a compile-time switch, whose default is
hardcoded based on the target platform, would not work very well.
The default will be wrong for some users, and users can later choose
to switch between different cron implementations.

Configuration knob can be used as a workaround, but in this case, I
am not sure if it is worth doing.  What's the downside of securely
opening a temporary file and write whatever we are currently piping
to a spawned "crontab" command and then giving the path to that
temporary file to the "crontab" command?  Wouldn't that give us the
maximal portability without that much code, no?

I think this is all Derrick's code from 2fec604f (maintenance: add
start/stop subcommands, 2020-09-11), so let's add him to the
discussion.
