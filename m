Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317AECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIOOvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOOvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:51:12 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEEE25C74
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253464; bh=THSt71gF9k8GukMeFVIzcIDAd+4/1i183ZnL3obbjUk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=asL3CudwVRkL40+y4RZ0pYnfsjdHMveKQpalULjlSUuktXT7FLw7MBHckletmkb0w
         GqAXVo7deVAicbLNxzZwkUy6gtaPDwhpnNAQPk5pb9uSHzU3geBfJGyBy8eoP/9EcC
         r3+32te/GhQ3wb8Jx/h8IvSsUvrZ4hpprA6cv5y7lc5EKU8YVanVxgUgbyw1rLQRXV
         /k3m2wAaCK8zOls7N3XpNZtbiLPcGzKuhLa0NlmqFemZjyFt0tSwYeZPxjodWOuoFu
         sGyuD3qHOsnE3RZ+OqMeoAZN1woxxeFLMQiPTCImGqVwBof8NOCZ5AsrGrt72IWEno
         LDwdYd/BTnR2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1p8jBZ48Qw-00b9uZ; Thu, 15
 Sep 2022 16:51:04 +0200
Message-ID: <9baebb3d-8f2a-33eb-3f42-3e1755883d19@web.de>
Date:   Thu, 15 Sep 2022 16:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 1/6] revision: use strtol_i() for exclude_parent
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7uefNiDKs0HnsoIKTIcD32vJwjZ4jtoFdJCrHI9XyiEmXvEAMb
 BOOS47S75agMKNpcU2T3nBrKibwTqj1lRUdDDeqE2vScY6lyz+gQhs+X2EqRFsxm49Azu3i
 y7zF1NFulZixMRVglW5k78PZ8HNfLJHg0s2SUp4jb1b7Zxq3WHrUiw1weFuHNAHCwmKCFcI
 wpDjr/bZb99KJ+XFJ+ABw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1nRgKuiYRlE=:CGLOlF63eCFbMo3pMEztnq
 W6e820Rmz5vfmeOX/0YRC5cIDoJ0L8ZbopGqkhH5LBQWdDaXI42IYj2vHZpwk8LP1Q/WLs4WB
 w/LVb1W3bTJ4ZPeCJiyr+wn8gJV+1wCQomwAWcoXsOfeM9yKGIcdC2vv0iYNo2itvCBe31l3H
 p25CnxQMLOfWxj5fmzt/QpvCOywVqnAx8+wMPdNM3wGYLFMQB0/q+6QJQQMWDkSpQML+5oVOa
 /FHPYOtstEY6jFNJ8X9acjf0wJ7C+NvTxrHo53KdK2z1jzLCOxZGyFk77lyNpSy4jebaImJ3W
 lucgdDZhfrzpRNrem4clLObtofel/YKnBoKmqGB+7fWzj7UD/MCNzpXmgrFd65YsQCmPgDXAD
 kFZIF0ZtJxfWJZaF3F1o8R2HbA0E+01QnglUj2+NGEaIpiVIdu7To3uy/CdwQjxP8PDigslR2
 mEP+CfqYvz6HLuM2SSxIFsvGjDxftdvZO0lmpSsARt+QZIGKhDgkm9EsugIb9Mx7+xHSOTwG4
 a6wpCRxO3L+oXGJgPlVTaLgJYX87mIo9Zdtiy7rtPOehJq7Z4btWNsA3uMYWBoNh2QOR/+aaE
 fMjak8GiWKMWl7YrpKORWrlsLhZ+EZGhiWx6U5PZ1yA/q/R5Xau1Z64GgiOk69mUFEfSvAhcx
 8Vs1/Y1pxUKZyDn3M7HDzE3XaEFe7x5nQ3D5keM/FFMW5GAdm1JiT9iTL/B/xixJ6zdqPWAgl
 mIKzOJYi5t2waNMY/PoNaitVrNK4w+bDTrpYcWMHqmBTjJBZC7oUJOBpsKB+Vdbbcwv3I0Bbu
 BqFtDNutggHZhedDP9iVVzlNiB0/Y51q70/45XHC8VMP+KCVFAZtW5bqBaAU+tM/0fNGVFaba
 YYbC+x3ZI6v+PwIzNzFnmyg45zwhqoRCKM52L2KaAkzP0BjRQY/XTS3llUkYOTysDTd97+iDm
 NgX80HImuvenc77q0TOuKfNZf4alOEUuD32MGKg2v2o9S1yOXRO32vPcunRxUr02lVt1JOokA
 AoWgVlri7zkpZlSZh4IUIXH4cztOUFx3PIH9E+97/ymWnT2E1DGtSx6b5lqymbEGn7TRznjlo
 vhoA21Qkj/MADbWWZ4ndBHn/G6/WoviS/WflfZ/ouQLxyKymLrvqi5BQsa24US3Cm+8I3ddq/
 P90us=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid silent overflow of the int exclude_parent by using the appropriate
function, strtol_i(), to parse its value.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index d5f4463cb6..0b8d48f94c 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2119,9 +2119,8 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 		int exclude_parent =3D 1;

 		if (mark[2]) {
-			char *end;
-			exclude_parent =3D strtoul(mark + 2, &end, 10);
-			if (*end !=3D '\0' || !exclude_parent)
+			if (strtol_i(mark + 2, 10, &exclude_parent) ||
+			    exclude_parent < 1)
 				return -1;
 		}

=2D-
2.37.3
