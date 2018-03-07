Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0CAB1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeCGRbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:17 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:54586
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751176AbeCGRbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7k/TSboRwMTE8aanuWkPHOMq1EOHGFClAMYsOttdLHU=;
 b=rhwi34eZPkCysnGnrErx2lKeiLFUwYdSGlyepCRMRMA/5brTKz69xAh3oVGqwNQaujRS2GW3Ud9N78xTPKtZkhogdOAT613qjw2+yA40BLepdsiLW5TVXNmacMGHlpf9pyC1mlOvcBol+7+JKkq+ZXKe8ABzPJvY0tTHOFKGknM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:05 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 5/9] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Wed,  7 Mar 2018 18:30:22 +0100
Message-Id: <20180307173026.30058-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07f3a14f-c009-4a27-7b3a-08d584513632
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:CL6CwAW+49zLww1mbttJCLLNx5bA4yexQ191VMlwJGNQI+CnTNMjkCPrAU13fD3HVURT9Vv4lIlwciTAy64ljiz9+0/NczcrHi3WHXAkyJXXPfTcud+LwZqKRTHIBF2knaDQvRZGr36BuJcCTxLBaO7xhhjJv3Ztt3tVPr7YEuFZJRHEURs99Zi4RkWcP2IWnRQyrO2JbB+5W0bOVlembF8EJ/S+f3Pza++dG2PRrcj4iYoQg9dXqo6XauRWnDTt;25:i62p/hRtUM+0kxrvMv0Ds1+Z4aEqfTh4uzssJ0gE2RBX61esoSo4OdQtSW5VuzY360uE/H2KMTm5eHpBrpwT21eCNuvqXoz+JRA+Fg2iRU5rmDdhTd+vgm6l1OIp/tvBDZrWMRUzEHEy6BzYiOuBMoYhwIegAgt/AG26vDVZzJ938+y7kiUTdr2yeKgAwac+djMglFsFpqgQBCwWHH6s+76k52Q7/aFuNLb9xmDKeAmWxaTJX2FqshxHe5FjduADYa865+wOMsVDtmxSPdAukRrEypXPyJCniGfo/8c8pJ9RZT4joykfXI+F+1OiCOM9U8KGG00HmTX7VAbhnH7NVw==;31:tupf5uF6WFwXT75podoHsa70yQa1uf4Mq15w+8aR2rRPV3ejY1UGAB+uXpZUyJwpIQZxhZwVYSi6u2/H0zgBbpGalxgNhv8ceKWIlZBd5eaRVRSHJiiqfzo/g+OWIjCPS0iePiwJeBT9WOSE0mVmoxogQbMsiEvW/NLAYVyianlmZI406MTdeobX9siIHtsrj25CEZv+1G8q+pymYKaGlf/I378MyvsVjErEee7K3Z8=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:I3K9VVKyOgXb3G+wnfy8MFnQCcwTOg+9mqv2yAjt/v9FC34gc1W4YnoOkVkR+iHpb9RABVhJYaSp311sIwJPPMs9DkkzMT2rhndzOiIpXTOla7/m/kn+DH1arAWtvQVTPLkdAo3EYldNVl6hhipkxg1Rkt5zSVBWEM2Xe5w/PHKRj4yl13vj1P6TTyFF/N/iSLAgICI+ypbGTOSRIKqm5EUGkOmTnPy8LvftvuHYXYmJMDBP05EzV2qlP/wf/za51R7fOvA5oqHYjWOWuKU9fYxFKfzddSdRzoNRn+fzFjnHLr4/ptpxeA0MlPdh1wiOegTh758TbPCCvr/TJ3zwV4hlpXxl48V8fw4MIOdlQA/FVbaoLSn0weD+0JUOYmtHNlHQZ7FeHRS5Cd6uPYFw2GbDx0Yx3RtpWQybscdM4FKcv/QbdZYA4WKAHqQhYqtLK9kWXDSp+Nyol6emuzHySrtmbeamRcrHpmrrJL/Zfforvvzqv5AR2NIb5W+GeSdrcUY7q3bB9OQqc9VuRI6m5MC3UVFNcPaCG2yGRuHkXTYwymGDCfBYX/7S4Lyvs2Ys9XVQmuQI/lzV54Lj+PDEnRUa2EWjh0sZOtuBd5Cjal0=;4:F8/lJUKlrQBT+CT5tRIndGGL1QNrR4ETL5Vl/m932scrEEFUOIPbUWCtCJlUaENiZQvfx8qouflvw/cZHIBQZzgODsbJRFPJlL/+0cPVzJb+Z1xRL704KW54hTuDspA5Nk3atmBQWT0ERnat27fub3PLdUvTj8kTLEYbVbBzysV8CY9VY6rPyUsnW2W7dNZzhJHIeGfuq/QeLorsduJH3U52PpE86RCMI9x/9AwJMV4SoPhIrSS8S3L3GJSNxUeCzk92S6omj6P9v8gnVOdQgIfjVNZSAMglTvb/hN9XiVJzyD0fc9xPooPbzWQW8VGl
X-Microsoft-Antispam-PRVS: <MWHP136MB0014E9D5AAAB217D5197F602E8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(6486002)(4326008)(26005)(6306002)(316002)(8666007)(386003)(8656006)(53376002)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(966005)(105586002)(85782001)(50226002)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:jfUQg3zg2DphR4OKKKcN1963WKCpWA6eGD1gNF5gB?=
 =?us-ascii?Q?0g608kzuNCmIa9Cuc/Ac1K16z7iXKo9pMIOLCtHNOVrM9AMbH/HAlw0vxgtN?=
 =?us-ascii?Q?fY44GMk+XO9KhaCQpyintwjhrk0PUQkKpohzND+cz8oatWJ7CR4Oq+arC7G/?=
 =?us-ascii?Q?2KA9//ugRRpg5tC5o0wtk9EMWD3dFt8zNVGP0bAR9qheKrFTS4sbiEbOBPJI?=
 =?us-ascii?Q?NFlWOX4wf7cZGhRvdTyh3x/6xpmredD6nEvcKIPbZG+gQ28+0lPCRnmnYvnI?=
 =?us-ascii?Q?odNbicg7IqfA3B6tdoy7/j00oFGuUyrG3+6t2ymo5TSv+vAUsifPliH83dJH?=
 =?us-ascii?Q?2cUcuqWxP9ZdfCSG0JBNcCR+PKUvXRwueAPa6ZySkZDpFrm/upXA6XjFWQTC?=
 =?us-ascii?Q?aeg1Rcz7TWV/R+ggX6nThou1sHx9HhqF4JvRPlL48M4Xd8Xvi5VHggjzubSQ?=
 =?us-ascii?Q?uzayRZF+ZXZvtFWxJNihd8lSO9qPsYaEBf3OyC12P4WlhckaKXRwAl1BJ2rm?=
 =?us-ascii?Q?o+08+KLt1ldCdWD+lL8s5UE30x6YWaKyLBc4v+/DmxI55azVzXY90iDLoRQP?=
 =?us-ascii?Q?Uu/oy1zatwY5WaB+0dGBDfmaRNqEInPG6vDyQ6aDLgupQ6MITbRGOs/Y06Mm?=
 =?us-ascii?Q?2ZQiHcEzWv0tnJ0tQNxtBdZI9mOjxcLFKvQeqBXBu8RZdJMVLZ6PuRBXSwnL?=
 =?us-ascii?Q?MRNKEUKbFUn2hAfRBF0EXy9NPE7Kwk2yO7hm3sg01xBVsgAJ9XnSYtrLJpjX?=
 =?us-ascii?Q?pnJ90BcMUJpLWCs+ExRDQhzxcpiKAK8Fv0PgshGpXLmiNjKt8/V9Apg3VVGp?=
 =?us-ascii?Q?K7TUwlpYHUC/NsNNYcJ700aT66zipb8rJBV4pLpar5Od4/T84dnFt1FmII+l?=
 =?us-ascii?Q?xvj9Mvy4CAumdUm9HEYUAMZEeBDPRjl5bk1mazPBXOuio2dQVi3/yc6TASm2?=
 =?us-ascii?Q?bM6UkqMWw28WOOst4K9w4PbSKEzc9+DSj+FXDmuZtlg23cD/sH7xGUHwb+jy?=
 =?us-ascii?Q?Ktw+dNGtTUmcfE3QOJcQdQhZTt7El4bQyXZnRnLHv/nB0Pvsz3lF2kvtKLBC?=
 =?us-ascii?Q?q9G1cowD+BmgFMouCJEnFtaY2n0i1cZxRnNbYZV7vMTmuqgv/GlZDqtdxRo7?=
 =?us-ascii?Q?LnFc4cCxKj6OfRGqYdRHyRxJRDXgalDpPhHWSEkXFzq7nERCEU5CwaU/a8N0?=
 =?us-ascii?Q?WXtyPLk2vxRa9uKUicoYUpJlXxIDV53lA53cnkkPv2LOfmgJRAzjAzakRFbz?=
 =?us-ascii?Q?eomc9bT+PimKeMFs53LWEndzuayU1Ts+HgCBJUDTzHNC+OtDIflsMi4Vtvhd?=
 =?us-ascii?Q?96jeL+xX9+8+a6qF9vSSRY=3D?=
