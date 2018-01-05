Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF031F428
	for <e@80x24.org>; Fri,  5 Jan 2018 22:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeAEWXC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 17:23:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeAEWXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 17:23:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE3F2D19F4;
        Fri,  5 Jan 2018 17:23:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LvtKT2o866Jc0pwBZ26HjmQTws4=; b=D6LBSA
        pjEkEViEMWRM6FF7SYlbLNWWaf2+sfQeSiG6CjYKysTi4X37Qi3n/GiXdVfL1zqD
        5Lk2iDeNEfcjK5dgb3wG0i8pNVizcbHly21R8aw96ErWw09aI+0jcll+Wy08w14Z
        5sfy81/sD8rV8VRZmEM93GHNtqJqKXMBDwK/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RAI0wnCUue8U/RvJamsweU3KS0SdlQtC
        3ZwQ8HiFaqBTtyP/C60xUWERGAtPULpYhj8N8h+4zL8G19e2CcnmvIoVhqE/McWa
        Qf5VY8kjKcHUvYNZTEQ9FvqfGfQFWnhltl6HNaK7EnN0s40lchrXw3oyn5vlcCyn
        P89aaLoMH2E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D34A3D19F3;
        Fri,  5 Jan 2018 17:23:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A88ED19F2;
        Fri,  5 Jan 2018 17:23:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 6/6] fsmonitor: Use fsmonitor data in `git diff`
References: <20180103030456.8181-1-alexmv@dropbox.com>
        <121828fc14bc6f3096d16005feffb58bf68f070a.1514948078.git.alexmv@dropbox.com>
        <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>
Date:   Fri, 05 Jan 2018 14:22:59 -0800
In-Reply-To: <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>
        (Johannes Schindelin's message of "Thu, 4 Jan 2018 23:46:27 +0100
        (STD)")
Message-ID: <xmqqefn4aqt8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCE1043A-F266-11E7-91A4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/diff-lib.c b/diff-lib.c
>> index 8104603a3..13ff00d81 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -95,6 +95,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>>  
>>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>>  
>> +	if (!(option & DIFF_SKIP_FSMONITOR))
>> +		refresh_fsmonitor(&the_index);
>> +
>>  	if (diff_unmerged_stage < 0)
>>  		diff_unmerged_stage = 2;
>
> I read over this hunk five times, and only now am I able to wrap my head
> around this: if we do *not* want to skip the fsmonitor data, we refresh
> the fsmonitor data in the index.
>
> That feels a bit like an unneeded double negation. Speaking for myself, I
> would prefore `DIFF_IGNORE_FSMONITOR` instead, it would feel less like a
> double negation then. But I am not a native speaker, so I might be wrong.

I do find the logic a bit convoluted with double negative.
