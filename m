Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7B61F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeCOW6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:37 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:63072
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932841AbeCOW6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FF3VFb4PHsb2koVRnedURI6srKSu6zq8ozGB3/TxVyY=;
 b=HRT/2c16jEN37vR5IJmRI8pZk+PBGjyfd6HnYAMLS0GV8n4hAQo1xZxSRPSciLuKia0KNRB33gaOVfKhe7lMqMinR677G1Q4TQozcNG1/Bu2IYKv895CLDMRWwNVU0raQsXXwN2wTzlST067+Pdbkh/pj29qFxYuOQ9aB0CAZDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:25 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Thu, 15 Mar 2018 23:57:46 +0100
Message-Id: <20180315225746.18119-11-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32ac86a9-d86f-49e0-efe5-08d58ac84430
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:QQQSWgGCdiQaY4q6juaQGLZqvtMzH50kwg/cOc9LxE7+pIE/AgL7c+9UlsgbGQPhD2lQjMX8MKheSZW8uEPhU/6/n05azIaS0VSMtFTYmi4qH2KqIvR0AqbjeS/38jl25m8WvLTIQmos8N2aFs9y3BF7cxAgZyjMCslKyaRIFOB9aK4JAindmel0Ky0Kr01FMjggCQq4Phb0UBXhWBEHebIkci0PwRJnLgJF1Y+9P+T0Dkjr680AeYWl5qkAjbXJ;25:O7CZS1yxFnaCCoqMKxk5AIuOqY1rsw7lrGNxkkfE2DZbrfufJR2MqTmRv5Chhmp4qsfccZouP2AFCF7KVK9NbyT+2BzJwLPIUvbKknZZrkx5yQE44ImbzxJq/ZDSVT+74tT0Io4G7/d1GyGRZBQI5c948jZ7o1/J4Q7Nt0KvlmdIH5vN8ZiwI0wONrnMCWzT6DqnSg39inFR+V1yjFHpOAmVvwyAxXxtUh8es9KKNfoOhh4/MoFU5dz/kIKP0wFU2jiCamTVMOHQOKlY9WZwPOkhoi7RgwYky4F1JO5SCC9sRxUIZYbF95W/h6xtyuSGtcxj1iSuGEZ4n0ZKv9R4bQ==;31:4lrHFaWjttmH5pU7mPZe1AAmpzBOCQ0UmE+eQW9d9HYgTUBonBLiFfCFdnFGUh6BnkCAgVqdhKHuGNc0RKTK7OYlNo5u6xeaei3PZcU+o2bbJSBkRB4e+kLuSAreBoMuUe8P5nOppWevDl4rW9Q2g50xSG/JWp4D6kVG8s0kHC0U7OEl4d+9dtFmcXnf+/B2EaBrYMw51q3afH1gQSeC9AP5B3uGPC94CN01pGNLMcc=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:4Dg8gWvGShnQgT+P1/Pxet3Jin/mcimXcHKOD1UsJVXqtS+f32tCUiPOqCzgr0FJZ0uUTasBT+5HdmOdCdiqq6KshWz/YirB/t8z8BLAl9VWqKGEuzWARoKAUWwyKPvIp2rmaPKg5w+a5LlAHM6FgKNStxjTvbNSa+IF45XcvNvLaCJQ6CqXpuMN/Obs1C9lXAaHoRI4Ym6z+GmtmrBcylkx4J1q3Q2D/SBJz+MgNz30eVRtR0nJJuMNWoEEKXSxjck5u8X+IkaUhOCP3D6U9V1+IzawtbZ1X8pzxg7Nhojvmnw6W8tMzvt+0sKqr8ZyP62hfwt64u/RF4Zz0Ylrimxtt2Hvm+nxHNij+gvc7dMCSKBSsNs23eQUl6EASJ2kZhNLDZtv4bIjGxpCA++m3UMTU9Eyj8xBs6pOK+b9o1OKXfOLh5OLkSiyw75ns2SmCXNlfEWO4n+ReDgkG+Nwo98GeAH/B+lw3RwyHo2L6sagt2UM14trsl2e18IPZ8lvrJgFtZn8eshwDxzRB550Wxe82GwdQvRc1dPAL9GBSrsMhkTijNKoNJ1ON9YNhquw3G0yu1jQtAapYckXWwpW1FUOfnxWJpgMHOicd5b0vhQ=
X-Microsoft-Antispam-PRVS: <MWHP136MB0014D748536B881BB5F490F1E8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:qY0oJH0ZXdc+EB79hlYYVMUXnW+hI0BdBPIDjFs2NK3hkcI+p1CTV2a01cAOg18sK0EZmUCU+pRWT1hrqLclU6sDxi9XoChGrNWwM/HL8Kextci48tcY7ZW0Nts56Z/yhgXdVoPL46nxfQtjDk7M965/ZTSOU6ka99m2tkBj0+4nRSlyR035eg4aaQdoJmK7s/ItAJr311WMgcZuKr/WjwH7TeX27P3emt1UZ9GnyzdsU06/k3bjzn/zBFmqNhmAHsrf/QM/sKIfkSICTUCv+CaFQqYyNZJn1Rsy+Iv2Xj8vVBdTDcr0lwV/Ov8LGuFMAZphSKh5bCqHOTPH7sO7RDBDx12Pa4qXOEpXrILYWkM=
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(85782001)(81166006)(52116002)(53936002)(51416003)(76176011)(1076002)(39060400002)(16586007)(2361001)(8676002)(105586002)(47776003)(6486002)(2906002)(478600001)(106356001)(50226002)(575784001)(81156014)(2351001)(26005)(4326008)(8936002)(2950100002)(6116002)(68736007)(3846002)(186003)(66066001)(8666007)(25786009)(59450400001)(48376002)(6306002)(86362001)(386003)(966005)(6666003)(36756003)(6916009)(7696005)(5660300001)(97736004)(7736002)(305945005)(7416002)(316002)(16526019)(53376002)(5890100001)(9686003)(50466002)(8656006)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:RmriR6EnploMok9DBJAerqw5KjgZK8B2LEE21i+NY?=
 =?us-ascii?Q?Vr0cypVuBUjiNpSSBTKQ+TJqiaJWoQ7bCDRtBsKctcKx+dORdMhbg599xtOd?=
 =?us-ascii?Q?IUxbGug84DrREmfy2sUNsBeey90kiw7sXpGTKdAC2SyI8XRVv89Y4iWkUyKT?=
 =?us-ascii?Q?GQYqsVJ4y8o2IdZgjVjg2tjJ42EeVWV3IOkdxVtuzzpT0zDBorhB5irw7VKx?=
 =?us-ascii?Q?puAiUTbbDSofecPsvnuqK8AgYyStWoeKN00/Yrpku1ivtXf6k0eZcZrW6iu1?=
 =?us-ascii?Q?NkAuxz2WjhadTuGSIWGGly04599Pc4fCtuWYlZH6tbzPisMsWsMghc9hihJl?=
 =?us-ascii?Q?Fy9DL0gOWNKM1u4cZ/NqHhTlmr+bTAJWUszRn5PkBzdFlwVk/SXSLgvm+SeJ?=
 =?us-ascii?Q?dXX/de5xT5SCO0tpcPH62j+I6nvNr4MEnq6D2F0kUZAdZZGm5rEv5SYYbFcR?=
 =?us-ascii?Q?dLvUm+21Vuy+b0n4loyA+elEvsmzN7ANAFHblAiSNLh7Zrr3zDvULLkKjMbN?=
 =?us-ascii?Q?Bptv3FG67Ri8UEEo8Gh0+CxdU5MdRH1izFkwdX3UMnp9MTPKpgP5Wab96g0K?=
 =?us-ascii?Q?twJrDQa6hTjAQmlxm5xgIagUso2DyEEWxBuSUOOzU7s3JsnOGTPcdE83+YXv?=
 =?us-ascii?Q?LnR16heahKNPkcDi81xE4TeptAshxFzRuAd5PaIyddn+YmXY34ke11SCQfgQ?=
 =?us-ascii?Q?jf6uN2Wfq81Z5un5oFlmz9XMbz9VYiWcYi1sLSo862GgrHGtMFcvIkKcrq/x?=
 =?us-ascii?Q?C3DAx646Rt/dHJqNhPUPtgs2zPVnsa8Z5//pCltxi6XbnIBiUZXPfVNfKulC?=
 =?us-ascii?Q?1qvz+oeULUump/t6JxZDqzSdNPPrTxFSS89swMUJ2Rtcwj8o7CUtPk8nscxt?=
 =?us-ascii?Q?dqCwpW02tv7+tD2SifflUzPbM+Bxpo1ZkhgCK2synNMW/ADrXIKsBz01/Svh?=
 =?us-ascii?Q?IJIVvvIfE5PfgMlx2sI2r3bPzNYd1tVkaFcEYupyB69P49n62Y4rppTHOLdf?=
 =?us-ascii?Q?+33nKe+CbH1Zp1wCq8KtHvp9DzBbLyCKBBQ0UgJskxVZwiFtv3WcwP9mR2EZ?=
 =?us-ascii?Q?tt99u3rXDbnAteiSr6amt7RvP6YubLDgGqU/PMDJ4p1ph+W4Mg6u5gVC3WGh?=
 =?us-ascii?Q?KTyOO5X9yTQqANASMWKo9O3PEuXKoYtlaThlRqNdieGSpiWfCr8aYcZNRh+2?=
 =?us-ascii?Q?nyJJL3yVHk4tszKkRo2pNl9Cmh+q7DeFc/yOGFk/D5MeosXxIb7QRrOrZSsi?=
 =?us-ascii?Q?vuazs2QKjf1J3Yy9+2y4wzeumW17xAZkhOBE/ZStpRGWOvhzAp1GRuqm7B1f?=
 =?us-ascii?Q?S7+ICFDBB+cmqTHiflJLmE5wqecTw0Z7uyPlT0jZFFlO7zUTplko3gqGWMQA?=
 =?us-ascii?Q?DnaDY4cvMtXcNF3t9ejfmBqpK/1PU8KJjCK2pwvnKl5+qh0i4LLkTnLaEPYN?=
 =?us-ascii?Q?7U4z7GOQQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZpmFjAp1Eaf7Mo8eLRb8+D3DVQxXFrY6WAkwkdI1Pc898MatVdb1bYDyuO60NWP6BLNw65SVxqfl6QEf194wqgtypbIhonymYO24Kwdec9V+XLCu3hhzg4TBT+QkTKFNCQozueYIUJGWNlhvOufkALeL7usj20a64mfzaIMs2u9rq/ni61QBfQZZIGSvLbbN
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:pxKrUvloi86uZeuoLE+Ciy+LYcAOyx/a12J+ydXUFW1aIZQLhpbuEEQdaPUc4ZDXPNaALI3v9K9GGPEcf/LDdxSdsdUDj5Z8X/pqOp+gY/VQLN3J6CScX+vRSL7n9thNGIUVgjOi1s94QCXjsnwVoWhC0XXajzfSQbEUAULLV7utrwIOU5qbNPPWLxDxzUrCPExJ5bkqG7IEg0U70u3zGrgGeNfXNcFYLxgbEyL/QGxkAr1AFB98A92gUn06gvRHdT5ceBsB1uFPfBj4+q/Mj4REV3dHxTGUHBVPzudVig3lm/2HUjl6uGfhCvyOyshpZhnJeIHs3ASzSJ+SS2XT+jQx0iPWiaPcoTWOu6jIzr4=;5:U78soU6DkDXglfVIn/APv/JfywTWfgmys4KD3c1tRb24IsfgUJz+cgAQWLVyAsKiUrBwYbuKTSlen3x4X9NvyITXYZ9iGUq8Xz7TdchQV4M/dFfWjq44XrobqR8Mo92SL0MjnAKiQ0U3wpKuRnWze7VzCpxdIawVu1WK9ktyx2E=;24:EkerJZP0mcyBA2goTIg2fo1BWk4mTGtNMindot9/32mFm/fKZFySnGNG3Gnwl9huKDe6xnfqg8CwHMwuiEOH7Re2tcl5t9IO8dXdGPTBGn8=;7:FNI6KU7p+7mA4+IlNKpSo8yPmX4C2YftTjF9aHnp35GOlhGKssg8OAmxuO4g6zou3bZSim+91Lx+xpKTPQtiPQz1IiLALLJt/SLHoe9vUP2cgZNygf2568s1k8cC+ZTcKUG+zzmpunapNgjrMJBBK040gYwNaYlcaldDKKxdtzBy24POJS7wsG8CLfmNNBj92BbOKbaYdUr0bW4MAvDrgeuOxA5oot078GC4Iz5rioOEIzw8cjtfJ2LKNDMDgbXA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:25.9786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ac86a9-d86f-49e0-efe5-08d58ac84430
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
index ba6f2019a3..2a002af66d 100644
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
index 2ff7541b34..884f0878b1 100755
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

