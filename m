Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA211F442
	for <e@80x24.org>; Thu,  9 Nov 2017 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbdKIOSG (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 09:18:06 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:45132
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753868AbdKIOSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 09:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=THhzt37uRDFEY50PJka5nnqqRTGeuHDLGOmekJreqkg=;
 b=XzCZwZy0IJi5tf6xBJRHlwRhggNhitwH1Obh/rtnnIBNXY0VEVrHMKhYhEJ68pctfFE9jd1JeBC4pzRE8lPGIfF9kK7WzpuBXh8WjxcG+JsJ6mQWYmS+V8Pz/KrsL4fyGYM+aalyhtHUp6z+f+tfid6IL6B6F+a4WYp+k193S3c=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Thu, 9 Nov 2017 14:17:59 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 0/4] Speed up index load through parallelization
Date:   Thu,  9 Nov 2017 09:17:33 -0500
Message-Id: <20171109141737.47976-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR13CA0015.namprd13.prod.outlook.com (10.175.123.25) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba57c47-25c1-4e5a-6c78-08d5277caf29
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:5n7+ajRR8uObG4iJbK0sUIygeVawkt30Hd2D0zVqaCxgTyZ7k7gCV5BxM5fp/4CpM3PHEGMdLd0JSyI4q0XJyEz56b/wC8D/O/8PYZLJs5wWLuXUn61BLGSXfuKtncrq8ySDe2WIwo5sAbEWT1ucrAaqJLTZjzXQzIBpkhFLVueXxppMW4yrCDwMnFIrvK/CIghvBjR9+mwAFvqmyXYS98Q4+zXfUMi1yOJM646YYZ5kte1h7pW7RueGeNDyUFYj;25:LGY0fK2tPCsJewJx8WV0RqREj2iPAKE7foSU0wpCN4SlKHk7zMwRYTzfLlI0QPJbO7DGHAYUCrKVsJ9MPReOS9RaJv/jtkcHtnIf3ddVemOQA0N096wklOZLr3h2Zg0XkV8nwPusUY5riAbwEL2NTeLEom/sdzi4U+M33q8TejHkyKIzOU5Ma+DaSncgvoNUMdgBsyY5GDzUr/XBv4NcTEtY5GY2hdY4VL0qyou8r6Rl8sD2iDwJROcrPev8X8Rkox7bO2Kyza2Lw/zdqPCp0/mBXpOJlquz7Mp8+8Hc4u7gB4H0NmNPVFytak9cby8YA7BLbUwyZtIXVXygy6pR2g==;31:/jJe2l3la7o9z/Bpf7zsyluf9tgtyz4EeqKb/UE7WYMIHe1aauw64d/bzslZpGO1rFVeHffTRsLKekE4zSznX/U5Yr+clHzPqIfP3b5oVWSxzPAmc/40SVOU4Ax3OoEbiwNmBWbuSedRr6DXrSbCABOBoeOu7Q+35i8XT5y8KFGjQYMsdjGBqx2/ONmSnw93OP/Y9e5qPpzk1L9ZT/N7J4zrcRLltBabP3Q6phwqyC0=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:W/zXv4klPgwF5WE6zV0fZoVjJd2dS47vdGxm1/Cjc5SAbdNCJi91T2xHT6kM6osat7y9liR76A8tTyWzaZC3fiZ7zp69d0NqGQLGY07lsVaogyhxWV7nJ6RdqzGejzmqPTPydxkUFLIiEZY4ZBnCqHJf/Un/PEO1PBrSSzf3lhN3d3A+h0T7JBHdSgzvYj/9+ehzYT2hCdv970p1cfxw4LBPGJOFt3LWhuZdBmV5DilqsWEIKyWLqA+wX6xicNAINLNQ8zzEXwwf6/OW4NmrWohotYAY/T0lKo8Lo5yAWWGZLhxLEKpM/i+aJKMjy2tD5hzKkrbkT5IVz0DXdo0zOHbUaC2Jh+dBqNLdiyBcIpOdI5E5+0E7RoizzFGbcVkRih/kXUqOutZeO+9NbjqYy8pF/oVm92y5bPjhY5h6i+e7qmNhhwTRePCNbeqLnc3mLt5qe8NczzOhiPANl6f0HRIMmfo0JyFAUa8/SuGrFpiYhxIihn1YaXypzHHRHk1I;4:32dQVJDl9w+sIL/Q6VBnh9IaFFkPPA/9R/nCW981nZcXzPB/sh+8ChZTSFWfBmgnosvm62o7rGMNz0DpBdLpOmw0Ey68wsGfioA2lmw6+NQZ/lUy+bf1JSLUHzfT2WALGZkgnYMMNlqRCUeh5zlREwYmN5SxCoChV4Uq+qFZD0UvKOQB4EIf7J5Fq8+k4R7TmUS5mlSkHaGqdPwvslDu4eCOUBVZRhWieX5IaK63AElFk1vidQmgoShS4+xpPE4dX62Sm9S/cHBELz/1/n6FklJQpD7BXHrHUvN6BhgKnk31MD+6/pXSWNx2Zp8JN2qmLCFANTPQEfHJTechsyCDZZS09O/G48oUUzza7rJkS7U=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(166708455590820);
X-Microsoft-Antispam-PRVS: <CY4PR21MB047198AC381A50C612C52E19F4570@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(3231021)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(47760400005)(15374003)(199003)(189002)(5660300001)(53936002)(8656006)(47776003)(68736007)(66066001)(48376002)(107886003)(101416001)(50986999)(4326008)(6116002)(8666007)(39060400002)(81166006)(50226002)(8676002)(7736002)(16526018)(36756003)(2361001)(105586002)(1076002)(305945005)(106356001)(81156014)(6512007)(2906002)(8936002)(10290500003)(189998001)(10090500001)(2351001)(3846002)(478600001)(22452003)(16586007)(6506006)(6306002)(33646002)(316002)(72206003)(6486002)(5003940100001)(6916009)(97736004)(6666003)(86612001)(966005)(25786009)(50466002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:3RI6nAd0pJpqBIHsPovhcoAMDhfnT7yHlg16dvzNq?=
 =?us-ascii?Q?itx+SFEBAz0MdJWUd0JfM2yPw0F8y1qvhOJDUsHzv6jrIj54ajz8uSNUwpd+?=
 =?us-ascii?Q?+LoqkFZiOLn1U5//SAPdanbz4fAtY1AlocPKMCLTEqkFK+XcXKBc3RzgOnwQ?=
 =?us-ascii?Q?dSFfb1VqIS0MnSFKwBbt4etCCo45H5Z8nAd53rtlf416ZeG4cGuqoShiJ/Mj?=
 =?us-ascii?Q?ivSDC6mKbo2UXNCUl4F3ibLgPrK2H+ZeKDF9rUKGjpG4prtz4n2PHaKZaYE7?=
 =?us-ascii?Q?K9aF/QZIEq/Kk3IBGcIZSBNpyT0RPmW5FFC0/m5/KkcQz5Wrq9Xky7kATtEk?=
 =?us-ascii?Q?Odfat+nK3RZGBEKCcxqvGl7I4AF98jzAgqVeGuiTgXSnM/iIMVwz5s7BhjaA?=
 =?us-ascii?Q?eOsYy+zSawQXdpPG8y4NVWozECqeawl1z9hcRympDAs/9jvhROc7M9Q9F0jb?=
 =?us-ascii?Q?IWiA38PiC/YfcWgZoT887G54Az1MlP0H7ZFxuTv7aI/cRpfoMA5hNlcv9dIy?=
 =?us-ascii?Q?uzMty2Rk6P13EisZRlplsIrz5l4ttUwp1PoVSV1VoohF7ouVJlv/GWMNGJ0T?=
 =?us-ascii?Q?dwnKnje6FTEtBW8nGcnkveAMt0eR4BFCWhURv8HjFqRob5qXM/N2Kzo2KKlS?=
 =?us-ascii?Q?1C5pMX8MsrXf9/eGQ0OOxHNZDtdM8G8t+9Rwztga8Kh6rKzSHfTDXSNVOgPh?=
 =?us-ascii?Q?TnR2F+4ChO64ifnTemZ1bzyIjaeWL52ChBHp4OXYWizV/74kYTGWmyVOh9K1?=
 =?us-ascii?Q?OG4UlharygpRSPg/W+O1pILWNzPRou0FXMGgZmlusuGnE7JO8ZhEqv5UYaD/?=
 =?us-ascii?Q?XMTEtGVCZ0EOHJjA4mHTOVRB924ZHQJj76UL1agRoE3xBsSAFdP4VACsf68u?=
 =?us-ascii?Q?9nn3NllAWHBvT7HuRmLtVPSq9qu/FdGlmYA+Nd53BMfjtDckimG/3Q9IZy+5?=
 =?us-ascii?Q?QuOuSTm+INO8Oi6QmLhyBCbBg79GO2/VXra4Y2NXxIud1Ujj2VlDSWMFZP83?=
 =?us-ascii?Q?U1OEw/8Aw4Uh+AeHTC6Hc3U8ymjYClP10YtTEA+QCqJI57GKWkNq+y3jnoEQ?=
 =?us-ascii?Q?7x+WSQsYF94rg7Bfb0o1VhRWED8pru7vJXPZsepbi+VCZUaMFNzn0rB45yih?=
 =?us-ascii?Q?k5pT/vlaOMKlHAXsAMt6fCSLc1EkKRONpS+gsR44qhoJbpMyjJL2QWy3cXSk?=
 =?us-ascii?Q?NzS+jVSuNF7m5F75xKiZb8nZBCWEqxPdNJEvxgb7LWxCv5WagyGe4ZeR7fIc?=
 =?us-ascii?Q?BH24LL5fJgEVnG7dObzsQtIMvE0iGd1Vpxo7szN3MC68rGbMTD0XkpWzgPRE?=
 =?us-ascii?Q?/7EkPRZx2PuCkhnnS8dtFzGPfmTFcXmJ0Fo4Os3EqepS6vEE544pJCVSg8hJ?=
 =?us-ascii?Q?lLsD1l4UfSiNv+cNcgNIbJ+HcDx+qclf58Sv0t6QQYfyWZN?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:3oasITTs4Bzhh8HGU8wBb+KszYhImDVJ+4+l+trlWZP9/mu4DRQK0om1kpb2FeXlPDnxpcpOeYm08wMZwnLyBrXUvETlIIeu2MKw8PYoYbFni2hSHJO0xHgTbjmEKvA2A4lv4Imm+V6CVJ4Wq7qtGr5TGeA5lLx/zAhXg9e6Zhjp4CjDqFjHP16J/x9iOLkgvUs8UEvof9xyBDAOnkTvS9xY/wbpFUv4BJzmWBMKH5+yxCljZT5cJyhuDvo0tojXzZiH59ABS6gF9iGKxquqGQE1WUxnbBzoqS/BfAaUg6RHRihrR8qSHfFP6NKKA+uYa2Ex8PTOyZwD2CNcdFPFPNMEBOqayB+FeidUb1ej1Uw=;5:YGlCdr1GxOht2H6CC61NEMlIG/1LMiCc/T71rvpXJj2iLylynomGZymsyxOl4vJMaHFreLURuflhnlo4UwLdbqwLnWeB1ZfjZXwNwuT79/C8wGSQBYmW/BimiapyVJH++KKWM+OVZ2qYj46V6hEtI4RY0qgg2n4jPjRwrkL50vE=;24:VfIqQtKMzYYcg/F7nlml8Ipt3oeIOTqP+eytkXfqOA1s66whLa5I8Y6mGZbSbOtjLDmpPJb0BG1ktG4FCM4g1iR3UJd6mkbDKozeR6zpQC0=;7:uCbU0BMCZ+1Tw9HhCOaYsVHTPKsL1sCaHQnTz+amKbcitdJGB80gIvF2XerOPKwuoq0zn945xBAaQn7ZU2lurSINrI2ugrVFNwg7OVQYN+oDe1E4W4z7EztFN7EkzQBrSR6vMITlaYPWltWc0RcMu3c33gHJuyx9r7c2TbhQ0QNrAL1z3euwy3OJgWH9vrGTnQcZ1OVwuBDoFUjFGROVxX/yNCk3CwoCIooiL3JzDCFb4FwxnYkj7we7rGkPAjrV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 14:17:59.3605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba57c47-25c1-4e5a-6c78-08d5277caf29
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch will help address the CPU cost of loading the index by adding
a table of contents extension to the index that will allow us to
multi-thread the loading and conversion of cache entries from the on-disk
format, to the in-memory format.  This is particularly beneficial
with large indexes and V4 indexes which have more CPU cost due to the
prefix-encoding.

I wanted to get feedback on the concept as the way I'm adding the table
of contents information via an extension that can be read before the
variable length section of cache entries and other extensions is a bit
of a clever hack (see below) as is the resetting of the prefix encoding
for V4 indexes. Both, however, are entirely backwards compatible with
older versions of git which can still properly read and use the index.

I'm not particularly fond of the names "fastindex" and "IEOT." I've
wondered if "indextoc" and "Index Table of Contents (ITOC)" would be
better names but I'm open to suggestions.

As there is overhead to spinning up a thread, there is logic to only
do the index loading in parallel when there are enough entries for it
to help (currently set at 7,500 per thread with a minimum of 2 threads).

The impact of the change can be seen using t/helper/test-read-cache:

                                fastindex
test            count   files   TRUE    FALSE     Savings
------------------------------------------------------------------------
test-read-cache 500     100K    6.39	8.33      23.36%
test-read-cache 100     1M      12.49   18.68     33.12%

The on-disk format looks like this:

Index header
Cache entry 1
Cache entry 2
.
.
.
Extension 1
Extension 2
.
.
Index Entry Offset Table Extension (must be written last!)
IEOT signature bytes
32-bit size
32-bit version
32-bit Cache Entry Offset 1
32-bit Cache Entry count
32-bit Cache Entry Offset 2
32-bit Cache Entry count
.
.
.
32-bit version
32-bit size
IEOT signature bytes
SHA1

Signed-off-by: Ben Peart <benpeart@microsoft.com>

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/1146d38932
Checkout: git fetch https://github.com/benpeart/git fastindex-v1 && git checkout 1146d38932

Ben Peart (4):
  fastindex: speed up index load through parallelization
  update-index: add fastindex support to update-index
  fastindex: add test tools and a test script
  fastindex: add documentation for the fastindex extension

 Documentation/config.txt                 |   8 +
 Documentation/git-update-index.txt       |  11 +
 Documentation/technical/index-format.txt |  26 +++
 Makefile                                 |   2 +
 builtin/update-index.c                   |  22 ++
 cache.h                                  |  25 +++
 config.c                                 |  20 ++
 config.h                                 |   1 +
 environment.c                            |   3 +
 read-cache.c                             | 343 +++++++++++++++++++++++++++++--
 t/helper/test-dump-fast-index.c          |  68 ++++++
 t/helper/test-fast-index.c               |  84 ++++++++
 t/t1800-fast-index.sh                    |  55 +++++
 13 files changed, 647 insertions(+), 21 deletions(-)
 create mode 100644 t/helper/test-dump-fast-index.c
 create mode 100644 t/helper/test-fast-index.c
 create mode 100644 t/t1800-fast-index.sh


base-commit: 7668cbc60578f99a4c048f8f8f38787930b8147b
-- 
2.15.0.windows.1


