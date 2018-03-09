Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB2A1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeCIRhL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:11 -0500
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:10015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932375AbeCIRg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZTppVjTSDaCKGSnw9r1muWtkEesCztBTu4Uupy/5CPA=;
 b=AOIggz7fco/OZr/QQC+etopA3FLIn4mxet6v3L9em99Co1bM2jcMHIgHRZxkHell4qoy5aEV7ZtWOIF/AY8nmuyFOQ4EEO5+ayBxw3tKdAwQGln7S/wxeodPEQ9Ej1ig6ku+NwIgvckBj0Um70GmEdqEJyfQUnDYk7pXg2Fjreo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:14 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 07/10] convert: check for detectable errors in UTF encodings
Date:   Fri,  9 Mar 2018 18:35:33 +0100
Message-Id: <20180309173536.62012-8-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 548797ba-25ca-4071-b22b-08d585e4438c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:Uhi/e2BSOQTqGs/6bgAAaOlNQeWlsNHTqwEUJc219JCzOX+VSwDMcYeCa+eJYW3WxH7PVui+gxyneT6454P6H5XFhw2zSWN0ioOeQ0IRfktrvsovgupo8iYYEcS5cvFO2M4tpkYhhrVv4t+SwiaJGReJqq9eMpAoey6A0IpBftQCd0Eimdniza+p4/C0a7/xmeOaFFOiQ/79X6qmjA7OxKdyDB+1TtlPrQ67EOQKW/BJNCUQyv0P9vh3x20rGfMy;25:jB1VMRZGdN5j3EaX33ud/OoeUre6fb+sZaIbTgZkQUUVeScMjoSD9HJNMy+nZ6L551i2jbIE3sXTVmuAx3x2xZxM42Az1R12gBtgYUdgfVkFhkZtHk0bLAmQzodiRwea/uDyJMQptb31cMX/xBOM/Eu8IN7ASzNO5bTPYTje/t0MQ3uo0BgyfY54Ygdk6EAeeglFa+byVAOIURAViB+eshK/0DL472be6kWiSN4PPFA+J2zsp5MA5VIBs5nQIWcz/1eKOryK36gdJyO+m42Ic09VwgTOkGrRGvu21xdDvOi+IU70KsI1/X4MzBv/8oekrwa+TfJvYPM7GV2N7qsiIg==;31:iHwUe1+MyTdw4QKPuiMcS5eTxgJtBaF1TwBRmLa1EZPR8Hj+znhtIrXa2dAcG6lM2nIooJMA2lfE3Uk/rTmee4WzVcO9sWxfssF9VciY4qhvX4oGQSaUZtFqDb9WQSVJbCmgh5QznArhkcaEeslCD4DZrx4nWwOJwqYDbav6lXnDV6o94jMBvtIgVjB9MOjZVyaQzh3FWMGfA3z9vf5Jty8n/KLl9g/O4Svbf8U2n28=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:5g3LpBP912N+WTaJ9Xidl1sanDlMHlkIzGH1IOeBkwcQl/UWklufzeThSyYggEk/zR9+utisidamQ95ZHyf/uHlvyQpdhhyy7ZkBtaxQ8byuRiUPFI5GI6sbwJNrwuLMPEECOyMAbDiptYOgpwR/DccsGx5ewwhHI2XkpLTtJ2zutl+WHPzDMx5ZO006ccwoQJqe0AyKIuI9EGwuNOspPi7QiVTk+TRB2Z0EfVdc5Nj49C2/6wkPS76byrhN8OSbu785UQIdnbhEquOH89NSdYevn82XMcuPhazgL5WPDa0m1kyfLe9vGGAI/2q2TuGuI/UxSfyMILgwnrD8qAHObEeTAUg79BIYi78jjBB9uZUSPzKFoKsK2/4hyOnIzmZALfMpoWt7DbHEgqInXMZgVPCggrldWSXBJqdJXny2f8iRIaOLhh0TGls4AZ480FrRKnzZF+wArarZZnTj2GlHw+FM/DsybY4+3ULBXor4CYsH2k5fY6os1PeMI0LgYrCP9LYfpvsRiqTAkfU2lcMT3iIcgMFRfZZH+czBpJp3GmkxELUaG9Ib4RCJEqQH9pNUvMSmMTRDBJTd8Hx0Lw1BXY86FtB53byYdUJ/ilFagpA=;4:X5Lf4XZydJm7LaAH3CaYXPegAvvHM39sHTNuaDXs7NtsWgfLnS+Iq4MpLzJB2BEpphsOPzlDJC3grQJ6hJdDSm3pFNHWVGj09AVyHNjhecdMGm2bPPBX4HfOPvRcWHG8qeH+BJUMVnyKKxoM0ecShTjVwND2Zdf+kNw9twXAPngl8Rh7XneGkmWCfpCmrtYycM7LKJJXIcsZZ7uEeezMhheV7pUdnZTS+tetvDd7TXAdxDsSBnOyZ8k4N6HgDJfm8bfgoE0H5Oc1qI9K641dKJmXB9LHU6bK9rbvvoQGjiBcQ1MV/RtEEBukY2CcoZVT
X-Microsoft-Antispam-PRVS: <MWHP136MB0015F09D2B6105610F0F5BFEE8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:cDu9N9cao/vlDbKIS99c78yq/iA9hBb1qUfC21IRg?=
 =?us-ascii?Q?Jfl13RCEVw3HIB8JCmelUa23Zgi+dLqtHSTgfh4uYjXuCfaymPbLuKlijiNL?=
 =?us-ascii?Q?ypUvTgIPK+1DPMmJOwTwr6BZs0koyey06aE+F7W09Z0RLJD1PNN9FqiYsUWo?=
 =?us-ascii?Q?yUKCs+Zjx8kPjMU+VjET6XuPCm1dUCT6HJN02guuVJL+HKfs5lbFXDEd8Hc2?=
 =?us-ascii?Q?X1xNozrf0IPi3FQL52tAU5Ykehv9UJphjKZ/v3HU9l2C+3Ltff6TkL6EYGh7?=
 =?us-ascii?Q?5zSL3okOoFUwZEQ1g9chsxYAE1DkYxCrPkVm9AyZHXqy0yeVax65MdbW7ZQO?=
 =?us-ascii?Q?OahKUCN4mCyRDpHnkKQ3cp7khVisjRA790fXUlHi0xWNfrVdXZWW5tXeP2H1?=
 =?us-ascii?Q?pp8KOfKZwUtKbqyztXRz1FXviShlS/uEfqaC1LqFtFV8dyWB4Xjzskrb7P2/?=
 =?us-ascii?Q?gUXolKh4bDrjjS4jHZ99cfWTab5MqGvQ+Dd2s3RBrqrc0+Wk9q4FW78IV/iq?=
 =?us-ascii?Q?4TADYypxmLcsPINf3aDdVfMMbxve+hgurM9cT0S5LSkeUE4Jr5h8Y/P1YiF+?=
 =?us-ascii?Q?qmG27166rT7RF9nMwOoVLP6l29RqMREa6hP+x4ko2L6bFdSJeoBZ83QY1LNf?=
 =?us-ascii?Q?v7vHTN/sqiM2G/t5r+h9xvWUcCf9zgjTUpoFZLEBIjQsF+xdV8RiIkyM/T7M?=
 =?us-ascii?Q?HYlfZWlXKlqAQf2gVajiMv5zjj8/thfwx7TSkKtozFWhwpAq+c8jrHYHhyQW?=
 =?us-ascii?Q?qN6CBVNMzR5hybQC7onBCNp9hkzE8QzHr/ed6BWzO9DFlAq/V01zwK/YpaYj?=
 =?us-ascii?Q?hykE7u/mc+8h3KgaxDw3Hkpdp0vUG/vss9fIXOiROK0MeQgLI03qYS9chZTc?=
 =?us-ascii?Q?HsAFPao/NOSkYFZ4k4dUTHkH5SvbHM+8JpoNECWsqKICd/oZO1RvI/nvNAe9?=
 =?us-ascii?Q?bjU7QwgqYif2Z9CQtK034qdTYVG0kxMuyWZhwRVl6EWl1VqwwiidpcFFggk9?=
 =?us-ascii?Q?ZyGK40n8N9jvLQNlS5xkJVfTxjDNKnS/c8e8eiOpzYxDQQHTtL829Q0Pm7Gi?=
 =?us-ascii?Q?TK7ialY6JCyqRZ3v5/HnKoxHLw2RE4SWDSLcyCYemyA2P2lUyuN+aotUdwdH?=
 =?us-ascii?Q?cvnAJaBeE8xyo4F2rtsUqdmwNGuAlzvR8x4iU7rbJYoR04Cr/7yp2Q1zZrHJ?=
 =?us-ascii?Q?vDXUE3upNDTftmU9ZQ+DFMzv8tI8wlrpx9LEJLDNsUqerlltiCtJiaE3daeq?=
 =?us-ascii?Q?qTjocnkLA+XItbXMvkDh9a9yHildTC0HoE6ggl486oz6985J9meHrw5L7UM0?=
 =?us-ascii?Q?WUqOL08sZGvJkOPYjVmVUk=3D?=
