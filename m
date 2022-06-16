Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22203C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbiFPEHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiFPEHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:07:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E67424B3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:07:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 492F118A2FA;
        Thu, 16 Jun 2022 00:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6qyrP7uBbFwoThs3WdsWtlzLBEK35gwJBQvZrC
        IApz8=; b=x/7tlfJToTKmeFgFZY4gEBe4uN47VWVgu11gsJUNeZcNn+cUx0NBc9
        lLZgx6qrQRqlkKluNKgfaCwK9RH4IDNiM3IFYHeT/b0txzM/WYyD7PA8GT1+Z9kd
        Yny/txQCDL65bOUR3msyuZbN/LyuFUHyxRvTXs9W50SW0b32XZNsI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42AB218A2F9;
        Thu, 16 Jun 2022 00:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E22C818A2F8;
        Thu, 16 Jun 2022 00:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] mingw: avoid accessing uninitialized memory in
 `is_executable()`
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:07:05 -0700
In-Reply-To: <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:35 +0000")
Message-ID: <xmqqk09hxndi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C95D16EA-ED29-11EC-A39F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, we open files we suspect might be scripts, read the first
> two bytes, and see whether they indicate a hash-bang line. We do not
> initialize the byte _after_ those two bytes, therefore `strcmp()` is
> inappropriate here.
>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This has been with us since cc3b7a97 (Windows: Make 'git help -a'
work., 2008-01-14) and apparently nobody made loud enough noises
to make us aware since then.

The fix is trivially correct, of course.

Will queue.


>
> diff --git a/run-command.c b/run-command.c
> index 14f17830f51..2ba38850b4d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -154,7 +154,7 @@ int is_executable(const char *name)
>  		n = read(fd, buf, 2);
>  		if (n == 2)
>  			/* look for a she-bang */
> -			if (!strcmp(buf, "#!"))
> +			if (!memcmp(buf, "#!", 2))
>  				st.st_mode |= S_IXUSR;
>  		close(fd);
>  	}
