Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63139C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071B722CAF
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgLDUHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:07:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDUHt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:07:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62706A957D;
        Fri,  4 Dec 2020 15:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bT1kPklWDvUu
        Nxlh/iSXmSjPK9A=; b=TKmFyaPTVNKtTyG6RMXG+63rwBF/qLL0nflVzB5mIgIZ
        1AF0UgPKKHBmTUO+SdXHKK7QW1IpTIwKJ2T9YYjiREw4eLSL4Kx4/4vPK7g06l19
        12jFlYsUCYWxblpyyjKtSjqnjX0eI/2UgO6O3GFSvKLfCqvoTTOQU4LKMfz62ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gsnp5Y
        lYLssME0G/3NvdLeOlZMB3hvETkBAQV+wWY75mrDL5XrnxKMD0VBD0S9+uippPj0
        g2/YTYKBkr2WfZ6YV1S1sFWyoUyOrNSPpN8mNgFZZ/3CV3TFZeLWCtwRywXRohOV
        3tsFm+0Co1t4pXp0IKOsZpO4Node0ue5WYgJQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37E82A957B;
        Fri,  4 Dec 2020 15:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C15EA9576;
        Fri,  4 Dec 2020 15:07:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sofia Syrianidou <sofia.syrianidou@suse.com>
Cc:     git@vger.kernel.org
Subject: Re: diff-filter=R can't identify renaming if not done directly
In-Reply-To: <19eb8038-20d6-385f-50e5-26c7a0bd8e90@suse.com> (Sofia
        Syrianidou's message of "Fri, 4 Dec 2020 15:37:02 +0100")
References: <19eb8038-20d6-385f-50e5-26c7a0bd8e90@suse.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 04 Dec 2020 12:07:03 -0800
Message-ID: <xmqqlfede3o8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 470CC232-366C-11EB-83E5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sofia Syrianidou <sofia.syrianidou@suse.com> writes:

> Hello, quick question about using diff-filter in linux. In the scenario
> that in my repository, I first copy file1 to file2, then move file2 to
> file3 and delete file1, "git diff" returns
>
>
> diff --git a/file1 b/file3
>
> similarity index 100%
>
> rename from file 1
>
> rename to file3
>
>
> =C2=A0 but running "git diff --diff-filter=3Dr" doesn't return anything=
. Only
> flag T will return the change. Can this be considered as a bug?

"git diff --diff-filter=3Dr" and "git diff --diff-filter=3DR" have
totally opposite meanings.  I expect nothing to be shown if all your
changes are renames and you ask to exclude all the renamed filepairs
from the output with "--diff-filter=3Dr".  In other words, this seems
to be working as intended.

Thanks.

