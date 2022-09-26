Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F3FC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIZTMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiIZTMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:12:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FD92586
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:12:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EA4015C2DD;
        Mon, 26 Sep 2022 15:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=waRb6iQcJHu2
        TT2naGXptJpC+aDNfH2IALr9YAk3kMM=; b=YfFJheZvEZ18Yzs0hiMrYCMnRAYt
        csWmTzyRlAaiexIMHLDHWvrsys0mXeHJU0E6HBRKGJxED8I7UVQQ8feLcKjFmofW
        QV1GOi9jJjvFC1wNvHnEKYksWppWGrr7Oe5MAdt9CvJUoxEch3WNWeF1utwq57/q
        ni7l8S/5t44Exho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2568C15C2DC;
        Mon, 26 Sep 2022 15:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85B9315C2DB;
        Mon, 26 Sep 2022 15:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter.c: fix a leak in get_head_description
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
        <CAN0heSra_LsBzYCNFh0cZOZ0pmk1Wb9RtNTLwi93UM=f-53Uxw@mail.gmail.com>
Date:   Mon, 26 Sep 2022 12:12:25 -0700
In-Reply-To: <CAN0heSra_LsBzYCNFh0cZOZ0pmk1Wb9RtNTLwi93UM=f-53Uxw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 26 Sep 2022 08:59:34
 +0200")
Message-ID: <xmqqfsgene5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 288472BC-3DCF-11ED-A3DF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Sun, 25 Sept 2022 at 00:53, Rub=C3=A9n Justo <rjusto@gmail.com> wrot=
e:
>>
>> In 2708ce62d2 (branch: sort detached HEAD based on a flag, 2021-01-07)=
 a
>> call to wt_status_state_free_buffers, responsible of freeing the
>> resources that could be allocated in the local struct wt_status_state
>> state, was eliminated.
>>
>> The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
>> (wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).  Th=
is
>> commit brings back that call in get_head_description.
>
>> +       wt_status_state_free_buffers(&state);
>> +
>>         return strbuf_detach(&desc, NULL);
>>  }
>
> Good catch, and excellent history digging. From the original submission
> [1] of the patch that dropped this call, I get the feeling that it was
> originally developed some time earlier. I suspect this call was then
> accidentally dropped in a rebase before submission.
>
> FWIW, this patch is
>
> Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>
>
> [1] https://lore.kernel.org/git/20210106100139.14651-1-avarab@gmail.com=
/
>
> Martin

Thanks, all.  Will queue lest I forget, but I presume this is not
release critical?

