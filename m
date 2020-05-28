Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF8DC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3580F208FE
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sFfDKSm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgE1PEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:04:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60574 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403876AbgE1PEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:04:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DE03D224A;
        Thu, 28 May 2020 11:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u0se9iNZbO9gXkO3Iaf0LwWL+0Y=; b=sFfDKS
        m6wfgz1vtKw/Vnk+qo22cOx2RGtVU6IpZg66J97dVopYfbsbBcO4BLycBGHi+AAN
        JNKaZcBzH39+DIlNgiYDci3lZJF/P++3V7C7NAjuDFQxVsKvrQzUaEGXfXy4FsEp
        H+kusKblYmy1tGJXePZpWILzp40hNTviEcZZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NGZfbsR3D0PR2Qr1QFNO5GLB/1KFbUpy
        YIUSMMtsMn6fxj+cqOOvovArKWsTCGqXHWDcv906Kkl12d3nPjq33RLn/QK+3cUU
        wuT2y+/36WcWoV/tHcDS+uMVuYJyS1gc/JSURO38bvYmdVFGjw+DnTiQ6bPFEI3E
        wmf628fjcHE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4768BD2249;
        Thu, 28 May 2020 11:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 851F2D2248;
        Thu, 28 May 2020 11:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
References: <20200528025359.20931-2-delphij@google.com>
Date:   Thu, 28 May 2020 08:04:46 -0700
In-Reply-To: <20200528025359.20931-2-delphij@google.com> (Xin Li's message of
        "Wed, 27 May 2020 19:54:00 -0700")
Message-ID: <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92EBBA90-A0F4-11EA-B75F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> Instead of bailing out immediately when no promisor is available, make
> the code check more specific issue (extension became special in
> repository version 1, while it can have any value in version 0, so
> upgrade should not happen if the repository have an unsupported
> configuration that would render it invalid if we upgraded).

It probably has to be a lot stronger than that.  In version 0,
extension did not have any meaning, so an existing repository can
safely have "[extension] worktreeConfig=~/hello" as long as it is
version 0 and nobody would bitch about extension.worktreeConfig not
being a boolean; worse yet, "[extension] worktreeConfig=true" in
version 0 repository did not make its secondary worktrees to have
separate configuration, but if we upgrade to version 1 merely
because the version of Git knows what extension.worktreeConfig means,
we broke the repository and its worktrees.

It would be safe to upgrade version 0 repository when there is *no*
existing configuration variable in the "extension" section, but "the
repository have an unsupported configuration" is not a useful or
safe criteria to decide if we should refrain from upgrading, I would
think.

