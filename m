Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024A01FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbeAHUhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:37:03 -0500
Received: from mout.web.de ([217.72.192.78]:59184 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755914AbeAHUhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:37:02 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgO8g-1eD6bv0N42-00Nhdb; Mon, 08
 Jan 2018 21:36:57 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bisect: avoid NULL pointer dereference
Message-ID: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de>
Date:   Mon, 8 Jan 2018 21:36:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KXLw7+HMjJKba5oofNT9m8RWj8VY2whvqGw/ZnlLbmkz9mXgRtT
 ekpE5oaltRranWys32F0WQ9b6g4KgjtdMhfwVIh6OLdrb3a9PzIzCy7A9rWYtT+kW3jCbEF
 bBSOKHYRMZdeuOu4mi03a2qSNWlQTzWQOJ5qDh/mn3+f6eoqCSGINls2etgvdpv+zeet9U1
 9e4L4qN70gTOhw9ufFkAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YYS58YpdIik=:SPYwaMqwOb4JMM9MebiHBh
 e3jK9XV1IyCUQOOcKfgY1Sp31A05B/1p6E3m6jtsDtEpZNKObhOOVJyaXJjh9UKqHUAhtG2Uh
 MLHQyp7C0AmFsN+NkOxLVrX5LOfmh04K3IM0hGE4ZyPoWw4qEni0oWQvwM/LJEf0eLackk1d5
 9MQOGPS2qt61AsUCtgAY4owXShAT6tZUXXpFUatpEgjm3gbRKFg/3fhAgTEwbruXKsbWXend/
 tfA2Xd3whaOsHejpIPl3EhOoeFqXXw4ELtTgNBaoLuot5G45CDmEAu9LWFIFjqQgP2LUbCYB4
 Ns20o7dnP6HCdFe3hF3dKLbQ8QDT00lBtD7FpGdD/15piZJbEYMhXZxLQTk3A4J424l8ZY88t
 a+zueNAlKdAWXJSbLlO8P9R8aA1WKn7RGdpFgHXvtsaHcmeMtxLEoZ6M92fMdUABWLOnVMP6q
 42pqk0zonrU9o7p99ruoIAGRT0QS7f/XRrLA6X6ZeTVmJXsUQYjFC/klGcniffqNBE7rOqgPC
 qq4NDOWXH1SV9hudo6dat4U8hzPeqePvstVvZ5oTLU8sHIFtvLe9rZ/X2cBR+S8VNmFtBUzj1
 30xt1MBqY1XOihGleFKMEnnBXBdWSh5FExH/wlyWkC6a9JhROJFZuSgI2PIe1cbqXuiyhn6Mv
 6ZHB10tN03i/SVrAcKCzWPQeoioEblkBNRPkLgYgDqGMmpknAYF0VWO5ZufFkSv9Jf5onfZwv
 qNXwj4kw8TtEUCCcOhMYvSU59XwOE64k6GW+QhwRZ8QyXzcr5Qz6ljZHcWVLhbcv9amwZlpHI
 gmuZgHyRzn9Ef6OOr/TXenX8RulorS5VY859kkV2HVybbSIRCE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7c117184d7 (bisect: fix off-by-one error in `best_bisection_sorted()`)
fixed an off-by-one error, plugged a memory leak and removed a NULL
check.  However, the pointer p *is* actually NULL if an empty list is
passed to the function.  Let's add the check back for safety.  Bisecting
nothing doesn't make too much sense, but that's no excuse for crashing.

Found with GCC's -Wnull-dereference.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bisect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..2f3008b078 100644
--- a/bisect.c
+++ b/bisect.c
@@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		if (i < cnt - 1)
 			p = p->next;
 	}
-	free_commit_list(p->next);
-	p->next = NULL;
+	if (p) {
+		free_commit_list(p->next);
+		p->next = NULL;
+	}
 	strbuf_release(&buf);
 	free(array);
 	return list;
-- 
2.15.1
