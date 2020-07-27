Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F617C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604A920663
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgG0MFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:05:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbgG0MFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 08:05:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C741B5C65E1CD6E48CA3
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 20:05:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.106) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 20:05:45 +0800
Subject: Re: problem about 'git am --rej'
To:     <git@vger.kernel.org>
CC:     "zhangyi (F)" <yi.zhang@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ye Bin <yebin10@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, Hou Tao <houtao1@huawei.com>
References: <ebec6423-20f9-d866-1d07-9e6c94ce845c@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <1698860c-d0cf-fd54-b143-419bdd9d9185@huawei.com>
Date:   Mon, 27 Jul 2020 20:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ebec6423-20f9-d866-1d07-9e6c94ce845c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for that, linux-4.4.y has included this patch.

The problem actually is that:
We reset to the commit before eead1c2ea250 ("netlabel: cope with NULL
catmap") on linux-4.4.y, and apply this patch, the results show as
below. Fuction 'cipso_v4_parsetag_rbm' and 'cipso_v4_parsetag_enum' has 
been changed, but the really function should be changed is 
'cipso_v4_parsetag_rbm' and 'cipso_v4_parsetag_rng'.

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 98ed5e43ab7b..209876615461 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1343,7 +1343,8 @@ static int cipso_v4_parsetag_rbm(const struct 
cipso_v4_doi *doi_def,
                         return ret_val;
                 }

-               secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+               if (secattr->attr.mls.cat)
+                       secattr->flags |= NETLBL_SECATTR_MLS_CAT;
         }

         return 0;
@@ -1434,7 +1435,8 @@ static int cipso_v4_parsetag_enum(const struct 
cipso_v4_doi *doi_def,
                         return ret_val;
                 }

-               secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+               if (secattr->attr.mls.cat)
+                       secattr->flags |= NETLBL_SECATTR_MLS_CAT;
         }

         return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index bfa2b6d5b5cf..25ab12e25e05 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -605,6 +605,12 @@ int netlbl_catmap_getlong(struct netlbl_lsm_catmap 
*catmap,
         if ((off & (BITS_PER_LONG - 1)) != 0)
                 return -EINVAL;

+       /* a null catmap is equivalent to an empty one */
+       if (!catmap) {
+               *offset = (u32)-1;
+               return 0;
+       }
+
         if (off < catmap->startbit) {
                 off = catmap->startbit;
                 *offset = off;




在 2020/7/27 19:50, yangerkun 写道:
> Hi,
> 
> Trying 'git am --rej'(git version 2.25.4) to apply patch eead1c2ea250 
> ("netlabel: cope with NULL catmap") with linux stable branch 
> 4.4.y(git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git), 
> it seems the patch has been applied with wrong function(should be 
> cipso_v4_parsetag_rbm or cipso_v4_parsetag_rng, but 
> cipso_v4_parsetag_enum). Does this a bug or a expected result?
> 
> 
> 
> 
> [xxx@code-website linux-stable]$ git am 
> 0001-netlabel-cope-with-NULL-catmap.patch --rej
> Applying: netlabel: cope with NULL catmap
> Checking patch net/ipv4/cipso_ipv4.c...
> Hunk #1 succeeded at 1435 (offset 177 lines).
> error: while searching for:
>                          return ret_val;
>                  }
> 
>                  secattr->flags |= NETLBL_SECATTR_MLS_CAT;
>          }
> 
>          return 0;
> 
> error: patch failed: net/ipv4/cipso_ipv4.c:1439
> Checking patch net/ipv6/calipso.c...
> error: net/ipv6/calipso.c: does not exist in index
> Checking patch net/netlabel/netlabel_kapi.c...
> error: while searching for:
>          if ((off & (BITS_PER_LONG - 1)) != 0)
>                  return -EINVAL;
> 
>          if (off < catmap->startbit) {
>                  off = catmap->startbit;
>                  *offset = off;
> 
> error: patch failed: net/netlabel/netlabel_kapi.c:734
> Applying patch net/ipv4/cipso_ipv4.c with 1 reject...
> Hunk #1 applied cleanly.
> Rejected hunk #2.
> Applying patch net/netlabel/netlabel_kapi.c with 1 reject...
> Rejected hunk #1.
> Patch failed at 0001 netlabel: cope with NULL catmap
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> [xxx@code-website linux-stable]$ git diff
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 0e83c5b08e0e..375733b96bdf 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1435,7 +1435,8 @@ static int cipso_v4_parsetag_enum(const struct 
> cipso_v4_doi *doi_def,
>                          return ret_val;
>                  }
> 
> -               secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> +               if (secattr->attr.mls.cat)
> +                       secattr->flags |= NETLBL_SECATTR_MLS_CAT;
>          }
> 
>          return 0;
> 

