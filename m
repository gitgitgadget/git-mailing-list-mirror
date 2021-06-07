Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FABC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ED461182
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGXXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:23:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGXXy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 19:23:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E35B9140FC8;
        Mon,  7 Jun 2021 19:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3M0Pg5l4ogOHEQSDVaLXNeX8XLSHJ+vBn/YZUD
        Ft1F8=; b=IY+zBnHdmEoQMOmZtpgp65aiPhm1vMcl4qU0rCGfAnSyrCkczpbY98
        +gjm90Vc0WxSebsOVHKlp/S4e+7vrdRGeeFq+KzbE+wpF2S0krXWaKxYw9R1F5dj
        q77FXvURf/5bROqnC2hqjxUGPYsO1kqYyxPihg7vwd3U+DCsWoRmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC81D140FC6;
        Mon,  7 Jun 2021 19:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C862140FC3;
        Mon,  7 Jun 2021 19:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] remote: initialize values that might not be set
References: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Jun 2021 08:21:57 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 7 Jun 2021 23:59:14 +0200 (CEST)")
Message-ID: <xmqqlf7ltg4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 284630D8-C7E7-11EB-A79E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/remote.c b/remote.c
>> index c3f85c17ca7c..a116392fb057 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -2101,7 +2101,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>>  int format_tracking_info(struct branch *branch, struct strbuf *sb,
>>  			 enum ahead_behind_flags abf)
>>  {
>> -	int ours, theirs, sti;
>> +	int ours = 0, theirs = 0, sti = 0;
>
> While I like this change, I am somewhat confused where the values are used
> for branching. The only time I see them used when `stat_branch_pair()` has
> _not_ initialized `ours` and `theirs` is in those `trace2_data_intmax()`
> calls. Otherwise `sti` is set to -1 and the other users of `ours` and
> `theirs` aren't reached.
>
> If my reading of the code is correct, maybe the commit message could be
> adjusted to talk about tracing instead of branching?

I too wondered why initializing them to 0 is safe (instead of hiding
latent bugs).  I think that stat_tracking_info() would always return
-1 if returns before reaching the point in stat_branch_pair(), but
it is not clear how we can futureproof the whole thing.

If these two are initialized to say -1 here, and then we had some
sanity check, perhaps like so:

	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	assert(sti < 0 || (0 <= ours && 0 <= theirs));
	if (sti < 0) {
		if (!full_base)
	...

to enforce the invariant we assume (i.e. OK sti means ours and
theirs are set), it would allow us to sleep better, perhaps?
