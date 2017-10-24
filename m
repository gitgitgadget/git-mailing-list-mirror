Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2C61FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJXOqJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 10:46:09 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:22649
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751318AbdJXOqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 10:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qgxk9VD0S6KG1pU4rRxhNFovoa1D+jIyt0vrxlTSHF4=;
 b=WnDXohIapwW9uc48zg87NVrJz7A9PiTIh+21OLPbxJKqA+2o4Myiy2i2rLB+gZLiGMBy8eQFCcpdjl1HITC/wdXHVbEnPPWNWuGzMRgmPPKRhQKQnB3Qk793s9w8eh41kRuR+/RwpgVd4Pn+FDyn39QL6Nr5/hl46Bx1DpBIo50=
Received: from localhost.localdomain (65.222.173.206) by
 MWHPR21MB0477.namprd21.prod.outlook.com (10.172.102.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.156.5; Tue, 24 Oct 2017 14:46:03 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, t.gummerer@gmail.com, l.s.r@web.de,
        jsorianopastor@gmail.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] read_index_from(): Skip verification of the cache entry order to speed index loading
Date:   Tue, 24 Oct 2017 10:45:44 -0400
Message-Id: <20171024144544.7544-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1.1034.g0776750557
In-Reply-To: <20171018142725.10948-1-benpeart@microsoft.com>
References: <20171018142725.10948-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR0401CA0053.namprd04.prod.outlook.com (10.167.104.30)
 To MWHPR21MB0477.namprd21.prod.outlook.com (10.172.102.16)
