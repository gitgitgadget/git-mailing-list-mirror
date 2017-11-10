Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EB71F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdKJVDm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 16:03:42 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:6930
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750799AbdKJVDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 16:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y+ze6lN7RGwlXZjLRFhN1esFBuGd26q6A9jHGx+nZDQ=;
 b=UniFL7iqw34ZCcBZpc8FQQaRm1nyNLWOfue7Esjty9cGEWodLtljgH/lOeH0TWjLvIj/vzKx7x9zwRij8V2F+db3PrbTKHItlFz99kIEyoMLffQF4kHmHQS7DsY2Ht72GbeH7cMK7t4Xz5/0NpE7K48/TDiatsKSQbzQX4Hb9Y0=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0465.namprd21.prod.outlook.com (10.172.111.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Fri, 10 Nov 2017 21:03:32 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, alexmv@dropbox.com,
        git@vger.kernel.org, peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v1] fsmonitor: simplify determining the git worktree under Windows
Date:   Fri, 10 Nov 2017 16:03:11 -0500
Message-Id: <20171110210311.11036-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <xmqqzi7ug1w2.fsf@gitster.mtv.corp.google.com>
References: <xmqqzi7ug1w2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2001CA0019.namprd20.prod.outlook.com (10.172.112.157)
 To BN6PR21MB0465.namprd21.prod.outlook.com (10.172.111.143)
