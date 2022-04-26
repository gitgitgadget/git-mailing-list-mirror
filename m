Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9797BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiDZT7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354000AbiDZT7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 15:59:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA56A06C
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 12:56:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8BA2186A08;
        Tue, 26 Apr 2022 15:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IO9XbLieyI2u7J2Z07SKBQljjXL0/gCDaXbK8n
        MCclk=; b=sys4tiMQKoRXuALEkZuCw4AgyLrzQHKRvhL9QoMEQx7uyjsq8dlCoE
        +O/m4mOga6PDO/SbMeSzcgw8OzT+a0N0SuwSQ5zLm9f/174qzKG8Nc359pKvq6pS
        AaEa0bawLXTMOmehQwbQ3jAJdctySRe2tbvnJj7saNfeF1aPlmNzg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFD90186A05;
        Tue, 26 Apr 2022 15:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26333186A01;
        Tue, 26 Apr 2022 15:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
References: <20220426183105.99779-1-carenas@gmail.com>
        <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
Date:   Tue, 26 Apr 2022 12:56:28 -0700
In-Reply-To: <9658dea7-d421-b238-113d-c7b83eca4569@github.com> (Derrick
        Stolee's message of "Tue, 26 Apr 2022 15:48:33 -0400")
Message-ID: <xmqqlevrr53n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7073B36-C59A-11EC-ADFC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Original discussion in :
>> 
>>   https://lore.kernel.org/git/4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de/
>
> I agree that the idea behind this change is a good one. The escalation
> of privilege isn't a huge concern when the "real" user is the same.
> The only way to trick the root user here is to set an environment
> variable, in which case they might as well modify PATH and be done with
> it.

How much do we really want to trust SUDO_UID or DOSA_UID are telling
the truth, though?

>> +	euid = geteuid();
>> +	if (euid == ROOT_UID) {
>> +		/* we might have raised our priviledges with sudo or doas */
>
> Similar spelling error here.
>
>> +		const char *real_uid = getenv("SUDO_UID");
>> +		if (real_uid && *real_uid)
>> +			euid = atoi(real_uid);
>> +		else {
>> +			real_uid = getenv("DOAS_UID");
>> +			if (real_uid && *real_uid)
>> +				euid = atoi(real_uid);
>> +		}
>
> I imagine that something else could be added here to help Windows
> users who have elevated to administrator privileges. It will use a
> completely different mechanism, though, if needed at all. We can
> delay that for now.
>
> Thanks,
> -Stolee
