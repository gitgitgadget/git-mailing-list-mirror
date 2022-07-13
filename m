Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970DECCA47C
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiGMVUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiGMVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 17:19:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF662EC
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:19:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F57919832E;
        Wed, 13 Jul 2022 17:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDyGNg98brd7Bqib9B+mZdHqninkE7LQ4kUslh
        T1H3U=; b=TFrz4mR0vK6A2eYBTDRPpWuZNgbcs41HFTxhU4az95EZzrtRf+Pc7S
        WByc4EG/wrwfZ93hk+tR7T16P9OVcT+PfdPrQPFbIq4kX9q+BohO1YDHio8zYnyq
        My2AlGsZTMEEboidOFmsvQ1J3CPuUSauQuVdji/6kh1AF+wXl7PFU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8592E19832D;
        Wed, 13 Jul 2022 17:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3512719832B;
        Wed, 13 Jul 2022 17:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0
 }-initialization
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
        <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 13 Jul 2022 14:19:11 -0700
In-Reply-To: <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 13 Jul 2022 14:00:08 -0700")
Message-ID: <xmqqy1wwaey8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70DE1FCC-02F1-11ED-BD61-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Ok. I wonder if we could reduce this kind of churn in the future by
> adding this to CodingGuidelines, e.g. "always use { 0 } for stack
> variables". Tangentially, do we require { NULL } when the first element
> is a pointer? (I'm not sure because this isn't in CodingGuidelines
> either AFAICT.)

A valiable can legitimately be left uninitialized, or initialized to
a known value that is not zero using designated initializers.  So
saying something like

    When zero-initializing an auto variable that is a struct or
    union in its definition, use "{ 0 }", whether the first member
    in the struct is of a number, a pointer, or a compound type.

may be OK.  I do not think we would want to say "always use X", as
the world is not that simple..

We do favor designated initializers over traditional initialization
in the order of members these days, so something like

    When declaring a struct/union variable or an array with initial
    value to some members or elements, consider using designated
    initializers, instead of listing the values in the order of
    members in the definition of the struct.

would also be good.

Thanks.
