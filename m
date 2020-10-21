Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E448C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36BD20848
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KJKwijWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506075AbgJUVYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:24:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58622 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440933AbgJUVYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:24:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2FC190832;
        Wed, 21 Oct 2020 17:24:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YxDjAxPF4fWtgEBD/6eHDXVf+hg=; b=KJKwij
        WRzYMIQgHm8292WqPxKVBKrTb6s+agZA5N7SYsDGrM8BsUNRmfvtfVxjSElBKXNZ
        IH4rEIm9VJa2RGkX3fNFa+HJMp8bYpNNzUUPDzEZPaGRRcChuXYvs6sj20BmGX/2
        WrS0oTahBhvu9yTvBuz2Jxm7zEZk2F5oo02to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NN4BH13r6cxVgEwZYdN0/YYaLrZ7ZZHa
        5sYVZWNA1wRJBcgBIGmRwnmaxNFYzQr8ES49YU2ai5vQsPakhNg+zO+tbaBVj3R6
        pSapCAe9qYRZOoKvxbbJYDm4OC6sNEotZm+0Sa3GVuQfJkQyA74t03YDo4QOA+FD
        xqs22mJlJFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 992D490831;
        Wed, 21 Oct 2020 17:24:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B46390830;
        Wed, 21 Oct 2020 17:24:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
        <20201021205537.GB1270359@nand.local>
Date:   Wed, 21 Oct 2020 14:24:22 -0700
In-Reply-To: <20201021205537.GB1270359@nand.local> (Taylor Blau's message of
        "Wed, 21 Oct 2020 16:55:37 -0400")
Message-ID: <xmqqo8kv5l2x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9F82386-13E3-11EB-BE4A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +extern void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce);
> ...
> Any reason that these need to be externed explicitly? Note that these
> functions are already externed by default since you haven't said
> otherwise (and for no other reason than this'd be the only explicitly
> externed function in fsmonitor.h).

Possibly due to the recent discussion?

https://lore.kernel.org/git/xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com/

