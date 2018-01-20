Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6841F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbeATPY7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:24:59 -0500
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:24431
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754913AbeATPYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UOPDaDxyJWghY+s84JLEJlBo4MxltXOLkq0O4ZQQ8uE=;
 b=CWQQ+jLNexM2EE92boaBJUWcspEPXB3VTny+iippF0Art9srrDVXkd/RMkJxvhD4drMMVZxLdcDDdLNmNUnbqEPOhkXXgXM77gtuh+auGr+DJIXA+iuDeOomiXIJQ11Kpp6SK99a0CAOnI3jNeas++AKGDOHFAiTfxyyuiuDANY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 3/6] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sat, 20 Jan 2018 16:24:15 +0100
Message-Id: <20180120152418.52859-4-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0705c710-ff70-4f3b-7134-08d56019f324
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:EY3vS5w0BMrjbAYgbVYScoXZN9yWy8RNogoOjIVYcCmcsyaM4UBE80SxJbkSbnWFRx3pRmNQpJsKRptelqLyFY1JEMcdOK3CRHjBdd7259cGtrwmABXZIcrRQW9skGEt+FOqy2sIb+GBgir4W21NxdJ03v7sC8YbU/QrlyZFILKb5inTiz7L0q69CsGszJbqFyWZxe/mFtmM5MuMoaN953vk+LBLJulxVktRFwNZnh9fnVNfgz5x51MUxPTxoJlw;25:qrZoDZYtN1gM85j7lPEDEcpiAf0GvFArIpv//WqHluZXDxAVJO5sBbbzScAKWyVLJl/4f95fNHFaBJLbFXzUZEvLItPnGTQhsGjBwClfqruYBsbaITbrJ2THiwOt8zYQRk/oBHPkSQkt6Qiw7YUfzq0HqC+DcjIxYY+wabY46WQ4PkXRhvqWbzq7vjvngWZF57Cqvy4pdYRsHqCuXkYHfFO9h/oXohclbx64HcCESWr6tOBugB9q2fV72wPKlzgWrz8Ex17FZ6kpw1fhfM9YFAgn7l0WugtsOEYOWIDm+Ka0XCLjRyzTgM/JPciCH0sXoJdUFIQvm5y9gxuKDPL6zA==;31:voljDvAT5+nbZciUtY0vctapy/2q/d0ClXUzW5VtANPaq1/N0iRQ14RQbImh+F8iFe5fWlJPou+sMroIzVw0u4pInczqRn87ZdGvfZa6zbETYLta9v4j5Y9ip1RI992KHns+C7Kx6N873cpk9PTZ0Gv/OVcumORQL/9PoFtlmhyCPv8iO64MGuw9T+/XtR9rmgDH5GcIHHQ+sh8IxDvbaauPVDsc9SiJe7IlnfA1ZLI=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:T/F9+5ZIkEdT5gHMlhxULUwvIkAC0tahV+elOcOig7gqHejzVwGE1p9/n+txcv9mlJ238J0slowt7nlWU8l277lyN6blbWTdQYdImUta9vhHP+63aX+mfT6LC73hISlmv++od2kITc/yVhVdQnCRmr43JEIMIO+W/SFrrkS6IZuycOo6FzYu9DG5gmDapc3zIFR9MjEOPJMzFIPY4R4RBGmj9bX32LICuV+zgdzNrjX9GCudKRhFoBFjK4OjIHwvBGYYxLv1M8L7a552IF7Zg8cUXA5AnwtLM9wQVVLCz21cjd7Ie6Dg0rq4E8Ws1W36D615jF0dc9uayeNjByL1tbqOqRuRCV2PZN9/anpruy4wIRpdZAXTicGVhF7t1oITEXaHIFkg1mKZRNrDrws0LCMxDb5Awqugj+xcdl7swPj1YjCH4OFf73YW1SgYHKqay3BCMgMuXzG2eoeuRtjtGzAhY/U+rKjJJrrpDolWeizHVo1uDoK1XjUlpE7Ny7rJeiWUvTIJxUWoXoOAukgyd0onIfKFilEEgG5Kdso0iIvsAQvKi1sNMeabegQ0eZL+WBfaST8VPTyXdzB7vPbuxSVtHza7b+NG7C678ZyFXso=;4:X9ahNlr9oRStcLL+hKfQEpAUW9Efg89b6KSveFH+pQVJcPycoWv1e6ea1oUWaM0+Ui8bxN9d+f2uK6GUsvHznv/W9C3RTVqkxNcfUjlfwrK/7t2A//rK9qDxWRdofhOMn4dKZ8eN1hb64iU4k5VvDf61R/Ev6/ayXBbkOoBp52u28qC5H7GDyw5F9US3rww2oP6y68J0OPQpsFgN24JXo9xVpHhPhBsvUo82sPpcmAGqD02/T7KBHK61V1tQXOUkuuxLEQ9oTqMjF61ZWtq91BD4JXhOQ4kXucHoPBR3jRaoTa+putDv5Wogq1j3PIlm
X-Microsoft-Antispam-PRVS: <CY4P136MB0022312133F585EF3724A330E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(6306002)(966005)(39060400002)(3846002)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(2906002)(6116002)(53376002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:kYUF6/Yq3FFkGLtEAeyZWpfzygzSrd/4Xc3alq9pW?=
 =?us-ascii?Q?RCaGyzedTvdWLwC+aa3jJo+SzZxs7PZNwhJLB3c9QEYFnq3GcD+d3DhUHt5c?=
 =?us-ascii?Q?7S5KLrOHO512Y/59lz/WiYTUxqAp9vohRE698W0CqY4qbq5iu+uuQVw5jLtc?=
 =?us-ascii?Q?2Lna4W1hbc/hQlHyHC69tYZgVFtziL/BUMMtFxaXFFYIhFN8Sz43o1eZqC5w?=
 =?us-ascii?Q?9x58tD9B2QJ3qEkOgDj5NZaVQ8f4zMs1CrWI8/M8d6JeJJkSd52chCv/Kf2d?=
 =?us-ascii?Q?CIyoGmIVwW/d6HCLU9Pd7oJknKghoSE+2Xkb0vsV18D3zS4KVJjoE2tWatE+?=
 =?us-ascii?Q?yZ8VcG2o7YIMVd3WLh5TD6gCxkcf2KkqAgW3U6KmSGYAovdWncc7YZsbSB2P?=
 =?us-ascii?Q?GSPf6mc4BMZJXZNlZ/URC9SB3KzhvPQtOdnh9XXvre3HmDiUg6vHNIfSIiy5?=
 =?us-ascii?Q?+48Wg4P53IDFtkpALp/2EifEXL+h9ZAhDU29lV9ymWzNuA5yPbiN8P0DAO/0?=
 =?us-ascii?Q?d5oNgYwfPmXDRPR+VPd93v5utyz87hD/ol3Xw+7XWHBSAHktLY9jZ3f5mG7D?=
 =?us-ascii?Q?paBQp0D0Rnzoj9C202ITgBmvdBJyFuB+R5dwUU1+UuYVNOOzRvaP+pGH85J5?=
 =?us-ascii?Q?/q9ShOOaOEAs5eRSGRp7v009G7hZhkfAYPDp4MO2GXwxh/CiKpzqrDCw5VY1?=
 =?us-ascii?Q?/DXQD7SyNjqMvXqiiC49St5qVteP+nmlFn2+DOcrML3GVlwGv6AynRugGK4O?=
 =?us-ascii?Q?45oDac2NIEr39Y4jonGQu5TvT1ct75jQf3JRJ/B2eiOT5+uvSQ40txqKF+Tk?=
 =?us-ascii?Q?tiiYAukP9VaujaZTBKt3oWrfbmlTUHlu8fMVN4VMQ2ZztI5wSJNleTZQWBwj?=
 =?us-ascii?Q?EzoIlyiRF6u+na+PplSz4CvGvhXBgodOCyR1MzFCbfcig45VlEvUp1QJOD0t?=
 =?us-ascii?Q?GFHDjuIkkw7UAqlhWeXB6OnH9UxHuqHo0jp8uinGNtGfncz1D0lzVE1JER5j?=
 =?us-ascii?Q?uUAAGPR9RygZ4K7KfvGalmrm6+JA4tbSUYkm1iU+OBEZAybdQwzGIuuOS8YP?=
 =?us-ascii?Q?OPAqZuYy+3RoW2d+Okw9lKcZAV2VXghcO+LtF/7Vnqb2hNdYW9a0pEE6Vz18?=
 =?us-ascii?Q?ztwS+U/6hpZ8WsQUGk+IIPUtXrL3y17lDppRAMYwLAxD8bIA9WWbSqzZbNZJ?=
 =?us-ascii?Q?E6l4+H+KwFouEXcL5ZWst6UyUHc21n9bvOAvOmIH9VLebu9Dl3uZhKYioe3U?=
 =?us-ascii?Q?okzRvVLQre2OE101wrDFzmtXNZgJKOUSW5IldipSCUkr0mu5lsqkJsCvDUd4?=
 =?us-ascii?Q?UqmxNOoGa8Oi0NZlysujRnNA00vzOqCeiERY/2yJI0Z4CRohQyDgyw6rRuYM?=
 =?us-ascii?Q?HP64Z1hgzZfp5G0z/nO8EiWjAs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:fJR4hPtsoihOAg+r9vkUSyj/injXaSVrplLLuy6hTQN446eRYwGEQdAAemDKnI1X02EmMKqknZpdHSJE1rln7dFUALV9x85w2OKtoY8E7xDkscNql2A6+cAOuZSqFwPi0wlXGigDCMsChsbtTQ5kDaK6fNIXIhtU+uA6YIbUjjvXTJ5b0ZOBg9Z1/oh6Z7P6rhT2zxqXzYuVBgeJkH2+S/rOE2I2vmwt+lAO4Kjyr2zeQDzaBOkuWg80jt2qav8iIc8LyZkJkAN1lHwLaBeS4j+zxqPQJbrXvlpffnpMa52ypmbfnJ9oQx8f/vmGan/RVh1PDfVuTKfuFEktCTQXwX2XGPCDv2D4WqVrTt+by5A=;5:IG8Bz/GOnZZyJG4vEIpVOAvVJtJ6L4Wvw+R8V1L/r/ggBUgFOV/kr6eI39m84pjIHy/PC3186+AvqQBNipEBytD68EzDG/LnqIOy2ybooJkE7kVupgdq8VU4eAQ7mevl9LsBUlhyk/t7KT+WKAON+OVmFf1S8iLuPPWatsmA5uk=;24:pe8K2fsnNT9vlZGEr1Y1p1gRP4TRHyGvKRL9s7kl60nNllNIHDgmokPeS1r9yRO1NrNTovQDbEdkrdMof6v0YCBfAz0OQa47JuoR07W0k30=;7:AtrsseayGC4ZKiI2u8iI+exr+RclJ8wf8fO88KR48OPU/ZP+8R13QdLwlumspOamW5jY+IQCsqUwc1krvGUx+CiVKo+rD1Ja95UrnCoMgC+sQ5WLusVqweCs9NHiipUZfVRsMDl+WMJTZo1WWnjLmCduv2snMfeLiV2yJcX99h6RQqW4Loh+H5Eaa9SpwHxOE/kJF38X98I35UIfH/q6EoEZUKsA2j0s07fPTylSrZ+zjR7ogXWhCwh+4U0/Wk26
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:49.3743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0705c710-ff70-4f3b-7134-08d56019f324
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
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
 utf8.c | 24 ++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..914881cd1f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
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
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..4711429af9 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0

