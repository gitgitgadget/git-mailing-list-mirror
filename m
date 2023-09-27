Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516C6E80A89
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 05:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjI0F0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 01:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjI0FZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 01:25:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5E1AC79
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 21:09:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC5B92ED5D;
        Wed, 27 Sep 2023 00:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=x5hvVLAm6Wab048Ifjty3yHu/CopsxX1tJf4MA
        T8L2U=; b=g9kISnlwlsbX0IqpxwYH8p3qzZtdHALb05iq80bNrjI1ZNHMBpx94S
        TE1FXj3r5ydWAr44mEOBNHzfthmJZ1nbWCNdF8CvmGO62mvcBn5hmdgMPy7GrK6J
        GxQOCFHWtN7Yj4XV/oEzoYb3ivCtsDgSQipAUchwdMs7xLcRuuYsg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C60072ED5C;
        Wed, 27 Sep 2023 00:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50D642ED5A;
        Wed, 27 Sep 2023 00:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Eric W. Biederman" <ebiederm@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
In-Reply-To: <ZROHrSmmZOIE6bl9@nand.local> (Taylor Blau's message of "Tue, 26
        Sep 2023 21:38:53 -0400")
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
        <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
        <xmqqmsx8mwr4.fsf@gitster.g> <ZROHrSmmZOIE6bl9@nand.local>
Date:   Tue, 26 Sep 2023 21:08:59 -0700
Message-ID: <xmqqil7wmf50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96E13876-5CEB-11EE-A856-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. I wonder if retaining some flexibility in the bulk-checkin
> mechanism may be worthwhile. We discussed at the Contributor's
> Summit[^1] today that the bulk-checkin system may be a good fit for
> packing any blobs/trees created by `merge-tree` or `replay` instead of
> writing them out as loose objects.

But see the last paragraph of my review comments for the earlier
round upthread.  This particular function implements logic that is
only applicable to blob objects, and streaming trees, commits, and
tags will need their own separate helper functions.  And when they
are written, the top-level stream_to_pack() function can be
reintroduced, which will be a thin dispatcher to the four
type-specific helpers.
