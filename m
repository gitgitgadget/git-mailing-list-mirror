Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730F21F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBXQ3n (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:43 -0500
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:55968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeBXQ3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XB7ZHdouGNm/DFuBSB4OfXxSWV1XfOpSnchksRSdiA0=;
 b=VN6Ma0vMoxoP+GR2SKtAs/ycAwSQpA+sflilCRdy0Nn7/EBDf/1PSzShXD59daldB1wjShHRMIuLrTB95v9T10wU4aMYHRXFKhMt3V9a1ujE/wk5NLfiFIsbQmhUv1/INOgG+q89auLRo+SAly6A2CHMxXoP28MDKqj71zpIZOw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:38 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sat, 24 Feb 2018 17:27:57 +0100
Message-Id: <20180224162801.98860-4-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac2b61f9-40f6-471a-3806-08d57ba3aa1d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:yHKjIc9MsZ/fc5mQyIwaJ+Q9Yax0AQK4oCK4Ad9MyPINHfBV9HQqZQ5QhhLHd2zMvjZ8ZeRhkY67Qk7F6XKlNaG0D+2WQSEDOymKCcakOJk67tbhDXwF/MTr1Xifx2Hx8PBgbiASFu+wUVvHs3JlJDctgQrJPTjYxpdE8Q3iywk3TTu8zDlScO+EC+0GydxMvQqAH2vHWVEy+xtkEHsF2kGKWSq6+oOGXxbmCYJSGUZLRdbqfeKMSebyoO1fjICn;25:uUYd53Zw5Fq+jdEL9WYxRkUsXmoFDDuAVgcK+ow9wTysqtorEMSslN6Kme0/WWSOp9bKzva4ABJciKcNBP4KdTzduV0hLY3aaFICz9Pfzq6LTOYTfJc7XDaJhKZgIcjm8asvHGhggb04AySuHJqSN6CGMCaRhj82sFaeU6OjP65btT+GLz+XW19RaJnHZB0TrUgaISivvVLYknz1VmGYStSzCWz8ClLn1VsIN+RypK9qloqzJErohTfW1LzFAxdYXJO/is6HGAi0/20vhpEsAWpvzfW47CnenOT3y2uLVsvUMUvYtsgK3dhybeNTP7WRGkIygcIn2xW9zaDZTUCblg==;31:m50EMvpMtgZrRSiewR2F7A7bwYhQZw8TaAHLjSpSqsqJ43INNL5Cfs21+JoXTZ3JGbT89ef2rzJxE2FYkkYpYphRlGg7L67RRybJtJI70aGFP/ZTKpckZcYU8Rdcf/0V//grrFbwiYCNcaP8Jcpj7z0dXYicxd+6u56FpH40015qHJgKgJFktE/C7ShuJTxNtW7l4fQmrWMDSHPCi8covttJ2UEjpLCTjD74bNzGtJQ=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:NadqmAGz938sVttLMF3AYG7CbPs6tCe56raXIdovU2NJ9Iutrb5eHmv283kwYu/WFUpZUmGl45YBRoPtaN1lnVN8RpvBnKGwbFlTDI2U4/uV2RdhdZoD892qF5/qQn3vB0NO9Me3O0vnAVuj1KAiZzqeNwGiYcYrUyQ825/1xoO6Ls0K1/3hx4FyzFIaQ9mlJ4oX5deIMnwAReKDv7nzNTmsjQLGhI9PjuTpkLAGsc9ugOGNYG5G8kvAL5qxBfQVjO98UT4PANVyhUu4ZbU79Hw1NGrJ0ZQclKa7b1PfmifUeEw6IO5tUI02omn/NfTsMHJOC590dYRfY1jx+fCgfMQVwhUwSIXE22n2tZLz4/nueEvbXU5HpxSLuSO3dk+/v45VeQ3NitXNtixd2LYcrkDsE0EO7exRSO1ZRM8gvoJmMHISORWxPhHBjku7SGgshf6TI0INyXRZ+5vwzngxRlkIrisACI5YkMnmloTR2Qt2h6whmtfrEQ6TqludkA3Pj56Cvqwp+cyPsy6YPph+sdyniLlCIAS63kM9haCA51SDorFhqJZkCKeOoHY2P9F2OLHLfeQGrz3w1ERpreoJ/+FGO+SFxtONRBecrdfjaBA=;4:Xysi2/GupiL/2biP0W1sVQTOznRmEuVTDZ0l+kR0VVIcmv58YrfM1bSbxqGrYeyKV1mKFTYKBVeeK1Dgrsx4ChQWxCBkirOaiU6SbxswmY+9LM4krLNMSpZ70Ykf9Z9spGmONjw28FhiwjdB1lKRxG2nFZNiOzy+gVLzgXasm4yOhzJPHcYHHByQye3cJQq6jVam9f1yCk+Ro63FK1XtwohPENKHBYjOvYOLV/Cjk05gJJ11/40b5IiehpfiTe7gFFOa0VSROH+sVupU1FG1Cg==
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(189003)(53376002)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6306002)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(85782001)(16586007)(33896004)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(966005)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:fKo3VcEeDNgnPgdPe4ObiH8c/Ovl+IRd+VmPk3t40?=
 =?us-ascii?Q?82hprFpT4qHIiRCbGl3uw6fID1jxJ0S+UmHlEItAnXcQiYMgvSaneaV1xpzh?=
 =?us-ascii?Q?baOTlr+EL1mU3EtPVVN2YUaA3g1gVPDSKimUoqM/8qcVBEGfiMA9bHmNgPTI?=
 =?us-ascii?Q?jOCV7ss5VgzZm2OrVjW4mLVReho8VNimSEYdrySXdHnI8gS6a5y+C8C92LZ9?=
 =?us-ascii?Q?1ikvdU8olNyTx7Vh7PpLoUbOU2Fj9+m5Z6SaeFvDBATvHQpYmVAIT6fx7irR?=
 =?us-ascii?Q?HwddOrJlV4yxyKD8ZEK4c92AF5J32cp5rXVw1VHNUboo4Ca+MJ42R64QgGQ0?=
 =?us-ascii?Q?mveCEIA6iD3TaIXjGOvR8xi4l3xbkfsmE2tto+27qN+acyLLxwBmJLbHDHuW?=
 =?us-ascii?Q?pvLRax3Cr2n4Wkpuc6XO4e+q41+lu6bnu2W6Jix7deFD4IzBo4ALaFRGcTPk?=
 =?us-ascii?Q?oTTegaqjg03p2wiLoZqLIcvUNBvsT5NFbxEpWPuTw72aQEVWligWbDgJNYYT?=
 =?us-ascii?Q?cxAVgyfH77MKcS3cplNEQx/9+AEj/CL3jRm7b5SDk1lDx+XWfxi2pGjhjxRa?=
 =?us-ascii?Q?NSJ3lpegZ4Z3IyP9z9Uk5nvZKRX7APZd6u2iYTnxCw/WL4HUZVMHj1rr0ZTJ?=
 =?us-ascii?Q?wSPIM9P98ppfzbNU6PJMa41lz8Csx9uqdQeNcXgWwFVYbH83Jg+S6KmV6Qf8?=
 =?us-ascii?Q?WOYUJstrF9roNVY5wgVNSPxkTNwdj5xyzPPKJBD64f8oU0FM21l/7wVdSP8s?=
 =?us-ascii?Q?Ki6qhNJMH8IFGF5/+X00aWxTJYWoo8KDgWpg991tPCg74VOi2lPCwD1FbAyQ?=
 =?us-ascii?Q?O1jfXvgkiW7jTetQGabAMOewVdbXjE0NWFX2NQV1he2VKCi2e+jQ9ezpciyh?=
 =?us-ascii?Q?lXeFXgsjEzI8RN3S3fhNYcXjvlUQZwk9+gumbQyo19oBiyRhjmSfTL3T41sQ?=
 =?us-ascii?Q?B3gME5/RkV1KpB7ZHugFrzi7IO+qV8hi2tHGiQRGHVNsOYze7zH1vALe93Yv?=
 =?us-ascii?Q?mfgeftnQ4IdfUBu0nC42PPUyygVLOc+D8bDtVw4sTjr8OKa9jDzQRnuev0rd?=
 =?us-ascii?Q?kzP8tIguLHj+k6owIoVyxD5g5A7jhjN810ANxU395tdHmAuJnu0afCmUOQX2?=
 =?us-ascii?Q?ZXvkM0jXWPeHVZiSTUBJciQfRWN7PKAsnwD2fc/l2FTiEOArVmU4ys5IT+L0?=
 =?us-ascii?Q?WCViu2QYndtsDc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:QC1NPP7I/W+SZjrGHyB0ikL/yNnaDXz/qIEPrJbeNftISnDQYcvptr4vuiLZHpifpB1atz1j3feggX/u09PfoOs1HrtkclMVR3E+uxKCecD+cFGVQcEMEcFEAsqX50Txy8C0RrcnD9RIjGIiShC2Vd3PfprboutHJE+LOTXol1PKv931d07Zzp7pufS88s8EfBsvbzD7qKWaU7tyAaQCYklTB6O6TH8R6l+zq8nZcJ74pbh/oL3rgmM7HUjVJzlyfnKC/wFeLk5UjoPcsnqqiFfrWW1ZP474fRwFD2m0U5m05cMFVxkanBPle8N8vkTWsik2jDd5Tb+lyz6zznOK6e/LhLWIKzyTwMg5Y1KkpBU=;5:ZjU20DhHLOjdCUYfrrIvci/paYrf/5vdwu+FjP6BzOp5OX6rhyIUpBGtR8uwukRg//W57YDimzsnDrfhf0ukNXP+kkTeRiAB0Bd7INcnnVhTdxgcVIMOedGknPzZEOLkvNN6czKjWxt33tsTEOk4IMTtv2IDI0rPfN3+iIey0uU=;24:qs7H/ZYFHLY2gQOMSrGEAGZAFDSUNNmkHfSKC6J6O3ym7qopGvdArhJOhD3yFq6TtvBDhMo8EMAqPhzzyZvBrDIaX4qZnmnkear7Zse11GA=;7:AquVHth5tz0QUl49AWYHywlxHQv13iF6IaBrNZ+My2nP3UlI7XD3VpT7g6hLq1uXnAYgDv/418Ud0dcno7d+9/bRSv3H1Mnd+QclkaNKV/GJ73wKTlZZBPWQnltEG/8FGEjW9Hcgsz7GwqaLGFPRT1FV63O2mkalQI9Rj1sY9INEb180g07T2Uw3qr20nVO49p9gAFppvG3SGuiJ71vMr99WVPvxObG4ghRyLjigwxMeJk3/29NxhKbUFofUVl3b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:38.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b61f9-40f6-471a-3806-08d57ba3aa1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
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
2.16.1

