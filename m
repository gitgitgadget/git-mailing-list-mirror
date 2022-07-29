Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB830C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiG2SVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiG2SVP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:21:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759522BDC
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:21:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24B021A286B;
        Fri, 29 Jul 2022 14:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XxSiMTtPYTjUVJxF4eiRXkX9XmLPFkYducYVBJ
        Fo+JU=; b=wWtRD0/XceCZTou7VhtnOxncxAMGF6/6biy8SLddgrvGFinTQ6PSCq
        wGgXqCMGnu7WdWMYlZDRrHBYnMWtk10JyORQDcF0ZqaPUTwCEsqVXQ7DVIyzNUaL
        ocEH3VNm2p51KvRNOfx3iAqVHIwM1Q4y0+XCVyzkOQRF/WWWFf49c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BEC21A286A;
        Fri, 29 Jul 2022 14:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8B021A2868;
        Fri, 29 Jul 2022 14:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-7-calvinwan@google.com>
Date:   Fri, 29 Jul 2022 11:21:08 -0700
In-Reply-To: <20220728230210.2952731-7-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:10 +0000")
Message-ID: <xmqq1qu37pbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3845C4D6-0F6B-11ED-A2EA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While `info` takes object ids one at a time, this creates overhead when
> making requests to a server so `remote-object-info` instead can take
> multiple object ids at once.

I am not sure if the above is desirable---doesn't it make the
protocol (i.e. the requests the invoker of "cat-file" needs to
prepare) unnecessarily complex?  If we have "buffered" mode, the
implementation can collect and batch requests and talk with the
other side in a single communication with the other end, no?

> In --buffer mode, this changes to:
>
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue
>     - Call respective function attached to command
>     - Set batch mode state, get object info, print object info

So, the existing buffered mode is poorly designed, in other words.
Isn't this something we can fix for performance without affecting
the existing callers?
