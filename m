Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02762036D
	for <e@80x24.org>; Thu,  5 Oct 2017 10:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbdJEKpr (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:45:47 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:16960
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751489AbdJEKpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=b2jN2kYmCsrKcUhvH89xuIaSU7pL/gWT6Jjp6CjBBUA=;
 b=OGR3V2ihLtOq7CvwXsvi7H83uzn31YfZCPY8jzSo77az9eIpUX39PzsdaSqyA/QMfvxkHIIEqUET6TFu6NCMj8G3v8v9+8gxXHp1Mcr0NifsOKlAgvT8aewfnxB+Xn8LzWXm1kMo1nnt5bTo0StqUjBHAYhef6slLDtHUkmtahc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 5 Oct 2017 10:45:41 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, t.gummerer@gmail.com, jrnieder@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/2] entry.c: update cache entry only for existing files
Date:   Thu,  5 Oct 2017 12:44:06 +0200
Message-Id: <20171005104407.65948-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171005104407.65948-1-lars.schneider@autodesk.com>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: VI1PR0601CA0016.eurprd06.prod.outlook.com (10.169.128.26)
 To CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe195f8-792d-4a66-e18c-08d50bde3a3c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:CY4P136MB0008;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;3:an/z2C4XdW6DOyZCp1nOMtthZfZJ9woocz4QiP8T95JPIk56qFdcofdaVBZJqwIB7WRsbi7isNS2di5HLZ+dcwq+sEkWowi1KMAafeg5YZxRYC28MXUpMN59Pgm9Tb9NtM+tbfIRYM4aUp1P4Kh4yP3oEyRcUwevKrzYglcIs5ZvC0YrXO8gZWcM8a+ddgZYzZZL98c9V2u9vDzzTaR57B+rvxYuG27rauY11lpqzK3EwhEutIByd9wl9P+FaON8;25:HmbcR+8Q8LOMD2V5ivsDM9OxamFxvzVPhqb9BYrWa9mmRa3Cw+J1bfkvvAuZZOWfhajdAAyTrWt/y2TxFzSxm4Yyt1dsdfO3NiFbsT9YEWdmc1XiXXipuTNE3YMmT75Ycv5nNvL49j5G/X03F2IdIUHhoBnvwfdww6e+a3ga3Sxxr4iCEnbuNjfGH66kf3gcPvtGF61F9QJMfARvxpAz6ZB+F6yDvCsRj1OH/ntG8GoqNthry6tV8TbmWDrQIAnPuNeFb8fv13DLqCfLorhcT+DHw+r3YXAFPS0VZfNGa8nSAoay0wKoJKV4NahJ3WfUZr3TOEGcSJHgUz9C2xhUIA==;31:eeEVbdOnLRg46r0c4vUwG7SkatOU3DMgv3R1aw9IqBAdVmmx6PEtSnGAey5i5KUrPXcnXFzFqq6zGp5x2pEy/Wu15v9xsOxpphseLt2/JeJagAeNEtiyfc1+eH6MXgA2kwfOIUYX1PMgY+d47gLIFYUyuVHMMKwNdVFvN71+Qh2F8QpVkWUKSLiuhf7IHs1kQ5Be4YXa8zuASA+xAi0Z8/upSoKArbeH8EpaKjRutrI=
