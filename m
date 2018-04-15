Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8AEB1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDOSQ5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:57 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:56240
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752776AbeDOSQx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9uLR0BJ0UAcfx7zdaTZ2NY1yjJyXphcVdSyMdyrGKRY=;
 b=f2+SrfQrCr9vGVNiyDRdtQz4yEVwgnyYIsuXxRda5rcNvIDIYJm3zYgYwHdTyYf44p3R+KS6G7JuBWxXuz8bvHHHDoAz5RjjSpuG3HoY3139haHktUVipuGuj/MUHz36KRfmWDQvH0Q73peVLCGWn+OK+nzf14udqTYqTtNsEko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:48 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 05/10] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sun, 15 Apr 2018 20:16:05 +0200
Message-Id: <20180415181610.1612-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:SAUSa5fXcFEHs6REvaWyhQApwjEh9ZcojQH8as2oybsQjQunWRhzho4UUYOEAPY5TJeosEHq0Ups8TtR7Sxpz9846KFqWSolW4x1LWX/jnXZt8zo5RwcAgQnuqhljdPvzEbwvfbGcI36BROIv/l5XqkltqMErFUc/B+T7TkLzJ/iNgma5bZ2WavIhQvmyaWym52zkkR8OKzkVbR640FvA1+H5a2bsXv8TIHXxQTJZtkiwEBgh3jk24Rjsz6LMXzG;25:AqyrRcPk9/nZeGf0Zhk6tXNxNGJUnBF3wekhVZEv1GR7XkNaXEkOj1eLIiHGxThRQS9xQWGhuVE2z4we8tpu551OSKEgJ7jNrY1bmF2OkL54/0QEojZlvWFdx8ui7cS+bSNkq1EW6byWBVDdLZpc8Lq3pdki43ZEb0epIr4M0vAsZT9bgax6yyMc5N0EZiD8hvMTJS0f0RJgpNYuIZ9+GgpKUC0DrumV9kjcGTHcsn+voWm9hTUEupC6UkExKDcCnw5TBFh3SjXwJnKmucZK2BTH0qh8wwk0NwZgHkfWTa6H7CQXaRxYwwv2rPT+nQCKZMzJSCIItAd+gCuue4eKMg==;31:O3VuTrvbqEswNeHNRdw8D6wsG+154s3jv6lRhJ8Elj1EUrL0+XCubsZm+1Y7smb2b4llYEYuaeIkfh9/IMcoFobWsHbZ2Q06MRs/22gBoeLnoYkhwIOMV5y5gKVbFz4GpzHBa8jxDyn5PepnBOI83MMVWS6PySBlfcT41EmigEGVR2FwzIs0kPQEtHIx1QRBpbk9lt1eNlanSJpzuph8yCr1AdEW2A8OXZwZolYhUi0=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:cYgViQbJR0uVKHNAPf7rTlUH4Ra4Zn2qsPUakP5NYfknayGwsALvhFVNr0s2ttXVtipRobUQSeqwPmY3tR3BWRB2NSNDyjfMfH+O0fK5gRWVgJsvDWQetshXHXla7ic4gMLWOrNAJvenjZoiKIdfXhzTO0FBQzr7TUVFeBqK9nn5SEMvCXiqFBZFSkAuaT1uMkSK8ifGZDRVFW8ybQrJDkwUe5MovrqSIlc20zXROglMxJkqJnzTRkfIPvfGs23qI4q0hFd+Fq1ifHdHpMM1ztCuPlbl1TNl1ATNnT4Kg6/lsMefd/i9nBvR6PHzxAMHEC3vdh/gDQdcJJJIzKYjoVszlDaictiDA5y7/CrZD8dNNKKEMJvtTfiITGRpfp5HoiFmpFJ5mYhJZWBoiT6cQ/bMegr+TeCC+yHkoEVuUT+EGAudLVRfoA7bpXYjbvELkklW/on7VTytoC4KjIlhrOe8f683Ot6JRDFB1onltYQKD2i+Fz1McrioRVyH6nzRYHLm04nScGGkywTIQPEJ519cif04VUYDfupYAExI0BITqd3oT3PV/nQZpQP53VaOXQm1+rj6mfBkuR/P18atvXNO8D/MwYus+ehpomwNNdo=;4:DjwKTyUOHgtmMSgH+JyRjBIsLJasWYlvarHokZcLwjPce4qbWeEmHt70tf+FsYB2gOSG0AwfwfrYRnL8W+8M2W/rc929/YbC58bKdKDSlq4BagpoLWp2Lj3uHg3+sgstPgIKJNeKk3K+C9Vg0nn+yG1uZBw1/g5G0jFS3Eaq3uNZEWKV/cnX0uQnrSU5/ahgtYNXK5BV4FE0WV5r3IYndjldZgKOyCet8Zbvs374BYlg5Xt3IV0bFvu60FJW3D3lVjVEodg/f+cRhAgwP6K5a+7t1xR5ERrXAZ2Z5QRnXhox3pYJwofhXeG4CCGFREUL
X-Microsoft-Antispam-PRVS: <MWHP136MB00143D0CE5E8EAAA47CA28BEE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(966005)(9686003)(6306002)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(53376002)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:HAVHqkhOVVQGpv72+zpbvrBevUd4AvA9MNBMdawux?=
 =?us-ascii?Q?7In6xvQpozih4LxJscLPVzXJXpSyeKhz23d9sW/1NTuEteFImghoNeVUcsBg?=
 =?us-ascii?Q?AllC8jzAFYU6NH20SzwlBgozGbJAd3YR5gx7iMGyvfIhzqhOZacykrIfBWLZ?=
 =?us-ascii?Q?YtRmMluf4RQDCkTAOFJOMJ5ZONn5rE4G5YKg5jVO38P4zEr9hgPYj3yfFvVM?=
 =?us-ascii?Q?Y9+ZbWQsGKCAhUh4w74OdaM6edkl/LkazIErWvqnye1gFFlxpCP4P05DDwFR?=
 =?us-ascii?Q?9JCPe45sacv65pIInfjBJGwkQ8cX43MCU7zK+ZLeH36FN1YzNM20RuSkQC3Z?=
 =?us-ascii?Q?svM1V74tW20NSwgOYSykIrIbmGyqrT9RZL1kCJWvSBMLSk/4RZug4Th4t5u0?=
 =?us-ascii?Q?PSLqtnMdNo4OHphYIIAy4tKk0EcvpX+SxyQrhXon0Jl5Q2J8u/36vDiELpB1?=
 =?us-ascii?Q?Be5Tcdx/PRSnajpPivSuBwA45Y1ntC7a6jz3iOYmeh+opF5wkdLsx7qNscg+?=
 =?us-ascii?Q?iWg4JwMvetC4wbdIKNnLz9YuWAwt1r9dQVBc6SnTamzb0ENs3N/uilEbXNd0?=
 =?us-ascii?Q?ycyh899ppTpWsQ6Sm6Gfn9/+3FD8kEwcVcJ//wrBUPU0gbXBt0O7Bn/aIjNX?=
 =?us-ascii?Q?hxHSjFu6DEEGzoGFmxTZmbIThhl7MGw80EgiDusmfC+CFdd1BmGCEzuy7fQc?=
 =?us-ascii?Q?NoHi5qRoL9strbkugxj5VZYIeurOa+KajOiuL1W0k2qHzFtOCuntU8p8E+On?=
 =?us-ascii?Q?wQUSYVISPv0M1V1dGjeAnyX9Jqta6trHTpYhcFaHZeJq2NJjQyN2o0eNVXzs?=
 =?us-ascii?Q?sO9WEq69EX1Qu/ijUXVq8n08z1cv3vgRdbhbQ8Z1aFnXry+tcFo9IqHk7W7k?=
 =?us-ascii?Q?0tiQUOBDLiab+oPFHTjyuVGXnIPjg1+gXeBGWpOaOmWSA10RyE+Csyu9XTqt?=
 =?us-ascii?Q?khfTkhxu7qsEwrDn2+UNTvHSY1uxd9xacc2Pevt0fIUYsgpBoBog0nAfe4L3?=
 =?us-ascii?Q?nEmOfqG6x+ymfID1f3SQkeXGzQnyNs15PgGmEaZOiFeNC4t3D/PzqzWvDXAz?=
 =?us-ascii?Q?2EbI8joF0+p4ILEK9gPZ//g+21wT8/ZyhM8wOTMkGpHbArxcQPAWnSd08Lyl?=
 =?us-ascii?Q?viF/7uT1QeyeN9OKLe7Yq8LF9JWn21cow/N5+mb/xuUunVYZKmvKAajjdtvl?=
 =?us-ascii?Q?pdxPdlT1lGqsnDfkxjGOQrDLktgGjAZExHWt9iGCIXSgo4jDb48G9XbhojOO?=
 =?us-ascii?Q?M1mQF6nMM+IDau6o+euC6CGzWiNVCvAkugeVLnqvDJyZ8hp4tvMCkBgY2MAc?=
 =?us-ascii?Q?J6w7PI53u+fRDzjE1+ZysiNeMbBE52XwBgZhm5aKJCdvRG1+v/qcLVjOfAcr?=
 =?us-ascii?Q?wAR4ZCe5ozg2VmvzOS5grilCkC82FCW/c5j/2RBvw8sfydQJc2J/Kmz0tqI8?=
 =?us-ascii?Q?DzHCVm8+ZfUObIfwhCNuko3sx7sXhU=3D?=
