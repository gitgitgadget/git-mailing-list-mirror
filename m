Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15671C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiCWUh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbiCWUhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:37:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12302BC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:36:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07EA717ADEB;
        Wed, 23 Mar 2022 16:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=laZpmBVWahd88nOHTml1UKPgyint6qvcguI7qv
        wcZUo=; b=k2zAAXpVfrSs7HzlDlvgouJLY3Ax05PfHlpbArbSAO1XRFW6swdcx5
        Qej9dkcQpwKg58TO/rRB8n7EIvGFa3PXfnJYqrIQvpWogKlsQf3CAeYkXLVn5YwD
        ia+vBTS8Kvalb3sYP2hU3jUs1QFuGGEger7psqXwBllgCuTykuGsI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0079D17ADEA;
        Wed, 23 Mar 2022 16:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 627F717ADE9;
        Wed, 23 Mar 2022 16:36:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [RFC PATCH 1/1] tempfile: invalid outdated temporary files
References: <cover.1648007488.git.hanxin.hx@alibaba-inc.com>
        <61af2576cd94b1958584da2b231aa75ecffb3cb4.1648007488.git.hanxin.hx@alibaba-inc.com>
Date:   Wed, 23 Mar 2022 13:36:18 -0700
In-Reply-To: <61af2576cd94b1958584da2b231aa75ecffb3cb4.1648007488.git.hanxin.hx@alibaba-inc.com>
        (Han Xin's message of "Wed, 23 Mar 2022 14:33:13 +0800")
Message-ID: <xmqq5yo4s8xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E515EE58-AAE8-11EC-BF02-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When git quits unexpectedly, some temporary files(e.g. HEAD.lock,
> packed-refs.lock, packed-refs.new) may remain in the repository. These
> files will prevent us from performing the corresponding operations
> again, even if they were created a long time ago before, until we
> manually remove them.
>
> In order for git to automatically fix this situation, let's add a config

I am not sure if we want to automatically "fix" this situation in the
first place.

Unless the user is sure of the reason why these lock files are left
behind (e.g. "ah, I saw a power failure last night while I was
trying to commit"), we are looking at a potential data loss.