X-MS-TrafficTypeDiagnostic: CY4P136MB0008:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:6nM7IKoJ5g6Gl/JyRS0mXPMf0/Si7uRG2QeZ0VHuKshcP63V1DT+MZe/URWp5HqwcR7Ku6xN7ALKf/ilrOtL/hl62K6fR+T1jy6v6rM1QP3lBNV/GV1VJI3SZw/rKzRq8RvNn73bSVqvPpOhfgSNNvm9HVEuJN0BYyxN/MmFOoxMQweUTDh1oTcITKt6BGb26+Wqm6xJZ5mcGGnWWWpZP7ioPtwOJRaYgbH6TSoIsl/obzRxhAtFKzojFsYmVehsrL3Tqg8UjNWnhV3mGR3WYmg95xFgdOfJmNkMEGjA1f39flQNy0vDozjabujLd6aZTbbE+MOQhbMdTl2GXQRSXqXXQ5GGePRSKNhhUdPbqsDAp6udKuWUeHWHCQrtZLXD8I8K1OL58QyWCrO8286IUHZTV/ajDtly3o+TXJv4kjNvk2qg5p8wZleg9Rcd4IqZGDR0RNzHrHXjW2IbOrXy9ukGfu+65Y2yCDrOup8h2oZ51ggYeXRC64ew7aD7+tCY;4:4HBpKt1AGuwGldnuYKmpa4X9jir7lmWiA8I7Zzhgepz4ZTmQvq+xlwK4SrY91agdv6V9XlDnUwGAj1Q/Hso/iFQP5XOOUFEdBs2LveKOCosX2u+YuMMeXT9KiYfPl3NFPfgJhdJaTm6PrBHF81904+4AKrNmsJaJo4Ccc+sfbno+S+z0IiPrgNaFtmdWwty6ccunLSytCgWtq/MUYuMeCXHhotMPjSs5TMswM8H7fwq7Sfu5jroR/CHh2da43zCV
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4P136MB0008D6F8A3A21A4C180564C3E8700@CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4P136MB0008;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4P136MB0008;
X-Forefront-PRVS: 04519BA941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(199003)(189002)(377424004)(76176999)(16586007)(2361001)(4326008)(105586002)(25786009)(81166006)(6916009)(48376002)(68736007)(7736002)(316002)(39060400002)(2351001)(66066001)(97736004)(50226002)(3846002)(6486002)(6116002)(33646002)(305945005)(47776003)(106356001)(50466002)(36756003)(8676002)(81156014)(6666003)(2950100002)(9686003)(2906002)(6512007)(86362001)(53936002)(189998001)(5660300001)(8656003)(1076002)(85782001)(478600001)(101416001)(50986999)(5003940100001)(16526018)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0008;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0008;23:Co2M5jSkz83kNIZu9SB5YvCeque7yL7C7kTFasj05?=
 =?us-ascii?Q?I0SuRUnZtop1/CqGXXN6eAC56ok6dmraXX5/JtQK5yTS2cz64BzpYf0DzBUX?=
 =?us-ascii?Q?E/WgXEH6wdPf1t+bMRsT02fp6juea2KUiXk+FuD3XH8Ddo4kB4cyqh5CeFU2?=
 =?us-ascii?Q?0F/XOxHq0cqh2sdQIDa9jYPC1W3qwiFEIlaVdln4a1JPXTkub0B8sNBc963k?=
 =?us-ascii?Q?sYOPYWBO8bY2N+R4ts9Tw8YpVVoej8TJhdrS/++jxmN5ztwgJThh8CORaaff?=
 =?us-ascii?Q?5tP7ywM5ysBPXGP+PXIeyUbwiXI/LlbToXQD4ExJQLf3/swkeYBNWH8ObCvI?=
 =?us-ascii?Q?vaxguXGTFqYAdYyzUI/VbZMb1nSdSYJHsrcueCwoLc2XFAqF47j2iHbv3j+V?=
 =?us-ascii?Q?Q/EppaQyeNz/C7vrYkGEqdYsTPnT2eOb65jIbsBFDyU02jzGSrhJ6renKlnR?=
 =?us-ascii?Q?EoWk7qfUuJq1Y4SuebOM9nvHYn6Mox0ANpIy03CqRUsFzmLnKb7ORfSpWsnv?=
 =?us-ascii?Q?nCcUxZP5oJLauVtf2ja+sFuwe7cLYNeGv+sczX08ACkUFKru2CnsdDby2gER?=
 =?us-ascii?Q?SgJtn1kNmJnSqEJF4BPHaR6zauYB3s3EYanx5tzR4QAaFETxqMRinHip5H/R?=
 =?us-ascii?Q?SQwk0RYEtyCCjuengAGXpYXiw829qL5TRwlYA6sVS9fCVQBFG88VkOAx/C+S?=
 =?us-ascii?Q?ao5p6YLcGS8gsY2Y0OmHL4Dpf1wyze1m4a9udzpji2wzOM+wKfHtNueox+gK?=
 =?us-ascii?Q?aQ/SJM5O3ncPBUimVWktEP+vLB9wAPHuOUtnSaeTBrNkNqjeqAkG+MbkG848?=
 =?us-ascii?Q?ssNFTWsIiBGWBssbKGdH17gnCl+yheDwV0xoLRR9K83KRGW41csvemjmKM/k?=
 =?us-ascii?Q?KRPUBdtjuHCSqY+6H5qxa3VFShXSm2I0xB3ayTZtTUlBB1/yueZGTvkAHGii?=
 =?us-ascii?Q?OHmS76FwBdBkF3q8OtyXNP5ZjhJaB86OhhDS4oFQbdnq+F8DV9Bf805+2p7s?=
 =?us-ascii?Q?OUoAFWlmWFr+23pc7ZhqzZqks1MU0qs2Gx23XVysiQjiDFO8m71DvDR11E7W?=
 =?us-ascii?Q?IXb1Zmx+5EO8EM093hsyXDi0aIq0pPRnLTqB1c3CtYTH/nTEyDGiN1Dv0GW0?=
 =?us-ascii?Q?GCn8rIXCurTLCRSR88YUATSgfOF2yCXcQ8f9WDrD++266/wTGvariC8+gRQx?=
 =?us-ascii?Q?ny6b+8AizKHhOSRdlMQnBgLAgDpcb99r0bwirHKDKfy5EMdiN8hE9/GJTq8N?=
 =?us-ascii?Q?HXL2WkVUskGD2aOtPJP1FjPwe6A9nMpd4xxn45o?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;6:mDbsUkH5m91znIdtetF3XEQMwq3b4U+aGXjnhKMa8OliUrWrVwKJ5bm9bzghgHKGcr6ASwNbRyRrc7o1eenQxKbVKN6oXUdKvWIxCLJcia1KPhdkvm4fv1oqvK6fISkwuBvDELFW3viKsRcBEybEBFBzDHBUMFv7kosZl7/HCdRGUIqNg6her9QR9vdq6xBKSwA0gsb/tt8CpIN+F9Q0HnWfvXCxAlcJCEFHZmmQ6DnXQrCfMFDzNXJu+ESNCvE0fUu4rv5xemlrMRqmGDaOJJguiNb9ixN6rIAc8/7Ug8XOjlMFYrSAx4rNVR9KaPLxVvICQ3rq6MB6g/StRcqwnw==;5:5TFTG9R8goKBw27GOun3athvZWjxgDguvdkGbI+cNuL9hyJx1TJ30yNjfi8qSV3/E+HQmmHf5xN+qW1G2fzu2kPnvLb9UeH4jnnh0ywpa5g65lze1NdeY94xs7e6S7+N1uF8KiEHWYqpPbatqT1ZaA==;24:71Cpep9V3Ha9PP9FB+NoienFP28tgp0mwR3urfTKkT80QbUHT0rQEW6bMBUI8ly0U+VSpmpWdbSSTRttVyq9Hk0mUpV8yTaZwgvWFWnd9e0=;7:ql7VPThAY0UJ55a9PCq8JgFpXivMgS7VRg8H6LxXPWuvhf8ar1xGoZZZa813ME7PpfMbKamEWhfxpnXrez4xtnpUPQ123Y3xkPQO+dOTX3cocG73ZZcEWc3oeVj0Am2auEwPa5GQPtUlhR0/cuhqyICXXOMedM/GGZ8K+542ZSqVP+nOee4jy9c3HoN3Y85zWnsXfXkd4ujYxZn/AFnXxTLQ6henS3CISp2rqPkOBb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:UjvO8Utl2FSm7qch0GXO86oCL3rBCIKdIONnqWJ2WsAPxvF4jup0A9RHBrwkxJf8KdKKO0fPJ3yhd0l19UhRuDncwlrh/nedni5YFkGtOTo8aR7t84r7Jds8L4PkAGWpw7VlrpC+JtJ6hp2y8+ku/+oTMN6bIEdtQGPehuOOrNA=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2017 10:45:41.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

