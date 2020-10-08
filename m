Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F8BC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5163622203
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 21:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oF4jri+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgJHVLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:11:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52794 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgJHVLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 17:11:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A11DF87B3;
        Thu,  8 Oct 2020 17:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3fAtq8AOhmApE5PVYz/2W0pioUI=; b=oF4jri
        +MYTTlBfULUkpShovfEuELE3dUVMjLOsjM7iRUYRpylHRvKRZ97qMyb6jdt6qGPY
        /nxNQQ876odA9CnbMsi+IUVaDYUDNqgBqLC3p41oc5yH8ijrpWFRx+mWhQPsVstD
        RMnduvl8fA6ON4eeRS/QxJWWPrD9QQQuk6r3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q6rAOdjxtUsfCKNSNylQ+sD8ArY/911R
        eAico2thSFut0GaCnLRX8YLCpQ0s39JHXoF7dJCQlZzkccre2bAF5CUBIAYIaHdI
        +Ju/b9YCFgjg6eWUHicEkS5RsdBMsPGhvRoF73HG5a/N02ModneJGQRrek9KjK8M
        ox0n/W4MvK0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 527C9F87B2;
        Thu,  8 Oct 2020 17:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99EC1F87B0;
        Thu,  8 Oct 2020 17:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Do not skip tagged revisions in the GitHub
 workflow runs
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
        <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 14:11:36 -0700
In-Reply-To: <pull.619.v2.git.1602170976.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 08 Oct 2020 15:29:33
        +0000")
Message-ID: <xmqqblhcwhh3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA4C358A-09AA-11EB-9038-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * The intention of the tag skipping was replicated by introducing another
>    check in ci-config: is there a successful workflow run for the same
>    commit (or at least for the same tree)? If yes, skip, referring to that
>    successful run.

Nice.

Our tests and builds do not do anything differently depending on the
refname we are on or the exact commit object name for that matter
(other than using it in "git version" output), so "has this tree
tested?" is good optimization strategy for this particular project.
