Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADADC41513
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbjHOWdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbjHOWcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 18:32:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5431FEE
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:32:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA9521A5C07;
        Tue, 15 Aug 2023 18:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=InHOZ8Oqq15TmRu7POwquUCxOwB8llYzhVdbsY
        o2TzQ=; b=KX29UPtTgJ5Qwtr1Cqx29JGxC8W6AT36JQbCUHJQPyBIo4mEMNHzJ9
        HhbR8ED2IoIYGYEAsorhR0mDcjcKTQ53YvZ0ND3lBLaRRUDLupyhD14pBYoBzX6K
        8pRLGUuJRb+gBI/z9PNKANb3HphxtecVunf+7iTg9kSg122l0Ua9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B25B61A5C06;
        Tue, 15 Aug 2023 18:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A3531A5C05;
        Tue, 15 Aug 2023 18:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on
 a filter
References: <20230808082608.582319-1-christian.couder@gmail.com>
        <20230812000011.1227371-1-christian.couder@gmail.com>
        <xmqqv8dhjfgm.fsf@gitster.g> <ZNvxg7BVJ+C5XFY4@nand.local>
Date:   Tue, 15 Aug 2023 15:32:23 -0700
In-Reply-To: <ZNvxg7BVJ+C5XFY4@nand.local> (Taylor Blau's message of "Tue, 15
        Aug 2023 17:43:31 -0400")
Message-ID: <xmqqjztwgcnc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B159636-3BBB-11EE-9B2D-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think the reason that this succeeds is that we already have a bitmap,
> and it likely reuses all of the existing bitmaps before discovering that
> the pack we wrote doesn't contain all objects.

Now I am confused.

We were asked to write bitmap index when we are going to create an
incomplete pack, and the packfile we generate with the filter will
not have full set of objects, and generating a bitmap with such an
incomplete knowledge of what objects are reachable from what would
be a disaster, so we should turn it off.  But the posted patch
lacked such a "we should abort when bitmap is asked to be written
while filtering" logic.

Then what were we expecting for the test to fail for?

> but I wonder if a more complete fix would be something like:
> ...
> @@ -966,6 +972,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
>  		die(_(incremental_bitmap_conflict_error));
>
> +	if (write_bitmaps && po_args.filter_options.choice)
> +		die(_(filtered_bitmap_conflict_error));
> +

It sounds like the most direct fix.