X-MS-Office365-Filtering-Correlation-Id: 817e2469-97dc-427e-8d58-08d51aedf3f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603229);SRVR:MWHPR21MB0477;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0477;3:r2X/oVRVYev20uOmkk7V99dMFyNepN5CaPccCzwLj7CowdF+tbcDLlsEG3qIed9CLMKMNRifeqQ4bU1Y3TcKNp0Cmp7TWqhsqyORSXcMvBv6YSPAsIaeF67PqBaaJ9iW8R+9lKRK0+jQhVTfhA1LXak9jEUmXYdge+QU//BHh5l9Fc6WUcHPIJSiaf3OGxy0zeM+D7iE0ASfx3qizKlqcmqMtDTbnhGa/W9KtqyYYJxzOQcD7pC5EPcbQlBanM0x;25:rl1DX9f31/J3BGcb+pueYLIdNTcCEfkZGidoCPx5DfGvgGg5e5spX8h317FLCvpfECQH1hPVwek63V8tdhejjdCOSCHOZsyVpimykrR+HWiVrXFYEYTlU9KXZD2YsAsXrsKykrD81kfsG3XUtF6rQvU6GBaUjx2c6i1RwRd1O4M1Ot9sFVsA1LcZaQeDujmsFOgQ2pvIS+B5bCJYh1CyYVSCPidP9yepVxxCpWNJqAnGG1nGoFkEF+G/T+4cTiEjwf4idxSScQWDEOxdZswF0BrLhBCtYwOeoXKN4M3lw9o7QLacBQSJZ27GiEkTDaJQQL2jGL5td/lK9o6cMmTv+Q==;31:mbAndec3gSjLXPYc4+2OZU8VO9I1xYMnNfuElb6RQ82+/cZh0cWjwINJlXMpnvqaTvQK1nh0I4S5iCisIN6unXNHG1h6cRRUVDh7rce80v4Dtb9U9z23RqwmfjjMbv0sX8GKX+JGC34B7jAtbqAf9SwoB0MyMPqWMS1IgViIPclwGa6dO97/m6LtWHk0c2NFBbZ9pwn/WJH/f9J0dR5RUwpDJwHxX1qKQ8pLwm9Yb44=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR21MB0477:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0477;20:dNxEEaJSZbwXNTFQgmJ75lW8YIdN9b7yBKlZB5l2QAv/uJ4H/Kpkr6FMzA2NNFrGT+E2gFJOl1v5kVC1q3MJ5lkpvPif8GO28M5mLLOFYDCoLvPxZvbVca7PSmARE5NKk3G2yrQpHgapWQ1ZpeNiUAVhLuajK/Cji+cwvvUNHGHLx9V0IKWJwzyMYuIcieQf3DBWHD2h4xhPh2+D/WSrtz/29T1cdiVB60YO1aflSoPnGEHHBB/RoFFNYf5YDlO2dYRl4OxQxR7XeBKlKUHwo7U+kn0B2b5JO1JS85x54K0DwmZFglnRu5WPGfaab0w2JpvjRE6P9hOE0K5mf3GvfpcUwS/OEmE89aHZxwrKFaPAa83tyHjZSLpfkvB8CRS9iczwy8DUi0CSn1GA/1JHmpMfmcYV/dTNQRG2OPWczW6zdrwoZSpgsPa/26SoBEcFdsUu3nnqenxEOSm+BjEKcGrApM4irLr8nJc3Z0PowXYRAMzhbBhJnJfYRlK4d1oI;4:9d4bsyKUbmqw0IpnEwl1c2WSEONwvdI4nNypZzG6HmuxXYrSTNhQp9crOBxFxkVpyXTbDBIj7Elzklmi9iE9aL8YlBdf657CPh1JrrIH+wveZydZBKuJet+3qOGnPvCuqv6/8qQ7+irn6k5XH0hHMxJbKU7kscF9xbKDEn20IF9d2w/9pfgzTiScvyt0ASr/0MEoM3BJ9LqTg+EIksu9mFpTX5aKpFXD6HOgvW1nbGwUSOqQmIyz44HyknbOnuPu09NHOIedXWV/0209tVV/BpicUjncTHyf5dy7mIqJ1NvqbpCaP1QeCaHzpebhU8vTuh+wmwmR+X68novQWKpAtXR4NO7VRsEvtuTbFHvwVdXfbhfd153sonN5ZyXM9X+v
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068)(89211679590171)(166708455590820);
X-Microsoft-Antispam-PRVS: <MWHPR21MB047769ABD5EF6B696AE489AFF4470@MWHPR21MB0477.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(3002001)(3231020)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123555025)(20161123560025)(20161123564025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0477;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0477;
X-Forefront-PRVS: 047001DADA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(8676002)(106356001)(36756003)(105586002)(97736004)(189998001)(8666007)(6486002)(6506006)(25786009)(50226002)(2950100002)(6666003)(5003940100001)(966005)(72206003)(478600001)(5660300001)(10290500003)(6916009)(2351001)(2361001)(33646002)(16526018)(68736007)(101416001)(10090500001)(50986999)(76176999)(4326008)(2906002)(575784001)(86612001)(15650500001)(3846002)(6116002)(1076002)(48376002)(81156014)(6512007)(53936002)(81166006)(50466002)(54906003)(39060400002)(16586007)(22452003)(6306002)(316002)(8936002)(47776003)(305945005)(66066001)(7736002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0477;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR21MB0477;23:L41+LWIr6Cbpaz3rQkN0UGmCp9E3BOk7wnylDzvyy?=
 =?us-ascii?Q?5EDlMrTxo/r55D3dHUjdGUr8MD0Z7znAzv4ck6VXs1pO+RLPN5I2iOYMSGUi?=
 =?us-ascii?Q?Pxt6G9GaUFBRcTugsT4Sqhf7wGRmiw2bW3JwPKSChe+IZYJe/dBO1grdTN2w?=
 =?us-ascii?Q?RpNOG2e3DxFheHf0pPhoJACnz1NrTq+b849dQxt4NG/W8jVADJPDuskEYd7k?=
 =?us-ascii?Q?gQIgduuDz4jkqrFW8iQt3056LxSZb8fBSoeVoW0VrvbGgpZjJT/vUhQP1BLR?=
 =?us-ascii?Q?pBgOPvI0Jk5OSqHY9lI0/Li4YNemXE3rpYcZ+gFFzNTAocW9KkXYgVAUqYcY?=
 =?us-ascii?Q?9CY/cO6XDQh/SfgbByqbIoH0t+kCx6nBiNbjyOyb4bmz/oP/cNyVePK5PPCW?=
 =?us-ascii?Q?Hsqt0MF5Gojqv2alPR5p8YIuSi9gBkUhraWNEDlIlIV71JCXrFoaGRg911mR?=
 =?us-ascii?Q?qmNytCFAJsM8BJq7Ag78ynZyj3/RtwIVJPmJ/fIkQM5HkjjSJ/akuzd2/gFP?=
 =?us-ascii?Q?De/I1U+TjKn7KXkCZ7GmOH5JmaAkXaIKeG3OeJlf+/ziqzWINQl/Wbu8kOs0?=
 =?us-ascii?Q?/2MgAc4CYdHaZ3aFlfcj9XgkVrJNqJCqgFWK0RILAs8joLshhcD3vSWmCG9f?=
 =?us-ascii?Q?jdE0eNI9Job5/j/1fF1aQl8+1IJt1qdoE1bc5YwEHoHkaLm5d0AuyDLVCfdF?=
 =?us-ascii?Q?Cb0DHyM+gDMW7mpCZFApYhKCfCUuB39X5f18b4Kgr069PO1aAkpiiiUPzp4J?=
 =?us-ascii?Q?HQLpJH59PhLi6uxgIZWGMvB8J7UesnTwbVgTj2XvToWSCN/dU+jDzxUfF1ai?=
 =?us-ascii?Q?qQls/EYP7JyuAH+5exEySN7lH0R8rZSwvnXwbJXRlB3Gfftr5+GXi9o7EVWB?=
 =?us-ascii?Q?l1lDkziDQp9rtOgxAxUMGda96RsV9NTl7G6yGWma5lep6Pj1yjGtcWERiPlB?=
 =?us-ascii?Q?lBX/z0LbCguCpzUvv9dQ5YwhGY/ocsictl228tywooAZ1VzMp2tTQv1xfnTt?=
 =?us-ascii?Q?+Raj5YD8IL6ZJ37C9KzdLNnoFH+MRamzVtang5zhbn3oMh9/tQZ5Pfv2gmRZ?=
 =?us-ascii?Q?Ld9/cY6Dem5U3jB2xjwYN7rcCUDovXIAOGxWrymxmCci5CPagDnHvPLZ9UlY?=
 =?us-ascii?Q?ladDyRrgSY7EaptzaSbAp9+VuhKbwcsijl6gTlWFkCeAU9RHomWkQU193M+r?=
 =?us-ascii?Q?/cQNTAJkp23Ctod72zuzDSnSSADJb2mSs8FfPlJRx3eTvdhDUV7fU0057ogn?=
 =?us-ascii?Q?1oe+OER+EClBxZVXGc9r6qDTT70BUvGRbY9RsFA1uIH7V4oVrWcQqO6tkWVj?=
 =?us-ascii?Q?siJOkVGPL0pWI+4QNSyniblFjVocDRwkWpboNjUyZCjdaQsIv+7g4r590dA2?=
 =?us-ascii?Q?0R0KcYvFi2qs1PmAP6taVsh2bE2ExAaUF/oY3Wb9ZCaHbPngQM6XAj8jBxRe?=
 =?us-ascii?Q?lydJkuImdpmD0ilRrY2jEfZy6FLN8V9XFSclH6jEHtNM49BnAbJ?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0477;6:66z5RIJnYknWlQPCswDuWvzPoSHzOafVoPwqWm0mOK4B03QJ4pOSgalGun1cakOwkLvBdGRD/AXStcLIClPflTydNOJbSwitiEJegjDayMaISJHy1aUwhob5fK0sYz/Lv5tbasoWOQj9eiuW3IgrTJ3qLBYm/Z807Nq5Avw/MbD/6BqpQDTnuv9fkxES2MabWTZQo+6/rnUxaxL5M8H8KwUWwObucgUT0j2/RFUsl/aizIK5ZBblJlW8UKt+q87u52BQ6pODZfNDE8qfzwBAiFn6RqZ89L03Q0M8FzMo1tbBUp5eCcLqARQYTGZJAfnBPOvf57YC59o2uSUJmqLK+A==;5:h6OcBsl+l2XJf6UUVKTtYhSBHAD7tHzw/s5xWRTDAuKvrSwwoEvTqfeR/mPwXNn83PANycSLA6TiKKSsWiSScb8Q44WMdNmCG/JTvqZJl4tLu/WddPUUeXN9Pl0UL031ryjMpMs+cqw5h2EQExsQbw==;24:gh8wKGxLIE0L4J5urh2FnFrWY+euFI0+fdPLFyAkDEF64/0eVKzP92fcuzNPUzhKE0LIuCNdT0hqbWoYhYvNN75XsMGKNWoYwIwvGovoP6E=;7:mp37d+z6G1bm/GZeU1VpnlUGNLXPqjoiOclSXLR4j3Zf7cdYPHrz0b/UXfGM5wGwo2T7Xk8aMMOgp1ksnLCexszgbLQZoY+QKEtSG0xljja9iRDFX2pc98dpDfIJNrUwxGvQG/W12pfhFccwpmpRh239oQ/lvXvI73qEFy2566A/YBt4ReG33J6osVtH2edHFLIHRFRXvHN3IKZXdvfwWdKcsZM249+DzCCWjNUbX0s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2017 14:46:03.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817e2469-97dc-427e-8d58-08d51aedf3f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is code in post_read_index_from() to detect out of order cache
entries when reading an index file.  This order verification adds cost
to read_index_from() that grows with the size of the index.

Put this on-disk data-structure validation code behind an #ifdef DEBUG
so only debug builds have to pay the cost.

The effect can be seen using t/perf/p0002-read-cache.sh:

Test w/git repo                       HEAD            HEAD~1
----------------------------------------------------------------------------
read_cache/discard_cache 1000 times   0.42(0.01+0.09) 0.48(0.01+0.09) +14.3%
read_cache/discard_cache 1000 times   0.41(0.03+0.04) 0.49(0.00+0.10) +19.5%
read_cache/discard_cache 1000 times   0.42(0.03+0.06) 0.49(0.06+0.04) +16.7%

Test w/10K files                      HEAD            HEAD~1
---------------------------------------------------------------------------
read_cache/discard_cache 1000 times   1.58(0.04+0.00) 1.71(0.00+0.07) +8.2%
read_cache/discard_cache 1000 times   1.64(0.01+0.07) 1.76(0.01+0.09) +7.3%
read_cache/discard_cache 1000 times   1.62(0.03+0.04) 1.71(0.00+0.04) +5.6%

Test w/100K files                     HEAD             HEAD~1
-----------------------------------------------------------------------------
read_cache/discard_cache 1000 times   25.85(0.00+0.06) 27.35(0.01+0.06) +5.8%
read_cache/discard_cache 1000 times   25.82(0.01+0.07) 27.25(0.01+0.07) +5.5%
read_cache/discard_cache 1000 times   26.00(0.01+0.07) 27.36(0.06+0.03) +5.2%

Test with 1,000K files                HEAD              HEAD~1
-------------------------------------------------------------------------------
read_cache/discard_cache 1000 times   200.61(0.01+0.07) 218.23(0.03+0.06) +8.8%
read_cache/discard_cache 1000 times   201.62(0.03+0.06) 217.86(0.03+0.06) +8.1%
read_cache/discard_cache 1000 times   201.64(0.01+0.09) 217.89(0.03+0.07) +8.1%

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/95e20f17ff
    Checkout: git fetch https://github.com/benpeart/git no_ce_order-v2 && git checkout 95e20f17ff
    
    ### Interdiff (v1..v2):
    
    ### Patches

 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 65f4fe8375..fc90ec0fce 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1664,6 +1664,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+#ifdef DEBUG
 static void check_ce_order(struct index_state *istate)
 {
 	unsigned int i;
@@ -1685,6 +1686,7 @@ static void check_ce_order(struct index_state *istate)
 		}
 	}
 }
+#endif
 
 static void tweak_untracked_cache(struct index_state *istate)
 {
@@ -1720,7 +1722,9 @@ static void tweak_split_index(struct index_state *istate)
 
 static void post_read_index_from(struct index_state *istate)
 {
+#ifdef DEBUG
 	check_ce_order(istate);
+#endif
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
 }

base-commit: c52ca88430e6ec7c834af38720295070d8a1e330
-- 
2.14.1.windows.1.1034.g0776750557

