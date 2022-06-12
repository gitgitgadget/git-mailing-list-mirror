Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004EC43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 23:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiFLXf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiFLXf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 19:35:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827556B3F
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 16:35:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB87112D317;
        Sun, 12 Jun 2022 19:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FvFfuz+/VOnVbS4QhBplAf+ODUHb61+FWhWCtH
        5D49Y=; b=tVgmyYfWVjv8FXEMxbofplZ0GPeaylYlMsu3PeBXsUNEKnvf+/0FdX
        1BfVoyxspX7hWMhRqZOr/XxB6M1U44kceOSLm3lZt3NAVIlPWa4Dj/QJ0jdFtqR4
        P8YJAQ2lMlxmyttYsYdIRp4CklMAcmURn9n4B0JzEmNIgv11N7Q6I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2A2B12D315;
        Sun, 12 Jun 2022 19:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F84C12D314;
        Sun, 12 Jun 2022 19:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
        <xmqqleu3au2n.fsf@gitster.g>
Date:   Sun, 12 Jun 2022 16:35:53 -0700
In-Reply-To: <xmqqleu3au2n.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        11 Jun 2022 12:17:20 -0700")
Message-ID: <xmqqedzt8nfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66D271E2-EAA8-11EC-8AA6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  I
> do not think in_fn_table() pays attention to "ignore_case" option,
> so there may be an existing bug there already, regardless of the
> problem you are trying to address with your patch.
>
> And I wonder if doing case-insensitive match in in_fn_table() lets
> us cover this new case as well as "fixing" the existing issue.

While I still think in_fn_table() should be looked into for an
existing case sensitivity bug, I think this one is different enough
that in_fn_table() logic wouild not trigger for it, and a patch to
add an extra piece of logic for renames is probably needed.

It might be sufficient to tighten the condition so that it triggers
only to the case you wanted to handle, i.e. a rename between the
same name.

	else if (ignore_case && old_name && new_name &&
		 !strcasecmp(old_name, new_name))

(the "both names must be non-NULL" check is new).

Thanks.
