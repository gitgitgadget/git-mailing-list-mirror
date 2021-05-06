Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7098EC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494E66112F
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEFCXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 22:23:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65063 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhEFCXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 22:23:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43E72D3D09;
        Wed,  5 May 2021 22:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8jpgBYKAXNZf3uQLyMEBmmVIgFULrRQbE2UnMm
        ONnv0=; b=CcE5VBfY8JU0SiQLcPBHSynYEQ0DwXMc/rkkOfaZ1l+80VEPQcUHot
        GYnU18uTonzWDrtV4ZJkvUxuAyR/ZcwUSvDUVoLG4dq3eLaXQRtxfmjvPsb9pOoJ
        6LXb2Wjhp2a8dO1yXvKhwsxoPpjje/QHeVLpE+N1pEbdXbsZ+Z1b8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B47CD3D07;
        Wed,  5 May 2021 22:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B933AD3D06;
        Wed,  5 May 2021 22:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Yuri'" <yuri@rawbw.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
        <000401d741ea$5227c610$f6775230$@nexbridge.com>
Date:   Thu, 06 May 2021 11:22:56 +0900
In-Reply-To: <000401d741ea$5227c610$f6775230$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 5 May 2021 16:07:42 -0400")
Message-ID: <xmqq1rak1tz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F84348BA-AE11-11EB-8F46-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I would like to suggest another option: Teach clone and fetch to
> transfer stash commits. They are filtered out normally. It might
> be straightforward to preserve the stashed commits. A mirror
> approach is probably not appropriate since that needs the repo to
> be bare and Yuri's situation is unlikely to support that. So
> something like --include-stashes, which would be off by default.

It would unfortunately not work, since stash is not implemented as a
set of regular refs.  Instead its entries are kept in reflogs.  And
because the reflog is treated as an entierly local matter, reflog
entries are not transfered across fetches and clones.

If stash are redesigned so that each of its entry becomes a separate
ref (e.g. refs/stash/0 refs/stash/1 refs/stash/2 ...), then

    git bundle stash.bndl $(git for-each-ref --format='%(refname)' refs/stash/\*)

might become the beginning of a viable implementation of "stash
export" (but note that the above does not list any stopping point of
the history traversal, so it is just the beginning and does not make
a practical solution).

