Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCD91F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfDXAzJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:55:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60157 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDXAzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 20:55:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A7831447E3;
        Tue, 23 Apr 2019 20:55:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YvFT+xpLzlTRXySUrH6xkhPXq6Y=; b=j08L+e
        mzr9jgbcYowh+zjeQxH4uSy3HmzliQobMl7gdHGO9uFmvI4F23cvuREC9mcAjygy
        3wVXhRx+C+Q5gaUUsxv411WvbV6m09yj12uet8i0N/Jn8Dqwfas8qgxgbnnc555p
        ZJuRfv0k8gRaxRhw7xHWv/AJMUceIfqDV1gSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cIaDuCrpWRoBQxWNpmCmddvf40oDTAD7
        IoImaC59q/Ww2HYD1V5kOojdymfMmg8qyqDqtHamMFPNyZM9opoiGVfD0n9zZ0J6
        utLtyyiHePsVPkyACuqFlYc+b07138k2y+p2ME5TbrwG9XNiS4HJNB7dt6u7sWsB
        pj5otrOAqdc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 825261447E2;
        Tue, 23 Apr 2019 20:55:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D934A1447DD;
        Tue, 23 Apr 2019 20:55:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "CHIGOT\, CLEMENT" <clement.chigot@atos.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
        <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        <20190423235526.GF6316@genre.crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 09:55:04 +0900
In-Reply-To: <20190423235526.GF6316@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 23 Apr 2019 23:55:26 +0000")
Message-ID: <xmqqsgu843yv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99A7C5B8-662B-11E9-99E3-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> What POSIX says on this is the following:
>
>   If any access permissions are checked, each shall be checked
>   individually, as described in XBD File Access Permissions, except that
>   where that description refers to execute permission for a process with
>   appropriate privileges, an implementation may indicate success for
>   X_OK even if execute permission is not granted to any user.

Do I take this "not granted to any user" as "no +x bit is set for
owner, group or other", and "a process with appropriate privileges"
as "running as root"?

The latter half feels iffy, if the system is still allowed to fail
execution by "a process with appropriate privileges", leading to
inconsistent answer from access(2) and behaviour by execv(2).  But
at least that explains what was observed.

> I believe that's what's occurring here. Your commit message, however,
> should contain some text that explains that AIX takes this liberty
> provided by POSIX, and why that causes problems for Git (i.e., what
> problems the user will see). Ideally, the reader of the commit message
> will know the relevant details about this issue from your commit message
> without needing to consult the standard itself.

Very true.

Thanks.
