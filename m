Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98603C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8020644
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHT0v8/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgDEUdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:33:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53847 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgDEUdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:33:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3BE4423F;
        Sun,  5 Apr 2020 16:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/L2OAqPETSQHwI4LQV+/GaBvrbk=; b=fHT0v8
        /ek/AOVuOPOPJgmK+MXix8VbjYvZT3EBQGN/j706+pVmbS/S7piaNCWrDRSoa7OD
        NQo5kIOoLbR+5rL1morNA9sH1Fkipm6H8a+tYeOO3VtUmYV+2fxUu88CY3Xvkj+I
        9iH5cOiQ7N7F0CFVxcrRa96xcLM8Bvm6bnqoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nckwt2qIJi/DFjNLFORudWEP/ckjf7Tk
        4jggQuH5OYAMW4GKqbbX6dZ442++5Xdzr/DmQ5TbsUCygZRsP+E50Ukrr0qQCYVs
        IuJfFlOzdKtnzNWfFp08cOh5Rvs/6YP4TG7z4NK51YmXQlK84+5T24YS2JdJySHp
        Zqbj7uI7iZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 349164423E;
        Sun,  5 Apr 2020 16:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5B664423D;
        Sun,  5 Apr 2020 16:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/15] run-job: implement loose-objects job
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <4c4aeb55dea9dd7b97bd7f08c8a767b498886109.1585946894.git.gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 13:33:14 -0700
In-Reply-To: <4c4aeb55dea9dd7b97bd7f08c8a767b498886109.1585946894.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 03 Apr 2020
        20:48:03 +0000")
Message-ID: <xmqqa73py8ol.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACD6C928-777C-11EA-A4EB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Create a 'loose-objects' job for the 'git run-job' command. This
> helps clean up loose objects without disrupting concurrent Git
> commands using the following sequence of events:

This is exactly the kind of thing I would have expected you'd be
adding to "git repack".
