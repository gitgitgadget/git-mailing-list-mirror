Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0AB1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 19:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeBHTYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 14:24:01 -0500
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:62262
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752380AbeBHTX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 14:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0fuEVNOqygTzIioPiTcycxupdxpW/NXJthKjZW+m9TE=;
 b=GD/J16NmGrnXPAz2+EHQXw2avuQxtR6lYY7oXBnsx+yb23Lc7El4NzA63pO0i4A7X/1NnLTa4IkA25esieTJN73K436l0pvbiyiXBdc+11k69W9Cy6SXQCUhDvgpYzuPOPHDnvR7/vWpnGMWXnjvYSYsxqLl7sG7fdL2FgSX7aY=
Received: from localhost.localdomain (70.33.148.227) by
 MW2PR2101MB0905.namprd21.prod.outlook.com (2603:10b6:302:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.506.4; Thu, 8 Feb 2018
 19:23:54 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com, git@vger.kernel.org
Cc:     prohaska@zib.de, gitster@pobox.com, tboegi@web.de,
        sunshine@sunshineco.com, novalis@novalis.org
Subject: [PATCH v2] name-hash: properly fold directory names in adjust_dirname_case()
Date:   Thu,  8 Feb 2018 14:23:33 -0500
Message-Id: <20180208192333.7436-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180208004156.36224-1-benpeart@microsoft.com>
References: <20180208004156.36224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: BN6PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:404:10a::31) To MW2PR2101MB0905.namprd21.prod.outlook.com
 (2603:10b6:302:10::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2496024f-3411-4666-7ae3-08d56f297e73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:MW2PR2101MB0905;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB0905;3:KuOVl7n5Ul826tgBEGRjBXkPSxaTIMX9veWhKXojEcGifV3U5XxdtjcyVGO/OrMlBfysRXuUNGku319UHvcOdjmTU4TqK9Koq6VxqBluQTnztSZYjOoKDXSyxGaCTg9PPSvC974GDBdKWAeA6RyWBDF+BMMHLogoQ8eUNr+ZgR+R37xvuiiBjgiC7xzRy2ZFewaoHK7vOBlnK4UYSTF6Jt7GXoNGhCio3y0d94FchrtbFZzZzno2zVBazwMAf5N5;25:SW8gqn4CUbgRQ02UZNcnu5jQ52zYXdjSEGTIrEjoMyGYeoKvkviMCWIsu0tfIbLAOHsq4/P+7OYqrH/FvwOvLVLVq/j0d6e8/Hwc9aDSkJpjH/l8wa+7NDkrfDkKyucBl8nfEKGbQYhH7z4vdkDl3cbPgRuatI6VjMH+9rkNje7om34WT4iT7gLpTj/OiKvYBl5MMJqr4QqWhoHIXwBcbLnFZBQ0aJHPHNGqVPvA9neAiA5KVdLPKqCD8Som5/PdBPp4EFaDofwQbQ7YoJNYKOaJWDIaR3Hbx2ORL0M1eFomr941tUwo6OD0UmXDddqd7DVrl/qgxBO+RCtjG9z15g==;31:gzS/550gQALSDT1jPXay4AOUl6zXrvTaOUYTcbufDFlyFzAUZEixEIbyBDTv07EWCFi43KiturSw6LneBvj61GekLboKUaoWB1KBRGC3GtHgBC2c3HkJIAqDTsvfbOekcyi6srP7UtYM0/n2nhZ5+O20zCrypaVtMJEnXh4u1b0vy/E2HHjI4YZKKAZBWkBOhhOyJa1Q+AZGg1rAFLtlwgvZ6V8jl8G6RHCv619+x/I=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB0905:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB0905;20:BvCbopEFm16dB7Nuiq1bNltw8oJ4GtOtOgxev+lazFYix5RlS8WQ4dDYOrOEnYJZNPURxgdwSQ87IQR4oVpM+4+EFSTKelyZfFqSuOkiJ6GMpHgOfun2GbPvUJETfu2Oneyk5SUaDQyOkxJJ68861OgD7LgtTPtGjOia2ITnWQ1fvA0+Kr9GzrFE6Zt+eYLMAu46HkKUg7fRN+WTOBsb+BKAQoq0/2JlAFaZE6IEt28+HEedyJ1yfRLYkCH65ZlwQFVdMAT3ZgueCgyeiErqvIH9XPcEVXBlgLvbpCqmQ56zosl8SB6ptroU61gfrtrlrZS+KWD6d3Lmrt5vcy1MNpjwxGOT0pSAc6RpoZHDieDymo+82t6oa3eJRIjuaFl3m6TxmfRdbdTcrSQ+S2wOhGrnnjI+J3iN7cTJs9yal7TNQUukX+VqTVi8rg7Did0H9Q6TCsnAMPB68xkL/ZeqFacXBqYGy34/fypitdXHHz5BzvUJMkRVnUWUNXHBXPeJ;4:u61gO3AepD1Fa1SGPpOFtwW7u3/A0ZdqiNQosk1QqsjqIi0j+SBxCbWiJ8HWesxiTDyUmS02480JQO0sFom0wy4cQN7nn05d/JR0gcGv3pJ7GqQ2XrxepuIsXQxn1qq0N6eHVhLUdRrTyNATPSuoq8gLjpgBnwQhhg6smZDFOmPPBAV8Rv8oBWS3L06bOFmf5NhBTx+U7AjXzPmMugkoRUiGSxaOkzZgx3mpu7CSA7XUxSVcNnAqyPxtXlTEQMps8DpEgLjPWi+1XELG2RxIKrd/EFkScFvY8W4II1VkSyURObLQlU4ldTR7WA3ZPHef17+r952sSiVzkqBsJaXFPeqo4OydDTT8bEMz2nkvAfsp+BxDKhItKbA/jbSOViLf
X-Microsoft-Antispam-PRVS: <MW2PR2101MB0905BEDB4B0BF848F9A6D35CF4F30@MW2PR2101MB0905.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB0905;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0905;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(16586007)(48376002)(76176011)(8656006)(316002)(50466002)(10090500001)(36756003)(22452003)(966005)(47776003)(2950100002)(106356001)(6666003)(1511001)(66066001)(8936002)(50226002)(478600001)(4326008)(72206003)(5660300001)(8676002)(305945005)(105586002)(81156014)(10290500003)(81166006)(25786009)(6486002)(53936002)(6512007)(6306002)(26005)(575784001)(7736002)(16526019)(59450400001)(6506007)(2906002)(386003)(3846002)(6116002)(1076002)(6346003)(97736004)(86612001)(51416003)(52116002)(68736007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0905;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB0905;23:1Tb2/20G/DZSA282eYBHC3YKB3+6YRNu0oNF7tJ?=
 =?us-ascii?Q?hN4Yh4BlCCpFCoaGLyXZWaF6bwuOmSWpKpWBzGvrTFd2tkmctONY9+fgzBhv?=
 =?us-ascii?Q?E50mrckizY8lPNsgdTpuFXYHFmZxBAAraSvETmXu2Wo11NilI/fn7n9IfvDM?=
 =?us-ascii?Q?3UNqk1uNVq0THi3Z2SCNjV7gD5nELs15xtqlbLGaesbbuIa+TrLX9jkeG8x1?=
 =?us-ascii?Q?hESED8VKum1FYQKZOF6dbFHppi0qSZcEeKdcYcxPqX+rzjgdMsI5ndppFgL2?=
 =?us-ascii?Q?KA1MVjQe1VFOSrsOSLHi+VxTJjpqzXJsxuQ/B+hG08Of722YY88Pw3wyFAu7?=
 =?us-ascii?Q?cbRMkE998uTJdtBe4ikXPq9gkdghwG/UzAj/C7KiTf2I866XQhgGS1WoNRc4?=
 =?us-ascii?Q?nUaLQEDzgoRXdmgpVzHbtyFvNK1Ksxb10el5hBkWHu+F10P6sawk5If25Cm6?=
 =?us-ascii?Q?nx6MdQ5QsGzULmqro4OoTgw2ahTA3P6/RWvhpo2TfpvCSgmt1KcMsrUFkGPP?=
 =?us-ascii?Q?zUX0EdBEowb5TAYjJ9I5Buq2C4OudZdBpOcKn7DNt5aYsAUFPW5nxJqZhHPm?=
 =?us-ascii?Q?5NJ6wY+m1ICANqCwYU0sc2d7FCVbF3mhtzVWHEJS6mQf2Mi8LODY397I1/5D?=
 =?us-ascii?Q?LPFhcARsc9DVjvYpWSBymIZxZoem8HFQGlY2i6JH4vw1SANmVVLxAOPze5bk?=
 =?us-ascii?Q?il5xq79haemKLBKFL+DUVKL6j9lT9rcq7F+1njuh6/TKuHfTEX4UuAggMUm1?=
 =?us-ascii?Q?WSz8K+OwehKpUx5RYTX/T13vyoZHNseUYdff+s4qmHs0P5td6Vk9MRH/y8gG?=
 =?us-ascii?Q?A7twoG5GdqeeRe4/V8nvjCRNWGoQxbT5s1r6es6R+grmihk9qD/Go+f2uMY0?=
 =?us-ascii?Q?CNT3QH+LScK0eCcyRX0zblKzz+cSHtvpHJnaygY4g1H+4Ir8N8uk+n+yUn2Q?=
 =?us-ascii?Q?tZiGYw2ZiVn9dDfGHLc0LEqOF9SbFXq9nNN9HYT2ZcVE7XITARSC9hWV9ElX?=
 =?us-ascii?Q?Qq1r/9U5PgJG3En4yJFcjlZHuHsjAwAdwFsUoC9f/myDQePUwqfmHF6tblPX?=
 =?us-ascii?Q?7TEc9zxqv+PVNJdJvJUtuBzDbNLYRRosjmmx6YJhqJ79KMXGmJD4pMISgNmG?=
 =?us-ascii?Q?HmL79n+2wNNm9qO2UUepZuS8KQ1cz599V/EyQhNeFe1gjyiuiC08qKLcCV36?=
 =?us-ascii?Q?70mjBYORBJ2O9vGs+ARzNcGP148NagJM5a5Nur7jcmebQqfEFoQygrYHSwW9?=
 =?us-ascii?Q?UcmZZxQInHAg+3qRZZuz5L1axorAw5m8TkRz19b5sXNHO1SFTNgoPyMk/Kke?=
 =?us-ascii?Q?ZNucwLWQARKWNvznXo+YMUDdUXKqVCKsROp/bdA3VRacTxMrLjmq5sgDut//?=
 =?us-ascii?Q?brOGo+A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB0905;6:92gxWzmD7AoRLaDTfwIQTHzJa23+xE//EYs5L/nqdfD87SmEPQKzO8uOBLC0gkdiIT7bcpVlcOhH8lFgQ23XMtCzvFZZlcJfg1OPh/DlvQkYyr5jeRbfJAH4FGajH3A3r1bVF12ERSyK752fT/k5Xjk1E8+EKFSeMdB+FZOF0JfJ8E+U3kWELGtFKZLObB0TtJa0vLgGAdZI/xf0Mn4Up9552rVhzUu4RMfmw535KqYtrnMtHchdz0IughZLOqE60H3nDd1Yw4TKKnKORJwrFr2QiUZKsNvlxVs3+mMsczOSJNCQt3BjFUCri8X0scgeNTBPhp7FlIjap+mcz0am/3kB86s+nrIzJbYt8NBViWg=;5:d11+eVmhJ9WDz5Rg9kMjzA/t3sfz6j9tKulB9wRDEgbhgqxsPMTLrsM4F53VJkMq3vS6G3i/P9qOAXdcEX3eV30uBm+E2vy4404dPkrqQKz/jOD3a9zYE3mbknrv8q7Gv2QgSchLVE7uVrV94QCJKUP0zSt5fudcV7DXZeitSao=;24:k/EQeSd1Yd2CtwaoyGk0Kbx5gnB4naFP6CxMowtmxXB/K6iAGfUtTx6jQXAbXWR6pCV0VWitsZRoIKJfSS+4iOdMLK1z/DsC7hvWzJwUhF8=;7:wCvzRsrjPNa9c2Va4fjmI5wm2DTT3kcwaP+lJeHBepuWYdYFX1H840+oNET74QHr1GEtoKQA2gYbw+U5LSPtoLRqBejOwEmT+7yEQkgooPf/fgLZIvbYHrlik6OXV0vPxkjddpPIZzbysC04JS1sSn+52FWbGNmgM/GMyRXw89pZEZQUx88/kPXtDVe8NCDwBD5HeWoLisyXEmZZNifqcvCZuw5q3RCPHjv0JUZo6hDlzoLjSgqWWvdfw5E1rYvN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 19:23:54.0820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2496024f-3411-4666-7ae3-08d56f297e73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct the pointer arithmetic in adjust_dirname_case() so that it calls
find_dir_entry() with the correct string length.  Previously passing in
"dir1/foo" would pass a length of 6 instead of the correct 4.  This resulted in
find_dir_entry() never finding the entry and so the subsequent memcpy that would
fold the name to the version with the correct case never executed.

Add a test to validate the corrected behavior with name folding of directories.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.16.1
    Web-Diff: https://github.com/benpeart/git/commit/477da4602c
    Checkout: git fetch https://github.com/benpeart/git adjust_dirname-v2 && git checkout 477da4602c
    
    ### Interdiff (v1..v2):
    
    diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
    index 219c96594c..0e4e51b79a 100755
    --- a/t/t0050-filesystem.sh
    +++ b/t/t0050-filesystem.sh
    @@ -82,14 +82,18 @@ test_expect_success 'merge (case change)' '
    
     test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
     	git reset --hard initial &&
    -	mkdir -p dir1 &&
     	mkdir -p dir1/dir2 &&
    -	touch dir1/dir2/a &&
    -	touch dir1/dir2/b &&
    +	echo > dir1/dir2/a &&
    +	echo > dir1/dir2/b &&
     	git add dir1/dir2/a &&
     	git add dir1/DIR2/b &&
    -	camel=$(git ls-files | grep dir2) &&
    -	test $(echo "$camel" | wc -l) = 2
    +	git ls-files >actual &&
    +	cat >expected <<-\EOF &&
    +		camelcase
    +		dir1/dir2/a
    +		dir1/dir2/b
    +	EOF
    +	test_cmp expected actual
     '
    
     test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
    
    ### Patches

 name-hash.c           |  6 +++---
 t/t0050-filesystem.sh | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 45c98db0a0..2ddbb72647 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -696,12 +696,12 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 		if (*ptr == '/') {
 			struct dir_entry *dir;
 
-			ptr++;
-			dir = find_dir_entry(istate, name, ptr - name + 1);
+			dir = find_dir_entry(istate, name, ptr - name);
 			if (dir) {
 				memcpy((void *)startPtr, dir->name + (startPtr - name), ptr - startPtr);
-				startPtr = ptr;
+				startPtr = ptr + 1;
 			}
+			ptr++;
 		}
 	}
 }
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b29d749bb7..0e4e51b79a 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -80,7 +80,21 @@ test_expect_success 'merge (case change)' '
 	git merge topic
 '
 
-
+test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
+	git reset --hard initial &&
+	mkdir -p dir1/dir2 &&
+	echo > dir1/dir2/a &&
+	echo > dir1/dir2/b &&
+	git add dir1/dir2/a &&
+	git add dir1/DIR2/b &&
+	git ls-files >actual &&
+	cat >expected <<-\EOF &&
+		camelcase
+		dir1/dir2/a
+		dir1/dir2/b
+	EOF
+	test_cmp expected actual
+'
 
 test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	git reset --hard initial &&

base-commit: 8279ed033f703d4115bee620dccd32a9ec94d9aa
-- 
2.15.0.windows.1