X-Microsoft-Antispam-Message-Info: sK2NUNIJLXhXggElct3JF0FYazBVsRju7a09dsh472j3hHGO/H4Ka1cYZa/kWZ7fqJ6+7XRONHLcdJmdJQifACHxck/Q1F6xAJ6zEKpAnGB4rCWgw+RacPKPjAsPMPtNI6QNFms2+ybBtmyGFqI6qpO7Jt03v8XtvzimPt0KzK7lqo51MxeTJ6qTl6BqN/E9
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:kvPaUBvY/mqRmmgjn+PrCJ+7OmnH4ShEmEOuhhTGGScfuM/IqI74zr1+YsxPUMGaro8nkSl4Z3scEtFH9xOWo4nLuEouCgAekLevOx9VG7V0wmcCxXI5NOKGk7OoatK5IfyGXt6yHg7popun/U0zpe8/uC6Sd482xae0AdvWEoZHMcDiUkj5JuAMZHq2zf2Ypl/c82nErBLDz6l1vwj65qiJCZQN0ebPr9rw2Gx0fDOM0g5sOvYJ8v0zudwptgHw4bdh2rjx4I5AEDUjla+BsLTTAbtjaZGS9HQwBB+npCNbTQALE451tbp5jmvD+cUrLbo0HXlyhQMTm8Tbav2yNaLSYZRPqzrLp+zf0r/jGXw=;5:2c+i1bsd9tGJilhiwKY6elp8d/Egit6NA4SN6FsAvW2yLmHcn0GFRaoHuhlDnLYzCcmgsOKGNPuFWVI7rsZRIkKw9dKQuVVKTUR2TX5XZcIt8q/UM63J0SCJ8WAmz/VuKf4Ah0feot2qCgP+DP6cARDm5TlDcffYmWb7tOnjuk4=;24:CpaG8JNdLyFmgVTR7nkq6w5qKwc/Ifu5gjT/fIbrl+aiOcSroxeyld1/RwDtvDSO2+iwboY4uPKBWYGgqj2TPU+hF4JVCLKyFldC0ZDIyLU=;7:cU8SzVbTNiMwPUnKgUHCbE2/hEZSAVpLkv6DXoQsK3kdI6eVNWq56Etsfgl4ENy6ctoUdQLKHdesNA5iBTAzyAOqZY6zpYBzAfrOPjQLcqOFFSFNGLx23fxMuetMY9FF7U2sdqIV2MXN8+xoJp4gI2Lh+dBCgAa55SjcnPVGpziEkIPiijbIXuB4f3WH3Jo85jTLn++ZvQ5acQJUC7N4rVAER5g5C++VVHJ5dKt1XL9vcv/pVmWWpYVOML/x2PtQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:14.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548797ba-25ca-4071-b22b-08d585e4438c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check that new content is valid with respect to the user defined
'working-tree-encoding' attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 48 ++++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/convert.c b/convert.c
index aa59ecfe49..b80d666a6b 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,51 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
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
+			 */
+			const char *advise_msg = _(
+				"The file '%s' contains a byte order "
+				"mark (BOM). Please use %.6s as "
+				"working-tree-encoding.");
+			advise(advise_msg, path, enc);
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
+			advise(advise_msg, path, enc, enc);
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
@@ -291,6 +336,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;
 
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;
+
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index e492945a01..e8408dfe5c 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -62,6 +62,46 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 
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
+
+		cp lebom.utf${i}le.raw lebom.utf${i}be &&
+		test_must_fail git add lebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out
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
@@ -141,4 +181,20 @@ test_expect_success 'error if encoding round trip is not the same during refresh
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

