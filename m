Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79749C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E40207FD
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OshHDtsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgBQSFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:05:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52318 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 13:05:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 105825420B;
        Mon, 17 Feb 2020 13:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZIMinWWBBO5GStrTG5PCmw+3IbM=; b=OshHDt
        sTkfj9WPiJnP4brptQ9pnGaKzrpSOrk2860SyaqYAKeNVx5mqFevT03tChuEpAmU
        hfSTKWTpBMT09M5DpQz6DA2XaocbYGSOfQGvsfnYK9YtOQUdeYWRblPegPKwWHKU
        fhF5DSy4qqM/VLZjVmcB4vBjLdd18uPR9mNOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sbYfbe8Xavs7VZTzJBsFYDQe95yAEy+b
        Y+3F2hw6W9tvss7VUBQ4aSD4EaPfdamUSEd92cYKhm33Ip0w2yowXqYH3qYSkR1E
        DbTtoLR3ooKpzrpc74vvpXcN6UPdsnmSyPamGvk6uppYm86giCeSdLIvRJ9kYjmL
        yWHWl/BENFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07D5C54209;
        Mon, 17 Feb 2020 13:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F79B54208;
        Mon, 17 Feb 2020 13:04:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] check-ignore: fix handling with negated patterns
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 10:04:58 -0800
In-Reply-To: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Mon, 17 Feb 2020 16:15:06
        +0000")
Message-ID: <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03018060-51B0-11EA-81FE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> check-ignore was meant to check ignore rules the same way git status and
> other commands would, and to report whether a path is excluded.  It
> failed to do this (and generated a few bug reports), however, because it
> did not account for negated patterns.

I suspect that the above distorts history.  IIRC, it was meant as a
tool to see which exact pattern in the exclude sequence had the
final say for the given needle, written primarily as a debugging
aid.  In that context, "This rule has the final say", whether the
rule is a negative or positive, still means something.

It is just the behavior is _much_ less useful for those who want to
know what the final say is, and I tend to agree that we probably are
better off changing its output to reflect "so, are we ignoring the
path after all? yes/no?" because we are pretty much done with
debugging the exclude API implementation.
