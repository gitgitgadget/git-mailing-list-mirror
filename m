Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC16C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75440600CC
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhHaUEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:04:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65303 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhHaUEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:04:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78C36156F56;
        Tue, 31 Aug 2021 16:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=evIkqgWx0QTG/eOu1TJiw5sN7gQx9jqixVgSIK
        UrO7w=; b=qt6etvf5wXRRGbgD9VGUaCPxgayHjYjVCBVwBd21Cxu9C7JZ7YvWu2
        42LNOsu9LW1wPUIGFTFgdPK1iu7gwdplY+65I6s6jFsgJ8O4sIuATjt78KP1XrHt
        CeWHofCziOx0wcRr/bDVLQ/ydUU5ytVBXZ5cHFRjAYWA7ToSZriSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71322156F55;
        Tue, 31 Aug 2021 16:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E54E9156F54;
        Tue, 31 Aug 2021 16:03:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 13:03:24 -0700
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Tue, 31 Aug 2021 02:26:33
        +0000")
Message-ID: <xmqq4kb5tm9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808A4030-0A96-11EC-B97C-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here are some patches to add a --remerge-diff capability to show & log,
> which works by comparing merge commits to an automatic remerge (note that
> the automatic remerge tree can contain files with conflict markers).

Excited ;-)

>  * This new option does not (currently) work for octopus merges, since
>    merge-ort is specific to two-parent merges[1].

Unless you do so manually, the native "octopus" backend does not let
you create non-trivial merges anyway, so punting on them should not
be a big loss.  Falling back to --cc might be a usable alternative.

>  * This option will not work on a read-only or full filesystem[2].

OK.  I am not sure if it is worth doing the "temporary objects"
trick, though---would it risk repository corruption if somebody is
creating a new blob that happens to be identical to the one that is
involved in the remerge operation at the same time, or there is no
visibility of the temporary area to these "somebody" outside so
there is no risk?
