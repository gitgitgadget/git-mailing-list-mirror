Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110E11F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeDOSRT (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:17:19 -0400
Received: from mail-sn1nam01on0139.outbound.protection.outlook.com ([104.47.32.139]:36736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752965AbeDOSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GXn3byQMkcfRXJQk9NWYwY+6TM+3dIO94HJsEFzfJMo=;
 b=OAgRoUf2aEvCuiOprH5oeVAsY6faLcULt7MoF+8/Ss1WDd3PRfBvlEnlAt3fqKbxO6993rfqEDDL/aAPLhb+Vwl02BPAW95eHt9+sxsOVEeRw/iNSzgXHAdh3oyM4m3S9m4uHwuxjvh0rcxFewbEl8+avAlVF8UiTESqbFfGL2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:17:05 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Sun, 15 Apr 2018 20:16:10 +0200
Message-Id: <20180415181610.1612-11-lars.schneider@autodesk.com>
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
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:iRSf+0PDCpFYlS53MHYrGEm4gvTwrsf8ppBmfC2dVkiJ3RT4m1q9s3hfh1v1LXblZhP7zdzNmY0fiPXbPN7uI82EbEbBVUkTLHGtmRPBvDMdIT7dlM31b4BecIvhdhY/wX1Fpev/Us+VJ0n7kXnqlXLrTIj9MIk69YKtjKckh09FvbTy5m/LGQ9/mwyXXsZC4rf7d6XvnXDgAnwIqAsg9wOhuPZ4/83x8IgygO3tB68S407IDhUQqyClSil4CO/U;25:4tP5l3F/p5KigNDCL1ebKPpVx5aXHVoDIy3FHoG+ouck1WuMPEClc23Bz9krKmVm+AGKRQgsSeVvaoAmLlo7rIsT6Ix80iOT2R/WmYgCsQ1YvAFJWGJtPgGbj9eaPo5bYqCoYCaCrgCoW4X3Z1Q8dkEU+qr6TiD+O739zyKvAcKEjE/vZMhK3mcZABi4KM7nsLYPZeAUqiJd/IlWByFYnVG8MQyJQl0ejUggz8eXBAjJP94kFDhxnbt/nFLIkv5vr+Su0P2pxgdsrp9SpU7y8E/0Rl/u1V8HvW//Cgb2ovmeK7KPh52kfC3Zi4gEGrsk/M0iT6j8cUO74NvtC7Qc0w==;31:r6XfYUrnU12bkFRVT+JhqjeIHzSIe7LYM8jdf+VSEukAwlbM0FHjt9CewzZAP2bECH5nYOX0HVw8L8aHHlEo7mrzkoPoDA3pW5lFNUp3gprQI1oB3/0EmjzFbSHLbEVJa76DxI31sq4WoONOtAL76s5yrkQGRRuDntLMs9toYWl8t8i7dHB/J3sNFd0B23EuziEcxpjw/0mmKist6zz8FxboGwwG8sPkjM4ZsK0/9eY=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:r6apeNZo82eI8y3l779trrI0dIlkvXRk/ovW1gpSjQ7l+0ac4ZMv/rwBlwOhQEkgwybbgbIG5HXkavx6OCOUgkKkcpCDCfUz20FrVwt7n7c3Jbi40YZQG8G761Cs32xPLt2IN/9P5XSZ5pOl+LAa6R9Oj6jRpa3o/RT2Vhyx6XQ94lYwHpdya2gI5qmkrVzJgg3sGDZk6csANViYeHcJRDhXGmGhoWsWdhXsxBcKEB3+WWgEzD8pNYXLWgjnTGoywEVCIxPiWZAl3nO3TowSqDlxn1HqLGmv0MzfJ0IYvnnD2i69WY4ESBdvq72d6u3mro0HCN+zI8uQ5OhVBkPG2tNMOhaxSpEyFNdxjptbdkLcKO8oAke/laQz91iNcriUe9+ArPCRSeIPjBexa+CVPqo7Rs/slTugfn/WBGXdIEGOSZc4zINvmucPuJ64vwboltn05HSKVLxqh9g0z3CaARF9AbSESytkjR5qvvx6NjL/QkK0oWsS0DHywW+q8CkTuE1j8F7CKE85g/Ymao4F/cZYutOZRhMcTzfdHP0BbpxWnti/JHMAv0RFjp00B3MPPrA5YNXoPRtGtRR0q755H4eRPnwMeqDRln7cNiiI7tM=
X-Microsoft-Antispam-PRVS: <MWHP136MB0014A02A016A2DFF14E6971CE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:anVRB75bbwM8GDlEKUh22ea2OUQ021AafRp0Ey7ctVLs/EuBxz/WMVoGfXgFfT4s4nY5gFc2ZKS/TSJwd9t1fTG1ytPh/PBGw8tB7lgk64rHlmegyLJfpsgPShEa2NPUJOkf4MABHmzrIOhQY4Rw051p8QVhEdQ141zeDbMV69sYh9ZcTiaq7sbkyPsCL71O9GxTbT44jG5NHisHfVrqJ67HFPFmtvhmfZdkAAzLO5BkYD1+/mAbwSAoJr6lbi1635+/2SSXrEoc66u1+Ac7jdmfK6kjR2xd55ROLtSnEj5ZP64U3BeHB+WbmMhT+cqLqDJdBNB3s8aT3N4JyHwVAmLgC/64h0Rk9o7p/YSnaBc=
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(966005)(9686003)(6306002)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(5890100001)(50466002)(26005)(575784001)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(53376002)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:I+qySfjCClC4xouCw8FsNHMBtwJfiuIBiCOdS0UVp?=
 =?us-ascii?Q?BxiOmaNbVGNXpZrMfrzK5hy+kyetDQN6GvAGS1ePQmqdoCqobnYzX8zAKCtS?=
 =?us-ascii?Q?op5GHtRxk1f4/MZOnS7Qq64XPgvvRwrQrsc7Vpk/M1mB7V1jjES/HiBlgsSK?=
 =?us-ascii?Q?iCeLRmLxLo9IIMgjAk60WSYFV+e5n8JuNGSpLil37Ji1vdkJNoa9b5YXYgWm?=
 =?us-ascii?Q?JTeJ9HLo+G+JYzvfIZcA6gOGfwyjZDUMGzNBYR901o5swxj+DMzDT5rOn2PL?=
 =?us-ascii?Q?YWkz96sF4IQtg92RslvGII0HReVsqpybEb6AlzNNeIHlnyNOH599cmsZfWI/?=
 =?us-ascii?Q?zgARr1dpmzvMwmw7Z8VMy4fQe0FEntt3CZhTUVmc7RWKSYNNVVZGWu7ygJh1?=
 =?us-ascii?Q?pJZmsOv5zn7EzEx8tRGpi3FsUpnKVETE8d5FkFI8BbnUJbgKp7eDYfKyA1G9?=
 =?us-ascii?Q?awqz4WSqD7jMgpgivBd/EeADtjvQK+2hs5xAZ/njkjMiH6SgucV0u8a82JjP?=
 =?us-ascii?Q?Gr1lKcWE34Izp7i3EVDqX+r6DrnUfzbZpLQc4JfJ1eZkVQgX73m+KZvzTD3N?=
 =?us-ascii?Q?Ra/uK7Cd+hnhU3si06nA3wERqb0I0Bh3kkXKsXRFJcjQS5tYLspa2Kg713Pi?=
 =?us-ascii?Q?pjtn6gle3aNRT8n6i5qfX00vah5Fxs8Yq46Swtlg7uFMufjwRR1unJdOAD2n?=
 =?us-ascii?Q?q+/OacGxgMXny5pq4Oe/gZVWG2JDWoEc8JJr1wiv+HI3ipBEokLoNrvwPT1C?=
 =?us-ascii?Q?VqrnkqHitdgrd8T7EC7jNzT1ewYr18t8rJbmeV6VGFJOmmtDFDmJk1ImPj/t?=
 =?us-ascii?Q?rIADAdYLrG4qXB0aN9Q0LtMtLN/RLgmIlxVPY6Ph5NKQC8+LKkN0+7HPgbc4?=
 =?us-ascii?Q?hc7Mi3aH1P9eNfb7tV0NVTgR2bZliAAXE6y9fbbMzFukjDKmjQXPo7CO0n8P?=
 =?us-ascii?Q?ztOAByaCw6dEhp+Z/1i5I8JydNT8qM4tzi5zSxWerhVKsj8JoulmjmPeAr7K?=
 =?us-ascii?Q?XOUm7LFTMN2lvqWgwUgd0zdro2sO/nKs3rPpf5W177lJepShcBtgKbop6Kpf?=
 =?us-ascii?Q?TmckQTzeNZspbFImMI/2AcqhitECWn+aSdSmap/+dCRHCMoOEEGify/YfwXB?=
 =?us-ascii?Q?yk26AsT9kgg6bixh1mOvg6a5ZrKnCsSvo6YRMNsBzUb5hxMp3eW0O8D1ilij?=
 =?us-ascii?Q?3NcQ/uNy6KLb9yvmAmwxBUfDQooLemnfz61zAY9YvAylK5D+rLls7z8Sknlg?=
 =?us-ascii?Q?lmMfBXdoSzjkMvBEjYRHDTe0WJbTP7mHzMBaf6r5hEBfJg0REsB9XFWrhrP6?=
 =?us-ascii?Q?82rH0SHvc9lyGo62sCMoh+IwNScf9RiqLjyokX+TK/w9tJW5B/5QHpBG1PXZ?=
 =?us-ascii?Q?huGNaliiTSpgR0MibK+HzYtVFy9KB6huQubSh9TcxgOMoYD8nOZeOw5v+wks?=
 =?us-ascii?Q?i8Do7v1nq+PI0jjUpzCFilqoO9KrgIjxevi4zUwJnTwjRYqvluY0AmbFMXWA?=
 =?us-ascii?Q?wzmoyghidBuDw=3D=3D?=
X-Microsoft-Antispam-Message-Info: +PiBY4Y6MHX1jdWEa1yYlo4kg+d3S1RovG7QxARRIB00B/ErrBAaKWf/CJTWqEZTnG/LLTSTgbDPgwtn/9580FbzPmN2W1r/PFUG8qawgwPYxD3bzFccCz1E3GeaEIh3wOKWEzvq+FjkHUKRr5SgV2O0kGCXuxXihwQiSBBlPUi2WNfOyBiEiROjV8BveBzB
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:XxnzYE74Q/WMUozqjetBGpv/ikemG8mJ6F1u38ptoVZcxY9/zQHvE0m8VRnTXPB45+jbFVlgUEIEyX9bPo+mJ9RXhj6GLzhXhZ7lgo4KAAVhNCP/s+k0N9R1JoncSPGXzAVvfQ0/1lLguGT9uOgG2FPHovj86uIdjDdfWgCbk2qBrTXT/4jm47mKzPWVf+8AMw1w4nK98f4EDTGmQOJe9dgWqQDAvKbDYCwwJ8fOKXucAnaWXzt7hYjkGuInNLItZYHsfBCeg5xJ6/gOPamoV1P/4Q2yA+MCQ/kSWwZ4xwNc5llLWlKekd12sfrHaMRHIXetBUtx9R6LBvMyqz2+CRR4NUegXq86xoHFrGBuvoFy8OTXrrRHMr/pGUMMhKvVH/StafJH/n2JrVrv/BEslHM+HP20RTM6ZTTBntX7IJXUniEN2fDuJ7k/uPpq+D1IkdOwPhgp/gAleN96h7x1Ew==;5:ZZMRT8OIRe4Y7KKKT43/Nr3TsrCB1vf8LA609nkF9VtYz+6uzZ5CuPd6yAWJcRhwvZMmI1T7LAyU4AX9BImvphn0H1z8zVqSkurzNRfhuk5FMHlHDHnxtf8GABLkSkLLJw7qQSyH0iy8D2XVdmzFa2ohH4+BmyPcxSb66hkyNuM=;24:sJYnDbPbsMxwUwb08r4418ClXl51Zw8p8GGct1Ef4uwm9VcUciuUklCRUnSuctBbuTNhr7DQLyHDlZQHjCRmVRw6GtJ3w2/TadzlDD/uj9M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:peEzRbMX/0iV3CKvQ2yGpIqtoade9g8fFwYd/Qtvt8w2lq3pG02aIbE5JHHApc4nxE4E1BBtA8g/IcUCtuW6R0QU+kv+tcWFO/KZEJYuzpnf52RNFIKA54Mhe8Y6ZjcxK3Q0IMqjewCItksyA/1BumxHujddGp7foJKC3UIY5mW9gtSHIRtLH6o9jQz4g+8YyFVeCRR8w6mDinL4m3Wp66XN7HjcuexwS2uF+v3sncG3XFpbfl1nBHOh+OCzzP8p
X-MS-Office365-Filtering-Correlation-Id: 2271a61c-8b44-4a4a-ab97-08d5a2fd1973
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:17:05.3509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271a61c-8b44-4a4a-ab97-08d5a2fd1973
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

UTF supports lossless conversion round tripping and conversions between
UTF and other encodings are mostly round trip safe as Unicode aims to be
a superset of all other character encodings. However, certain encodings
(e.g. SHIFT-JIS) are known to have round trip issues [1].

Add 'core.checkRoundtripEncoding', which contains a comma separated
list of encodings, to define for what encodings Git should check the
conversion round trip if they are used in the 'working-tree-encoding'
attribute.

Set SHIFT-JIS as default value for 'core.checkRoundtripEncoding'.

[1] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt         |  6 ++++
 Documentation/gitattributes.txt  |  8 +++++
 config.c                         |  5 +++
 convert.c                        | 77 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++
 7 files changed, 137 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..7dcac9b540 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
 
+core.checkRoundtripEncoding::
+	A comma and/or whitespace separated list of encodings that Git
+	performs UTF-8 round trip checks on if they are used in an
+	`working-tree-encoding` attribute (see linkgit:gitattributes[5]).
+	The default value is `SHIFT-JIS`.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 31a4f92840..aa3deae392 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -312,6 +312,14 @@ number of pitfalls:
   internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
   That operation will fail and cause an error.
 
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to
+  `core.checkRoundtripEncoding` to make Git check the round trip
+  encoding (see linkgit:git-config[1]). SHIFT-JIS (Japanese character
+  set) is known to have round trip issues with UTF-8 and is checked by
+  default.
+
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
 
diff --git a/config.c b/config.c
index 1f003fbb90..d0ada9fcd4 100644
--- a/config.c
+++ b/config.c
@@ -1172,6 +1172,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		check_roundtrip_encoding = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index bc35c33249..1ae6301629 100644
--- a/convert.c
+++ b/convert.c
@@ -347,6 +347,42 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_release(&trace);
 }
 
+static int check_roundtrip(const char *enc_name)
+{
+	/*
+	 * check_roundtrip_encoding contains a string of comma and/or
+	 * space separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * Search for the given encoding in that string.
+	 */
+	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
+	const char *next;
+	int len;
+	if (!found)
+		return 0;
+	next = found + strlen(enc_name);
+	len = strlen(check_roundtrip_encoding);
+	return (found && (
+			/*
+			 * check that the found encoding is at the
+			 * beginning of check_roundtrip_encoding or
+			 * that it is prefixed with a space or comma
+			 */
+			found == check_roundtrip_encoding || (
+				(isspace(found[-1]) || found[-1] == ',')
+			)
+		) && (
+			/*
+			 * check that the found encoding is at the
+			 * end of check_roundtrip_encoding or
+			 * that it is suffixed with a space or comma
+			 */
+			next == check_roundtrip_encoding + len || (
+				next < check_roundtrip_encoding + len &&
+				(isspace(next[0]) || next[0] == ',')
+			)
+		));
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -395,6 +431,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	}
 	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
+	/*
+	 * UTF supports lossless conversion round tripping [1] and conversions
+	 * between UTF and other encodings are mostly round trip safe as
+	 * Unicode aims to be a superset of all other character encodings.
+	 * However, certain encodings (e.g. SHIFT-JIS) are known to have round
+	 * trip issues [2]. Check the round trip conversion for all encodings
+	 * listed in core.checkRoundtripEncoding.
+	 *
+	 * The round trip check is only performed if content is written to Git.
+	 * This ensures that no information is lost during conversion to/from
+	 * the internal UTF-8 representation.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without an iconv error. Iconv errors
+	 * are already caught above.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if (die_on_error && check_roundtrip(enc)) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc, default_encoding,
+					     &re_src_len);
+
+		trace_printf("Checking roundtrip encoding for %s...\n", enc);
+		trace_encoding("reencoded source", path, enc,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			die(msg, path, enc, default_encoding);
+		}
+
+		free(re_src);
+	}
+
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
 }
diff --git a/convert.h b/convert.h
index 1d9539ed0b..765abfbd60 100644
--- a/convert.h
+++ b/convert.h
@@ -56,6 +56,7 @@ struct delayed_checkout {
 };
 
 extern enum eol core_eol;
+extern char *check_roundtrip_encoding;
 extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 10a32c20ac..5bae9131ad 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 026544ce09..12b8eb963a 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -203,4 +203,43 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	test_i18ngrep "error: BOM is required" err.out
 '
 
+test_expect_success 'check roundtrip encoding' '
+	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	text="hallo there!\nroundtrip test here!" &&
+	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+	# SHIFT-JIS encoded files are round-trip checked by default...
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# ... unless we overwrite the Git config!
+	! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage \
+		add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-16, UTF-32" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset
+'
+
 test_done
-- 
2.16.2

