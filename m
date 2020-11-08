Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D7C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24107206F4
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hhg2o2Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKHTbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 14:31:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51040 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHTbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 14:31:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2472FD7A4;
        Sun,  8 Nov 2020 14:31:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tDRq+chGH657
        G1ZUjRsccOH5u40=; b=hhg2o2ZhtsqNc2+c9FZTtrQqnWVNKGt3WHrBLXi93bf7
        k/DYhlsKeI9raSO9EFJRCNNFAApgb2tu712biZN7q1OwtthmNdBVoLf83TK3mm+9
        OSacH66UEn8dKt5rFb4ikpW5Uy0j0wpfp+wadJah9d0dzf0I6nLl8hhP8s0DjtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Opnvr4
        lOn7Y9e2W5zLhMQa3giqgdBjOLkpnZ3lYlDjMrvH8exXftQUSRwh0c2R2CtsfUP4
        pAXI/ckYbGijU44X2SI0lZYpVFg0USDji4tsmfWJulXK28N2hnPbZ3KeZ8oGIir+
        CnrSZhgfAxhX/A4ZDQbBBxjvwZ1B80mW0uxrI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA10BFD7A3;
        Sun,  8 Nov 2020 14:31:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65BC4FD7A2;
        Sun,  8 Nov 2020 14:31:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] push: teach --base for ssh:// and file://
References: <cover.1604362701.git.jonathantanmy@google.com>
        <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
        <20201103102307.GI24813@szeder.dev>
Date:   Sun, 08 Nov 2020 11:31:14 -0800
In-Reply-To: <20201103102307.GI24813@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 3 Nov 2020 11:23:07 +0100")
Message-ID: <xmqqzh3rd4sd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F82DC15C-21F8-11EB-B38C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +	# Server does not have "six".
>> +	test_must_fail git -C file_child -c protocol.version=3D0 \
>> +		push --base=3Dan_invalid_object origin HEAD:client_branch_six 2>log=
 &&
>> +	grep "is not a valid object" log
>
> This should rather use 'test_i18ngrep' ...
>
>> +'
>> +
>> +test_expect_success 'push with --base that does not exist on server' =
'
>> +	COMMON_HASH=3D$(git -C file_child rev-parse six) &&
>> +
>> +	# The push still succeeds.
>> +	GIT_TRACE_PACKET=3D1 git -C file_child -c protocol.version=3D0 \
>> +		push --base=3Dsix origin HEAD:client_branch_six 2>log &&
>> +
>> +	# Server did not advertise "six", since it does not know it
>> +	! grep "$COMMON_HASH .have" log
>> +'
>> +
>>  # Test protocol v1 with 'ssh://' transport
>>  #
>>  test_expect_success 'setup ssh wrapper' '
>
>
>> diff --git a/transport.c b/transport.c
>> index ffe2115845..531ca0a834 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -236,6 +236,10 @@ static int set_git_option(struct git_transport_op=
tions *opts,
>>  		list_objects_filter_die_if_populated(&opts->filter_options);
>>  		parse_list_objects_filter(&opts->filter_options, value);
>>  		return 0;
>> +	} else if (!strcmp(name, TRANS_OPT_PUSH_BASE)) {
>> +		if (get_oid(value, &opts->push_base))
>> +			die(_("transport: '%s' is not a valid object"), value);
>
> ... because the error message here is translated.
>
>> +		return 0;
>>  	}
>>  	return 1;
>>  }

Yes, and we are getting CI failure ever since we queued this patch.

Let's discard the topic for now.

Thanks.
