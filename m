Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55AC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiDVURl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiDVURk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 16:17:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CA37F290
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 13:11:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D99DA17B143;
        Fri, 22 Apr 2022 14:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j1Vd11rjuITkpckN5Kvp3nW9J0vuIpSnTjQCvZ
        gNBWU=; b=RdYjiWVWZLQuvKD0l1tfHSRHtwbe5/BDvJb838yWjhfdN8XbB8XA2E
        m5kIoKU5JVt3jmjefBlfzvA9JUBIGxGkDNmv3dtNK5HQZzLHKXBkmXjtcz5+Hr4I
        Ys6CPvM4peTkXhiQ54ksC5aHzT/4F90yN7LvylfFEv5vYq8W5QtoI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1EFB17B142;
        Fri, 22 Apr 2022 14:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35DD617B141;
        Fri, 22 Apr 2022 14:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "gdd via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        gdd <gregory.david@p1sec.com>
Subject: Re: [PATCH] show-branch: fix SEGFAULT on both --current & --reflog
References: <pull.1222.git.1650634704191.gitgitgadget@gmail.com>
        <xmqqv8v19ght.fsf@gitster.g>
Date:   Fri, 22 Apr 2022 11:43:51 -0700
In-Reply-To: <xmqqv8v19ght.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        22 Apr 2022 10:26:22 -0700")
Message-ID: <xmqq4k2l9cwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27D81A64-C26C-11EC-99DB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> It seems that it has been introduced in: Commit 1aa68d6735
>> (show-branch: --current includes the current branch., 2006-01-11)
>
> Yes, the commit should have noticed the invalid combination of
> options were given and errored out.  Since omission of such a check
> lead to a segfaulting bug without producing any useful output, it
> is safe to make it an error to give these options at the same time.

Actually, no, the commit couldn't have been the culprit.  Back when
1aa58d6735 was written, "--reflog" option did not even exist.

If we want to find a commit to blame, it is 76a44c5c (show-branch
--reflog: show the reflog message at the top., 2007-01-19).  That
commit should have caught invalid combination.  It did attempt to
catch some invalid combinations (like --more in the reflog mode),
but apparently forgot to notice that --current does not make sense
to be used in the new mode it was adding.

Thanks.
