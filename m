Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548F41F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeCOW62 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:28 -0400
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:45186
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932806AbeCOW6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nXqFlot88YLp5+WpqisKmvuQp2mOAR0voCMOa3uiyuU=;
 b=Hq3nADRCElbbtfP5GU3+qWps3MLTfullepN/i6gXDoihq45nTzLSR+8wf9rCfNu5d2CUf0FNKMZ/ijkzVoZvoiKncliylMBStn59n5k51mG66K8SASAf/fyrCMrJQMiI2jObICVrkY/z1Da09zJCChToPd0Hdo9APQQM3zNvylk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:19 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 08/10] convert: check for detectable errors in UTF encodings
Date:   Thu, 15 Mar 2018 23:57:44 +0100
Message-Id: <20180315225746.18119-9-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e319783-1b6a-42bd-1a89-08d58ac84070
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:NbH8YNr7BftmHwn3b7oS5EQVWE9xnFPUp8d7oJTleIipQ8cQnjeIYqizUSlIvDuHc4pSqNVXF6POSUEUdOOWmj61sG8siKAOt7B809/9vZ7Dcy7xvVPgkDlhmKRKptwxTlI5CbEobBslliFLraEyv+LBUysxN8aUugTVlylFf6RIDIgEOoeSqBqFAaY2ChdA8nadAbNA/nf29bfrYm09wnqWWwxSDpvJmuAqgQK5pD9n/TXkKy9KtMzqL6gjIcJQ;25:3a8S9W5VIVfJs7vBgK9hqYB/w0a9po+RL3wvIEKENZXSHDWXpUUPS1uOouZDMQI9Yw6gj8JcneUvJRM/agUSKAyh8HPxQmZixsDZ45CVrWcF9bLFsnrGSqO6SCpSNxGBxK3WmM1m5OGY8gnRPriFzIMXtNGgNEpPwKb+byvkuRi+33rFddj3VAIvrWsS9xcyqu2t1mWC4EU9hUS+wauN+O/Ou+rDCwDUXUTRoel9szSYvK45tu/nNQUoU53z3FX1J6hw5DiuYpYnEC94rol0XVi8dk8rBPAJXUBrEf/MC/rBDbM0yUpofPsOwTvkIKFOrDquYv9LmnJ16WW9cGZ9aw==;31:ARR6VgaHgidffPEZ+3Bcaft3uAP2QDzfdWU9UeQb0eRJ0BcfVsynI4egI5Kai3IY6gouz4YffntE605dnNaRsDvmjwPx1PVdhlXkTrGq+MnyOAl7286fmi1mVZwU0PYaqVG4QloISw8vD7GtYBByo/sl2zfJgmamK/OpaDYjvjGsFwRiRl4no1x+LQpwLxIN6urAQzyLdAabZViZmnkOI/YSro7l+LU3Eyu9aYRYd4w=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:2P+pf5RNF7UXBpigL4nq38iZ9npKBZrj2dH5JgQ8hJ4ERjkzad01hu0De9WM13Dbyd7vi60eEXtFFJlhvcO6dDVXTHu6Df4/F7PSeuj9dwgCXdXH3iFbfUBi2kXuioZvVP//FJM+sCLQw/L8M1W/P5yyTnE1HIFFdJEdW+yGv2mXEBxrp2tG1X6w6W6HRhJBiwQ+96OihWk5reQp60lhBEeIt/tGavpw/mVJ4eMQr1/AMm/2X3v07rLLT8RiJn58fDok8iJ2XzPYgpe5abvjuCVC+/czKBhRSQ4xnrutpqjyhJgWEoxbO7J+EvgajTPd2Mmj5xpxEeu5AqA+KlvARmWnAifITCIeLEwROG6oatvMNqHp2t3tgzO5/h2x27Fz5vkRwYr6KI8eBLJwbKU7qhbxZhTQwW/0CJZDAW83Ixg5d4TAq5+FuLhaXLhkxof/TmjU1eruyehikyaDZog+/9zeWcpFouRN4obxVAgwjPO3guHbcQMstSURfu/CDxqlFwlilbibWoUJD4+cJWpzlJ6tmy0Sn8lRmAQQaV9RIo+iVulqd/aPlUYqrubCjWiDcpvxTHbuDKe1EKYiwaOylDgjrO6SBIaIiEDagdU2JPY=;4:ioFOp8/XMStDsRhNdLU2PJAGt8ZzZHuLQXWC3k3eZ/A8MHciLEQ0xywRelDyVKeuAoq7+OFMrbja5dAbvi/21as8QIDkLLIAG1GcEbgLIHZ6QiYEs7hEUMJxRmEj8IZrF//fgCs5A/hTh2PKAO8ApCndMFPbVEgivIGSEwVP/fGs7wmbQhTzPeAAjqAGzji74RKVWYI9kWJs1BwUt7KTNEKaqPgHrGWaVadJU+qcsocdubfQfx/7VeQqxY/kwARFiAb70YuPZrQvYbApLnE27JykDiAAKh84Nz5xJmImveOTjPG5CFjQrzTLiYFa/LDP
X-Microsoft-Antispam-PRVS: <MWHP136MB00141D0A1FA4774A4A1559DBE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(85782001)(81166006)(52116002)(53936002)(51416003)(76176011)(1076002)(39060400002)(16586007)(2361001)(8676002)(105586002)(47776003)(6486002)(2906002)(478600001)(106356001)(50226002)(81156014)(2351001)(26005)(4326008)(8936002)(2950100002)(6116002)(68736007)(3846002)(186003)(66066001)(8666007)(25786009)(59450400001)(48376002)(86362001)(386003)(6666003)(36756003)(6916009)(7696005)(5660300001)(97736004)(7736002)(305945005)(7416002)(316002)(16526019)(9686003)(50466002)(8656006)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:DYqpjgY4lB3rl1/HmIaBptpcdwpGiXf8v59Z59AeK?=
 =?us-ascii?Q?r98A9yLBZd7KDL/SubLbohOUxdDk8AUiXRRfEGZk4kxUvQLtXubIndZjAYCS?=
 =?us-ascii?Q?i5uOPlDeACTfZYTHmy6ClC3VK3YO2VGtOu27WtmJPPU6AL+MNX/EaKifu2Hv?=
 =?us-ascii?Q?NbG55a8AwfTa9sJ59pXE6Jdq1NvXjfYt1Ex1MFs1LMMrqpaRaTOwzme4+3pp?=
 =?us-ascii?Q?vv5TrPts2eUWnXRH7djzkeoOkCsUseif30dzo0wMJ3qTLr98Jq4T3AVGMDo0?=
 =?us-ascii?Q?jL38ANVtDdG30EtJWU02/puTSB/sFM3CV6yTlgKN6+PtKeXNYNrKH8wnStJY?=
 =?us-ascii?Q?UwIgwonnZoctr82up9HL5sDMxQ0muvVdGxd4Rn8MBjyirMMDYDGRaEXqTkYn?=
 =?us-ascii?Q?pDubyB5sSe8TU2PV97xvWH2TY0snfLa+xz/ishGN5cPc4O9b60PV/TCPZC8+?=
 =?us-ascii?Q?fDIO139/K/qQWnHha5mEiV/HU0awM2WvDRbgLMJt6cvXY1k9vSCaErCcUNBL?=
 =?us-ascii?Q?lhWmExIoZCVP3NmskeSC/Jw+rgEZ6SGM01R7zupLF2nxX/vM2jPlDgv+VXME?=
 =?us-ascii?Q?qIOTLwXDTZl2eP6HZWrLPRKWnjRTvS5Xitz17kpZns07V/Y3y65V7gOS56l8?=
 =?us-ascii?Q?zDycg1ldSWDYr/E/xHz4Tz7ur0A1NaYO6uIxm2Ogxgol4vhDpB6Wx4Y5t5G5?=
 =?us-ascii?Q?gCYBi52Q5U+HXoXO+aCEqewsRfKifrcPblTbF//mkL/QrExENzV7Z2bktG2y?=
 =?us-ascii?Q?1DGLdfMZFjgqv1hQbRssMNWIMVCW9+0027OzLjN5gq3f5WvkCykcibRgThLv?=
 =?us-ascii?Q?UQg6WB4Lua+PJ6I/1Ezc2IxMOW7Rijy5CUKzlqH3oII8KvCM8phnZlBi3N2y?=
 =?us-ascii?Q?bS4iRyfU+Q6vMorQVO1Har8rSelFH5+35XpBOVHziykhs53dWJk0LcdB1fwO?=
 =?us-ascii?Q?HEQ1hsILwdSqJvyWj3gjSE5oEu2WcY9mGeUTYiT5sr6ixT3nBIVlj5MU0Fx/?=
 =?us-ascii?Q?i0D1jjerSlAOywnY4RNf/yaWo5A1gngCWdsv7LvwCjg9i32YnCSkSly8D+Dd?=
 =?us-ascii?Q?WaCj6ap88T0TzEpMJbe00rilQR2q0p5yfJC0Yp/eiabv5UqX1J4IgLh6o5M2?=
 =?us-ascii?Q?aSIiYGbbLStmGYpAt+jwwEE0m4l/UC+Y8mFfYykFvgbIoDAYFurX4fn0IYiO?=
 =?us-ascii?Q?CvoZHglLn/kxXH64kwokgDjMhYRXVYNaruVVXW60uGcx7gDLnMxndfjUiAyc?=
 =?us-ascii?Q?RpV/J6kOOehEPcwX3sS72Z0+sfgoVaw2kDSkFNx4ylaJmKCKHtC/FMWBceIA?=
 =?us-ascii?Q?IvoniMrDHQ9lHV/pLclM2Y=3D?=
