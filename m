Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934BEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjF1U6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF1U6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 16:58:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49E19B0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:58:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42C4B18F5F4;
        Wed, 28 Jun 2023 16:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=o9N8eh22tR+KYRh1UCK5sdWsys1mPfEk/3ENS9Be8/E=; b=pTY3
        0xB4delu3WjC2rHEDQLfqdW1hzANcvKgADCDcLBALhe0psPAIqhYBUcWcu2pspEj
        y+Der4uqjsy3xrn5/0qWlB/Cz4n9AasCU9Mz/9kZwyrpjVDMjgNeMANOyFp7ws1n
        tHzv5LOm87nbweQu1AkTSZfRVAzVAXZFWQAa9Pk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AC0418F5F3;
        Wed, 28 Jun 2023 16:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2A6218F5F2;
        Wed, 28 Jun 2023 16:58:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, jonathantanmy@google.com
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
References: <20230627195251.1973421-1-calvinwan@google.com>
        <20230627195251.1973421-7-calvinwan@google.com>
        <xmqq1qhwfr46.fsf@gitster.g>
        <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Wed, 28 Jun 2023 13:58:35 -0700
Message-ID: <xmqqfs6bcnic.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D003046-15F6-11EE-8F9A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Having the function isn't just nice for typo prevention - it's also a
> reasonable boundary around the pager subsystem. We could imagine a
> world where we wanted to track the pager status using a static
> var instead of an env var (not that we'd even want that :P), and this
> inlining makes that harder.
>
> From the cover letter, it seems like we only need this to remove
> "#include pager.h" from date.c, and that's only used in
> parse_date_format(). Could we add a is_pager/pager_in_use to that
> function and push the pager.h dependency upwards?

Thanks---I think that may show a good direction.  parse_date_format()
reacts to "auto:foo" and as long as that feature needs to be there,
pager_in_use() must be available to the function.
