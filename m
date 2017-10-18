Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA0B202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 14:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdJRO2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 10:28:52 -0400
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:45036
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750881AbdJRO2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 10:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pGLRUnIadqF7C6aqs09DK+nnlrXacJ83Rm4H4nRkJUY=;
 b=c0VR0gnXWMlvagyHhv7m+LmLeWMH/WyW+WKBMwI01ZXz5DSB2wRKFtpiUMUtvR423wmJxi+fDpSsrTt7+SInbfY9jZrbW/gTEYF9opmRvDsqWXFYpoIvWR9eAp/HvM499GhH9LL6MjZgVwaPgz86sQSzfOVYyOYueAkdK54X/qk=
Received: from localhost.localdomain (65.222.173.206) by
 MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.178.1; Wed, 18 Oct 2017 14:28:46 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, gitster@pobox.com, t.gummerer@gmail.com,
        mhagger@alum.mit.edu, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] read_index_from(): Skip verification of the cache entry order to speed index loading
Date:   Wed, 18 Oct 2017 10:27:25 -0400
Message-Id: <20171018142725.10948-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1.1034.g0776750557
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: CO2PR18CA0064.namprd18.prod.outlook.com (10.165.92.160) To
 MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ded47927-67fe-4c41-8aa3-08d516348bb2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603224)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR21MB0478;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0478;3:R4bw2WZzw3jIuRM7fBzxh3DNoVrNJplGJ0bVzAqI0whg2m2chPzn1xOAZGzGqZseCZdvzjh6TPOjLt0iMwwldMgh3QuILq2S1OpH1sj6tQ5K/QXblqAAR4IcU1fdAtCHrByyNVKcH/3I359fvSddYUL6zzcEa3CRpwbqwFl6I2lKp7h9b1IEfxA+uiqDOMkt+Gs2Tfw8S74QeAwD9BnSB5JtEjvmChF0cNJD4gruzSrR+xFCgskZ+rilQmsCjqcm;25:SPthe354VhikenxF5j6nExsbWw6CKUij7bwm2HZNPdI8tElx/0KUAeoYn+v5rLI0ByH0ufY7FHlKTR2+1xyp1Bh51GBxp8w9hfoaX415W+2W14KaAY2Ozpe2oWSEqJkP9AhnUSPXmIy0Kp/MZLrEjlcqOSvgfoRZTroGccxNuqjwGzO5tHfO1OYoWOwo2/UEDg3NeJGQbWW4g2ZLRR18TMV8Di9l180S1UVh2xPk+r2NPLMqLCZI/bnwy+eCBaHZg10EBJgZLned2+zBwmWOPVVl1qPMAN6SNZ7HfLMy/WJDumTv3GpsbCk+SUCyDujQFdLzw+UttsnuG8y8agmckQ==;31:TrN4R4N7iA2IaGntXxjgae157qa8fSp2jp6/4O5sJFT8D4eLkZ82taPBCIcQXLPEMTqrY6qimsw+/o8Ier2lgXn+j+sqXmvQ0QwQQTg+FCaIQvYPwfqyvP9aVbGTKq41hwbZjR9d8YaT/Zp9lj0vgzEV+dyXndqjGyMGuzMrEIhrrs1HLb5ZrsQYxcrGBShFVYBx21JXh0zKM/JfBz7LcYH1dxDZKl9Ma2UJAlGsmbE=
