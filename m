Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794AEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFZT4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZT4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:56:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F4170A
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:56:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E87E1AAB98;
        Mon, 26 Jun 2023 15:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aKg42OrRbdeGYV9r07a6OoDCW6Ik6RZ4TjIO2o
        WSXfk=; b=RFWmXiu8VVoJjLpPWUerX44yWvMqpCIESMEC0CyAQGyYN3TE833psp
        0LSPsRrAHqG8b4ZmyU198bjxWveUZlMQYmG5tDPDma9viFQN9hMiibPY8Eae18OD
        dwE2YqjSARHdtEIQDrBrykP7D7GTLU7zRRmv31EO/A5l0/mr1I5Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 477451AAB97;
        Mon, 26 Jun 2023 15:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 991061AAB96;
        Mon, 26 Jun 2023 15:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] var: adjust memory allocation for strings
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-5-sandals@crustytoothpaste.net>
Date:   Mon, 26 Jun 2023 12:56:29 -0700
In-Reply-To: <20230626190008.644769-5-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 26 Jun 2023 19:00:05 +0000")
Message-ID: <xmqqy1k63slu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B48725A-145B-11EE-9385-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: "brian m. carlson" <bk2204@github.com>
>
> Right now, all of our values are constants whose allocation is managed
> elsewhere.  However, in the future, we'll have some variables whose
> memory we will need to free.  To keep things consistent, let's make each
> of our functions allocate its own memory and make the caller responsible
> for freeing it.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
>  builtin/var.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)

Making everybody allocate like this patch does is also fine, but
FWIW, with [3/7], we can selectively set ".need_free = 1" for
minority of elements in the array that returns an allocated piece of
memory without making the source code too noisy (as the array
elements for existing majority can omit ".need_free = 0" and leave
it to the default initialization), so I am not opposed to the "we
set .need_free bit only for those that we allocate" approach taken
with the previous round.

Thanks.
