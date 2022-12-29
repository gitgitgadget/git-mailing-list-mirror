Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7AC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 15:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiL2Pt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2Ptx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 10:49:53 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B213DD2
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672328985; bh=AvPWcA9QZ39ru3el3aWfezmyhwU6hR5n4FYHRPPGeO4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B7n0ELNUdyEZbIsG1A+bYGhLG1o4Fy0rJtPhvlJoRICYy3LOmk3WsW7jaq1pOfuev
         wDmABzfp/TRt97c7u5abFisi88esgTWWrCv4n5nRx2bTY2gUJuQReNNQWYlZkYwRH6
         bMkKy1NgvAtKy3k9c/hRFufewDHnfhVIK+frEvqH3j50xPDMFudEP9722xrH1u3MMu
         GpiVChkhoq8wNJg6+wG1oYxW0wPNExviie8rlBZ6hHwUTctRFsDGDAq/zdLmLqWIdg
         bt2ji25qOMNSNYcMgwjfXKpvYw1z3SsW0IHM4a6suqkrc3Yxg7FHjJgn5vVnDQYWam
         cBoiiHmPH+mDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwwJ-1oVkrM0QcP-00na6s; Thu, 29
 Dec 2022 16:49:45 +0100
Message-ID: <ca564bd3-cd45-aa4e-7c5a-8fe4e0cefbce@web.de>
Date:   Thu, 29 Dec 2022 16:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 12/20] http-backend.c: fix cmd_main() memory leak,
 refactor reg{exec,free}()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-12.20-9be5b0c7836-20221228T175512Z-avarab@gmail.com>
 <5ca7b3ce-dda9-270a-6439-bd897cd5df28@web.de> <xmqqpmc2mzpw.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpmc2mzpw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1MKIE7jwXA6S3cTQEQQNPLTst1WyZAe2MEzBjDmKmSdWmx3Owni
 vl7CEVcPf0fXfoA+d4BdGrgdIBDCfNErTpIqZlz+9GlPLFFBqztFhz9h0FINv0JleoWOY9b
 VWyPUfIPpm64kOVOm4Ryb4q0jJJtlvtJ1gHb9oXlZfn1nATjEKKKNojD3ItAPoHS1H2r8En
 LU+KYXTpUatOyK3LMvV5A==
UI-OutboundReport: notjunk:1;M01:P0:KjLcZf72TFs=;bJE6en7xj9Snvdmu/ak+rPgnsST
 rcjcrPcKNSCG/N3gSAQwMOoNa2n+2+ocjEe6rkoXQhtJaBsPz72UrTArvE0eeuzI0TxxuVu/S
 EZbSaCfxyJ56b/wX/D3QSP8TmTrXrB/q+8m+FYlwOR9FQBeW/TJjfe2CDR6tE9r9XxUHThlPt
 nCCn9CyhPsrAJY8ViqhNxZi6sfk0ZeGjAdLMt/2MKLe5Vix7LkuP3PJPCNyN/DcmzHT8T1348
 F3/FjwsHn1ZyRNF+IJ7O1b7o63bLcFbGyBBovayD6LNrNj7HYYE2SyVqf2/8rkk75f+CuTHCc
 NQkkpPR/Hc/22fL8xb2pnaZ3gB+Rfso4wgDkG1CfIL2H2c6DX62U7v5wpjd6JfsvouxPeYZn/
 fJVqUzYIlrBkqY464IiO5ivolmW0nH1+GrBFI4DNxIqPBlRHP5YFRW/iev4sgccPgyWvA10IR
 Gej6/XsvRg/YJ9QQvBe6+OlsnO2vFtjwqrYhjqX43g5XoTylFOLu/7wfwwZcKIqFk3K0W4BwP
 va4AdEvkfSY0FqMRQLMquElcLDa4+5iYuAkrDIz5K035QJPTUav92rfkQCjLvEJhAW/uUslUQ
 QC9R/NhdULClTfmIRgDDUG9woTMOkkX5ymYzFQY3lsOiYlbn+c+zmTR/5ZErt++XnCtewWiQR
 eHFwl+WBTl2GP4NQT4gsPkduggk6bdm9Ywbf1B1YZpIP1DIDyAefmHQKpId0BOG37SLYVSpqd
 CqzKAY0ha1AGCE6hlfhFiq5ae/cy7o+DVIKjlN5FmYn4ES0I9Mr8bYJfMtLLEDXBDugYYDrdL
 Jfx/ukWIDbh4+m39tQ3MrsgRu0m8VZGxgkrGRqWgBj23tEb3fFxxpOWr8Ug+nP0hCBuYjBurX
 kkgmJ638iv9HNvqqMLi0/BB19MYzAZixMsUANWh7nfgY5IRa+deF2O2GRan7wQWz1Wzf5Ggd6
 Kaolx2QRJTTmE23A+Dq5zPBRRlQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.22 um 08:32 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> diff --git a/http-backend.c b/http-backend.c
>>> index 6eb3b2fe51c..9bb63c458b1 100644
>>> --- a/http-backend.c
>>> +++ b/http-backend.c
>>> @@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
>>>  		struct service_cmd *c =3D &services[i];
>>>  		regex_t re;
>>>  		regmatch_t out[1];
>>> +		int ret;
>>>
>>>  		if (regcomp(&re, c->pattern, REG_EXTENDED))
>>>  			die("Bogus regex in service table: %s", c->pattern);
>>> -		if (!regexec(&re, dir, 1, out, 0)) {
>>> +		ret =3D regexec(&re, dir, 1, out, 0);
>>> +		regfree(&re);
>>> +
>>> +		if (!ret) {
>>>  			size_t n;
>>>
>>
>> ... i.e. right here.  But only after copying the offsets out of "out"!
>
> "only after..."?  Do out[i].rm_eo and out[i].rm_so become invalid
> after calling regfree() on the regex out[] was taken against?  I do
> not think so, and am confused by the comment.
Nah, sorry, I was confused. o_O  "out" is not affected by regfree(), of
course; it's supplied by the regexec() caller -- cmd_main() owns it.

Ren=C3=A9
