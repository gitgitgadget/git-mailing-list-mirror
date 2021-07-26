Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A6C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1605160F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGZTWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:22:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58063 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhGZTWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:22:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6081A1541B5;
        Mon, 26 Jul 2021 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q5gaPEyInBbUHpIHT8043Y2fyDEBM2HResic/5
        8EK6s=; b=Kybwj1H5Yxju7hNoEFniNOQ3TjQXqL4UPVapA8bS+Ml23sZQtwqkyk
        nprbwbs2u4+784ToL6ushx8aHjGH2caa6CW9NE45ru+3AwlftoO306W1aWpAeukJ
        2SSGG/dtD7Yz1+zq5FN0C7PRLR2JhBOTTZ0tW913Mo7rXBk+XWQMg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59EAB1541B4;
        Mon, 26 Jul 2021 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A2851541B3;
        Mon, 26 Jul 2021 16:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 05/12] diffcore-rename: move old_dir/new_dir
 definition to plug leak
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-6-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:02:54 -0700
In-Reply-To: <20210725130830.5145-6-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:23 +0200")
Message-ID: <xmqqim0wj11t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 779A89B4-EE4C-11EB-AF14-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> old_dir/new_dir are free()'d at the end of update_dir_rename_counts,
> however if we return early we'll never free those strings. Therefore
> we should move all new allocations after the possible early return,
> avoiding a leak.
>
> This seems like a fairly recent leak, that started happening since the
> early-return was added in:
>   1ad69eb0dc (diffcore-rename: compute dir_rename_counts in stages, 2021-02-27)

Yup.  It is not surprising to have issues in younger parts of the
code.  Thanks.