In 2841e8f ("convert: add "status=delayed" to filter process protocol",
2017-06-30) we taught the filter process protocol to delay responses.

That means an external filter might answer in the first write_entry()
call on a file that requires filtering  "I got your request, but I
can't answer right now. Ask again later!". As Git got no answer, we do
not write anything to the filesystem. Consequently, the lstat() call in
the finish block of the function writes garbage to the cache entry.
The garbage is eventually overwritten when the filter answers with
the final file content in a subsequent write_entry() call.

Fix the brief time window of garbage in the cache entry by adding a
special finish block that does nothing for delayed responses. The cache
entry is written properly in a subsequent write_entry() call where
the filter responds with the final file content.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 entry.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 1c7e3c11d5..5dab656364 100644
--- a/entry.c
+++ b/entry.c
@@ -304,7 +304,7 @@ static int write_entry(struct cache_entry *ce,
 					ce->name, new, size, &buf, dco);
 				if (ret && string_list_has_string(&dco->paths, ce->name)) {
 					free(new);
-					goto finish;
+					goto delayed;
 				}
 			} else
 				ret = convert_to_working_tree(
@@ -360,6 +360,7 @@ static int write_entry(struct cache_entry *ce,
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
 	}
+delayed:
 	return 0;
 }
 
-- 
2.14.2

