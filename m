Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13099203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 06:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbcGZGqM (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:46:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755061AbcGZGqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:46:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E772828243;
	Tue, 26 Jul 2016 02:46:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gy+FxnxEcb+mhnMqvh8nW+6q0Pk=; b=iP0u/q
	Q05LdIquPMLdN+OpclDO3wcLPTNCS3eH7LpXlxBXlNatcHXJFi5/vrW3YU41CLCA
	cwqdEat5vdHQV+dK5wMLTa0MpV2osQLpmoQTAsKMAWGSAfmTrRoz4evPo4QkjoeQ
	Pwda6ylmyg8p3a5a9LwQpwF8s7TTFwxRr1mAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyfl1xM8KUeSDN1n9Dih7miJiPels4nZ
	9BJ0LRpZnk6YgbVFeRSsxhJZyo7zlsJePgHK/OUOfCCRBNgjgU9+NqMjK45GTNlw
	0z4Guhl1K966SjP9ThG/yCXGEOFZKQRBqDMZPOlfhrIvWC4P5unGipvGfr9MbKr0
	HuuOpa6q3jU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCADB28242;
	Tue, 26 Jul 2016 02:46:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55E4328241;
	Tue, 26 Jul 2016 02:46:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Subject: Re: [PATCH 1/3] t7900-subtree.sh: fix quoting and broken && chains
References: <20160726041416.9438-1-davvid@gmail.com>
	<CAPig+cRGz2eqPK0uaih3hYCV0eLayot3VGyjKaz5Qf8Jy5o=DA@mail.gmail.com>
Date:	Mon, 25 Jul 2016 23:46:07 -0700
In-Reply-To: <CAPig+cRGz2eqPK0uaih3hYCV0eLayot3VGyjKaz5Qf8Jy5o=DA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 26 Jul 2016 02:06:15 -0400")
Message-ID: <xmqqd1m03nio.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A294C97C-52FC-11E6-A604-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -73,10 +73,10 @@ join_commits()
>>  test_create_commit() (
>>         repo=$1
>>         commit=$2
>
> Perhaps &&-chain the above two lines also to future-proof against
> someone inserting important code somewhere above the following 'cd'.

Yup, also we can have them on a single line, i.e.

	repo=$1 commit=$2 &&
	cd "$repo" &&
        ...

Thanks

>
>> -       cd "$repo"
>> -       mkdir -p $(dirname "$commit") \
>> +       cd "$repo" &&
>> +       mkdir -p "$(dirname "$commit")" \
>>         || error "Could not create directory for commit"
>> -       echo "$commit" >"$commit"
>> +       echo "$commit" >"$commit" &&
>>         git add "$commit" || error "Could not add commit"
>>         git commit -m "$commit" || error "Could not commit"
>>  )
