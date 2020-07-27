Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D0C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A4D206E7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 11:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgG0LvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:51:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbgG0LvE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 07:51:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7463A6FDCAD0EE0B9A9C
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 19:51:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.106) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 19:50:53 +0800
To:     <git@vger.kernel.org>
CC:     <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ye Bin <yebin10@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, Hou Tao <houtao1@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Subject: problem about 'git am --rej'
Message-ID: <ebec6423-20f9-d866-1d07-9e6c94ce845c@huawei.com>
Date:   Mon, 27 Jul 2020 19:50:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Trying 'git am --rej'(git version 2.25.4) to apply patch eead1c2ea250 
("netlabel: cope with NULL catmap") with linux stable branch 
4.4.y(git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git), 
it seems the patch has been applied with wrong function(should be 
cipso_v4_parsetag_rbm or cipso_v4_parsetag_rng, but 
cipso_v4_parsetag_enum). Does this a bug or a expected result?




[xxx@code-website linux-stable]$ git am 
0001-netlabel-cope-with-NULL-catmap.patch --rej
Applying: netlabel: cope with NULL catmap
Checking patch net/ipv4/cipso_ipv4.c...
Hunk #1 succeeded at 1435 (offset 177 lines).
error: while searching for:
                         return ret_val;
                 }

                 secattr->flags |= NETLBL_SECATTR_MLS_CAT;
         }

         return 0;

error: patch failed: net/ipv4/cipso_ipv4.c:1439
Checking patch net/ipv6/calipso.c...
error: net/ipv6/calipso.c: does not exist in index
Checking patch net/netlabel/netlabel_kapi.c...
error: while searching for:
         if ((off & (BITS_PER_LONG - 1)) != 0)
                 return -EINVAL;

         if (off < catmap->startbit) {
                 off = catmap->startbit;
                 *offset = off;

error: patch failed: net/netlabel/netlabel_kapi.c:734
Applying patch net/ipv4/cipso_ipv4.c with 1 reject...
Hunk #1 applied cleanly.
Rejected hunk #2.
Applying patch net/netlabel/netlabel_kapi.c with 1 reject...
Rejected hunk #1.
Patch failed at 0001 netlabel: cope with NULL catmap
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[xxx@code-website linux-stable]$ git diff
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 0e83c5b08e0e..375733b96bdf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1435,7 +1435,8 @@ static int cipso_v4_parsetag_enum(const struct 
cipso_v4_doi *doi_def,
                         return ret_val;
                 }

-               secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+               if (secattr->attr.mls.cat)
+                       secattr->flags |= NETLBL_SECATTR_MLS_CAT;
         }

         return 0;


