Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF26AC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349220AbiC3RTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiC3RTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:19:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F392220327
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:17:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBF47179C76;
        Wed, 30 Mar 2022 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZgwTPj5JnoJ3rHtTs9yM+ZFcYFXKhCW9Aj72L8
        7DvwU=; b=dv5EtXVhgfE6fO6y/ixQ+8GJ1mXDmEBeyVW5KTPyUfCu/YRF2XL9lC
        B2+A5Kf8TDzklbcFW/dx3zl9tGCSj3bz3GJv43B0dw7QMEIKtMttkCnyXoooUJ+/
        vWFZqkD2RfWKALhR6i86L4h6eXbkiOcgT4/fTqygWiuascRtFdM4E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3BFB179C75;
        Wed, 30 Mar 2022 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 272D5179C74;
        Wed, 30 Mar 2022 13:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 02/14] bulk-checkin: rebrand plug/unplug APIs as 'odb
 transactions'
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <d045b13795b38caa27f8e25340212f736b66bb05.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:17:31 -0700
In-Reply-To: <d045b13795b38caa27f8e25340212f736b66bb05.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:20
        +0000")
Message-ID: <xmqqk0cb9x78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48C95764-B04D-11EC-9902-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Make it clearer in the naming and documentation of the plug_bulk_checkin
> and unplug_bulk_checkin APIs that they can be thought of as
> a "transaction" to optimize operations on the object database. These
> transactions may be nested so that subsystems like the cache-tree
> writing code can optimize their operations without caring whether the
> top-level code has a transaction active.

I can see that "checkin" part of the name is too limiting (you may
want to do more than optimize checkin, e.g. fsync), and that you may
prefer "begin/end" over "plug/unplug", but I am not sure if we want
to limit ourselves to "odb".  If we find our code doing things on
many instances of something that are not objects (e.g. refs, config
variables), don't we want to give them the same chance to be optimized
by batching them?

{begin,end}_bulk_transaction perhaps?  I dunno.
