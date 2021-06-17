Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D222EC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7BD601FE
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFQHam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:30:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55136 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQHal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:30:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 816811396FC;
        Thu, 17 Jun 2021 03:28:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ssimZg3zqvwi
        b0lyShYnvNluI+mrMbv08xaGEC+yxf4=; b=lVjEKg87Qnsyu7VMHZxnkNCzNLwY
        gb2BXh+ZAx1zlQi6duPsm5c1l42F3xLodz9CMJZZBjBLvath7khU2J7FY48hMpF1
        EgQi0PNHkbcLYWxSPOghJzO2qGDZiIyud1UPlfgt/QuXOr5MKXijeN+Di+0XzXDP
        PaE3NuhS8Bfj6rg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78F011396FB;
        Thu, 17 Jun 2021 03:28:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA1291396FA;
        Thu, 17 Jun 2021 03:28:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/8] [GSOC] ref-filter: add obj-type check in grab contents
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <48d256db5c349c1fa0615bb60d74039c78a831fd.1623496458.git.gitgitgadget@gmail.com>
        <878s39x95m.fsf@evledraar.gmail.com>
Date:   Thu, 17 Jun 2021 16:28:29 +0900
In-Reply-To: <878s39x95m.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 17 Jun 2021 09:04:57 +0200")
Message-ID: <xmqqtulxkl0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9E203DFA-CF3D-11EB-A633-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> -		if (strcmp(name, "body") &&
>> -		    !starts_with(name, "subject") &&
>> -		    !starts_with(name, "trailers") &&
>> -		    !starts_with(name, "contents"))
>> +
>> +		if ((data->type !=3D OBJ_TAG &&
>> +		     data->type !=3D OBJ_COMMIT) ||
>> +		    (strcmp(name, "body") &&
>> +		     !starts_with(name, "subject") &&
>> +		     !starts_with(name, "trailers") &&
>> +		     !starts_with(name, "contents")))
>
> We have 4 "real" object types, commit, tree, blob, tag. Do you really
> mean "not tag or commit" here, don't you mean "is tree or blob" instead=
?
> I.e. do we really want to pass OBJ_NONE etc. here?
>
>>  			continue;

If somebody throws OBJ_NONE at us by mistake, we do not want to
handle such an object and try to extract the subject member from it
anyway, no?

The intent of the code here, before the patch, is that "what we do
after the control flow passes this point is about the body, subject,
trailers, and contents request, so everybody else should go to the
next iteration".  The caller used to give us an object compatible
with these four types of requests, now the caller may throw others,
hence "by the way, we know these four kinds of requests make sense
only for tags and commits, so everybody else should go to the next
iteration, too" would be a natural thing to add.  So in that sense,
I prefer it over "we know these four types of requests do not make
sense for blobs and trees".
