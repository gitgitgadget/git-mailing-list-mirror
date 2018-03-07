Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC951F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbeCGRb3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:29 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:59904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933612AbeCGRbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XToh5MetFEN7hEd/NC8KGPpqxA6o5vFwsccaqQ4SrDw=;
 b=an6JkKdOC1wMErqtgIahgvNlOh1nqGrX2gjoK1s93RXNNWySXhmV99XS5VuAiSv4+LS/GY5C/bWcOjLsuo5Cy8KhX8/LIyiNkjGCjZOcu193i+voYspI/tQ2d9MBVp9wAY/As2sXdc6po7xJbOcbC+OEzjo3T4BFIFIcqWZ7Plw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:12 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
Date:   Wed,  7 Mar 2018 18:30:24 +0100
Message-Id: <20180307173026.30058-8-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a46ebb7-4a75-4c73-6f62-08d584513ab4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:VFkRZlCR5nlwd7hHpAsjEeGk+MDAdfktKd5Sdd06LqZ+mhtDxYCZkBpTeiWU4DLImB8oqOYogbfhF5iGemUSlU3C+7gOg7cUXCQo9PZpMk9MvL+1VUoBTLrtQcmfqTjlERdnHNMrQ2fIJSCcx8QYq/powDNe6PZIIKE/j5ES8WhauumkS3TcvjqEBENWbbTMBMcL041YrsJR5jBVyOnEj8QCaqkCojL2eN0tm4sNJHkZ3EetU5b4C+axI76KkhVT;25:Cvp6KwQq+54jTWqtSS6POLBRbt0S1sCRJTEDsKrI+7N8hYFF03TxmaL5Vj/GF1Knct0um3Vuyk+7vc+k8AoMxwxpHMuIKEASkD37Qzt6B/vFgvx2rSca9eWjYyaOGxycVNElcct3YZ10ncnZp6UcoL3tXokbV0LXRKzQV97xIWX597ieXBwLwcAoqBJ/4gJ4n03BCcmyYdSFrCFIHNFH7ylTVPVn0CfRhD9YIgCkEh3GKATrhLqURMJJo1MxalMljvbZjJFOpaIHQPMNl0PGne+NRFbEvhBKS6acQegxgepwnD4JuHKWXBbaHHKcq4XtZZK7jOxtAUK0/p52SPfsFg==;31:U0xNFJsrIOL4k+VsE67OIkROZxt1HNr9CmsVb7ajJkMXFmduOSEXQrcN8f7SuvK/66EnFWxShUxdUBvjg51R4nrJfPbAZ3IS4PcbhTdVYg7bxpuZ41L+jaRuTXXL5lX1ER66uzovpiFFIXgGah52IJyGrpVg2TtLAiwwgNasegnBXxqZZEqjMWI7jGyidCVTqcePacOSYkBOZF80Dw281o5YMFONQL7wzOYSzVhZUOE=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:QFFBkLTGI25y0C4+45W33fmkd3KhXlzWSVCv+H5t/zrjKvbRRrro7Phn1WurgsBydCJRINMk7XjgbjLQgfVumwl5XpY9BCWdI5qlpXPSTu0Ng6xtR57qjl6dTRgsJYSfAGGGVgmOp7TEbSOfR60iePyNpQ+BPkaZYbGcCFYyWyT7jdCHF8mH3CdV4WOjF0zUUbq7XbQzNKuO+FHzM+p6hfHdyKBj/5YNlJUIwF9k4KChaHwOxBEvlzKJzPSVZ7eYpVshef9qIDgRncjZr6AH7Fl9hQo0foW/FiEeSDU9iBX4IORbxIOaZk+lwFh0J5kEQS7YNZUHJNoncZt9S6BtpUuHQWtR+x7JnUIjKRFjRX8IH/hMUviI7I1uN3WuA2Z/BDIt7vBF6IDkROd/0yPxLF0O9wEx+RrXFTdRtVewb6zIm6t2gWLT43NCbK6yUGX3c7475I+zCLjFVhRtMmEr4+7l66YMrgWZH6GQZsC/ypphKmlPHFk8EzhiuzBWG9BP2r1Vfh4MoEx6o7gEWD/n1CMKPVOQXGdgcrEGcyW/zgBdTNfq+4kYUrJx96NNSlB6N2iBlEDmXijoRORd6lxgAjhjyWtU4FzjFViur2OGUzY=;4:x4jfkVof80faM4YS/nQ04DZpPhlO6X0ICgcZUpydzCCEijk0reOSW55axMd0bUnk25PgOCXX21ptZ4hH0Hh9dRpMGYaFOv84yP4Qlle4hamUdnvOO2z5H+Zk9mPoapjWegM2oGHsDoDVilEeXQnx9Zisdc/eDsX59pf02G9Vz1YzaHOJtKdgE6jyYYoCblehIydRT337m8t3X8vcuQs+W5/RNayUZcaxXbe2OPrcqh3ZwaUznTuK3hio5RCEcLoZt5V4Lyct0FmHZ2RFHFoMvJ7CZLOFtk8Eep4s48ISc3tFscW+kKvNK8xJmGWz+8t+
X-Microsoft-Antispam-PRVS: <MWHP136MB0014D0162E721A47964CA87DE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(105586002)(85782001)(50226002)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:aYRke742OKPWTgwBjTzhCLrWVF7Jh99GYppHL9I+h?=
 =?us-ascii?Q?UZInHGvylCDsLdxEXBtrh71iOutIVdLVeLz/h8RUIkIIO/0/0JmTA+MmkQmK?=
 =?us-ascii?Q?L3ezTGYrGX+spf+L+v0B2sO8gCElhrbt9mrqQ079kdGXeW+9hn26Qry6rl3Q?=
 =?us-ascii?Q?ZJY9AyaY8FS+CC6EmybETgiiHNUzgjjKoqpwVIRmpnCBxB8ORCtaEaDbi8F6?=
 =?us-ascii?Q?Vl4JI3xnmB8PuOLbgOEbsf9u1t8Ltn9y2Qk4V48mK2EYx1IMwoUyPQODIea9?=
 =?us-ascii?Q?A3G2qI0ooValtodixTPZkQnd7n2oySjg2nF6Uuz2AV2oBBu8ky+WVGyh8EKh?=
 =?us-ascii?Q?RqQ4hZwBuzUBJvMsekme2M9+s9vX9hUuzxJJ4AOUz67wVhWXyGCgJ2+DX0gR?=
 =?us-ascii?Q?l8TBdEsjJxMdNSW/qeRBeinY5K2OaechAzrY01KLrMMyymJN9Y6fCGjoXQle?=
 =?us-ascii?Q?KrClTCE5X92s5wmLadgeq9LzHLoek1B0ck9h9On/NKQRULKlP5NkIcT898Op?=
 =?us-ascii?Q?c/HDlr+hzNUkvKS4OltoWtxLw9SEUrCn38JmzUiCygFfBz5ksTEjlFRQgmHZ?=
 =?us-ascii?Q?cz7zgoPxMYNT4gjUVf0wLyxTWOKJJWVbarwQ8JGDkpMdtwEno9hCiFT0Qcbt?=
 =?us-ascii?Q?IaQFFsS5UzSpCFvnhKEBPVPl/j77PP9yE7cQrZl/cpTfIpP+zY1czl/Ork3m?=
 =?us-ascii?Q?OavJlx/LOGsmw7X1WNKK5kPAjcartc+859byk1GeaPX2JIxqVyxlDNXm48mr?=
 =?us-ascii?Q?ZOXMH/H8D83II+pOdp7OEuYIOov1diU1I31z7UygXLJSKRv5R+J91ulSj7Wt?=
 =?us-ascii?Q?D6mUBbPbgOML6clZjFnKBASFo7K45OHZ4ULg0ek33sls86xWi1ItslDpy0rE?=
 =?us-ascii?Q?WsR4rAIaT5YnQIXLvMFzC+/IjqsUxAcWsNL74Lyu96K1Ykoruk3tds0WM8Fh?=
 =?us-ascii?Q?qQVgujt0C4kXgOGeSm03iMFjpMZPAe+gWkT6tEzfuYKi/m9otTnT8Dd5nN+U?=
 =?us-ascii?Q?pfpQjo8cuVhgDwtK7pPne/Qp/QxxeWrRJG9YRacR+/a8pKxOjUSyN/MRyzCK?=
 =?us-ascii?Q?yeojWqZBPuPafV/ArWGFBWgN5Rmacw7HtSE9XUylSFUnQGRR0tmGRy7BO+OF?=
 =?us-ascii?Q?WfL1+hwwky6a6BCFh0qXBB/qQ4qdCWC6H/+TFkOn78kGQE/90p5tKrFquh58?=
 =?us-ascii?Q?XzB7W/h53rLawsCHuKji/aBYFYARHA9Djn1A63OlmsdD1aQjk8vYY3sJJRza?=
 =?us-ascii?Q?pTXIbLJ4BLqsmVfZlfmxovpt1zyhUCchGIQ6uO8cmxaxKVvjS8vuoGtQe5bV?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 43Bz08CVjayBBrjy/Q7xu1sMvWOvV6SjsKxRKB9F0T3njdXlBt9DTsYwMxErgo/x/5hh2q6LxVBxLEaFKwC/fyOuPTxexohgATnlRBT/29lVZg/T2kZv0QbKprrY2U093fp+qiGMTZJJeFazJ70dAmMmA2Kf9fGaSpu9EMaRN/uGueAKPWdSKHhD2aKwkNHq
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:ZB2xDJkCUvGPD5TPZaoAoB+HMdBeinraAZRkshfNBICKICiDlMtQVTMNdaIYG745JLVWZKU1+8xBZDY8L1OGYcoqTeit6OUy8ZDS6ZnaCLxxdUcN7tD/jgGdvZ1U3h7FSdf+8zRJScECIxdMbTgaxNEyopQS7zwkZ+LBgQNWO4x+xRhFvDCN95cFRRO8jH/kLjE0OyKyQEPyEXQ0RPbFrdM+yniw5oVAv7CgjE3r/VHpSh/ck9Z92yF351HgeVFyqQV2a8wQU3ZLWe86MRZwkcbHixLbAl4wUY49kHvNUIfHc1//am/fAM2Pn4rJsM5ANcwBYNIG2R7Uqj/pWvWXE7peErRJYlPG5qmUNQ7t8AE=;5:jKO7rv+xqWkeYnDMIFBseIFnSl0NdX8QlhAlBVDS0jixlXKJYkRAH5jjj4V90fW5MqfXue/rxqFz6Snji8eNq1yvYOMAdCohcQiymXxdGLFd16A6Wv0mqdTWViLrAMTMnOZ49rO+6jl6OwQT/O3ObiEg2icm4qy80/y1nzPZc3U=;24:QjrcMfgDft7T2ioUiyKJ/4fxhBXFusOYPMznJa+a/MITExxXpkY5lO7qRDIJ36+3ZqnaDRbQHgZ7okM1QpkWkhE3TOnEhP2RQh5JKYlAiKk=;7:4CDFxdQiFdnslt577gtevnFRuHa/U4bkF0cGh8JvC6U2VxuPOY9J88SrNvmuOytsJTN5m/FXthCylt369LEzkFQ81a6P9ZvzVQbRDt1ao8W/jTQtB4FZQZ8Wo7o72lToMNZ2GZe3QGmlYL+taNt64xCF9co0BXUUW82A92/jtifpKUTTmTMphuSgZe9RrKMlI4brAkt34NsTDWuy8UjPnFwXHkLLWoW005ET0kKa1i4sB5paL/lIgPAv3JT4vPv0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:12.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a46ebb7-4a75-4c73-6f62-08d584513ab4
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
 convert.c                        | 55 +++++++++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/convert.c b/convert.c
