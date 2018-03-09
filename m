Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFBB1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCIRh2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:28 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932327AbeCIRgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jJSu18qaUBk76O1K1OvOmMeKDEKn9JDv2wIyGnML4ZM=;
 b=I2S4N256g4QPgiUrWsVsPPvkkfXpQbRBCiN6XBRLq0Uc0E1DLChJ77MWDdOlsQ8FxW6MFYzrtg7g0ALOV50EmkYNAI2uH+mLv8QS+KIvm1FsZVnqay19G5PjNvp8MSB4mSVHt48zr5V0Sk2H7wOEQQzknPt9s5Cy9TZzNkBB1Z0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:03 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 04/10] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Fri,  9 Mar 2018 18:35:30 +0100
Message-Id: <20180309173536.62012-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35fcac39-81ff-4732-ebb9-08d585e43cb1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:6/G2HcpN5UyPO10TRVklMFZHHsg3r2Psm3mL07BB8UwDDKYg2hTi2h7kLW8ySlAm2DMQkUivN2G38YVyAWZT++AMhv7towWKXY7tBHc1W2SPEQ/bqulZQ8+0uCVho9gY/vQwSgqwarlrGgJO9r8kzKQEoW4JBZ7zddTbkjUhlpVBok3RVhJZdociYJ+yg2eIF37sELzjrJ8nVWjh6IHOzu/MBAqAukUSb8nGwRQhvHxDoCJUybueEfOjk/0SUUfp;25:HbLhloKRlFbaRLC0bnrbIlh87j718KaX2wdsuFTENqloYkXMm1Dt0CvH7LvXTjKum8e0iMCK/kCWaBf9cWhtN4e/csTGV4wTNR9IWX0YK2vrLao24HEnj3W9SEMLcCKyBpPjLNoGV6Ipbx6CgXlRy0aPiQmwcrWxzUnvTmBDYeTA7XlwrsOPtCnu22PmAWgBR8d/L3fuWqcV+mHBBP/KYBkMb+AYloI7ov8ku+3XcdfT9ZHGr3a8Sgm7SaWMRqNSC4ibDV/rqw+dEdhSZG+RBySrhzQuXjQ3oi/zjEcp8hONChaykB+NVrGeNWQY1A8U5SWZcXRQN9G4dGkiRGltSQ==;31:wB/39PYvgAaqOxp6T7UiZWsdQXWUPh1fQ6GXlG9CWWwk/k8SM36gBGpEzxEMSADTRcRwZQTNr/nrNYc9wt6QqTk9TnrUaiGo339YIRjtKIh+xYuwsnfDexs8VkcGpk5dteIlMC9jSEXV6vWgaGHVJY5vB4bccFh0fAyYTc0YGsXrtejuquMhYJgh6YkbpBlnoQXiHmMIt9QwESJA/1ZKRajXM3DMNDRwZrk9ZYJpvAQ=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:c/XCTk93hLunSV+XDvF8I+5usnXPejzu/F40DdCAV9Lx6bi5CzLSMiXOKI6D0mAP1VRg6RGGgMowssbalD/I53TY4e5zutMGYQcfHF6MTQLYgOUjbcrWiP6J05kucOG6TDOaqy8ImoOSHWRKl8gdD3jVhXCRZegJYuf1kOGYQDpLnh+j5ubu57Lmt0UbxGoa9MBMOhe3+PZT4aL5Uv0tiYRRWozFker3lPa5Eb4k6qmZfa2IR8FOH8C+Lijmg3nBrPJzwKj6kRzme6r6DsuKTf+dlVzQ++8D9tmiDlXem2RVwxlLQVUJGKUa2giZf2TNoggjjno25yuEOUrU4I/TEQKKkDIYLZthUTK5KyOeWqmzlCjF86VaOBck1nII3bZsirfYA0+XxpeN7oVvqnp1cBH6PjsSXirqyxvVwgEZbLcY9ckbEYxQWgsg51DESDoAXbDLBMsiT6kOZ068HTzbYkkaxiasdpoeQ63XubzjDUaj645J5lQixJ3akTGkDEXGhAer/0ymXmAgRANqIVuYXPXJk6UICOvAaqr5q6WP0THQeYSFQijnrNSQf+tCGIOyCY87ziC1c060q9GMqUX1bSASfdxjs8FKD3cZ5UfgBek=;4:HvOT+1Jb2BeEzCtAN8DrxuwMUavMV0OFCUH/+q4pVrluY0axlgQKGnkuN7t7XVCOptmoCriUX7Ki+JJrMk0ZzlxN4XdLumPV5SnpeaYk7hIRCrwwK5l1F4l34mDhptzzhNtH+AmiVVzl4Uq26B5QPV5CtqQ1/pe10tbffoowDwONNaZw7Aai4oufPdrXOUjYVYyzy7Cfs1XCjwC5oBd8C+IJCXWIPKCqAeI8QKfGA5NhnKglNl5SgnBiGAOMU+ZsErgh7N0UKTYAgB+I6bRSDn2IQnzu8//CHoE+jrboh6eSoUa7wvB/ezKSg/7OCYOo
X-Microsoft-Antispam-PRVS: <MWHP136MB0015F72971341E9800A98433E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(53376002)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(6306002)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(966005)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:4Gsde2dkMWcvLfSx5bDFYNShnat3fkGeSFUSMTXVB?=
 =?us-ascii?Q?5Tai3qMsXgjAN/1OD9G9xwAahlYffPh8dQqXFwnCS1YTV8TV/+hQjpnskPsz?=
 =?us-ascii?Q?q4HpC+6ALZXQBuFUC1gcgG6XKxQNpIhEuQ4nmqKDPvsw6aNxyUZksfJkZjjH?=
 =?us-ascii?Q?kHl/YC5UskH80x8D+dnlIr79k+sWz7Bdfg4aAKhXIFn9VOdG8pjUueyptHv6?=
 =?us-ascii?Q?k75ECEtzHDckiBgk76tox7xrN8jXkzfvWMWnaXUuISPZbdUuyNyh3r0VUGqK?=
 =?us-ascii?Q?qf0N3oJ4xHx7AdaKZegWvaImjQdY7siotNAKCxXIk5cycQnPXmgvn5JswGNI?=
 =?us-ascii?Q?RwQ1ARgldnA2P8pfTjz3IDd4Y5uF4lfVsg8uE79nAo0gna68fKG0BSwlY+++?=
 =?us-ascii?Q?l8phLDa54mIubUYXrCTSpG/0ICkiHAnQxoeWGcd9O6u4QBDVKakH36wUt8D5?=
 =?us-ascii?Q?0ZkzgEgJTotolPlQ7XmNczpKy1trqReUx+STk8FnVkQGEYkzU00/uRpOuero?=
 =?us-ascii?Q?d6Xa0ODX0tGWl1jZiVbqVRHXO/s0jsr0I1ZdA8LpMVFr6X/T1/E7/1UVeR/+?=
 =?us-ascii?Q?gFcEI8gZgsTb6TQ4WApn7VGXf2EWxjL/Dad6ePbtpCCcyAWx5B39XsCf+VzF?=
 =?us-ascii?Q?T03VJhTGU9wJ4OVnwCSuzeuyFYYSHyBTYp/mGWKYBoAwFRu0GZBCr6/u3F4Q?=
 =?us-ascii?Q?NHPsICm7bokuPRYZAq78nDnTPGwNmJoSBifgt/iEeSNWm9kT9ebux0xqAk9b?=
 =?us-ascii?Q?Z1bAczi2C19nKCyVsJ6Rn7pzn3q2pq+IeJK6bjW0NF/dWeeYDkCf7azNl8Zo?=
 =?us-ascii?Q?U/Fiwn+F1+KyFU1oCTDrwIltXSjvF+Ogo9k4eVrl63s2yq+FFwEbTknTuYPo?=
 =?us-ascii?Q?P5mRLz28sy5Td21nt/NvrSPRvTWWIH7EiERRfM+yidkQukvbpiet8YPLb1Ig?=
 =?us-ascii?Q?90QQ4jvI79NYF4ZJFeJWPe19Qo6BlIw89s7/IefPpESKO6IOghCHZrnnd526?=
 =?us-ascii?Q?OXJOFgAjIgKDd++iNGPbhZJZsXjXwpEaC6Cfxdx7UihCSiWGgZsBYTBj9sCZ?=
 =?us-ascii?Q?JpBYtO26WphZvcdj8ftmcnv4Ltr0IpvM3vmAMvJkp2Gc11AdieTiBTKoWUhW?=
 =?us-ascii?Q?NM0+e+mqFhra+iLGbhsVy1oCbgLKenpa+JdQ2Q+8nvSKOJcSK+T475++5VEm?=
 =?us-ascii?Q?x63JAUMvwMAoOj0jXETCgbh2MJ/oip1o2esoUJH4/3PCXl8AA43iqcxjbIl4?=
 =?us-ascii?Q?4bHak2x+I4um55pTL5GjswI2m/xCxqPyKqZGTMaiO0bKnTWy4eSVqVzS8ZVe?=
 =?us-ascii?Q?LENIe272zme8wREqrhEddTIcLqt7aRgW+43HkWLkd8B+QhOGPi4ejkbumH44?=
 =?us-ascii?Q?Y8OYQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: SCrRL0f97JusqYbIho87zzo2seq3ATbKe767+LNwWoE2EdZju1GWv8E/8ujQ5Jr7s4Xm3UeDij75b+lct5zOUHGmHyQCZNp/7shW9I8gOqN2Si07esmJfa2bUoQh8+VK11GzTQcTxxGZnCffNboALj2ZAFeHVRkJ5DXdEjOK/Y9o5EoXm/Xb5kcYxud0XwPw
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:AhEhHYZQpbHeItvcMhmm5hOmDOoOamzmFuCn79zL7R3aQYAqgU+hmgBMv6KhEgH81R+0kUDWPRNjdTiOl08Gp7O+7nji0tWewaH3MJJqD49HIAQq1j8PL/vrVM+cAc6Vyei5aQZIqTV8dwOx9ZmZWU1wURr79Mo89GRJJA67rgTwCPc+LJxpn4R9i4n5QO3nEbdQxWeKQMf0KlqMVIHaUas8EW6EaojTgQ55unSXDn5Tmp03KKOyKVSpqyFlkwbFNGANyF/ksDz6NQooWOd0fOyxUHcTDbYgnyZkyZhvLWk+unK1Ikb7K0LRhLZL3Uz6u71bQz3l5pJErYOoBHP+izqPKaTFiT1qj0Mshl1cuJo=;5:TaxWh3RDX7wt2EfqHvvQh28MzPLyHdIb+zMb22wgYmZVep9rFcrP9UX/M+UMrJfnAgfKnoibh7khbYIOuxQWuFeYLN7gpLPsosZ4vH28f1PEFTxjqidT5Kt+b6PVhflOEqBLwSiLcDAitzBoJ3j3gFHxt8EgRLLsfqLwRFRK4Y0=;24:jItGpBksU1HSbDPUewSMvgR14+WSh/fNnLC+8eMlf4XJ524XC7YhspB9A8fHipiWbOueYMrRwXawunr29qEYIDJ2NNCM9MxrlqnypiwCGoI=;7:6aUs9SY/TK9zKs58Y1CUFfen062Z0j5/ZXE1ok04TTgY4XedlKXn28MbETc8w1hw9z4Ra7S0JAS6MS0a48rEUDc9qB62Mr0IbX3hKiHO1r56teK/emKU8F8xWUPPpS9HxEMwWP6xaJ47AqUSIQzb+OEtj8xdBrxTgnTt/t4lZPPU4TVYErKzmIRSl0oPi58/71vWFSVMTP/8eSrM8duSnLwkGnSukU5miSymPcVN/WwxYVs63kllDUY2a9/Fcss7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:03.1217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fcac39-81ff-4732-ebb9-08d585e43cb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
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
index 2c27ce0137..e4b99580f0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,32 @@ char *reencode_string_len(const char *in, int insz,
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
+	  (!strcasecmp(enc, "UTF-16BE") || !strcasecmp(enc, "UTF-16LE") ||
+	   !strcasecmp(enc, "UTF16BE") || !strcasecmp(enc, "UTF16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcasecmp(enc, "UTF-32BE") || !strcasecmp(enc, "UTF-32LE") ||
+	   !strcasecmp(enc, "UTF32BE") || !strcasecmp(enc, "UTF32LE")) &&
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

