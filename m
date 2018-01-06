Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75E81F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeAFAsx (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:53 -0500
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:15709
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbeAFAsu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=b5OretgS0El1hliXK91V9IwfUJOnlaVMMTS2jyn9urs=;
 b=A4pgbu+PrPcAMwXUjfa1ivKVQxGsQ1qdYToZIUzm0T8OZcsNMONMYYd6xdpRfu+U/XTvpBYGVET2Wdi+cbMNMDYruSF32GAuj6FGXNv8YleKV/ojo1BROpKvE3gpi9RFfoVHpkxT87W/nDEYY05xwHmay+DxZITHU8HspFAQqoY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 4/7] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sat,  6 Jan 2018 01:48:05 +0100
Message-Id: <20180106004808.77513-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da11900b-b50c-4a2a-fb07-08d5549f400a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:VbNWQm4hVgEAeDaXJ3ORvWwNgi8vS8sbXbYj5w3y5gzDvahcUy6lECR2oZz1rvNXRNIsDsDth9t6cJ64hh4s6qe+ihxkx+N37gz4+2z0GjhMMaQYXVCIdavYqdWFZxUvwgYDIVGorAHdEMkNZcmXN6HNBwJoZhdVTmdpsQoPKwz48gV71aas/FnZipBK8jxaY1W8c0hD53jeo2I0y1QtAZbiTJ0FHus4TDyzubUUGdctiYHz38n3Fd9HFLVyjHrf;25:K8Xz8x8kI9qgmMHQMskAYQhSrLISAtsKL0XgQSzhxM6rpj+pXjXQuEJ4lhyEmRqFXwus3uXcVkA32E5pLMUUMmHP1oMPLqN0eigC89EBaNIN86Vx2cVwLkzRnxqB3M0jRTEds9H/ZiQ3GO6zaTd8KN94u9pz9UQvzyhYY5eDNm/lCiiCuTLvjIXeKj6aIK7VoJEQLwY5ro1pnqRxh6hpK8BHfyPbBNCyZRha1HJN0McfAcoPkt12zymtAVPj4ZjVZzmDOk3yB5B5vMbSp7Zzq/HNd4cErt9mmof5nEnBKwLBAGJmdnbvkBQksXB9SB8vYCnRXhYYkhCNyDQB2I2r9g==;31:UA/Iebar3089kTzDjWs0RQ6pvLNmZ+xvqz8uoj+jS9l0okQIbKXro1VOLoLBbJpC+2RGOQFQHQSxeBsAoawdYCQDZLl7g6ziORF6Mht7qSHP2poubpB84U5I/qQPkpMZKAUHNJxl1i7N2ACapc6APqPAXO8fEXq4db45SWUctZU3fnw8whI6ApA+CdYTcAgj4F05C/wNhwBkud03hv14LBH91ChwvrCOQiSYNLBndrI=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:OXWYhv//VpZOaRYm726rXkHVMabaHIcY/f5V9eYZsxKhUagIQoPZ39A99V43Ruz3mml+VHEKr/7sLvNY0Pyfx6QNlvqdkC7atVhgsyLHV2V87TN62qdkoHEMGQSkQc3Mqyis31gkz72f41Qjh3f2FUUOttUUPHLrfj4BPSTZyAOxzk6MupBykLLHlQ9q0a2cGXWA7K2a2GB0Bc8b5Sq75wbcKyGX+a+rsxMcM93394c2Qecwk2QKhiPQlI4rcTRMCxGWULc0G9PWC7tCnyLbuDOyQXfXDDOROvfGDDUXoX+s6+o5/fHFxXxbyfWYIVK3Ak6nbUpMTTRe11+aAmKSGSreXUyWjZhYguPn30zDrysBB6LaEXV1Kl/P0+ljmFrbQMZrJw3SXvQYweIpV6Giols7sqy/p+pHZSCRsADnUoabT4v/kBV/mjcaW0a1K6dpA87zBSKc7CiNqDgb5MHSxrXo7x7Fi/BJ5XSn1oGshNbGNvma8uNHP60aA+spHDAnkBBOmV8nUBRh4n/LQXn+mFnjY84vS2gIdCKO2o+1DgUlWG1/EvwWDZw+lKx4s6Nyibm6zVziZXZgrtjMCjv7foXBB8dAf1QthPqxRjPZkTM=;4:tzcVA3m25TJLZSANHsPxnCQZMHP3ulaT6XSxD2rCwq6OepCA7r8MnP/rOxUP8LfTW2UtALCGZGn3S8beYfJyxUgcIkTZ3tH7FkmBNGR7aWu4vTjuSXTq/WJNaSewP453sxMJeYQqwko83v5+ZFbgj0OpsYLy8AOOmFE9QDrPimbbhtWFspIDDh4qBLSnR6nmWn9eCRGnuFS7UxyWvfkwg336oMn9MGd+c1Zmt1yHv0HnbFXUhnolXPQakti892qiLGenStgxcSaRzdsgqHosFQ==
X-Microsoft-Antispam-PRVS: <CY4P136MB002137B86124AD6E9E88EE86E81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(6306002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(966005)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(81156014)(36756003)(53376002)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:Ooqskr4jXWJlhGb6sMCPUSTBXGyyX9lrnuhVaPgXC?=
 =?us-ascii?Q?W8y0WsF4mc+wIxCJoAWJFObF5/9+ctT4X4kBD6bTmGcgAQAoiPncr4zEIBCj?=
 =?us-ascii?Q?tble1f7Sr1OhuwjxyFSwzhQNdHdpGw0rz4/dTfAUEhvZnWcRmGdT5iA+6Lfl?=
 =?us-ascii?Q?iFxn6Z7j0OBne1gxhqjsrAcg/j2kPN2Ds/zElnfrAGaVtHDtNaecg1/rnWvg?=
 =?us-ascii?Q?YYzJp3i6KhDC8c2tPo3hFY/tMPEFAlCr3ITfy3IcWSLjy8W2sbVxZJCZ76Vn?=
 =?us-ascii?Q?VCLxx/lATH0Z4O4T/7en/mAX6ke3jtPwcvYHXy7B+r8htGbl1HiQRu5FgkPS?=
 =?us-ascii?Q?vVhvGUjuQbROyPh5dK/frgecySH8ZXjoPjaGlWiD+yw1ITXjk5DQAmadsgBC?=
 =?us-ascii?Q?D8onowwI/BIIBg23KVA7uA9bTdKOs8v6yH4RYJPtUhTPOlZJ/Z7aqvsjBpS4?=
 =?us-ascii?Q?mQTRV0vTvZvBNc32poAnnwTwN2dNrbKKWqLc6wQQ9OiBZ2Jx5fywB0v7Q171?=
 =?us-ascii?Q?fzetIYwz2IeZErDjUbRiDB03JxZHCeA3t+Gpis53o6fmcMM0NbnYS11zUPKM?=
 =?us-ascii?Q?QRigJoeDyT0bnvQwQ548AUPsUxHNeZW32iO7qAto0y5gYKntQoWbsos4efRX?=
 =?us-ascii?Q?xAB9G+7qfSiGkBZf7Doixf3YsRN4U86WHGaoEQw1vfwxVxAJlmHfcyKpQWQd?=
 =?us-ascii?Q?gyMe3cTIv4VETeqGLERTim1ow5MVEKP0YsTmFJDmXrFoXyu70df06mI7/sAs?=
 =?us-ascii?Q?US+0jp39Kccl/sjkUE+cePC6L/YpVK+Y5+QTqVga0mwsuORGLL7U1f7DnbaZ?=
 =?us-ascii?Q?AGGWPVK5T3TxZ4xlgyKaw9dnJ+AfwTLxBvA7zJVNcQKDamQwQdFjt+YEQclH?=
 =?us-ascii?Q?Y9mLjbLwMdnAqRBcARwsRgUI8KVAwxT12/TaJRiVlQm5Ks33fqFHu5NiJF2v?=
 =?us-ascii?Q?LBu7GCi0pnrcPDumcLOJsXWRavrjGZvxRp4M02YICg1LYKFP+ez3ae4W7M77?=
 =?us-ascii?Q?zv67k7G24Fj+atbkBGe630kcgSauMFkxA3JLZLW4H3s7+6fWA4Zi/j1Dincc?=
 =?us-ascii?Q?1VPbOV1myCMbsD91EgnEIWIsFc1VTDzHYM1s52aJ5PygdRKDXDVXrFwpS2QD?=
 =?us-ascii?Q?4ZF9JDKonRKMm68ro4BzJwzI6xzwDSboXPIRSdrm0BnV/xgjVarw3pjBoGk/?=
 =?us-ascii?Q?FA6YRkcvW7/8UVinBNBGX6ZtiT9+ZDhxtjlksIihR+sJ/6S6Br7zBYOm/hYn?=
 =?us-ascii?Q?hj8BvlZOx8ZoUvxCXyujP/FQwRSPG7LZZBCpfxaKvMFtUfkWiaF0+SFYfQHp?=
 =?us-ascii?Q?nZ6RCDEWArObURD+4LiIPx0pIH/yh+sNS2d/+dW6JvqZN4ISCGsnFnFSjRde?=
 =?us-ascii?Q?17K2dpp45r4UukN2Z8FGK7A2oQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:E+Mqxm15npmlCFhuFpl3PWf3O5pFAnNcxDRxHbLs+v4C8VuHid2xmm3mf38rox49ZeL7gu56VFJTuhKX6//hW6Qdgjb5tHa2kxYDetw3rsuJAeASBK3IgVw29NBAnhvPyQtDBKPkkDUyK9nBZ8DjxhCMKnUoAVzRrqzTPqWUaGRYeJmoZXc9f2a6dj23GCMpo0oYTJXQG/tMF9me8ZQHbrVmr4Y4wUrrtWt6E1nrh6hKVykgOhKePy6w2iZlUz7q82PoGTgdEQcWkjLrgyDQ3N7yi3wiZfl5VuiHk5kH2aXoIxeT8HXnmuuqRh+8tdTcQTgTelBACYIGEUeKN5hSzTmy+bN0vQVjIEiRyx8efBc=;5:+RVm3yn+5lZpvTZY/dK1/MPLs02hT4SmwdTLEo3s2dYW5bJU0NZCNQkPwG5aAPmlSXNVucAWQCEa1B563cXvRcp0oxGSkrvWHmScwg2fPwFqh02izPIys5wOAVi9BMPmIES9kKLqXRYITg9HDGLQuy5dZ0WYVRCV4a8GznBE0NY=;24:oJKik5SKsiigw5N8dV8NTcA3K+Dggy9Nn3AVx/JTBkC9gelq5/uuOegcZozgi4aY7GH662ySyeaLutqEJb7Uy+mTbH2NXdFfHy/WOtmEvxo=;7:jYNepf/E4qvaTdtLnOoyIHz5nSTDCWcREu1iQE9+9U9Swoo6ekdCPVJAZIBd0r+d1LMkVchrg4/115jRF+firMoZPwQtN9gBSW42ciAVpbv0xFwpLai5AQfEWusxC10Rz6iKl3z6idyYcOr02jJgUXdSgRKZA9y518qrmVHZ8Jlr7Agv6jWLHj8oOFtd6U605BTuBzSHzu9bsupDoTIElUZEcY9V1f2hXW46vjYPdT/8nZgpwUf1iVhG1iwZgDrt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:46.9100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da11900b-b50c-4a2a-fb07-08d5549f400a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
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
2.15.1