X-MS-TrafficTypeDiagnostic: MWHPR21MB0478:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0478;20:dmgHkUipTEsVio5yRS3VqGi0K3Hzzg/OESq+0Ew6Vx8sD+tIM7fyUMsaR2IO9y/+AeKECjUuNKjXU1jbp238GLEvYrlklmODQPiUXibfIh8AM7bUNPzuVzqhGRVpiE/cuQ0htXqSoUsBdJQlRwuryBxPwWzxUEhgPhTQ1/mc3YGl9EAiO6kZLN2zBRGpk5V9MCSLbV6S/ANPekzMy14lI+houRUeuefUQBXlmlSnodGD21SEBzoUQjOlTDVG1oInVJboh9NOQ+tq7ezeQ0ejVY1n8w3jD7iT47HlpakiwCsY/u8bdCN6qcLFQ8WDahkH8usVnkgBY8UWC4ucZBzQfJnXkflnuWfFt6P5h7E2u8wXJ+CR6YYvLLVG50JMb35u0ugvhinIqzFEoMZ3Mf9VvYtW+nX5njUPuMeITtA0mXhmpf0RSRo35PGZuUk0egZOZv90yWeYk1BakQjTIdfQv5ORHoDYV5kS1VqDQCLd46VHtg/UuqorQxBGjmNDZf2K;4:eajCSBM8G6mnCZ5zNIBXzt+r0sZoWamLy61Pd99VJMsMPRxyE0tCmSLhqzz/MDGVgTDT0BdS2dqvf0EGPURLcugH0L0Ca6Ld6W+CP84zHdzV37603uTSNmf4Teei5Rt65LRlEaKD0rQjlopYs90jP0fukxd6s6YKBO8V4WAprsJLEfEeISxExSZirgwMxEs0EwTzNTuTMDWgGW5JweUzbQaRzONIoHzO6cZ9L65qeSdJ1fF/eMQ8X8jTK1vCGdcjKFTtD6X2k81MoQ460uavDKYICGMQg0Poh6c/S/eWhQtaTjqFLRd9BEjUq30+uRPreNtlBS0U0+SY3Hbvo5aq/7pSW0GIuZ4IW6DG8XMzzw4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(166708455590820);
X-Microsoft-Antispam-PRVS: <MWHPR21MB0478FF2B305F9141E1B6419AF44D0@MWHPR21MB0478.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0478;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0478;
X-Forefront-PRVS: 0464DBBBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(39860400002)(346002)(376002)(47760400005)(199003)(189002)(36756003)(189998001)(47776003)(316002)(22452003)(6506006)(3846002)(10290500003)(6486002)(33646002)(5003940100001)(6116002)(66066001)(478600001)(2351001)(105586002)(6512007)(7736002)(16586007)(8656005)(8656005)(2906002)(305945005)(2361001)(6306002)(101416001)(106356001)(6666003)(16526018)(53936002)(575784001)(72206003)(10090500001)(6916009)(97736004)(966005)(50986999)(50226002)(107886003)(39060400002)(4326008)(15650500001)(8676002)(1076002)(48376002)(81156014)(68736007)(25786009)(8936002)(86612001)(81166006)(5660300001)(50466002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0478;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR21MB0478;23:2bNwt0gHbrEzsHE/ruhhjLhJYUW0tdmNMzXwQU5Bj?=
 =?us-ascii?Q?itiFNiFf59FP/vuVqFPtErjEROKoKTkBEZUtdi03qHRXkvQmvRzQEh+6TB40?=
 =?us-ascii?Q?ws6Q6AC+S5xevyQcb3/CnPETwu+9X4ziy/j+9LC/uHK0+8tffmhPybdEvX4N?=
 =?us-ascii?Q?JtZpgiQ3jSrFKPNE+CpDzwi5y6LVO/P/bC+hKagf/hyJVIMlhsBrG/P5wM8D?=
 =?us-ascii?Q?alwCqaZuOOSrj9wP1NGDGbcvmTi5hzJ1tVJPbuHTWaS0+DLyMZsCKpGUAFh3?=
 =?us-ascii?Q?btgcVWmSamm+SPrbe3kMDR88Yp4LSEWpbD4vwuVFFYftXXIpW23gts7qsYgm?=
 =?us-ascii?Q?J5EcGkcLRgQ9s6xwxR3NH3QEkjM6XO3aR8hrgoJtuSNTtJIPkxI3WtvXw/E/?=
 =?us-ascii?Q?tsifuu1RDJFoEXGEJa3QI0NZgB10izk7iV/gfHMDfP+0TJQXUkFDgXCFeheZ?=
 =?us-ascii?Q?APZYVA7NlB7naIqrtQ9D5uCY1R9eH5ZFcS/9WNvCgYdmB7jz4dkRm69zfYtu?=
 =?us-ascii?Q?2wVqGK84I6B5SSU0CLQiGrrtOv1kMSev21k/76ifR94ZSSgDyJXfVJwuTqt/?=
 =?us-ascii?Q?6idfk10pUUvmpBDuynDGZeKWyLTQi098KKBI6WfKOlvxki9WtLGaiJXphAUw?=
 =?us-ascii?Q?cty/bngT6//ws24QXM2g9gv48T5KZRxxrCLv4dPD/d8tYnuUReM7JFioDpCj?=
 =?us-ascii?Q?l0ynSZAZfB12kvLc8/nbvOwsL0Kp9qwwVC/6ckxJuzwbWw4emFyGLKQyqrd5?=
 =?us-ascii?Q?jh4wriwR4ixWwcXsEO4JLxkHUQ0OjJRAcjvDKOua02IhTPHBAvuAyFEj3Gi4?=
 =?us-ascii?Q?+QtDts/wujsBh3D16NU33VbL6LY72QtaCjCjIKltAZLV822NGbfzHINCViZ5?=
 =?us-ascii?Q?7Kmlj2IJhFj3EtcJUpn/DJoazHtexDE3izgH0IsRw8lx0ITqsGA/oM+206dm?=
 =?us-ascii?Q?wx1j/+udyydIELYWKr1GOYWkLSnUv92fAgAtbvf6T/l+oIK90nLaiaQkor5b?=
 =?us-ascii?Q?2OZ7Nk8Z3aLdKDRSUlF/fTE7mcAPHVkThnSOUbc+Zlh3xwByN5DANYvJKvhh?=
 =?us-ascii?Q?yZ71xrs/MMXYJDIQBe5cmBmjFZRUoijI86DGJhDV1857hmQdoSSdbL2JSr/2?=
 =?us-ascii?Q?S75cBjmATUN1+TzVW3VuzjAISw+RBAr0CXLI5KnjMPrxkzkWve03XOi+/8xA?=
 =?us-ascii?Q?4P4bgpw5QIsCv5RyV1UI8c9aon7ywDFXv/xPNhWriiLUO/O1/QLkijP+m9pp?=
 =?us-ascii?Q?3I5epUizdOlSm/GYsBTOAg5feRxw2lFAZbJg+kDo7c2O+FTeXA4XZpE9eqln?=
 =?us-ascii?Q?qA8eExzxR9n32vq7bespNUjlw3gLMXjeIbok66nAnuyODwuLdkl6XgftrFzw?=
 =?us-ascii?Q?b07OGY04WlznTX5LmH0XH4ldyDf5xxHe0rWeLekhGI0uJOjBs7hmV7xTbDp8?=
 =?us-ascii?Q?64xKAFjpvbpQj2yQBuKD7ZKUFoeo34=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR21MB0478;6:c91rYe2kIX7Durn0l9JEvWPxbLJfw48a7N3yQ32mDCsMNNuzmapfm9vvNa365BxOJ2ePiJUiG+2pEa7wvM5HmCz4cTCbOhK6MWYbmFVMaGv+ZDiQHhVXsmZvIeWUnMIzhKObLiIb3odhnSyRyoDE6PiU803xhZqe3CNiVPMys5v81k78i9MZjn+OSwZXoEqLYwCw1D3Q7N+VyoLgFdiwNG4OqC7d7GT6dcLSgri/oktd5ISFVCExuOaP7byCCpALUm34N1AzPCR+rdxXBbfHTRWd4/E/egRVzmJq72c0I+HVk9VS12s5Xiy1md5KxdawkLogwffL73kDJlMJtQrbMoCqrU/R6hRf12BxkOPlgwM=;5:Z/9v3T/Mz/HqI4j65e70vIXVUGps7SDJShg1utyKfAgWC2YglfS3j53MRGI5jFa6VB2ufLcApjKenFczBjLb0CvipnGEl2B/IHmeDA1t/VbW3XPLMPLiOk6n2i4uJaIHWz8HMQamCNCiJg54wSBSACYJE+YZcz/l+ppRaZ2RW2A=;24:av9Spu9T5IihyDKVgx48Xin60gN73eJib0oSPIgrbQwL++tYGEYYZZ6LH8JLLxgoje6paVod4IkrL6h1MotwO8qjI2slEkFBnTM+qttcS1k=;7:n0aug+x/wZ66HxZ06FowyoGJ8NJCyULd50H6Or57ZL4sYfHLGzKDTmIFqS2tG8DoySnHb/HvGSrRDX0vBbYrDbxOQA2UItsbL+Kvv42Xn7DNDdQwyq7gdwpWPRM2ok+KL1NDco5df7oYKguq1wfKaDo0y/HOmHEYonisXmD3hPSh/507hFXJFDoDZZ6B4VcGjT2M/YC9MX3lqtRp+bUtrSZ611eD4LRZCGFupRPHOYb2AD5tH3UyEE0BVd8DHEoe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2017 14:28:46.8997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded47927-67fe-4c41-8aa3-08d516348bb2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is code in post_read_index_from() to catch out of order entries
when reading an index file.  This order verification is ~13% of the cost
of every call to read_index_from().

Update check_ce_order() so that it skips this verification unless the
"verify_ce_order" global variable is set.

Teach fsck to force this verification.

The effect can be seen using t/perf/p0002-read-cache.sh:

Test                                          HEAD              HEAD~1
--------------------------------------------------------------------------------------
0002.1: read_cache/discard_cache 1000 times   0.41(0.04+0.04)   0.50(0.00+0.10) +22.0%

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref:
    Web-Diff: https://github.com/benpeart/git/commit/54fa9cf954
    Checkout: git fetch https://github.com/benpeart/git verify_ce_order-v1 && git checkout 54fa9cf954

 builtin/fsck.c | 1 +
 cache.h        | 1 +
 read-cache.c   | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d18244ab54..81cc5ad78d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -763,6 +763,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
+		verify_ce_order = 1;
 		read_cache();
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
diff --git a/cache.h b/cache.h
index 5e2c9512ff..4a4f879061 100644
--- a/cache.h
+++ b/cache.h
@@ -721,6 +721,7 @@ extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
+extern int verify_ce_order;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git a/read-cache.c b/read-cache.c
index b64610c400..32743da157 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1513,6 +1513,9 @@ struct ondisk_cache_entry_extended {
 /* Allow fsck to force verification of the index checksum. */
 int verify_index_checksum;
 
+/* Allow fsck to force verification of the cache entry order. */
+int verify_ce_order;
+
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
@@ -1698,6 +1701,9 @@ static void check_ce_order(struct index_state *istate)
 {
 	unsigned int i;
 
+	if (!verify_ce_order)
+		return;
+
 	for (i = 1; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i - 1];
 		struct cache_entry *next_ce = istate->cache[i];

base-commit: 46309c695b080648f8c0ea5e2d1fd7387ee7f044
-- 
2.14.1.windows.1.1034.g0776750557