index 80549ff2b5..f19a15dd02 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,58 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static int validate_encoding(const char *path, const char *enc,
+		      const char *data, size_t len, int die_on_error)
+{
+	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
+	if (startscase_with(enc, "UTF")) {
+		/*
+		 * Check for detectable errors in UTF encodings
+		 */
+		if (has_prohibited_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is prohibited in '%s' if encoded as %s");
+			/*
+			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
+			 * We cut off the last two characters of the encoding name
+			 # to generate the encoding name suitable for BOMs.
+			 */
+			const char *advise_msg = _(
+				"The file '%s' contains a byte order "
+				"mark (BOM). Please use %s as "
+				"working-tree-encoding.");
+			char *upper_enc = xstrdup_toupper(enc);
+			upper_enc[strlen(upper_enc)-2] = '\0';
+			advise(advise_msg, path, upper_enc);
+			free(upper_enc);
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
+				"mark (BOM). Please use %sBE or %sLE "
+				"(depending on the byte order) as "
+				"working-tree-encoding.");
+			char *upper_enc = xstrdup_toupper(enc);
+			advise(advise_msg, path, upper_enc, upper_enc);
+			free(upper_enc);
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
@@ -291,6 +343,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;
 
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;
+
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 89b4dbee1d..aa05f82166 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -62,6 +62,46 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 
 for i in 16 32
 do
+	test_expect_success "check prohibited UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}le" >>.gitattributes &&
+
+		# Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
+		# but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
+		# In these cases the BOM is prohibited.
+		cp bebom.utf${i}be.raw bebom.utf${i}be &&
+		test_must_fail git add bebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}be &&
+		test_must_fail git add lebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out
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
+
+		cp nobom.utf${i}le.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out
+	'
+
 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
 		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
 		test_when_finished "git reset --hard HEAD^" &&
@@ -130,4 +170,20 @@ test_expect_success 'error if encoding round trip is not the same during refresh
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

