Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA02FC2BA80
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A142078C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9c7D/ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgDCWMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:12:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55412 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgDCWMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 18:12:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9617D5EC8;
        Fri,  3 Apr 2020 18:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jJyyE8hUSuTO/+2OBYfe8gC0FM8=; b=K9c7D/
        aguLs19M4cutQ/c5gPOKypdhIhkKJvR/BwGZ4kaI6XcK10A9N/0tm52Nzri5Mm3d
        /eB5UrPiU8zF1tBZYasjuVdZkYpTr19ooSNoViFy9xcRDSbH4Xrgr/HYpNanr5ps
        UK4gC7RFkrK0LuSaSYhiQAgj+4/cHuvk/D9Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BV2Jlp5oxMnNvdkYEBe8J0axGDC9E5yU
        /ciyGYZgqxo33MNf6RSlkNQMShKklc3Vh8zeuVgH+202F7aA+Q2mZZ8ZkkVAQgph
        vfPlDDNyJ6fmzoPjBETxWDkj0jHVATzXp3jazzC0BBwKhg1eiGz090VyXP7cuJSg
        zaP5+2HjCMs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1533D5EC7;
        Fri,  3 Apr 2020 18:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E64F4D5EC6;
        Fri,  3 Apr 2020 18:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
References: <xmqqsghl1m0p.fsf@gitster.c.googlers.com>
        <20200403213546.237273-1-jonathantanmy@google.com>
Date:   Fri, 03 Apr 2020 15:12:39 -0700
In-Reply-To: <20200403213546.237273-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 3 Apr 2020 14:35:46 -0700")
Message-ID: <xmqqr1x4xlpk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C24A554-75F8-11EA-930D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Ah...that makes sense. Besides the accumulating of prefetch targets
> (which makes deduplication more necessary - I might make a
> "sort_and_uniq" function on oid_array that updates the oid_array
> in-place), looking at the code, it's not only diffcore_break() which
> might need prefetching, but diffcore_skip_stat_unmatch() too (not to
> speak of the functions that come after diffcore_rename()). The least
> brittle way is probably to have diff_populate_filespec() do the
> prefetching. I'll take a further look.

It might be a losing battle, unless we can somehow cleanly have a
two pass approach where we ask various codepaths "enumerate blobs
that you think you would need prefetching in this oid list" before
letting any of them actually look at blobs and perform their main
tasks, do a single prefetch and then let the existing age-old code
call the diffcore transformations as if there is no need for it to
worry about prefetching ;-)

Thanks.
