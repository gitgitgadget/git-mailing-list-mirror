Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474811F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbcHaTmM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:42:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60084 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753689AbcHaTmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:42:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EA3F37917;
        Wed, 31 Aug 2016 15:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZP7RsE8ZKDl7
        EsUyOoKgSz/GN4c=; b=GtgjbPdnFblSxy0eXKC1xgIsGBRMYxToKhtAyYJa7+AN
        wH9+lVfyZcKXmv2oXg6QabrghC1pmRpebrovIOWU6jzMBTxzzh5qngigc6FmvsWA
        t1Pvc0qLLV8Fgax/xHhcwU1Rq4NRa7pM/iZYI7V4rif9vNLzfeIeNK9BDayZJx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PxV0OI
        sgnBvyLzJjvOKCIu9f4yinsI9YjncQO7/uthNyyxrnV1FMHh7Fgzfet6eeaFxTSg
        dNQT7nDz95RqqTa4w5WaSxxb2tEMoFCGQWnnGgoHQ198coXRNF9LLvXrfXywYcpK
        8o+x4T7IIcFMX3dCWnSZepvBF3VoQ1nuBxNpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592637916;
        Wed, 31 Aug 2016 15:42:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A103837913;
        Wed, 31 Aug 2016 15:42:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the todo file
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
        <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
        <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
        <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com>
Date:   Wed, 31 Aug 2016 12:42:07 -0700
In-Reply-To: <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 31 Aug 2016 21:24:25
 +0200")
Message-ID: <xmqqzinszpww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0185972C-6FB3-11E6-A7DC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>>>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_=
opts *opts)
>>>>  struct todo_item {
>>>>  	enum todo_command command;
>>>>  	struct commit *commit;
>>>> +	const char *arg;
>>>> +	int arg_len;
> =20
>> I am not sure what the "commit" field of type "struct commit *" is
>> for.  It is not needed until it is the commit's turn to be picked or
>> reverted; if we end up stopping in the middle, parsing the commit
>> object for later steps will end up being wasted effort.
>
> From what I understand this was what sequencer did before this
> series, so it is not a regression (I think; the commit parsing
> was in different function, but I think at the same place in
> the callchain).

Yes, I agree with you and I didn't mean "this is a new bug" at all.
It just is an indication that further refactoring after this step is
needed, and it is likely to involve removal or modification of this
field.

