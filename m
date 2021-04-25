Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A25C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 00:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BEC613C4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 00:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhDYATO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 20:19:14 -0400
Received: from avasout03.plus.net ([84.93.230.244]:40682 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhDYATM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 20:19:12 -0400
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id aSTjlE1hlutR5aSTklJfOs; Sun, 25 Apr 2021 01:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1619309912; bh=RhzJAyPYiQa8g5FiHWLi6AzoCfvyiL7lSsOBCK/djik=;
        h=To:Cc:From:Subject:Date;
        b=p71fa4fQT8Edqt4jDRfDgVe5fXZcA1qradYLh015NMQPYizs5WOMuHZ2he/S3y8az
         uEjdxWuxVrodrZmN0hUUlJJm6a2jZC1/ZbIGSB5eAabEh+bl03Y1WbsHBSo7OEqX9d
         IiwcW3wqbYb2x1qjUeNo4vLRy2MQReHzKFNMN8X985N6w3w/dbd0eUl2T71vU2sI/u
         VDtsmN2WLJ6zXlIlq083xHSIMvOLgm14MK1Dc425M1U6fwSVpx5TincXYtRMaNN9ex
         a+k9hlT3EVu/zzZGaEufbTFth5ybrjc9ylKUI4bWj8DEM9cd6fQ2gFE88tNP7SlLE8
         2jySqk67kfIgw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=KZJJTTQD c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=b-94UI71HHwM9cwx1dIA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] bisect--helper: use BISECT_TERMS in 'bisect skip' command
Message-ID: <fd40e12f-9649-1327-4bdb-dce5b5eed619@ramsayjones.plus.com>
Date:   Sun, 25 Apr 2021 01:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPVTZFWqvmR4L+CZByc6oO54pepFItCfAPY1FRCSq4qKEyJhU0na0St43DRFCiv9mTt3Iv8shiixevJ3VzhUzK1WoGCT8qaWxuiVcwrtyTR7Tl1s2bdz
 gy0Lt8lTVShaRoUnQWwHL5QUXq9yCgiK9vAK4CvH8yu3iNfqqNqLUfuu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit e4c7b33747 ("bisect--helper: reimplement `bisect_skip` shell
function in C", 2021-02-03), as part of the shell-to-C conversion,
forgot to read the 'terms' file (.git/BISECT_TERMS) during the new
'bisect skip' command implementation. As a result, the 'bisect skip'
command will use the default 'bad'/'good' terms. If the bisection
terms have been set to non-default values (for example by the
'bisect start' command), then the 'bisect skip' command will fail.

In order to correct this problem, we insert a call to the get_terms()
function, which reads the non-default terms from that file (if set),
in the '--bisect-skip' command implementation of 'bisect--helper'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This patch was created directly on top of commit e4c7b33747 and tested
with the test from Bagas Sanjaya [1] (ie the second version of the
stand-alone test file t6031-*.sh, rather than the newer patch that
adds the test to t6030-*.sh). I applied this patch to the current
master branch (@311531c9de55) and it also passed the test in [1].

[I created the patch on top of e4c7b33747 so that it would, hopefully,
easily backport to the relevant 'maint' branches, should you feel the
need. ;-) ]

At this point, I would normally have looked to see if there were other
examples of forgetting to call 'get_terms()' (which seems possible).
However, I am a bit busy, so I will have to add that to my TODO list ...
:(

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/20210421040808.14185-1-bagasdotme@gmail.com/

 builtin/bisect--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7ad9b4d55b..49c07f0710 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1129,6 +1129,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_SKIP:
 		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
 		res = bisect_skip(&terms, argv, argc);
 		break;
 	default:
-- 
2.31.0