X-MS-Office365-Filtering-Correlation-Id: c1499b81-0349-428b-30fd-08d5287e83c4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603258);SRVR:BN6PR21MB0465;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0465;3:l9B5SHgJmmFsGWSOg5HGuMwKfr1ijBGDYJfqtFxy26mleBxObfsHpea+GYEW87hHdSQh0KEWdqB0qdp0/HVX0aGeBgV5tVK6iaK1ql6Rivb6V9NUdKjntKz96E1Ne+J5vh4RNIcHaAWrAqWqgXp7yrQHOWn99Ca9r/WGO7JRZMgE1AmR+vDypf92/Li02kzM+KospWb+LPiSBe/lFexAoebHx/L3qU1zA/QALcJQMMPKZ/JAsVoO9m+qwnTZoxlp;25:EHs5Cf5fC4DR42uLAWuRTuPosKeDeEAjBTyA1+caxLMzhQKjEEQglApRfsHCjF1W5SXvq0NPJe2k7IZjdqgqS7zIqSIy0Q+iTRyeqr2+fJ/wAPxBX8KNIbDPNoepj+Ps+Yph2z1zGOonwPFfVZpNwC2MO0Ww2oWAj7JM8kXlNqPSjaOSg6zldbnd8P4QuKGqo/N3QQ0wSXoGIcmRUejH6rUkareAKIRBLaJkpL5xKsetCQe+xAQeFAqekJsqGlvrWXgbCO37yW/yx6NXp2bkwp9SHryTEZEBubWPjs/Dt+zX/t5qgTIliuKkYNNwRGRA/ODB83GRLVG8h6dw4Azbvw==;31:E5OGx7q1wGo4LTV+xUJ5XxIw2QrvVSG/yr6kydIatNH9/R4vi7y7HYmR90L96+naXdPvUv31iASCVOgAj0iD3pgdzDRDbQ95PDYCWWkGLBNshmSMzRgf6i4d2s1kLD4uoHlNu2L1ssAu8CSH8LLEgfTCuxbnf/tEVnczCdPKbCthp5RDcdc3ehVd+8AWC55Q8xceLDsvagtrJp6EyujZufho4Wcbn6NetjIvjQLNu7w=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0465:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0465;20:mC4252DdlPPxPRCLzG/7gAZHQgrn6CpD6mjzLhoEY9XQPsPNKUmtWeL4VkFAQtOw9R8ogJAwz8TcpjV8KzXRnrofPsgt5oTumP84AXE+RhK7HnJrm/+ZjOcV70O+SAxYriBycytZYcF/i0adutlP4Bm0W9yXAgIQxVBPWYflCEJp9WSdokiPSkEhKCxVGw0QlfMfhJbc3iO+Qp/brIF6OD+dAsLsQE2PSrnbO3M1pueeYkbASMpjUKBtBg/IWwniLgACO6Kc9Sk95ibcZlehpTiBDjh97GNVFq3S4uzmoYIx9oHRwaR0YSq6ExrXe6ssJvo4hhHJhxL/coB3UaUjPNiF2oAIYt6lZwvwJzH1HoVaTG9H9s78W3n9yr/vMztpEVKjXBlRdh0YbOl6s6iO9VojsVWnlGsTZ5Wmoma7ilbFg9PVSsiLk7eHRaloksObD+B8zJQ3/HxqJ8PLaMOkz+FNYpCTl12P/KgfBCFJJMuC2BUoXjtlPIy5ywLyuF3P;4:cS4yl5a2mlvRaGS6D2/4rmQYU6x9/WFbDAO1Xbh8ZsGdXi+QRSI6d5XPkPpnTjwo6Lxv/G0X/n9BJt0g+JqBL75jTbRVDYK52d9wtgd69uNYX4tLSCRnPjL1pmU8TQeeoSZmdcn+mirHHoXQMaPVMtm4KM8mqLG9H/2coOPhCZzpfV0tWVYeWAOsMRZZfOLGrWqH4R6JHcerPJKSAmzjsPKtwSLgQ+MriPAF2KXRVFXnUMbvAkk8SO+g7pbNuxqCVCTDZqoQIc+kGD9jOvjGk7HPprKUluvqBBMHZh4jINBX7dmfGthEr5clSJjPYgP+Xcgrj1SYeGhqAYe2fYGHiEob+Rd/z8YefVXypPcUlOKVdrrTtcUJ6ojcV1kAvVEI
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068)(89211679590171)(166708455590820);
X-Microsoft-Antispam-PRVS: <BN6PR21MB046594558ABAEF88292AEFECF4540@BN6PR21MB0465.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3231022)(3002001)(93006095)(93001095)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123558100)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0465;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0465;
X-Forefront-PRVS: 0487C0DB7E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(5003940100001)(2950100002)(50986999)(8656006)(101416001)(6916009)(4326008)(6666003)(10290500003)(478600001)(16526018)(86612001)(76176999)(5660300001)(66066001)(50226002)(966005)(33646002)(6486002)(16586007)(39060400002)(53936002)(72206003)(6506006)(22452003)(316002)(2361001)(8666007)(2351001)(97736004)(36756003)(189998001)(54906003)(81156014)(7736002)(68736007)(6512007)(106356001)(10090500001)(6306002)(81166006)(6116002)(50466002)(2906002)(105586002)(1076002)(47776003)(25786009)(48376002)(8936002)(8676002)(3846002)(305945005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0465;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0465;23:8MDyc2Uv+2asEzRadYNTns3H4tg5zVZovW/6iZKry?=
 =?us-ascii?Q?AwUfPHv8EF5hQgGcSuzEqIKr66SCcx5N62Vm/erU9O7RrJqEQM0X65ZWPYJP?=
 =?us-ascii?Q?lIJ8gtvcn28x0aMQyfnz3tUTuFcUWT3Db5oACW8KcrXm5J4kpn6HlQDAgOzb?=
 =?us-ascii?Q?u3Wd/geBccsRAZKSIOY/7WsijpynjFBUJ7uPbG+onTvYfnAdHOTvarMmdNLM?=
 =?us-ascii?Q?eD19CvU9rHe1E67qazBxw6hfM90Q6hJs/8KnU9bW0yCfaGUPowiVMjm6WMYF?=
 =?us-ascii?Q?J4hu32syBvRfmBmR1/Uf+vMcl2P4qpJJJjfhHMftklAs1gS4gl+1LsQeTZB0?=
 =?us-ascii?Q?+tNjATF+rUEpiVT7cQSzsB2iUJGGDUtnZ/DydsUMTzbpKJHVpaoUlb0JURNR?=
 =?us-ascii?Q?/rlEngAKWSF+1qoBVEnf59dQZB9OlSoBzt9pkSLS+Y0AtQRi0XNc67iduqFU?=
 =?us-ascii?Q?aoS8MQjCyYbxHptg1jJI7RHdr4aobw/bVQ/DQbF2DgmUUyCUOQp++v8+Tmtv?=
 =?us-ascii?Q?SZyPDQ5iYtCeA1qJF3B4xOvSdxy9vjEpoiwoV4nFTWcHa2xIB8RhWe3pi0rp?=
 =?us-ascii?Q?hXLIr1ySSoNS9GtMUuMw+rqlZJl6mQ5G5ujkAQcotXrd56eHHJNH8zoHVLaT?=
 =?us-ascii?Q?A3nzBOHaW0IVm5exmcBKj7bBJlnUgkL/y2WjPwMGHwMbC0c4bia4LgqykSoG?=
 =?us-ascii?Q?Qx/NqNSuGcAVSkf6kBTky6bj5v81GK2KzHGPzpYhaQ0wGDxImQhosUmxc0lx?=
 =?us-ascii?Q?rD5kV/mQMQp0aK3a4GvpirsqUF2IcUiZXzF8USTuB7wwf2nhMwPsostznD7D?=
 =?us-ascii?Q?Cebui9wo/DVTNNHOHfzpvsR2IXC+eCJ7BSrxDAZA6WIy4Jj5rFxUL9Oo7fkv?=
 =?us-ascii?Q?9c1XbqerrkyMrYPrx1V9kB1r9OVA1BQzIKYk7yD0tNg4trE8HwCBs+RtOqao?=
 =?us-ascii?Q?qcFpuhIYNqtqmBY8T0xnBSSV9GjV0flWJFqCG63m129mrSbup3OkPQSkDQ+f?=
 =?us-ascii?Q?/nZQ1r4i8lwfwk4GI+n+TWrfepYCembkk1ND/n9Dcfob9jrN98y4zQuqGM4T?=
 =?us-ascii?Q?594glVlToLyz2b+QxEhF2psS4LZEthCMRVKvLk0yUvvBnRBf8dVAy+Jgi+Y4?=
 =?us-ascii?Q?mVQb59rsp54oHgMSKBorqXWsW/Un/u1loMqvUek1Z8QGD5gNg2CpIv1bhxyc?=
 =?us-ascii?Q?JzfsKSZF526sVaIcl3ZPmpuBIqo6T8+N3tXairl1TY1PJXEHt3o+mlLCbjR8?=
 =?us-ascii?Q?8yPeyhE7oMu816jyYDCcejIG5ySaIn50PrRmTmMHkuFHCK0xlZW1YFjpXQ4/?=
 =?us-ascii?Q?HbahSZP4P6ORi5I3iFaqEa8Hq23BaLZ3k6Y3+AeOhwzfGUIiaZMIfd2d+RUb?=
 =?us-ascii?Q?Q9+UsGC7RKakpn8qdeEAVBOk/quxSzGUALrkt+7T+VLc8EglC0CwNifXsKVd?=
 =?us-ascii?Q?XbP8zctgpsUxBogOIcqXDnPArGObt8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0465;6:H7Ta5zUlbPSF2Cy7oIPzwB1zT1jbMh0depfQKlDB2EFLpNEb/jUiOHmy/M7h12FZo/vgk5uzCvmrZkQKQliGK5VJA0Z7c1pzuFmNbjoDCOLviRXxXBqTekNMzjtp3AJMNkNtPVnv2nly6vkfqc1u8ZKjH2gSqtLszqHMCMjsHw5inTJTu6AU6boFQ45MjK6iN3yhssdlPk8zqdPxMS/co6OFZFbDGAyyhUiWjbmw1/tswvbThw/X/nN17Q9n/tYRS1ULi7frQbtZKBiQ579JDqa6deRwk+sJW3ohGuq+ndrBj0DDGIPILJ+Slx0ytzR8sqN1WyAEL7c0eGBT/PS8KEmSFYFNoG5yqG+4GPMDke0=;5:wCY0S+Ekv/T4sq6O/IbELIbGwpMs+kxQ1cMxx17VSRfety/DCamyHX5lI2MGQtIALk5vpDDTOTdKYpBUsQebFYJn1bxbfr2cefWIL4BOIEtQcZb4p+xsIoPtrfPxJa3FSzGSyCbFMNrho1xHdhi/W5s3s5zlxak3vYMmEffj7e8=;24:EodN8y0v/nZ3ej9w5ggSWTwuniVev74lnX+nZnhQI/5zNdOxDN5SSN38PXjXXSdCQcplrsU9Ir7A329UPTFxonvZtFL/7xpguExC3Sy/nLI=;7:dZ3rLgj22iaG8ArIz/5IOUXFmUkn+05P2qO8yq+jY+d5kkwLfSsCeFrK35x3Rui3/juGFuyWdJzD+6W2z19kvIY60C9qK7YRmpAdSrlyxriNdd5RWs3VnPQ1fEInCdbCfXahnvnX41X7DjqcBxCoP8w1tMJicQpf1HdV5EjpcpdXGpGOdvekjt5M4f05YlKPpvsfN4378uvRRh3ehJUE7uR/Pu7D0Qcy5twTuuIULpbIyHh9KAq4zXY++8j45YsY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2017 21:03:32.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1499b81-0349-428b-30fd-08d5287e83c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't tested the non Windows paths but the patch looks reasonable.

This inspired me to get someone more familiar with perl (thanks Johannes)
to revisit this code for the Windows side as well.  The logic for
determining the git worktree when running on Windows is more complex
than necessary.  It also spawns multiple processes (uname and cygpath)
which slows things down.

Simplify and speed up the process of finding the git worktree when
running on Windows by keeping it in perl and avoiding spawning helper
processes.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Notes:
    Base Ref:
    Web-Diff: https://github.com/benpeart/git/commit/20affe124b
    Checkout: git fetch https://github.com/benpeart/git fsmonitor_splitindex-v1 && git checkout 20affe124b

 t/t7519/fsmonitor-watchman                 | 13 +++----------
 templates/hooks--fsmonitor-watchman.sample | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 5fe72cefaf..5514edcf68 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -29,17 +29,10 @@ if ($version == 1) {
 	    "Falling back to scanning...\n";
 }
 
-# Convert unix style paths to escaped Windows style paths when running
-# in Windows command prompt
-
-my $system = `uname -s`;
-$system =~ s/[\r\n]+//g;
 my $git_work_tree;
-
-if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
-	$git_work_tree = `cygpath -aw "\$PWD"`;
-	$git_work_tree =~ s/[\r\n]+//g;
-	$git_work_tree =~ s,\\,/,g;
+if ($^O =~ 'msys' || $^O =~ 'cygwin') {
+	$git_work_tree = Win32::GetCwd();
+	$git_work_tree =~ tr/\\/\//;
 } else {
 	require Cwd;
 	$git_work_tree = Cwd::cwd();
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index ba6d88c5f8..e673bb3980 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -28,17 +28,10 @@ if ($version == 1) {
 	    "Falling back to scanning...\n";
 }
 
-# Convert unix style paths to escaped Windows style paths when running
-# in Windows command prompt
-
-my $system = `uname -s`;
-$system =~ s/[\r\n]+//g;
 my $git_work_tree;
-
-if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
-	$git_work_tree = `cygpath -aw "\$PWD"`;
-	$git_work_tree =~ s/[\r\n]+//g;
-	$git_work_tree =~ s,\\,/,g;
+if ($^O =~ 'msys' || $^O =~ 'cygwin') {
+	$git_work_tree = Win32::GetCwd();
+	$git_work_tree =~ tr/\\/\//;
 } else {
 	require Cwd;
 	$git_work_tree = Cwd::cwd();

base-commit: f9d9e50b62094689773dccc5f9493fa15e30d592
-- 
2.15.0.windows.1

