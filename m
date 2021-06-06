Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA9C47082
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D92861164
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFFBac (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 21:30:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52303 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFBac (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 21:30:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 028D2C0679;
        Sat,  5 Jun 2021 21:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZpRfqVJ1c+7A
        37ebi57pgnSjxNuezUvbgbHxoGhidtE=; b=uWo3EXx5iVaHiKm4ZMxTEKyK0uQG
        cvWZQ1+49IFEyG3btsk6mWm5pX/61UGM+dJO+pMwhKiGCRy0Mgc5XNBY1dPSY3gK
        p4M0ykv1/0+cOJ729GIaOTBP9yAyRQ46ui+zLZ/8oF084oLGM7RVarUG0187BBqg
        xtCy5e30j5CI3m0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC4F4C0678;
        Sat,  5 Jun 2021 21:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A49AC0676;
        Sat,  5 Jun 2021 21:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
        <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
        <87fsxw5bav.fsf@evledraar.gmail.com>
        <5ed77a50-3b34-4f3d-8348-a11d3930872b@web.de>
Date:   Sun, 06 Jun 2021 10:28:41 +0900
In-Reply-To: <5ed77a50-3b34-4f3d-8348-a11d3930872b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 6 Jun 2021 03:01:38 +0200")
Message-ID: <xmqqa6o3233q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 874D16F0-C666-11EB-A0C2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 05.06.21 um 21:56 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Jun 05 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> -	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$=
trace_file" | wc -l) &&
>>> -	test $workers -eq $expected_workers &&
>>> +	test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_fi=
le") -eq $expected_workers &&
>>>  	rm "$trace_file"
>>>  } 8>&2 2>&4
>>
>> I'd find this thing much clearer if the v2 just narrowly focused on
>> avoiding the "local", and thus demonstrated the non-portable shell
>> issue,
>
> I was not aiming for a minimal fix and I don't think the patch above is
> too complex, but you're right that at this point in the release cycle a
> duct-tape-style patch would be better.

Sorry for being late to the party but I tend to disagree.  "grep -c"
is used elsewhere in the tests, we know it is safe.

IOW, the above change is quite straight-forward.  It is much more
obvious and close to "duct-tape-style" fix, than some altermatives
like enclosing the whole command substitution in a pair of
double-quotes and rely on $workers always getting used without
double-quotes around it.  To me, that looks more subtle and brittle.

>> and perhaps with something like:
>>
>> 	diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-she=
ll.pl
>> 	index fd3303552be..aad6f3e2bf1 100755
>> 	--- a/t/check-non-portable-shell.pl
>> 	+++ b/t/check-non-portable-shell.pl
>> 	@@ -48,6 +48,7 @@ sub err {
>> 	 	/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not po=
rtable (use FOO=3Dbar && export FOO)';
>> 	 	/^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4=
}) and
>> 	 		err '"FOO=3Dbar shell_func" assignment extends beyond "shell_func"=
';
>> 	+	/\blocal\b \S+=3D\$\(.*?\|\s*\bwc -l\)/ and err 'whitespace handlin=
g in local=3D$(... | wc -l) differs in some dash versions';
>
> Any command can output whitespace, it's not limited to wc -l.  So a
> better rule might be to always quote command substitutions in local
> variable declarations (local foo=3D"$(...)").  Or to disallow assignmen=
ts
> with local altogether, like we already do for export, but that might be
> a bit much.

I actually do not mind "no assignments with local decl" that much.
I agree that is outside the scope of this particular fix.