X-Microsoft-Antispam-Message-Info: SLaqrLeBvCWCeZKcq25Nkb1t7waaATmfhwFSa2feSuEISJ81bgik62VjMdptpLVTUiLy/Kzq+x22yIgqwh7qZXbgT/kUnapxi7nuMozOccyK4wgpBigJFwGp5rhHR2PLGlHGC46Lbmcug4bErrgoYMisqgtnjMZm1GiUau1U5KXq7U4RMhN/2upuz3cOhiI9
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:QR0W672z+1N6ZB/343iIOM6Xzxc6n/ZaT0fx9u5vP6xSEBMk2MNRFLP3bvTC7cfOYOf6FhnuBXa320N+T1ALRon7rMqPDJ0m0cCDX8qKQGiR1OX/7m/Fn3l3KeSOSGYJEnWaMAqeFM/MhWJ9SnfvQnpFAku58QH8o+qP/75rwDyy8DyH8hTifzUeefbIAi2iGa5wgKGQk4nMZL8foTocSyiZ8h94ef0tE4GxKX08POaKAVHzf3XWC0Rpc5RSatipikemrlSAwiiSGktTkTuQVWTLVY+vTjxem2B3i9jtvBFtcotsQTHrp87QVBPdkANwDQHazSXtG3xKU2N0MTcBHRK4M7k1r/zoVXroDPe7nirSjGzH3In6c5TKS41ydeeCFFmwXsMUr32AUXxknC5KtxhOlX8uW2J59ZcqSjiHhB6Rb09lNEtct0ufy5n/LZ1I+Dt0tCITdU+1Q0nnnnspFw==;5:a2209sNts9sEVMl1tS2Ktg9tuQLBFIU8ByxoKU8gTZwQAHKu2IdfXICdrSANCJuwXSKydqCT9xed1FUdzymG9bJPLOPLU3/CS4SU4Q0Qkz6l21tD9w1flfi2ter7N/5E+m/EyeW3ZXMM/nscIue8utgwIKDGNqGJMMe722JI6jM=;24:kk/12p1XFVRLbEP5fm0SiNUS4ggMv4/syblJlWeXrivvSkhLDXt+3T/hmo5jcTAuscw4wN9J80es6zoeGXZuJDzYATOcLl29wlTwEDAKD8k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:TUJHFxJ1Rwpn0h9RjJ9Jt31bw2TjJc9LokngTFo1G8GzX2WSNdT/Fe1kfDn7Kd0JgxWZYooUo0qktUyGY6eQH594oR+hUKaSBx1balONsRy+AAMDuR/4tuCjQJXbbHy8INQJ6F266lxQNLPIJ2EUHW7q/jtM+FjuoJ6UuClrFxhQiO78hvVfJ+huuzasT94kqJwPizvSn7zKvQYZemMV2Ic5VIeC33SkmHxg8XYoxjK6vedAQV5pSufn53h0pemK
X-MS-Office365-Filtering-Correlation-Id: 7a5562d8-e199-4fb7-1a8d-08d5a2fd0f99
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:48.8034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5562d8-e199-4fb7-1a8d-08d5a2fd0f99
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
index 40f4b142d6..83af3a9f6b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -560,6 +560,32 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
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

