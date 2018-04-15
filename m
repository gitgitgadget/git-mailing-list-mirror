Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B941F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDOSRC (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:17:02 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com ([104.47.32.138]:60384
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752926AbeDOSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AlALoG45APCDaGcotr3UmgVuCJ9c8dssCf7fXlbLhJg=;
 b=Oh/1U7J604a2AYZUlrtjgKPvGW3OW+nxFQDwOrFz16QR27daRCgMrSZJfyMha4BvQn1u54LQaezLuTE6d0yra6sBLDpriyQYauZWnKDm0GS5KT3VpBPjdNy9BEWQ2OYbnTgsGPnZv8rTO+HRJ9fL16qt7As9aW7OGOAyb413eNM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:52 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 06/10] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sun, 15 Apr 2018 20:16:06 +0200
Message-Id: <20180415181610.1612-7-lars.schneider@autodesk.com>
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
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:8qiH9GoBwHcUwWN6XFLve2rZLemU/IB9a8R94xL4v8vk1BZFuCp7/Bp+ztJc6KgN5WIAf2pPZHyYgQlETEbj/pr7DmhSzn040nRn1lWtpBoH29DK/11+QJVRRwXiIMHeIpBRArIC0BO+fWOP2krvk5nCjPxNx5cB10xQ8BhKrFC7cr801ShZ4Y2zJHCGFCh1DoB31yd2oGFAYs502WT5ktrVXOUa3bUO1tAhwdAnd8CKLHrQAc+xIj9fEmfhjE2Z;25:T/C40cTmNdh4O7HyemMM7MSLuRKYqTGJyop7I+OhXDjIxrs39m6pYffXod57pUkVjz78HeH2dcIv2IiDWP48Qi/kBbNhIVEHBtLhwX14yg3KNMvfp//TDvDLNgGkIbev8JXmL1/xI67K2l6+Y3PNXe/9aS3iTzEA7pEzvqNUhqVp6fz/8IK1L/K+mvvb7TJep50q8/3PfVobjd3kuy3ZafMAU09Gq71+/Qv3zk6sBpTPfFLQrly5OD1oE00Jd41E/EY0xj37Ok+4z4O+l0m1R0RW92td8avqzUsDroOx2RIiV/jqsuFsn/VpdgCVSK+3n2O1pIxQ0Co0U2uEBn3t4g==;31:58wUX2XPmTG717jVdiUDfz4MqReX6etRi8Q7GQGZK9JAptR1wskDqZhvoifQg1B71AwdcC9cWHkEUdUBdKWueu+dDCp/HNh/86Mqglezb1whwaxAJn26snO5hEYNa3Ib1ZsfXY1ESfMV7BKW/KkxZmAF6QKcASMh6P6jbp+3O3rPRRe9ujBqMLgyb0i0JtnSpojKwp/aAgHcjqbIKykKhccDozZr3BLwFs1GNVyhQIM=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:9h38RxhM7xkOUYB5h3gcVbavp4cMXbEnQqwNp0sYM2zlnxjpAwHK2176+B48rlMQ71M7W4WmOGPPrpuExnpxVxl5LFY2GLAZtNl+1q4o0rYc9BaU0BAo40emqWFw+ibCpqopf/+FK6011ykCPnW5w2YTfiKO2jz4PhQgYRoAvzKGs+wDTRYuql7w46mC/1GoUTiQ8lIzASpAZIY5Ic9uYwxJE5/H+2NQ+Pcpb5RTg/5qEeyJ0Tnk+gf/GxnbnWEVFihXOGnoDuoU9XgywzAHwnH7yLt3c1xqgOze7g60cdahnubiTmAe6OmEoKk9BpoYsyT6hqfHHpII0e9yFFQINAcQu2icxAXqBv68H7kvGitoK3m5pb7poSuQx/r92+xXWgbzXvD9JN+rVNBTCIsblKmt74LBEvGdEOCIOoOofEnJXal4h7K7czX49w8TKQQ9TwsRrVPV94znrl+GTayjSQ1o/aYVPk22ktpUvKru6Nr/rGqjWLu5gBNr8wKVRr9EG8pX47CFYHjFp9zOmdN6yuPXlya7dXMp/7kpcSGzFxEVhN3e22FrK+yuG63Wn3grr/qBy+EO9fFZ3y0o7LYu7H7tp7URlCJcUCL5Q8lSZb4=;4:qoiVHCNJHExH5lG21LqvPJCNiVDEhiRB0C0FmhRnTs20FXl9CQTqix3yWSaTZA6D40LYiZEDYO0xxLwuLl4i65t3w/ovXOpmw5PjjiVxrSJ0595RDvUL5WDrIE3W8XDZruRqmqmnrs6pnsGcx7iqaB/Q1tDBVPbLK8RJwD+wgwRVEHj5819Zl22XiuzVFMUIwe4+Ime0zc3cgK2SygwFBORRO4xBAse86Cp7+Jr/3QltapWzuVEDNEODIirM0IL4sCSVWJ/fq9ZI7xCE+vC1u2A/aZAaE6dwUWNJoznl1YSJVvpTWPxSrjhgmwlLXXuK
X-Microsoft-Antispam-PRVS: <MWHP136MB0014A38DCF87BFBF6157633CE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(966005)(9686003)(6306002)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(53376002)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:ijcGwlnyV4y9u1s4a0ggU9Rc/QfgzgJJDFS4xQPMI?=
 =?us-ascii?Q?JH1QXJ62rBWZKeXlRZJmen0EBS2ix8Fec06XdvbohjyncIuZIWm6qoIoOVMw?=
 =?us-ascii?Q?x8p+OILz9pB86H7x9145ClyTW+XXbor9QE2TGOYfiJE/3JD/dIYkDChnQT7Q?=
 =?us-ascii?Q?GfE0w9KRg1QbLxlgyQLWRzs2cspiDQphC1dHNda0NKqVGY591e2Dm2iRG0gE?=
 =?us-ascii?Q?k9uCtt07k+NitW/tZjCVClhGm0HTuTB6nKWbZ0BHnUIsSeaXEs0tUT0i9q0k?=
 =?us-ascii?Q?2YPLi/WSJ+qcjHtaVKOBxpDGdiyE2D7PxQvm0qIDvKaykXK4Bq605N2ML4uu?=
 =?us-ascii?Q?uSGLv+ymx+nN5nb0h+euPo5WQ9ubLuicRiSbuvQGghLB7+fRZzB5hAn7jlJV?=
 =?us-ascii?Q?No446kALq5eZ/W3Yr6/opwLWUy/IVBKU7dkz/SdJ9BvWdjssydi7ilK2hT9M?=
 =?us-ascii?Q?4/GvyvcVDGMVnYLMDK62HwbL3/JaiYx0Hz7/ml/JMVIe7+WV+dykJyVmPt4D?=
 =?us-ascii?Q?+iIjwkoKLqKdxWQj/IG7X7hESkULeZCeMo/RIq1yXizGwav5ovTyajnDMnWl?=
 =?us-ascii?Q?1xzCWOuuFAem0oxPWxRgL+6D4N9yWpLzYKbEsg6iHxeoAA4wM2nh6v/q33jl?=
 =?us-ascii?Q?kmQU5N+CM5CXK7f4+i8dvsN9ZIHczeSdzkIbA33BGqB6GtdqDG/iBoojwAqp?=
 =?us-ascii?Q?bIV5Us4Os+otj67CY3l4frbdFkHYSxShtHZjVUzg6drTg2OU2TrLS3S5+Yc8?=
 =?us-ascii?Q?EIkTo9MY0yuzicwzKuD5PMK3RXFl3eL+QHadPvyDEdLK3XUV7aRAZCJaC0T2?=
 =?us-ascii?Q?KsVzDIsWhmf02Sa9uZJPhyxdUawz0R9yBg7PxG8UuyLlLmJ6mNLY57+Vr85n?=
 =?us-ascii?Q?RPdbX1qy/e02lcE4Rd8XU+mws35Ne74VKJMUL9emhPgDew4XUTXK9XZJLiAN?=
 =?us-ascii?Q?EjGP2L4d7D6o0hGRnd3ePal23a8EjB+P+2BRTGhzlLGRQmYb9clz3KGBXzY3?=
 =?us-ascii?Q?vRMML9kvef8huzYn6rilr/WI6p6fHkMuWZaoVzr2m0yfd83hF3IDxsGQXgRK?=
 =?us-ascii?Q?vw2glvKqppTpSFMC7oP3BTz1dZ8yoxiBtFzvJdryfXjqYmWWgqkFYrp5DrAH?=
 =?us-ascii?Q?ISJKyPFfcOOFdYbuh4x7dL+URwGlT2q7C0CL8LtjYCCoCVb9WapTqBROgxTj?=
 =?us-ascii?Q?KNjvwsVhz78g6ss9wf+ymfE8VRtTLFiMZfGku5Fj/IKJe2l04vi5HhS1Qmqx?=
 =?us-ascii?Q?Ooyadde2Va17rFxInqhKoC/BnwWQQASSHjhgoLQhwjiU/Suvvxca2piY8LGa?=
 =?us-ascii?Q?F1PP6nrHUxJnTr9fEJ/PSQWalEkvHAvOgovJYNw+lBGJmJm2Eh7NMKWNpbFy?=
 =?us-ascii?Q?i6TvoX9UizWZuCIIudkai5siElWFL3BOqLjbdGFXNUvxudhG1YHjedNXg79M?=
 =?us-ascii?Q?pnxc3Z/dw=3D=3D?=
X-Microsoft-Antispam-Message-Info: bzboGRMQKp4gP56w13pMEuwxXJUKJLLDpQUZN2bvOhxNGf/2WmF4yfJegab5NI84VAYHWj52jzA6zrzNS4z/WiihOXAwo21ngSKQWdMbjcw1rMbLdLjj2GfVcLxN83iF3GY/vDGqrtpdoTfHuGwaogpHVKFTgb2nPi4LgP1RjxfMf0wUEhibwoNyQA0snkfN
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:tAVkz0YyGsga+TmlNVdSDzPhSwfz1c80/1WU7CstlBON5Rp7dLtFXPBof6WO58h3a9SJoz8Xk4iYYpw90vo4Xy53NjbmaszuxkSvFnLSa7PnGbzuJ37+q3T2Tj0hEUO2G0dvlx3lCRPo/nrdHi1Ekidq53gj0/IZdOF/AuxKXbgqGMKTrhexOqxw4LqcBA6j2pIEyWO70Xx+/SivoEaRjl6MdwFhKiDQ/++5pY2MhRUS835RWOnkdOW2ReLtZzrNZtdvp9RXeuCYFH4U5nwIUuOil5yvCXVOtFsyntx1KjTTUfiuQR5r6eacaDZauHCUh3mHGVcUrIDNfHP+ivnQYn4PUvUeXp/9wcou5XwqxWtN90yrM4A+CXiwaCvbMTbQekBZ0TofZ+MMMQksmpLL+ZE22JChAlT3jhsNFEAUyVzhjayiuC0xClsokehqcoJO063APF2a87r7t5kEt5vCLQ==;5:JnzYWtgNC+14TjCiDfApqLbEwNp4oLykEPnbdipJfRyuRd8Du/QV/2frL7l6a3Ar7b1Am2wdbrtZAYEbjl9KvqtF9XZ9nWEWsDdYBdsfHzTPVzv2raJlbXNq4GQ6A4Smgc6wDGVmbcDlF3reGcfUsQKL3ngZgY8GV/dX2eieoKk=;24:rpzVGfP+Miv4x/C/Qgrf57XSiWB8WxCO2lpDrWBsLy6koWVbLF33knvmDl+1Yt3aNaCSd6V7j/5pNylsRcSPAuspUb/Do/1znHsU3dlfxPY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:x+6UqDWYEhFQ/tK6cWyQK7XHhkW8g/Si6yVn7jtUdjKl5WXyUdLG5CdOY0mZPLq3WRiZQkwG4DhkdoM4T/Qt8w/ax7FagyI1E0jJIkXjk3S88WzhwBrLzVwZbHksED5hthgz+wOb9shFMk0K3ejDcUmy2/x87JNCJuiCTFJ9/3UKBvWDKwPKPZTfo0M52JxIjXB02lch+5qMH2WUR3LKz+g9mSdukRcZNsBKiPoVhLN7RyqoT9U4yMUOYVkUpEVw
X-MS-Office365-Filtering-Correlation-Id: e4a4a2e3-663b-4d87-cd5c-08d5a2fd118d
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:52.1004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a4a2e3-663b-4d87-cd5c-08d5a2fd118d
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
index 83af3a9f6b..25d366d6b3 100644
--- a/utf8.c
+++ b/utf8.c
@@ -586,6 +586,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   (same_utf_encoding(enc, "UTF-16")) &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   (same_utf_encoding(enc, "UTF-32")) &&
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

