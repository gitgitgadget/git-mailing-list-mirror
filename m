Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FBC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 23:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbiEPXdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiEPXda (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 19:33:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5870C36B72
        for <git@vger.kernel.org>; Mon, 16 May 2022 16:33:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E20D1302A5;
        Mon, 16 May 2022 19:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=APGi45o6Z4MBKbb9k5S2SblzZpvA4gCQvSSGuk
        qX5cY=; b=e6OYeoDd+6z/IV9HFJbxcy/1tk2Fn5eY7zbHSi4gk//tiHNcq3heiO
        SxxgA49kMz0QpC9lSLqD1d1Dy6iY5HFwoWzgMHhLKYLYEZvVdTqTVficyFTxIubL
        oWXJV1+BSynnKuRFqhlclzFa7gou0dMQh8WmimjQRBtFap51UqeX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 742A01302A3;
        Mon, 16 May 2022 19:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D430B1302A2;
        Mon, 16 May 2022 19:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: [PATCH] fetch: do not run a redundant fetch from submodule
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g>
        <xmqqczgd16wx.fsf_-_@gitster.g>
        <kl6lr14thysl.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 16 May 2022 16:33:26 -0700
In-Reply-To: <kl6lr14thysl.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 16 May 2022 15:56:26 -0700")
Message-ID: <xmqqpmkdyrw9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96736C32-D570-11EC-98E2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> IMO "&& remote" is non-inuitive enough to warrant a comment, e.g.
>
>   /* do not update submodules if fetch_multiple() was called */
>   if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {

As I am not so familiar with this codepath when submodules are
involved, I need to be explained why having called fetch_multiple()
means there is no need to update submodules".

	/* 
	 * This is only needed after fetch_one(), which does not
         * fetch submodules by itself.
	 *
	 * fetch_multiple() has already updated submodules to grab
	 * commits necessary for the fetched history from each remote,
	 * so there is no need to fetch submodules from here.
	 */

perhaps?

> The test looks good, but I think it belongs in
> t/t5526-fetch-submodules.sh. I don't see anything else in
> t5617-clone-submodules-remote.sh that calls "git fetch".

Good eyes.

> In addition, I think we need one more test that adds another remote. In
> the above test, we only have one remote, so we hit your new optimization
> and already pass the test without the need for "&& remote".

True, too.
