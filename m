Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDD11F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFLSLu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:11:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62813 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFLSLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:11:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A4E679649;
        Wed, 12 Jun 2019 14:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqQ/DaZSMnBCu3Tsy+cYxG/vhqI=; b=KVuI09
        LY58LTVYVGEfCTnRz/PJLw0YsNIovStxdm7+KCP9KOnK7ofvID2QNiiuVT6+yVSs
        fYw+hauvon/ty1KFlBO+mRMFtJX7wh2gu/uZ/XoxXLtopEqsNTSbuYAmGh/28Sdr
        +KydhNxMo58EVns9rnqQ3AJOZk/QT8tGIOs3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MA6jwBzb+Sdo5KMp/CxKFG1crhv+eatq
        dFeZU3bJ1PCQYY1zntVyCc7mgcFC98yV4oPA0oHMib7E2QLZ1DLv8E2FUxe+g3Yg
        B9LVq2jAwiq5NCYEeSD9WGzMyOHdLck50zjEeWLGwb+MQHhOGZFoe73J6HqFewoR
        KuL2mhrO83Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 232CC79648;
        Wed, 12 Jun 2019 14:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A26F79646;
        Wed, 12 Jun 2019 14:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 2/3] cherry-pick/revert: add --skip option
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
        <20190611073152.12214-3-rohit.ashiwal265@gmail.com>
        <6d3c1c1e-6140-dd8c-c37f-8c625b04ddc9@gmail.com>
Date:   Wed, 12 Jun 2019 11:11:45 -0700
In-Reply-To: <6d3c1c1e-6140-dd8c-c37f-8c625b04ddc9@gmail.com> (Phillip Wood's
        message of "Wed, 12 Jun 2019 14:31:53 +0100")
Message-ID: <xmqqsgseisgu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AD44C9E-8D3D-11E9-88E6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for the new version, this is looking pretty good now, just a
> few comments below

I agree that this step is looking pretty good now.

I didn't check closely, but when 1/3 undergoes necessary polishing,
it may have repercussions on this step, though (I did see that the
change in 3/3 would have overlaps with what was touched by 1/3 that
needs to be done differently).

Thanks for guiding Rohit's series forward.  

> This is only slightly different from reset_for_rollback() if you
> decide to keep a separate code path for skip vs abort then I'd be
> tempted to combine the two like this.
>
> diff --git a/sequencer.c b/sequencer.c
> index ecf4be7e15..b187b4222e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2740,11 +2740,13 @@ static int reset_merge(void) {
>  static int reset_for_rollback(const struct object_id *oid)
>  {
>         const char *argv[4];    /* reset --merge <arg> + NULL */
> +       size_t i = 0;

That size_t is, eh, "unusual".  For an index into a small local
array of known size, just sticking to bog-standard-and-boring 'int'
would make it less distracting for future readers of the code.

Or even better, perhaps use argv-array, so that you do not have to
worry about sizing the local array sufficiently large in the first
place.

> +       argv[i++] = "reset";
> +       argv[i++] = "--merge";
> +       if (oid)
> +               argv[i++] = oid_to_hex(oid);
> +       argv[i] = NULL;
>         return run_command_v_opt(argv, RUN_GIT_CMD);
>  }

