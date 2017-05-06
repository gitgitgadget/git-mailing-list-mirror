Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0948B207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdEFROJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:14:09 -0400
Received: from mout.web.de ([212.227.15.3]:52173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbdEFROF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:14:05 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0ML8F7-1d7KOP42nx-000MCQ; Sat, 06
 May 2017 19:13:53 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] checkout: check return value of resolve_refdup before using
 hash
Message-ID: <f2e1a050-13e8-89be-ec6e-778054882ea3@web.de>
Date:   Sat, 6 May 2017 19:13:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JyK0ciUOWAXibjT1RQEUhviLk2UFM75XrUOtOSS5urqis8oEcjG
 gTlZRohSOfRYeIYfCC+9v7NrnV5p+ZFTy8ge7WeCQ4g+BviWanvFWq8JnjD0lIKFkrEQuBf
 JL2oLMUB4PF9sg57x3nVDf1wHikS9IlpGXIgq6wg6yuXiBW4mhmANz8Jw81SKwX9laZm671
 LeHJ/f9ar3tXf8Ft2NN/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K7F5XItsrZg=:ykW31s/W6Cbcnjh6EWXVKU
 BqF47uDiagLABRmBsVxXiqvf8WB5AosZ0ndytMVM3Yehb6g2o1rLkTIWUtaVnEnMeMMBdqB3t
 Wp0kmz3eHv+AbFBP052VO8Pa8vj+249n3HA9dZgpBYrS2acCoGRV6/uHXmBaYEn8HuRjx2PSU
 dKvREKVJTV+BN5GWtJhJGIjJUJ/ezavQ5GSungyKZQ6YgGUjkG+Pc5C+QjgGSsKnuofpM0PAB
 VwDKCcFJ7W7Md2nanzJ2gEVgm1lwzk1zya21DsivY5qhvpxq6EsTth5724cynAuXS9noggbF7
 clgFcZ6W0BGO9ZL2WfBTLS2+RxjMq+ei+ICNFlbhGlz3pv50iD6FLRfG929pYwdwKCQ7y3FNa
 89ZJ3TzldiuYy6P7XXkG5L6kxwqRiBpaprCNNmsEKDuRCfMUK4L301y9N3GGaxKLn/2uK9OJ+
 jrJspgK2GALd1eCmwV8/eYSrOlbA1+mdHlpx71ss/ozcr08hbXJE8l8GDpWUVLGO04JxxUkdO
 FBPaoFApKy/I7X4SiFuZ+fVYzlKjgjPlt4Zwcyk5VV0XQb1PC8a+5hXwBION/we/dSEhwpT4G
 0KU6HP94LicCLCBdFwBCaq3JOxABcKAn+rfwvDPaZZqQCdDVAMX3AMcBWuDr0pgLHHCl3/Sb6
 QnRBwkvVkIEkLVV/d0ZxJyVSMOBfY884LUSeFvL6FjxWSZRex8+C0MvjDREWwIndGwBAsR5sg
 bIPgaYlVnZpx9TUclmiRHXkUBR9BsQsJdnte5YUhrU6+hZGMqtK7bw4OfqZPBulkNQYGk3pMa
 Rey0IIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If resolve_refdup() fails it returns NULL and possibly leaves its hash
output parameter untouched.  Make sure to use it only if the function
succeeded, in order to avoid accessing uninitialized memory.

Found with t/t2011-checkout-invalid-head.sh --valgrind.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f33..6c3d2e4f4c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -833,7 +833,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
 	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
-	old.commit = lookup_commit_reference_gently(rev.hash, 1);
+	if (old.path)
+		old.commit = lookup_commit_reference_gently(rev.hash, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
-- 
2.12.2