X-Microsoft-Antispam-Message-Info: ff2+WTdqCSbYBdD8AhrBVOPuTVQIMGhti6KlwJ7B2weTZ7O3XtwlRN1qGdXu7wSWbm+LMJuEEwpCRgL6Uwcd3lG5uh2cIqiFrF763axK7/nHS16GtGHjrBm62aacDGOVv0bY6WJxCvh3wIba7pwfRuvoXyyEW7pjHRAekSlHL0ylJC1SWI3ihwgT/3dg0v09
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:XhoERxDk41COosPt1flp73Id1QzKnoVfNSdwTrt5xjBClOzoVrECzEw1vvDsjmo1jaz9LRh8KkW9hk673XnnBq1ZtCkbyYXwA/MXedjkwrHFmEJSLqS5VqyOUoc1MDxtHattCaisIMgVY0ejGIsKDxg9g2Hn+TrpErj2BPBZlnYWwMq+8KL7meMHXdr7L1yOGBcoL3hxgMbaj1lBkqeMh+9kkPJq1O7cUw2CXBMvPD3C7LpZN1QRpdvm4QmhNnIuogee8CVKhIXxK58xVIHXmFYlmOZe2uajohFXVD/LQO4IxPkPS3mrMEJVO4ebrjMcfiUb//LXl0AGohovwJ5zx+o2sHWtCXaBf1aJJSn+/qM=;5:DXUMD8wzN0z7E8SsCcX7/iAR6MxMoBdXO4+2GBCLdy0IImkrpiBOrFRoTiQXZonWLvkFk1Rl6vKWwYTkTbUe3Uarbto+dc8MYygcgcCxR/h7qSjq+8eXzzkxlU0QS3jAU983cRe593Sj8JyRNM1K7Ypp/izy6klPMqznBmkXGYo=;24:zKEOZN9hPnrslsSA1zHlgh9FuhXWtztU4BrrAjw5Z1enYYGTCBGoaVUPF+ZUaP70QK6IR4j/0sbornwEMlV1xGS80Sg9E/4DjFVj6zwqFnk=;7:VxG0ztksEnhi05aZnR61mBF/ijvTH7G0u5A66Q+gxZuTowjVSj27TYO/NYtqLDftyOiAS1aXfyKEc6APWa0L8GC1OBpuvDmhd2uhpqvPRb7VKSgMvVBOeZP/m9FwsB47QzxJ6otV02iwHSzCSAnRVjrLkZi/eCCM9tBb/ni6WhX4BPMpf8PwxwtLFte7N9GrYHYq9cDwtOzjOVblkMIw7XFX6ljfTUNVAjE/TNQwIPLzU37/qyr9uGDA4h/cvFqr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:19.6661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e319783-1b6a-42bd-1a89-08d58ac84070
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check that new content is valid with respect to the user defined
'working-tree-encoding' attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 61 +++++++++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/convert.c b/convert.c
index 85e49741af..3cab4fa907 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,64 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static int validate_encoding(const char *path, const char *enc,
+		      const char *data, size_t len, int die_on_error)
+{
+	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
+	if (istarts_with(enc, "UTF")) {
+		/*
+		 * Check for detectable errors in UTF encodings
+		 */
+		if (has_prohibited_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is prohibited in '%s' if encoded as %s");
+			/*
+			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
+			 * We cut off the last two characters of the encoding name
+			 * to generate the encoding name suitable for BOMs.
+			 */
+			const char *advise_msg = _(
+				"The file '%s' contains a byte order "
+				"mark (BOM). Please use UTF-%s as "
+				"working-tree-encoding.");
+			const char *stripped = NULL;
+			char *upper = xstrdup_toupper(enc);
+			upper[strlen(upper)-2] = '\0';
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped);
+			free(upper);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+
+		} else if (is_missing_required_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is required in '%s' if encoded as %s");
+			const char *advise_msg = _(
+				"The file '%s' is missing a byte order "
+				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
+				"(depending on the byte order) as "
+				"working-tree-encoding.");
+			const char *stripped = NULL;
+			char *upper = xstrdup_toupper(enc);
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped, stripped);
+			free(upper);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+		}
+
+	}
+	return 0;
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -291,6 +349,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;
 
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;
+
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index d67dbde1d4..1bb528b339 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -62,6 +62,52 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 
 for i in 16 32
 do
+	test_expect_success "check prohibited UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}LE" >>.gitattributes &&
+
+		# Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
+		# but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
+		# In these cases the BOM is prohibited.
+		cp bebom.utf${i}be.raw bebom.utf${i}be &&
+		test_must_fail git add bebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}be &&
+		test_must_fail git add lebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out
+	'
+
+	test_expect_success "check required UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i} text working-tree-encoding=utf-${i}" >>.gitattributes &&
+
+		cp nobom.utf${i}be.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out &&
+
+		cp nobom.utf${i}le.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out
+	'
+
 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
 		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
 		test_when_finished "git reset --hard HEAD^" &&
@@ -139,4 +185,20 @@ test_expect_success 'error if encoding round trip is not the same during refresh
 	test_i18ngrep "error: .* overwritten by checkout:" err.out
 '
 
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out
+'
+
 test_done
-- 
2.16.2

