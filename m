Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA47C49EC0
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiHVTcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbiHVTau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:30:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C45A160
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:25:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96CF91ACBAE;
        Mon, 22 Aug 2022 15:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SSRIFCliVioIIWLE/pw5H11lRM7YZLUFQ22bD7
        HPCdk=; b=miTpnwLf02uJ8zM1vOnGtd/bfrj3GXI4fz+q7lesU6PuOo6EmzatnS
        mxg51ZM7mJu8bbA8AEio26fXTgmwg/o72Lax1T67JyfDGMkV77X/WfqalaOjGW80
        V97HFx+R82ARFnq9KYEmxG6A+cLgPpon848uGn2YWeq58KWS9oT2A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F5FB1ACBAD;
        Mon, 22 Aug 2022 15:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B6CC1ACBA9;
        Mon, 22 Aug 2022 15:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 5/7] bundle-uri: parse bundle list in config format
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 12:25:37 -0700
In-Reply-To: <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 22 Aug 2022
        15:12:52 +0000")
Message-ID: <xmqqilmkcc7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33F26C7A-2250-11ED-BAEA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To allow for the incremental fetch case, teach Git to understand a
> bundle list that could be advertised at an independent bundle URI. Such
> a bundle list is likely to be inspected by human readers, even if only
> by the bundle provider creating the list. For this reason, we can take
> our expected "key=value" pairs and instead format them using Git config
> format.

"can" does not explain why it is a good idea.  "As a sequence of
key=value pairs is a lot more dense and harder to read than the
configuration file format, let's declare that it is the format we
use in a file that holds a bundle-list" would be.

I do not personally buy it, though.  As I hinted in an earlier step,
some trait we associate with our configuration fioe format, like the
"last one wins" semantics, are undesirable ones, so even if we reuse
the appearance of the text, the semantics would have to become
different (including "syntax errors lead to die()" mentioned
elsewhere in the proposed log message).

> Update 'test-tool bundle-uri' to take this config file format as input.
> It uses a filename instead of stdin because there is no existing way to
> parse a FILE pointer in the config machinery. Using
> git_config_from_mem() is overly complicated and more likely to introduce
> bugs than this simpler version. I would rather have a slightly confusing
> test helper than complicated product code.

All the troubles described above seem to come from the initial
mistake to try reusing the configuration file parser or reusing the
configuration file format, at least to me.

