Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065431FAD6
	for <e@80x24.org>; Fri,  8 Sep 2017 19:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756750AbdIHTEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 15:04:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60654 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756303AbdIHTEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 15:04:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54A8396687;
        Fri,  8 Sep 2017 15:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NNoCGxKove83
        5tLfVU7UeD2UEdc=; b=Dzbgoj1gBOmg9sq7sUNbnRV1CpxTU2nu0laia5wXb0pw
        eNKhQHhLYB9CG9/q93Oo6Zb4zBX/N/OHrYsYit6yaZw5DjJU6nweFCljwvuFW7v5
        n4+7Rn9ncP8tf+cHuxYxVoppqx2mDTcT4Xc0kwVag76Wkr+pNE6hauoyhPAfVp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oBXbfY
        tUcxmdY9VBdlx3ZRIQ/XEFen2LCv8U8zgUZbZ0nuvF7/l/gEz2myMloDsDL7PTe8
        szXHUAqAV42L6A5cdEJZokrkRJ/AQmPw+8H3Yg7fvZqruVFXiEs6/0KaloRfKiOg
        g9SmifyZ0wocAWyD+tA8c72UTVH5ckjMj++Ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AEBB96686;
        Fri,  8 Sep 2017 15:04:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CF8096685;
        Fri,  8 Sep 2017 15:04:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Kevin Willford <kewillf@microsoft.com>, git@vger.kernel.org,
        peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <20170908185443.GA15081@tor.lan>
Date:   Sat, 09 Sep 2017 04:04:45 +0900
In-Reply-To: <20170908185443.GA15081@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Fri, 8 Sep 2017 20:54:43 +0200")
Message-ID: <xmqqzia5xb8y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94951F7A-94C8-11E7-836D-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +test_expect_success 'setup' '
>> +	test_tick &&
>
> Do we need a test_tick here ?

As the test does not check against exact object names, and it does
not create commits, the order among which needs to be tiebroken by
using the committer timestamp, it is not strictly necessary, but I
do not think it would hurt, either.

>
>> +	echo "checkout file" >c &&
>> +	echo "modify file" >m &&
>> +	echo "delete file" >d &&
>> +	git add . &&
>> +	git commit -m "initial commit" &&
>> +	echo "added file" >a &&
>> +	echo "modification of a file" >m &&
>> +	git rm d &&
>> +	git add . &&
>> +	git commit -m "second commit" &&
>> +	git checkout -b endCommit
>> +'
>> +
>> +test_expect_success 'reset when there is a sparse-checkout' '
>> +	echo "/c" >.git/info/sparse-checkout &&
>> +	test_config core.sparsecheckout true &&
>> +	git checkout -b resetBranch &&
>> +	test_path_is_missing m &&
>> +	test_path_is_missing a &&
>> +	test_path_is_missing d &&
>> +	git reset HEAD~1 &&
>> +	test "checkout file" =3D "$(cat c)" &&
>> +	test "modification of a file" =3D "$(cat m)" &&
>> +	test "added file" =3D "$(cat a)" &&
>> +	test_path_is_missing d
>> +'
>> +
