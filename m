Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A84EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGES0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjGES0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:26:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F55173F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:26:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0198536A4E;
        Wed,  5 Jul 2023 14:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zpSgcwnTpmh5Xpf9s0DXD4RVxtXr1pmiXC8n35
        LZHZo=; b=cuE8uY2ocPrUb7nBRpNln+PkgsvPMIxM8pjwcGe1S4U/bE8oj/SaCB
        Xq8O3p1hCxkf9bhMeh9rm9rv4jT4mCZCv4KDHq981XmhCKX9Trm1fP4n2TmqnOgg
        VCteCypJKKlGTzqgFwT5e4xmjUOeXnTQ5LJ7RsuDtrw4jtkcvgM1A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE77736A4D;
        Wed,  5 Jul 2023 14:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F8D736A4C;
        Wed,  5 Jul 2023 14:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-8-christian.couder@gmail.com>
Date:   Wed, 05 Jul 2023 11:26:18 -0700
In-Reply-To: <20230705060812.2865188-8-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 5 Jul 2023 08:08:11 +0200")
Message-ID: <xmqq5y6y1agl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FB17FAC-1B61-11EE-A92B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit has implemented `git repack --filter=<filter-spec>` to
> allow users to filter out some objects from the main pack and move them
> into a new different pack.

OK, this sidesteps the question I had on an earlier step rather
nicely.  Instead of having to find out which ones are to be moved
away, just generating them in a separate location would be more
straight forward.

The implementation does not seem to restrict where --filter-to
directory can be placed, but shouldn't it make sure that it is one
of the already specified alternates directories?  Otherwise the user
will end up corrupting the repository, no?