X-Microsoft-Antispam-Message-Info: vblA/E2Y7qUEvkha5cvT2jv4WQBxNcchgCRHyeqx0pjNlSigX5jDN75iSSUX/NOCkBKsYhf4CtwFeO12rHf23mMiMFQIAC1NkdKj0XvGplWT8LCzqaa2uUGlhsxOndRMnZBJnGcJPMFjjHQriMnzAjSFD+WkIW08uhPSYYHLkUAduYVdGFrzsZtdcHGpoRmG
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:XlOUHEECX2zQqhS/QPd21ON+latAZQGVWpnf/REqBk3Kqb0QCw5MXiCkH3Eh2KPH9txZ2SMnzn364r9x/cPTFrNYKW4uaF2nblT8S3HlYMswxSXsD50pCE7v57XdiJ1FFnmc95Fi+9rR3EcDx5cuHZYqugtqh9Pi7Xqq4E7Xb2G3YJZHe5zY8Mcw+StfusFUhmqsrPLb3gIUOoy4Y76TcAkXe0G/ATRbzo7cOylCyVYaAYOQpmyALWfWGwj51kZnoqE40KWCNpPEkUyAyjoJHMwmlb57cb9LFOXxnVVdHMoAy5V7etvic3Pb1m0yJlE4q2KY2GQ2yMVHhV9yfQ1YrZMp0FXr+nQ1vrc+/4EtR+4=;5:klPub0YjSlWvq/g9GRseMlhwZYlpfUSxLhveGb03W+Roiq39NIxHqy1sS5xAIGCbHahdxzuOKLjFBvX3/HppGuvLdLkOprEu7DqQY3SJlKJIofCV9kMVIAlPCsB6G0Pny1H3GozM4nw3/jNgfJmrwWS9EqZVNQM+HD4QuUU0pVA=;24:FUCWwi88rPyZnp2SEEPdKeLMj3Cvi8SNyiD1+hE1x8cQJR3enA6tjzO+Jdis8OHvdfigdd7NHg4KuauP97/5SAGPC3ETN2RDCwi6KYURlIQ=;7:AjF5ZKXGgyYJ3FHrqjeCDNsKzb0uoOxidSozH7yTmJ2r64PJnRG4n32miN54/DrXXKoJo7iCgpuSv9FNcH1duHTyYh1aRThLqSQBpqgoDLocEPD8JThzPMT1fDg5JEHIKsvq1KhRk2FTxO8zs7/8vbTb7i7RUekIt1zgk0eDzMo9b/xoX8H0RC6fixgALsnx0JKDhbinTmGtufMDlhg5Y9XNwEuttzv8ddrtM16250AJyOI7voOUdUaCS1FU+jc3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:05.2413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f3a14f-c009-4a27-7b3a-08d584513632
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
 utf8.h | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/utf8.c b/utf8.c
index e4b99580f0..81c6678df1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -564,6 +564,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   (!strcasecmp(enc, "UTF-16") || !strcasecmp(enc, "UTF16")) &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   (!strcasecmp(enc, "UTF-32") || !strcasecmp(enc, "UTF32")) &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 0db1db4519..cce654a64a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,23 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there in no
+ * BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard
+ * used in HTML5 recommends to assume little-endian to "deal with
+ * deployed content" [3].
+ *
+ * Therefore, strictly requiring a BOM seems to be the safest option for
+ * content in Git.
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
2.16.2

