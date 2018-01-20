Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F711F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756071AbeATPZD (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:25:03 -0500
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:24431
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755324AbeATPY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=t/fX4B65tOlG3lBoqHnZIjjRSXhGfUTZMg6DH3FRIxI=;
 b=S7whTVxr06AvgHx+1Fb7UCedQ8o9+iZRZ6MIdlNnz2MSFCHfv4vVi34KXXK1cepu6QVzuAVkjp6Jc5udrE6Lj67rPC9ZHawr6yyEf1UPbaCpHogzbexdR3aBan1NWsQyMOkGO42QatRIUmcr8GiiZHtTl2EnscwfKdny5y1tuLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:51 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 4/6] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sat, 20 Jan 2018 16:24:16 +0100
Message-Id: <20180120152418.52859-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-1-lars.schneider@autodesk.com>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [91.89.52.221]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ccfc8a-4785-41d3-74ff-08d56019f48c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:ExpxBIihOgAGlv8QAGqpIC+mIxxCLC7gyrX7AqVjnJuLkkT1HfGF4iljTk4MWCAGYncib3onkR4jGkWO5JcwM950diLvmdOiucBffIpjPTA/p7SZ+gxYxd3vjNOpBVyyG3G0YsWnplN40c9I6XLZHIuLwclkNAwlAR50FoctJxV/FSAey+Zaxl1cNRWK/m3Xe78mEYBtLsbtryjjrCE0P6qvbnGoYwO+ozQM+SyZGZDL3VYZ/L3dRd1q+ARNID4q;25:Ae6QCAxuZCsXXbk3qY8hCEZ95BXe7TPAXfdNTCFja2Wv3YhyVuROsVQ1AsckYfOVwKb5T+hLYaCw50J/gho5UOMdtWGHvU+vJsTM9YAHL+eg8pgNQBXeS/VZLVRpfyf2O5Jf/4zgXM7HGDlHoj0HAbElsnH1tY8zjL69I2NwAthLJT5jyUjhUKzGqUeSOE76zqFi/Zd75Wp8gOuo/wgZtWsuLccA6kmAt1yihGro83vweQ4+Z3L2cQFbEYoSOjsdcQ685dzM7vL4yHmZFXLkt10vMOg9+zDYqKDPDkfIXXUyicNrYio8vVXVhOKzQHPjSfqqq8xojd0ZdSfCNcgGrQ==;31:QCIkbIbL8KtaSsrCiB8IdhgVrVqR+hCltdvq9g2PlMlEonPXrUxYToY6b8Q5IDFvt4R/5gZgfT23AkyTnEOIEiTdFBu1RARsC9SHxl6HxGeYvhhbvj/O6Eswj0b3suyIHzZbWXKeAKT/onRMJpoiXLYDe8bzEuyy8wR91dB9lrpZkREACzFmNquhTpGOn2kPWdDPXkQ4uermOC1VKI5EXP08NN6JPFw+EDBA8ct03wg=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:1oGoAanTgXKTfAdIL+2shvhxhcTiWrmgrZSQADScEPzhY0Lx4YR4FdpQOsTTh6CZesfLzAIZ5552A1v6FfZOPHTme48lUAODPlkCXOY6sakOEJvz8+RpXv9Ee8CtMYuuoFPwVZXcWTPu9bgu+z0XQPqvPiy1kXZEJ59e61tRpR4Rkx8GFlDgeChusZowolZ876TOaiDWxjcAySoeJaT5AHOUSgj+7iQikYhiG+YFIkZYDhl2oxe3BcQKfWQF29G5rPUs2X2yN3F/asuedIyYAQcesbT3/loBd6Cnvafi7RMBMPyCkkKelIvQVwoCOPJ/eTlxyZE4uK+VgFss2AQyBRRKKISA9bDUYYqdNxeAbylLtY+GCXLnJBRuYwLz/SVdtgjR5YU0TIwSjpV4bm1UpZCOpg9pPr3L9tHu0Wm1oL231Sf/kcbaCgEv28ArWw7YmHtGtp6MTwPGA27cAVsXIgbuiqGtGNsj1hXmqmScO6Co251Rb6Q9AdF/pERe5YrNAHWh98Olul/0bobJEVAoR2k4jKEEX71Lv1nIpAxIJCTxJoTRS+UJkXS7sZud16usEyKN1k/ALUnx4G7U5BApFuEV+8Yw4wXuxhR5SMnT4ro=;4:tNPIuyjPdH1338fMgY/A829U3SN2n/IG4rVK2UEGboyID+stkQsVQtefJ2mB+9ft/lSK6kjale0DrIdZcSQN2Tnyh70nXqUsdFDzkXRM9n8Rgi/O0R+l6QvrGwbGGZ+q+h0eXlaa19xwCmB51P7mpET1qbADZtkn/Hw96xdtfvMcJ3skotSrhAnTzhZsJkCbXYqAEu1D9kufy2IapfbPNrYrqJtw46DgBGRLD+tio/gBHIur0g5eCOPShS67mX8BHj8U0GiMPXhXCaHqaik7EZeT8fFutDRKGWRSyQNLXBxW3xreA38K8BriDJWJplPj
X-Microsoft-Antispam-PRVS: <CY4P136MB00226634285559ACF6577D67E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(6306002)(966005)(39060400002)(3846002)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(2906002)(6116002)(53376002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:Rqs0WPFZRdf1xOx4mBOT9qlT2DDHBfAF+4L/zRyWZ?=
 =?us-ascii?Q?HPpeK16oBVTycy3xqT03GrpgaeNqBLUxjOfbaKjkbllm1+wxKlYkkN9YAovM?=
 =?us-ascii?Q?q6L1PTT/oAh2R2bpVNzMjoGeJUGxYLE+8dDOocxLnsXMibk7QhFfdIycRRWj?=
 =?us-ascii?Q?pJ5fHt31kBeuW4YOxJ2hPQIz1VZuD7HT/F35DSlIPEG1vXlAkzZw9aTMRKLM?=
 =?us-ascii?Q?8mPmaYsXfoSVKIxg5wD6phNixCVb6nsSJ+Qdfp12KsTtXTtXDGZ/5M4KECmP?=
 =?us-ascii?Q?ek1wOxAQRqrwfHy3iAXxW5+gyqqNNZ03CRB7e2G20eURBriRiRfOR+QsHuja?=
 =?us-ascii?Q?Uwk5WB7Dz5tkxL+91EihTA0ER/GbHU0JXQTTMkg1MFtWXYOxS1w6u7WJMB+t?=
 =?us-ascii?Q?wir498OWj7mPeKgqQELTI61ZjJjIPIitrnXoDOjy2RLryuS8H8lM3QPuoZCW?=
 =?us-ascii?Q?xvLx7SB9uR/CMxPQ27T6tCmOu+4qRzQNAnYrAQeaQfkvSeKFGLL2UGKGPXKK?=
 =?us-ascii?Q?/LLv5ITE3y/Ss6qNIbyPpbqyV7EDMhRuryNtXshyiJfQZcUlumPohAWesRt0?=
 =?us-ascii?Q?WBUOgOXZbMkmMOluKRhGkbfAw+it9Iv5qdJTaDoP0kjZNOkLUc2MJ3FD6TWx?=
 =?us-ascii?Q?PDI4aOOeo/n00o7iBH/k5/6PbS67YBddPbt4tHHWNGFvoIv0a81g3GVDEeUc?=
 =?us-ascii?Q?46B5Li5w6pDJb1TtWdVvBSFPphnNp9eboqXRCGiSoSc6JsU05D0626R8pPhl?=
 =?us-ascii?Q?2DV/ymAQfd9LmGMhIu/Ke1+MANOi26UFolRVGn6qv4mmCXLi9AX1p3mx5J5Y?=
 =?us-ascii?Q?KgzqHhvF9UqYtEZeQc9tBCHZjELVcF9T+8CLsnSfXsSV1QpM34GulXiDO2Ux?=
 =?us-ascii?Q?Y5MZ4BMlMzhacS0kfJwsEh5UmBil1CJIAS1g2XqtRWzU39rwEauVs1niuX6M?=
 =?us-ascii?Q?l4QNk4/tB4Cd4eZCpBx4HTbCwcqdea7ZOCW37tJmWHPM/TT37MSX0Oo8vj3Q?=
 =?us-ascii?Q?+tLMdEquu2uN9VJwN/Oehh0dGQe5cqboJapGXUyP6ZOCXoE9r18gsALAnrAf?=
 =?us-ascii?Q?yTR8u+VJ00N/C6rbM45qNeggye1X9XV/5altsDrgUI4iC3hVUBTgsV8S3ti+?=
 =?us-ascii?Q?nbrf6HqTIbYQl6yz2Bfd2tdlciSi1RPKVCp3yMXeOFtOYkoOWguRfgL11urv?=
 =?us-ascii?Q?9BzH/IkG0l6BFLfCC02eYPeo4HbTDRqFfIlANUh8duBT0s8OqjQkScUA6QCI?=
 =?us-ascii?Q?Ybgs9/OIp1PmtxeeuBEgWSvaYbHOCBLwrTcNHOTvDo8M/DgTQPqhNSMQSV7e?=
 =?us-ascii?Q?TEh2eZV5k22FfZi5LIdC24Kdk/+AASEhQzTzEoAAHuh0TDjSqIA5Y/k6n4Nj?=
 =?us-ascii?Q?2rQIlKm9aor+osVC+xy+bbBF7E=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:vNh8SP5TlJ9c9zqfqIljqPPDvmntzVV4V0TzkN+BcRJX4HObFH1QLnyU+8vtkJSvItbVKGZj3T5LoHGS+qsLjPGLCf8CRFTAq18/GgecVvG/Wmk3LjjiXNW/T8oE4HVkcEcYH7oadUZ/VNy/XmG7FpSoa7yCoRFftZbLpqgMWzFFo6Y9zmeVkmC/5VUQF+K3cnlF1WujhllHX5XuWgAgRnBa/hQyxKiOBBeQ4EZx4KAWyKApPOFMj5KOuljP6AGBVGsSXuZUGgZPtcNUdcnpjO8yldWDNeUhGlr07WRUXR3od7ntcgwtFNygcT6jFL96qv6SWyuWt72RsD1a8i2g7LzRsl1iWOJMzLT78/+2Gy8=;5:CqO60/Ya03Ae2xM6Z42Cf3t+eaKIVzeM344wUjO3QS/MGaFcAy0NVpRH5dAFCy4fWR3Pc6cG7b6GJYacQt2D56J4+CUEB5zpFsI9o5u7Jp56May8gHs3sj5fk0sDkysad/OxzaSPTX4/x87f2pjxHwoarFcE+Q91CyqrtQraQP8=;24:YXWD3ahhmZcWoivMoSHq7fSIw/utrJlskUE7qURpRyCzeRpwYsOR2oqSIs1iDSKSTibUMMPQ/cEDTSQuMjU1FOLG67ihBLMeMLBKslJ6Dt8=;7:DMHQ9sZugiCv1ufbNLFpPOqGl5rOUAxRpXJvX8vU9IRHaMejORU4LuoKc+JcKLKdLuVa3tD1VAecP3i1/zj6akoSoZ5I7ICo138mHOGxCAedepX27lkizTYDNov78to7KaGDpxTBy6lLev/imrYpjkYnNcrd9lywXhGfp/K2VaVluH1XbOX6eR/Cj2tDi6WNGy2dzc/kV0O+JdZpcw9rLQpNxzUOS7QbmBi8B2LAz1fb4ZGOJVB8wQW5h1/Y3EPx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:51.7493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ccfc8a-4785-41d3-74ff-08d56019f48c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
has_missing_utf_bom() function returns true if a required BOM is
missing.

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
index 914881cd1f..f033fec1c2 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int has_missing_utf_bom(const char *enc, const char *data, size_t len)
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
index 4711429af9..26b5e91852 100644
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
+int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0

