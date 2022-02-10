Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D242C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 20:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiBJUaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:30:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiBJUaM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 15:30:12 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EEB84
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 12:30:13 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF194160110;
        Thu, 10 Feb 2022 15:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVg4+Z07AzvbyrUT8FBL6Ad+lOOjmkByEEwiSy
        uyAHM=; b=oM57QWfRyx4bp+8IF0yJWOZyKJh9PcjdleBNnqs5YPEtFTFXHnjW8w
        MTtpOiIAqza7DO5/0aaErz0S5engt4xviqKuac1Z4VSQ0lzByYQ89qYQ3eF+5LTS
        TVmbZe28MVdF2QQF7sLyl5cx/5/IdPm+suDGZOGWhHHeEUqYcFZlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D724016010F;
        Thu, 10 Feb 2022 15:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C9AC16010E;
        Thu, 10 Feb 2022 15:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/3] Add cat-file --batch-command flag
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
Date:   Thu, 10 Feb 2022 12:30:08 -0800
In-Reply-To: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 10 Feb 2022 04:01:43 +0000")
Message-ID: <xmqq8ruiforz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E1DC100-8AB0-11EC-9B1B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The feature proposal of adding a command interface to cat-file was first
> discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
> before moving forward with a new flag. An RFC was created [C] and the idea
> was discussed more thoroughly, and overall it seemed like it was headed in
> the right direction.
>
> This patch series consolidates the feedback from these different threads.
>
> This patch series has three parts:
>
>  1. preparation patch to rename a variable
>  2. adding an enum to keep track of batch modes
>  3. logic to handle --batch-command flag, adding contents, info, flush
>     commands
>
> Changes since v3 (thanks to Junio's feedback):
>
>  * added cascading logic in batch_options_callback()
>  * free memory for queued call input lines
>  * do not throw error when flushing an empty queue
>  * renamed cmds array to singular queued_cmd
>  * fixed flaky test that failed --stress

Unfortunately this round still seems to fail fairly reliably without
--stress.  FWIW, I usually run tests with "cd t && make prove" but
it seems to get stuck after passing 

    ok 69 - --batch without size (blob)
    ok 70 - --batch-command --buffer with flush for blob info

even when the test is run without prove.

