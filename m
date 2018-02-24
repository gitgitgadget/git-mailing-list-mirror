Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8EC1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBXQ36 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:58 -0500
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:30992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751463AbeBXQ3i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MWxvvI4gll5jVEoBK98Fickef1jnHbMq3u9uiqOu5sU=;
 b=Z8n1dcauGZa52anEZbw+d6NCh2eRwd7zXsgjFee5BPu16XgorM7OKt2aO3iPSp+wwwWdG+/xgTDpFDveXPvXWZRtglTyu1pqR/gwONSxBBQfxWnXWu/T/jpWB8lceaMr/rUI4CVhN9zgJ306F64qi/zYH/34ZPDqhnBou+y+TQo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:41 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 4/7] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sat, 24 Feb 2018 17:27:58 +0100
Message-Id: <20180224162801.98860-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224162801.98860-1-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d802f8e8-8957-4a79-d6c5-08d57ba3abc0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:raUwrAoGrnUjXhXxlaaASrO/dUHfosp+k/74cqBTHMgC6LCu+nSD960DgSRBKxeA+CO1a9x02XLbtalIzOWj0JmumRieZPU0UDwz5hsBXnsFPt9LOxgD32gG5EFYgDQDgkjm/jyR3penrDDANJ1f/t9I2cDHYVoECojcGYTgMt890PrneCbbQeemSiF4P6BVdAz7Verafdde93IWDLu67QTFr+Hxr1/2wME/PRyEfcmxVxCYiUEn75gUpxkKWctw;25:Ux5nIk3bND4Pqpfb4wQQ5Xg/7hxvAH8LiCPlj8D315VK9jaqb6SVXdqrFvQAVMjTwz7uTdbg4b7ofQqkYl1BH/4CWcTlxtv09bmPm8k0JDnD2hqBjENTxEjTyR/4DMGIBrrMvRWvfZYx4/Zoo5AGp6iv3R2vnIsYgOPxFb0or+tjZH188yuntsDl2FC0XZT8udwt/TAnjM5RFwKzDNL1kWwUd8iYYHL5neUTpUL87tQ30otT7upZLWIh3UO6vqGt2GK7bnyIht193z0vwxL0tB2ItXnemWFdjtwNEPKhTx+amIlOA+I0i/j4MprQSPRD76QkcupKjplWv3TQFZtVlw==;31:uEx43Sa76bsIt8XRE3gmsHfx67xXoOmH4kvm073QNy0es55bHjCzttRioRMLgqdMT+tmh0vk2MDiQ/SMI/W2D2RrMqIaSO0F+Ch242GIdHmhUhvQVBMKzQSfrZJLg8pBVlk2wgeaHnlXQ+lVQubhAnpJsCNu9ZUrGGrQ5xykWqQJv4ezfyj31QIlHNI+vOj8GUN5Y6K/qWi6wwVOln1E2lv9QhQvZidlJnsi/Mvkmhc=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:oI5in/TDRALkqDq9kf3UxImjhubBXyGDY7atw7GUCUE/qQcNl5tpMuQZbxV3KPXX7qdB1SnGFtF1CUNGOFS6/rprkch2hybE642OkO8h05/iUn39TFUP851HL8x97WqnFsfW80MPf32xkE0YGvhwkfyf7uB30lLQkEYGDSNtlLOrZ8PzhRFpGhq4P3JZUQwMpTX8aHaYcrivWOSsHskg3wsKAv/pXZW6by0FbVtKrCTzAhW03jeV85CFrluVhkgc1tdV6cgD4u00LJ/BxFiKCpxbi3tfeBobYwMo0jejEThZUn0GFs+/r85qcZhcJ3ypKS3l2QSkN7dhO8aAQTXGR2JoXcVizUdBXPnsYEtYcVmJXUwH4ObYullG68dOpPLocY6jR/doRsa1c95JW5gTo4eISeKMszpynZV0FCgfmrBOtJC1se2DQ4Q3gxH/wqRAJv9aPxux5lfhirP0k3YAmLZJ2vKpNOEkMZzLkhzqg1SXjzh2JLNuk4HUsVd/V6JaLxtnmDQkWK2yV0+6I2U3/4PACOkWZrDAjXLyi71bJcEvE7qc2fS8hgqw9o762PClSmISKeMDcEu720hzPSqBJYsiueDtHTsZKguYUbWW/Zc=;4:j7tV1w/0xEsU5Rzl8JRLOQmTSBuLP0xcIpqZuB5BXOPB3kWzcXAJJqIQmbYHHsIl2b/7xTW8ZqUikHYRvQUSdiahboJe9H5JEOMGkTX4KToqG2BhE9YzqKCXM+6eVDZSZIMxdrgdbY1CAzsltcZpVG0p826Zw45kwuf86TzlPMqwW/LpSmktljegkPGtqAmSX+uxM6Sm84O+QeZ9tts5LGb6XdDofQSjSaiEn3lwFZyEH8uYMjEsr9EKxd4y06pZFDX4WMNAknQj19adBCZFWg==
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(189003)(53376002)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6306002)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(85782001)(16586007)(33896004)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(966005)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:M3Isy42vP2YVcHhEGuwmmLChEwP31GdSCRNI+idZt?=
 =?us-ascii?Q?FrM5pnHOVGWPk4flK70aNVdREF7dtMY264Ig+w6pz1NFCsdWuoieAX0/ABoY?=
 =?us-ascii?Q?z0ccAgNJqJByQn4NDnrzZ87xjWdQRv9uz0WrIvl3r2lAkfSawiQVTfjQ861M?=
 =?us-ascii?Q?g0zwOWqH8SNFHnkVCO6vpDdtt7k/H2gWoV6LZ3ZBJI/cY/iIphQrS4PgIw08?=
 =?us-ascii?Q?JKLBjffDrdCA42vF5iMeO8lykm3a9txweBqKKznsinZxga3UVPNJbpS3qj/6?=
 =?us-ascii?Q?bgm3Au4wZQu6GOLZOHwgo/f/ZZe9uGfFzmGQknzff9DlGfsEN8+CZwbo7oA/?=
 =?us-ascii?Q?Qb3gnqcRs2OLG7HKgnhxiAeuBKYNaoGFH7UGi3EC78du4ijmFJ5m9/JEVHVq?=
 =?us-ascii?Q?2SdP1iatUVvUj0Kzt46iwRy+vrCRUVmqU57eI/YbOqvhmZl/zSaUmUDe9O1J?=
 =?us-ascii?Q?/Q6/iY8xKHmCHtHN7YzAIYCZY20S/zJSu9MKXXvwWDQ4wHpdODF8GfN+YOvT?=
 =?us-ascii?Q?SgQ6VTdqw48guUUZx+AS3jELKU0siKQniNtkReT4pUCqM0NZhDbYdmBBD7Pr?=
 =?us-ascii?Q?62FAwK07sI+7rekrLIG8gbglVTC9OJKH9mLTOJzmHLON7I6I5C6ppZQk7oQk?=
 =?us-ascii?Q?uuEPvp2aQ8psMu1PeJwB4cisUcCboumvWkKyqvVIIUHnU8yy5lEE1LPyS4Wy?=
 =?us-ascii?Q?nDdl9LA6Hn2TMeSpvmdxEN3lfLOjsTkRLmcloRuiwpQqxcB3wlH/vKcMBuPi?=
 =?us-ascii?Q?jaWDMNdJEv9MMbVhQ7N3QwxnyTWP1hOeX0tbzFwAzNBHN3i69YkpokWF1eQ8?=
 =?us-ascii?Q?vI/eZHEL2rOJNPkb6TDfjkT4EhuiP2Q7LlKbOCt4XCZDsNMiVOSjqdWBwsKh?=
 =?us-ascii?Q?HyFUNil3hk++PLaQR94bZk8CwNXeUvw81skZVuTqvkHq80WXQSUkNtySHqwH?=
 =?us-ascii?Q?ajhEuXcs1AtvDF6k2N/2ZNru6LD++nnrvCFCbUdSxqyG2MZK+XPZeJsTRMkB?=
 =?us-ascii?Q?Y9R0CXXr52PZYsTCn4J0R1OuWhLZa56cxhOmbSp+CYmCaYzAOj3Na50iFjCL?=
 =?us-ascii?Q?0u6V9kzcxNdoj5maiz7nmjBNJuLUeHGFp5LkbQoUtwxDMCs+J3exPZCK3F8E?=
 =?us-ascii?Q?JI9VzQn2PV5+aAZBao4NHwCoy9DC1u1TIGt2uKEdGYG8Ffb0MHkWlXwP9+wl?=
 =?us-ascii?Q?dSunOHHkbI/ce8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:SKzSO1ja+piGtqH6qFsonxF2Ytewf76iTTmo8Zth1K6FiklLhev6Lh5NKZ2ivdFX9q84qgrR3JbHuUwdqVP9dZa7EqCl8sbaKcYsef/oSVdnAO7iy2B9MWqm9/GYgg1XoA4Z7nqMLqcbjPLYnHNLv/we6clhEUzFvwahk2uvPY+loRDto6jHctjbEx4EHxJpv48QUMxAQKKPvaRUm4IyQBlt6E/4/q6+wbk2RwSw17MkVAh6ZwqSWZNoloYntGtb0dUv1uPK/aqdVWw4qhPBACi5kuWfpXp8SHZVTFOy9hBuqPkvjNk4keXa0sWbV4Dm5S/RyDorBFXfU+54T53x+R3kxgeKubx0BZrGqGDlXXo=;5:RNWdRPPjTHzQthDJEXRiNt4WLucwXnXOUneOkzvUC67IzNgQEpamb1d1WT/UHyp62xR/fRfSZhmvWY1b+WbM5Xqt2M8wIe7qFvrH5GMAH6URsEHSnvXvaSFzIM3hOauabspuXbngXQeARjIBR0COvN8JV6ri4F92lzDJKO5OMoU=;24:XkH/NTTZr4aHgwvdklWeW2pG4nCTGYdf7nzrkaMcgddc/d3fRZq1KN5MQ/ROVGcQCaRhR6c5h/YJTe/bhXCQi7Y6mSjU+qCAPp5/4dmFiHw=;7:2t0KwGazlxrvXH3xuOPA+LwE2mzks25a2Sm1niqzeldwCJb4eHtV106e+I97zRZ/mRCBxmbmn3cHll88AgaXgzLOnTxsca69qq+GzcCnpcqrbfWOwPCYnvs2C8hmfM8MnFnktoX6U7HCtH1YpbF4XKvCRsK4UqCF1Aq6hZtovIHElRkugHseugtyIWbf+NyoeBPyeLG38rIREq5nqQgyoHSeZya5f49neIJLMxqDkxgiYuPxmSYvXThN1/BsNED+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:41.3126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d802f8e8-8957-4a79-d6c5-08d57ba3abc0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
is_missing_required_utf_bom() function returns true if a required BOM
is missing.

The Unicode standard instructs to assume big-endian if there in no BOM
for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
in HTML5 recommends to assume little-endian to "deal with deployed
content" [3]. Strictly requiring a BOM seems to be the safest option
for content in Git.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#gen6
[2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
     Section 3.10, D98, page 132
[3] https://encoding.spec.whatwg.org/#utf-16le

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 13 +++++++++++++
 utf8.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/utf8.c b/utf8.c
index 914881cd1f..5113d26e56 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 4711429af9..62f86fba64 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.1

