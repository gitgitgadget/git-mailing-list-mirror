Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602271F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBIN3D (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:29:03 -0500
Received: from mail-dm3nam03on0139.outbound.protection.outlook.com ([104.47.41.139]:46483
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbeBIN3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H/6dn7V09ssTXT3ty8VCdpFYlF+ZypsTpACVpF1dCoY=;
 b=T0Z9zfoRqiRqMxasbY4Rru1UB+JSkI/r/sTN032vZyQP2eS+mfPsBP4R1ANfEqmdPY3Lq8iDwb1V6oFN7JI6dP3ck0zAGJUJkHQuXaVs0AxxFfj5NPWhfS25/6tgDFHEWGz4jni23k0cfDt+ITrlDJK8aTFml3u4YI7TiEq6dwU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:28:56 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 4/7] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Fri,  9 Feb 2018 14:28:27 +0100
Message-Id: <20180209132830.55385-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209132830.55385-1-lars.schneider@autodesk.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DB6PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM (10.171.79.28) To
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc9df66b-26f3-4633-28ad-08d56fc113c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:rFVY6W51Z+W+uzwqwWB5ssiUyKj829ybAbZtDqpIbbbUfbgSmlFJa7XIoX1zN5bJRXB5h00SbkB9Jr9R/1Flz2yRLK9YaYE8jlqUl00w0DO+a3BVXij02t9lcEwIU/SWta7RnYs3nrtFUkWLrPCLinZdLKgjt7TIPrGB9eqBS0b/p2gcgSWc8wrnp9kyioh65KPV7qAPNaJ6sllm8py1Kj4kMS/v4tK3ySFKvj5Ab/LONsFKwqlpGMX5UMg7q1OY;25:l+pkIzlzlZk+YCE6C8hWsi6HRHIJ5SxJAMd3/GdSTI84P0HUdMtUfukPh661/bCeiyN0nbunfu7M8aRNPde+JZovuT4cQnCHeY3mW105EyoVocRM5QaINJp9DsoVamD62xDedyBZnqCjI+w5Wp5WPtSw7KwjfJ44YX5wVI0HSG7Z/bc3dTYGs2G7k/B/8mdKsXNbD1mp6JP/iyLNc2bdusrnlrxY8HhwdaT7f971pYb9082GJuDp8a+y1lRK+Cj4ZVxVvL1BgYsSIYTc4nbCINWuzT5m/p8CxmHMHXK5aONgPs+zGhu7aBZseqojvy0+epgHKEr2hR0wDAwRCh2YIg==;31:ZUPg3DetjAv7yxXp2l0GMcAVYdzAD1+0n07UCworFZ1OCULFK8xpiKzDLhHbySPlrM32kxt9xSaRMtZUGOojoQQN/iwAU43RJXo9Z4j74azA/Rftxu3q4k6dqj9Yy1TUDzcd+AhuCQyBLK84kLzwxQ4npjnkaozGFU7cjcCkE3twMy17JRUsXVwYbegTgOTp50wnMUSoziD1gmSxVje+OPCCEZr9UTms0Qvu2H86E0E=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:m+B5SlXjYnTz5l2iYFGLhINEkVbaMyCpBlsyTfrIwDKT3kbeJlfghQsM6cWAqPQnIFh8Slbaz6K1+UkUgdhO7R8rO1IPvImOc2NkQCvL4z/6IkuDTORhJPIxVcL0+qoJgDEXYX4LhpXM/UeJ2Q7YpNLw8J9gnigeqTM6qmrU3gRjrtYx9BniW8dEux9vyYWseby7fbWGaUw4s8HvbvIQMG8xZg8lj+BibWzluNCnP9IMx3iOKFnvn4OHLwS8BAcOymPw2v4+HWTsVGN3l+BlAVdC/Z68dwQjc9hu59JSPVcjy8iCaXQG2cqut7U0YcXL/vsGUsbkseLgVVzGphRrusZXtchv30OagOQrcAZC08ZZnlvyGgKevqseAelVlAM+UEeaVu+5ZCrnEW6BC5gN7SEd3g/CFXe7r7zsvY6epjNSJj8QXNkmVv1aQiLVHvKBb/UopvTGwxSo8l2GekxjjfnKFqDYmhghiuiNA3gqHZl9/ONzfoTSD+Oqlv7/0gtC6XrZIc8MjKoacSQqTZ3s3bF/1cHVeb/kxElD7A6cd6YBzE5lqmUQkPpHXKabxtOwFGuPdWVN3+pF7acX9/WoYcE9zQR2qZ9ab2d2wXOdtOQ=;4:UFAGNlrGtT8zcU+mHTjiu5drse8qO5h9itOKQtzil6n3ZeaIqpEBLVXxgDf+YOQZNKtv1VdFWUS0bWKyip6clT7IUZZzla9Ha1SXO7vFMp7st6aaBllaCcVcUArWnT8L6bh+U0aGCRlm8nILZoGWqVtXSztKyq50KwtfRpRtOwfFXU/DncIiohN1vCN5ODxoveUZNyLfPguyv6PExUqA4nvWHWG3OR6blb8ai1qmrbq/EsGymvu49OYf/b/imH21K9P575yS7JVfRK8BJkCDzedIcqH5J/9mNYkM9Cu8XCI40MOuupc+F7SJcl9jBQRN
X-Microsoft-Antispam-PRVS: <DM5P136MB00288B9A186BFDD38C0DAD1EE8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(966005)(86362001)(9686003)(1076002)(2906002)(85782001)(6306002)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(47776003)(6486002)(66066001)(39060400002)(53376002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:ea+lUwH/VvpKrIfbWfR61rZtFqExYrtPiaTMbJhiA?=
 =?us-ascii?Q?SFFuUSKgQt34z4h2j3tezj4SSxiBPuNs2xw+1JV8wrfYO+0t8FG6ijC93Jps?=
 =?us-ascii?Q?2Y39nK3MYvtY8mfXGeVivoIK/quY+G4z+mE1lL4bPK5I+06gClunUGqH9agB?=
 =?us-ascii?Q?7lDBzzen+fXC07lb1zLbK8Rye5gNE156YhQCxl2LcGUlNwhdfykZsZHV1UIs?=
 =?us-ascii?Q?QZC3i4U25P8jnk+YN1IFhKnKtY9+A6WHTrGIff/+FGMy9HJpZkYg8Pck/2os?=
 =?us-ascii?Q?IlvTDMOykRQ0IVtV4hzRcLMZHCEX7Yr7bfbXH9E/x+Z0f6fjAfTfcfoHFTFG?=
 =?us-ascii?Q?8tnJkZb58YMJbyo2vpdU+SI2UwKwqDIuLqY1QBY6zhBWCO3UBSbFu++v2bKe?=
 =?us-ascii?Q?RhJjqhi6u1owquflqZJME/uV79Y8vX9Z1vilPto32YSFDzAuBP7i2AJ4K+89?=
 =?us-ascii?Q?ygPQ3s1elv7SXXOeJjQvi9QQe4Fi+oTibVWqlB2/KFaNrNHuspBs2/p4Bkrq?=
 =?us-ascii?Q?fIVO1rhPwWWF6nVwCIelFjjL41EeFOE/UCjiFkdf16Lfl/sNpRde6WFX0689?=
 =?us-ascii?Q?Y+sNYxHgbZHI2Ov+qtd30nEAYPam+QmSWjq4aJKp2R7gtrlAg7PwyciXMivJ?=
 =?us-ascii?Q?+Ag1FdK1rAACzosBPFEWKwb5iugsG/5Acnj//I9h0Y3XupQuoP+L/0laDS6r?=
 =?us-ascii?Q?l9CX8WLILUO4z360aRv/binLYRo6Dk3jMs79mIQinNzzzhGucr6xwMvs99Ns?=
 =?us-ascii?Q?O38HJ092vN2fAy7MFlr+Efw4kDTRgH0IDhQnHGOMVvPwY7kdVwI9GuWmpNJ6?=
 =?us-ascii?Q?evFLbjapqsIToopQWhYQ3zjUOxOQWaXzJJsXFfPS/aLLTyugIP6lOM8jx986?=
 =?us-ascii?Q?pXd8AfXDikkR8wihG1Ft5bFK12EQwVcWhyzZMLRvBkrH5OKmUV5lzMiXs1sQ?=
 =?us-ascii?Q?qZjofY1EGaqVg++P1616SfY7/ST9QiCHddDW5u2AYNw1X/yMNMRm6UgedDIr?=
 =?us-ascii?Q?K2EgxeAxzedFVe7gKAproSHjhPDAKdWp4658jHJGqYnfpgANpVdHMDofLveb?=
 =?us-ascii?Q?FwMMmC7PoKnPgktIArHiiUUH5cWvWbzxpyd1/XsL5M7AyKqWZzp0F7ppMsvb?=
 =?us-ascii?Q?iB3EEP91cnMiAFGbAB5jPCvhFXzyHDljR1Z2DA8zJByCmFsL6FGF+e0j7tsF?=
 =?us-ascii?Q?UZGs0MJrPcjvC7/xzJ2zMHRNl6Cp1XSups7fl0uNqxesmTmvzWcpBk+Xkr2K?=
 =?us-ascii?Q?fmpmrWid/RoxKK5z3QfwS9pr2PgpCSxSb9yzdhpFYepmRQ8gToXWsA3fbaX+?=
 =?us-ascii?Q?xPSVfXnRXJ8goFEum2JDiM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:5/oXdher2l0ERdlulp5rphZSn8m1yqwPD6WfdmPKZQuEG0qNVB6dk+eXkBSB9brUeGhS9H2o5gfbloiKvD662tqgn3+v2cvyFMsY/DK1npcq6RqVsa+WuSW/fVjTsxSegrkYyzIiQSsbEf4B5/W83Ab1L4NqX5R/+y2zExk7TwcpDMv7IR8Xp1XKSeFzIE10DCFofrcFcUiYQL09lOLAyiwKWjBw29oYu0bbsQ55wif7NpRb43XsQ6nsJckqEViaYcw+zJ+QLjVAbsTwA3GtQNV1X9Uzc03WhI7dM3+gpsj+XwUcgQEtXiuzwN3V4sKYSHjWfJtdNs6XplbGnGCTnDEF0dTUjLW6ggILObKbOsc=;5:8cynLNlXca9qbyFcev86VtlzZNzxTQs+B7RLCUG1hy5l+x5pb+UMYztSwxCLrvq70tquVjqN401/YptDIEQCNmJMt6Oh9dTWVsz1ORYzCACDdmWsRlV4DmJXU7jQovkmCHbpccjKhvT2mP91rm055syo7WRoqHNlBkTeukVtjU4=;24:J0Z6IRBPrFBzNjVAxSVOKQVAQBKsAHMG6ZFWuqaNn/bwBerrypsFyu4LM79ueD0xWTgGvnqI2qbSUbkjKCK4OmtdP2N6l9DU62ZmvFwAJhA=;7:D7vfuW3LXiGJHH2biLBeBQ1MemRpvww5k97PPdwBes3XZ4Gnc1Y8H21vTDZxxsG40o0UgcwEn1syJs/l/rnozpp2OpqlOuFZDQt8l8EQwLbeV+TX46FteonME1BsPpzcjGpb1hTu3loycxmeCOeDnwLMoMa/rPFq3IJdL8O9uN0DS9LXVUcvmshxPiuNFOjifch0wJYC04lEGFo52ScGFOw6lWa33fUIECkk2YnkMKlR84/SCiHv1NGMwpCnNy5w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:28:56.6533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9df66b-26f3-4633-28ad-08d56fc113c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
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

utf
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

