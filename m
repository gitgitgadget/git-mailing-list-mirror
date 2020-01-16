Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107EC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A77E2073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pHka036E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgAPW5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:57:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53987 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAPW5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:57:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 792839FD8B;
        Thu, 16 Jan 2020 17:57:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t6X+MQ3Fgfg4eSlCHx9gBtyJxMw=; b=pHka03
        6E+uSGRduxn/bmnDaAP2qKkIoqvLofWkYxgomx8WUgKRjuxT0b6ib/a3JYDfzOYn
        ISZczOV4K2JQc+YyPXNR4P+sfX6sFv7GkVgqujLYtlR4t9sQibIsFP07q8+28nBt
        jM+KIp2FLSRdIQoeLFjdZa7J89un4UipX2fuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F1QgVDHWHf2W+rsBwAege4T8PtuxodH/
        iqvcKQMRAtEMjVyoxJ9lm850psZ4JIiJJHXg5XYi9kgsBHCri6+qoJZNwBMRZkBa
        qMstL1sT1GZh/Yjl9udgssTCfPVHFWGHqg6eKOnXmdDagUbt5mupX4EExapo5+iT
        89ArX0Sj04w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 715019FD8A;
        Thu, 16 Jan 2020 17:57:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4AF799FD89;
        Thu, 16 Jan 2020 17:57:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 2/3] t6025: replace pipe with redirection operator
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
        <20200116203622.4694-3-shouryashukla.oo@gmail.com>
Date:   Thu, 16 Jan 2020 14:57:39 -0800
In-Reply-To: <20200116203622.4694-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Fri, 17 Jan 2020 02:06:21 +0530")
Message-ID: <xmqqftgff1r0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9976EE6A-38B3-11EA-85EF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> -	echo "120000 $l	symlink" |
> -	git update-index --index-info &&
> +	echo "120000 $l	symlink" >foo &&
> +	git update-index --index-info <foo &&

If we had "git" on the left-hand-side (i.e. upstream) of a pipe, it
would make sense to split the pipeline like this, but this (and the
other one this patch touches) is on the right side, whose exit
status is not lost.  And we are not in the business of preparing for
broken implementation of "echo".

So this rewrite is unnecessary and unwarranted.

By the way, I think the pipeline

	echo ... | git update-index --index-info &&

should be written on a single line in the previous step 1/3.

>  	git commit -m master &&
>  	git checkout b-symlink &&
>  	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
> -	echo "120000 $l	symlink" |
> -	git update-index --index-info &&
> +	echo "120000 $l	symlink" >foo &&
> +	git update-index --index-info <foo &&
>  	git commit -m b-symlink &&
>  	git checkout b-file &&
>  	echo plain-file >symlink &&
