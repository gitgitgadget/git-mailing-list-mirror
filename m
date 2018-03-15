Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BB01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeCOW6R (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:17 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:64144
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932589AbeCOW6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uf3vTfh/BaXe84jMyt7bAARZwmoi35u34ndAe93mKB4=;
 b=N1XhDG48uE70Xmq9f2YdnZnu41oTliNpn02tiJ7OHhFEaY4VN5k81SmRfuPAvZ901xo/eQbHRGy3EVpfjLYIsZrwuG/VYQlXFYnsDJ6ZMHxZDwc/ExGru1vhsHMN+bw2afSNXwEiGi91VpgdeL4pYUCYeFQrn+t7pPRAniUKFiI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:09 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 05/10] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Thu, 15 Mar 2018 23:57:41 +0100
Message-Id: <20180315225746.18119-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84049be6-1d04-4379-fa2f-08d58ac83a9d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:hx42DvmWkp6yM1DYMxDnHGobR3cP+jRUFSmm6gsRwMR6c8pId1sWaxC2/BHZUeMoJX1joLmf3PaDz52rcCmh//XR/KKsKW7rOfl6Ge70hegKzGG7bfaBHLksN94+DKOmcDT7Kj2/FOtjMC5rLTtMJuBEw5SZzhA4r79a/NW9rYCmTOAxf3X3m178Zy/Jkr6eBJ4cVLuiH72WpLnnpdnLu/SMVrTZTnTJ17Iuh7NYk9jtaxmBnl3HAgez0Ph2SzOj;25:myfhleMEdi7QR2nC82Abt1gLGX/0/mg7OSaA6SB30ezTUBCorqkTfKVyBeD5kW8FwrHReVH73LLj9EBYCwEMJfkpwED2rBV1p7+o4wP/Ib5WwW5dAcCyZAK7L3Yxn6v6WA0799YoTvnXmb6LZLk9h70YutUQsTDLb+Z64HCskuEtsSg8xa7EBuAASrIzbjM+XmYxDSvpyxPAp6xWctzwob/6arL4TrWqSsu112OB+3bmKMiJETt0chsaeFYEvyYQVNlIBDKjxKuZ2SIAN1SivfJQIMlnYJrhFEQQmW4At+g3Axh4VGiArf1rRoyhq33RjvE1k8XzB9qGQw294FRJWQ==;31:tCwzIBTyRZKo5dKrgFCJLFVAHk3jJB5Zs8UI26wxUzadxpPVS+3xRCmq00JhXly7pnyBRKZzKceKA5bjsA+IwTVZtXgIuwYaqE8CANMAxNNaQfDKsOEGJV6pgjiHwL8Www6k6Ip6zKfLYyTkKQ9wlh/GI2d+OcOScAThRnobw91VN+xWnR7C0vFlS64n166fZTPYZCuE3WuQg/+T6aMKHL02aTrAuL8m86hnJ5lY0Tc=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:xtwfhKgb4JTfqBPedEACXQC55kXcwgwonAB/kGyj3cL/ySp2S+x6GXcy6Iqy0V4hQNUFlY37BWq7/Lic10wF9/7MKD0YtWdtNHMqfyql7hCqxCTux6/SH1KykCGBCXAUuDCurH/G6RcLzT7jFilgJnpWm5znAnLlYyOu0eqXz2J6wLnn0RaXOoPPVY/XcMyqHv6TEhbV6hdR8lV4fvH9CH7dk9VhmHQDst1eCFjrHk5kJd7VAf612HDN2laFT8pyMjpY7bEjdukfmXVwPT/ctdHNWRNbloLGczN7+Ka/46LFawkQjV0Th2hZ22wb0CZSQf088i2go6gQtsgIeH3iCd9RDIBSLqF325sColj8OwYl4WHzwjmND07B9yPff8O7TDd85NmGyeYxitr/liAw14x9Byfiem9r4VhX2l3797JQxXW3r5sgyz9O3HKNGaPB3f5/jRjZyRJbWGS4HPan82ehY6ZuDfUckHQrSv1Tk8ttDTbvJa3C2NxxZtUKMiV6+AtESyRyWRGDwK+ptlJBm2W9vWANCdooRK6cM7f+sz60o9nWMh814pb7D6KXTlkGBIu0bFdE4kCqlcC9pvxIgeIuztMYk/xf7gPXKzZXv00=;4:9hPpMGj36s4u6yYyc1HEgKcQ+qERVpu8O2A4e2SRZnSsk6S07O083YXQgX8VdWrpyEOAtCSRc62Lj1izgJLq3htoCkmMklwofX0ggUL3NlABcE7xmtOB8ZQE4cSQP4m7jPUI+Bzspq54Lx6uRFCq0BOqFdZ61wzUDWCBVlnAT78KdOEY5SlHLcE8MBNZviEr1at+PBdIPGF6TnRz2C/Ao6yRZ1oMUnOmbQx5IfiUIP/NDs4QMNCL48MjfZyADmrbT3c1zf24CVI9w/iN4OPfIk3ryjHElnT63+FlZyk6Gfryv37r8ozv2w8vOTeP++NK
X-Microsoft-Antispam-PRVS: <MWHP136MB00140ADB1C8783ACBE7EB373E8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(48376002)(386003)(6306002)(86362001)(8666007)(25786009)(59450400001)(36756003)(6916009)(7696005)(966005)(6666003)(3846002)(68736007)(6116002)(2950100002)(186003)(66066001)(9686003)(50466002)(53376002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(76176011)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:irW+ooBOFB6iioC3AE6BWPl2ohkF/kSNdpRNQswA9?=
 =?us-ascii?Q?X3bfRTmhtR2QqTkwQulCfbq7EYdwe5adnl9IV7CzM3WZAme0pZJ2UuFWBjur?=
 =?us-ascii?Q?e7Dknke9YEjB7uYP9dRmaDXCDdUQN66YZDpwaOflwk3gAwtUC1XFABPLARSF?=
 =?us-ascii?Q?urVJtMxMiTelUhQF3A3xrkRqoItfwcii/oBoH2BFxyZskxfYclofx2LICyZ5?=
 =?us-ascii?Q?WBEfURvE2Qaw3uQpFVMdh2cPCJntjAHuT+OZajoiFtmEXj7nSiAH7gcbl1AO?=
 =?us-ascii?Q?qIBnutW8VT+19Xym9HIOgyohGAd9HRuEGmS6C4tBjd07ZHmEI3yQjkUtzArh?=
 =?us-ascii?Q?c4NuKMrX/nbcA24j7hQOQ/Ruck5kOVQrDibeBO6FPjMZ6hLJKLzX7EZgjP8p?=
 =?us-ascii?Q?1xErt2N2D0iU0fu0VgZD4kb4HtB7Ke0N5E66dt0CBXqqZq5HP2R3TjnOXrUG?=
 =?us-ascii?Q?Upb9OuoyK9ubZXL92Y5VrPzVjN0qTlTGLbfiU0we3ekjxLUAIvI+hq+4ZSON?=
 =?us-ascii?Q?uD/S6foAPlthBgyMTgym4UQ2seXbqyVVYDkC5hf6vgpKuF6o+c75Zutp65K+?=
 =?us-ascii?Q?P/uMwmrD9rkOExYy3Oim+med9+h8I53E71Er7v4s47QbHmg6Cq7y5j1tJT9r?=
 =?us-ascii?Q?hz+T3gCLDM7ei8ua05rqCVXeOJMO7cCtfkBLNnSI1OaLzat1+I9MSGMEZve7?=
 =?us-ascii?Q?Bq2okd5rvKlZASTh1DXtsnLEG+3wO1/iuXmOkalgBBMSr2aFhsdg7nvMPpb0?=
 =?us-ascii?Q?efC2y5Blf15rvHLFIy9DCTKF3kZ4jt0HLObN1fkDHjtxsMYFARrQ57jzjamX?=
 =?us-ascii?Q?BeOEcHMSvQaWmHQVwUF0Y+ZEiqQzfL5+yQ+EOh7olO1F6/e9mXlXExfabouQ?=
 =?us-ascii?Q?CpzKpNqCA3qsNvT/QhGGraio2q0izX44P9NYvA8IJIj83d7udU5uphL1jqLA?=
 =?us-ascii?Q?od8Qj+UGv29HQnqW6FgvikOOh0kO29ojr7jxdtJx1arXyABsynD/hhnqstqE?=
 =?us-ascii?Q?MPb5twnsk7zogSVw1jyorAT8O3OV3tUcecOY8SyEiD/VVceKSwBctA7JTHC5?=
 =?us-ascii?Q?H+xjWdwyZFoYu1iKRq+mlQE4IPBLGX9o3HSeE+WwTc1O51hjOeqv5k2+Pcls?=
 =?us-ascii?Q?ANtBIACpTHtawqHe2DA+wso237+y37E+ZjR+b+/JITAhzzskqeVuIbpbCqPz?=
 =?us-ascii?Q?LjIhbdnRe+hG7Vaa/1Th7Ns5Tsich/Ino0B4Xsdh+94AXYbTfkNyuu25O66c?=
 =?us-ascii?Q?XemPKbzR0aX8O73GNHq8u2a1Lk0GgytZvIfEgUdN1m4C4tPvjHD2vWm42onk?=
 =?us-ascii?Q?6prSDlHwJxkxtZSe3mYzrb6LB6YOtioLr5Q/II/jF6Hb+GcR5CXlEi+0nvFZ?=
 =?us-ascii?Q?s9UJg=3D=3D?=
X-Microsoft-Antispam-Message-Info: H9taD6ynrvrPvBxfDTP6+XwQAVIxpI5UN9jbZULJX+m/To4s91L9I8CX1pt+12G4BQwyJY0xnk8NzDCWu1obwdqf8oCuvnU+cn9d05aqgCzywLS+jRh7jz/XrEpKA28sVYmys6iMxqeuvJYBb/+wZVQmmG4o5uZ3P4pm6VhiBWfQ6qUCDM2jjKpRDxvnTl8u
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:i90UjdmaMZx2+Wrv2gIW7B6NUni0K0u19jjXFEcRwqQK/hMSUp5V8j8jO1+ylpxiYexNlFa+YrJzDMxgafsyBKz9PwreC0HoEj6mbJWxBdHlEfgEfuQnNcpa53gNX4yWOAL0X01gqfXN/e/OYBE0IKCVfHw1lyvgddGGBEPlITF0I7loADTxciDiebpVTjc5wh3viyyZQzzTPU5rE2O+tDli4vm4J4EuYSVE5Sr2vBc6tfrgKspO/12xhz7j+Azp/xBkpWZ7ApJfHsf+ylpVvVXa5rR0l7xbzMl16IzOTQMoNwo4c3RnINLb/BD+jSwisAIkA+ZQN7lEwDSDToKgjReMLA3V3Y83HstZCTZMDgk=;5:HS/WBqDupsw3pCXsElewDtR/P+6Zzqb6zDZefGXgwWvGbx4DYmAcOX7GTJjLWw+Y9Ct1swc2FUSCMp4zogOUpFdlGcYsKmQcSrcSASG+teGSgJli6yBdt+OKM25skmPjIbJzOS5J67GFpLfRT6bVJqbHl/h+gWEyi61JadCUU94=;24:hcKiBwd1ue8MR1btk74wGZxuQ8AEHCwVnOVkTp1391gYwczEl2mQ9+GSd76vU46HSw50WC5buW5GioxPFTKEPID0UJN6jidxn2YinPjOfko=;7:g4ikn2tKKLm4AHCkRcd+Gi7kD7Ccc1EB+bljL1XgWhU0XeBRRxO7HUr1bI4s+PRMWH7jVkD8u/QHUNlE6i5gDuWiulQcSq9Cyj7Vg1nYDP2tbbIQXLDFrhBBNfs8qKQQ5+8Jw2N2sdbrTs6p/PuGnZjVzOajWkgatBU7r9i2TXz9VuM0heHymcJPBbrqsEEj8NHolIbrqCmaR+v1BA0+oVk+4uWDu1TmhsSS0GKD05D+6/Ask3aDYVvkxnCwWKrc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:09.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84049be6-1d04-4379-fa2f-08d58ac83a9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
or UTF-32LE a BOM must not be used [1]. The function returns true if
this is the case.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#bom10

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 26 ++++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/utf8.c b/utf8.c
index c30daf4d34..d16dc1f244 100644
--- a/utf8.c
+++ b/utf8.c
@@ -556,6 +556,32 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (same_utf_encoding("UTF-16BE", enc) ||
+	   same_utf_encoding("UTF-16LE", enc)) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (same_utf_encoding("UTF-32BE",  enc) ||
+	   same_utf_encoding("UTF-32LE", enc)) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..0db1db4519 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * If a data stream is declared as UTF-16BE or UTF-16LE, then a UTF-16
+ * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
+ * The function returns true if this rule is violated.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.2

