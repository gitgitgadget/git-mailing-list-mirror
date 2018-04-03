Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9CCB1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDCQwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:23 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752582AbeDCQwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ey15NucbcGqm2LPIFNRNMM04QJz48XQFGAO/GhYFfs8=;
 b=gwkhhrbJTK6m11yzhzc/PUUZmN3GUyrSL10VU7e2SvFaJMEgwjTrqcqBcObR7IB8gfR/WBcndDsZANDPXLN57qznLArmgDMZN9q6OH6uePsxH0ymz0sQRxX7pkV3DWNFuR31g607SkbTbTjfT5OknFF1yO+Dzld3/oqm+s1RM6Q=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 4/6] commit: use generations in paint_down_to_common()
Date:   Tue,  3 Apr 2018 12:51:41 -0400
Message-Id: <20180403165143.80661-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fadd7f3a-14e3-4a70-be99-08d599833d92
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:/NdkEIgU9Dzfk9uMMthDTi41ojHqYvnybXIotIadhHJS/iRV2ZSbXJTJn848xC1VQafQ2uwayRGg7xrJJ7hDA1cEXYwb3l23cQQtMlWAAUOOyZWe/c62KKBhQR3hkphXSIrVZJNyx76JUCfevk/CCR2rhjIDrNvl8HZOggUEpKYap+oHbvDA5RXPiFM60Vdqn/1qCxnrt/XiwC3qjDND61crRjEqqCo1uS0JIXVPUIwEQNIkx+Ttf9kFZHzwBUEm;25:gf/C3+2Wa+iqzvgVzadEXRYf08RFKfWtgy060utNSCKRIUiQ4XJgaYIk30iWb5xh3s5LNev1yy/E87gj0Fd9tLg8HYxJXY02Q2jiRJCxl75fdNuyDmk2N4oZOnUMFvyHlg9/OBhkLBDqrH0rdPkWb3n4ZBfwTpeFlL1mfvlkYcly5gbfs27H7UYsSSTkYoyT22shLLG6xqbhnJ60f85TEwySXvzAFDogqf1gntFHWWcQPnIRs8wlzCpPqcc4ZP4Bmdqi7Xy4fHIeyDHzAZXoXrSjCHsnZQalHFhECmZif1V9/B8QB5uYjM9Zcz/uqJAsXvNq+8bTj7MxRlYEu6liPA==;31:QsDTLU9k0bDwTk4Sycne8yi8Dtg50Xfm6PnC7ZSyKGLsdaIYaviCwkHiNyHUaBAS6jQkcHlI251T6L8x4LffWh/mv7z1VQbt0p8ZEZoiO0WyxkD+jLM6vjOSBUJXGvgQ/oMrUrZqqL0FDUE0IoK3EB+Gs6f5vs7nBlt3kxfS0w8P78cqe1RIA1kS2As0TvGstNYqkKTAbPBUANBVgSltqClOepOofwk56+X5VVci59g=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:jETyZgJJfJgid9zpgNmEJH4EfrS5+yRpmq9TyL2efAyCf9JK7tu9PcoNnkaJTpLuxKZmIEmUQZKvv+GJ/uYMrsxz2hv3/Nl3gbz4AkrN72hAKAPYVgFwi2gkFIBE8vsRIKrYkc5YQYcmgGalx69VuAZdINXTa7AMpq+tQ59Zz8LeWUh9kA067wPWGaHbfpQHGgJrZJCFO+qQCpNUenQ1F+s6+mDn7XsC8LuMp1O9wuVPVhbA2Uw2AoI/cDIyMQK/9WnpR7+lm1nRVRplmZfXfNF2DuMDzSYbeUAQGI7iOpf/kysmw3pCyAUM/xeZ0YcxK5DC5Ouoe5FxzqWnzjLvCfs3rgiSfrkh5c1gXRO72o351cgM9DylRMAsuofBZLvIN6HTFvbt1X/ZTeF/YZknnNkcoT5T3Viz3NUNFSFm2P2m/GPZMryz/sIqqsrdMA4cyGSyY5SEHrzRB47NqVvZJp1sJxT7QEmI44SL64ftPniN6SdbiNnzx0bbyM4csLkE;4:RLQ5T4qgEzN6Sa82IiJkjqq87OTbWDdL8OH8VNajXuEB2hIuKNjNpBXDYoATfCBv4NL1wkmbobJI95nkr/YbAhZL8fVS+WVmOvWsXPV6GWgHzUSc+ovtmFAxpMoRxGthwZxdWbvmSiomu6IGZDBoiB1/+34dBHOtIUjNZAV1FJajHtQ8n8b0jgu1/7or9+iDbkEmxZIeMUtyW/Djcx1ffkex/Z9CzACDWmrJRhsad2jWhfHETe7KBV6Xr9hXLM4xofWSCWq2HraH1RrVwBTwPVmXhFAmrvUK/46x4yD27wva4wJ0ftCjmUvEOmuxGeTIoMZcErYapHcoWYfgdwjUDfAA3RJ4BsEBvuIJbTLbIJU=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011BB3E5709320A052ED244A1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:WLvy+Pwwp8v2ZePTDN5Ly4CkSSKV/zIz6qZ2FrO?=
 =?us-ascii?Q?mA/YFq6HU0oBgIKHfCKTUllraVaw04U+y1hvl2G7yCxiJCyeFLHCCM1vUrdo?=
 =?us-ascii?Q?roPNqKVvBYzUXp6QLh7HzeBqGQqLI76wQfD6xEkbdK2twIkc3i3jrIwF64fp?=
 =?us-ascii?Q?juniMseYKTyHBsWEHpOEKxPfN5r5jxsmRPAdIIxbYNzL0Q8Z6UO5bxR3i0G0?=
 =?us-ascii?Q?2HlvRgzBCxv6ArkBhHCGdusL6aaV8/Jz2yPo9OXL4DSbFog54j0yy/7lNqsH?=
 =?us-ascii?Q?D+Ym/BiMYCTNTuB7Kj2RcYyWVgDbeANjWEIeXA0JR0pQ6KAeogWMClgfM/BR?=
 =?us-ascii?Q?L4wNTy6Ah0D7hXxNEmLSTmIeiq+7YYOsstSrR365gThsy8NVXGiedlwXEm4u?=
 =?us-ascii?Q?Ck2Oy1txwE9QkQVv81zc38tnA8f8wlA5+EVUwPnS3rLAn316Qr02Q0EtWYVv?=
 =?us-ascii?Q?Mlb5KgEI0KUXp+G46qaoMmb4ovJqtLDEQLU33YOGepYVNColkw0DtyOndSRr?=
 =?us-ascii?Q?vcS/pXiaRKKGgb9n/LvJCHVwPEeK7IqdTNjAi9zqi4+eaArpqk3mi8UmLFAh?=
 =?us-ascii?Q?dhMP+xXKf2XjCWmuZYOzx9v75w631BqERX+K2L0cw4Ec+TzvEUcSck0dYSg/?=
 =?us-ascii?Q?3nN2gtaQdPbnw37f+EteU6KXssMOMC5yTL6Vju6Vrqd3AWJf9jcFeHdQBQlJ?=
 =?us-ascii?Q?sbRFm49/grbtMFCNlQ7dNEHzaV/cKGzGFAlOOJBMhXOc3x9aPJwNydmjBiiU?=
 =?us-ascii?Q?h+fdDfZivtjEHnUmyAfSo1++lWbm1sGLpGcpi6PytlAnfLrhawC7IHLYqA0Q?=
 =?us-ascii?Q?ve+6mVEY5O4uncLiUQ2wOl0izHTRJz3PunggvfPOc6XvFfMF1Qt7VKHq0LZp?=
 =?us-ascii?Q?HbJjhlRPyJ/6c6s/5A/I2sb8aqJ2aHA1Q1xhbBMsdLdDvQ/I47vDYtbK2PZU?=
 =?us-ascii?Q?taXRXRO2PocSf5Zff6Hmb1f0OVnIXlC1Xac4sXytCn2PMxuUtba37NEalD8a?=
 =?us-ascii?Q?GWDA24zpOdwN4vND85n37zduhXvJlqqpiqjnfN9HYpNqMdz77ZJ41gtZordj?=
 =?us-ascii?Q?Ng620GEoBQPYSrox7Z566CaYTzCCG2iT3Teq/9t+p5U+Oal6T15ptILwOxvq?=
 =?us-ascii?Q?vUBW+MzQ4a6T5RhH/27a5FBlYMIeTzZ5CN9VW1oBJPKmhHEh4m0PBlJ6AkbF?=
 =?us-ascii?Q?IJVo7wnWNNZUocI2aNa/7PRC3N2zOWZI83N6c+UJYRyz4COfglps/lf8m0z9?=
 =?us-ascii?Q?1y1Wu9wboo3A2gaioL6vBsPxn7O/BODrCH/uoir+eyWObAUhHQO5LIUGXQuz?=
 =?us-ascii?Q?B5FpmmAcQwUYgY5o52uTEXhgRDDerXa8YSD/QsoXN51ZKR23mexRaumre/jI?=
 =?us-ascii?Q?GClgD0s3DIE8rd4Gok+Bjy4LYzUk=3D?=
X-Microsoft-Antispam-Message-Info: WH2aiR2nB3tUifZAmWL3lbOJ52QgGZ7Q3Uz6XhQ43FUQhIM7GFU26bqqhXr5x0s//0KYgdg073coVj+KlmE7z0Ez+yHWxw5gaaJ7rIaSlqOAkK35yGa1DeEu3pZxveMxrAr4k1hjQUAKlLih+iK44VtwWm0jRKZ5DZRkOh1vzG4M3divAZXBNEN6pXSDAqBv
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:Rr8y02a/qZvzcGhCY+iSZt0npfInZk2qgDojyspImedbklRaauMa7j8/yQzBDsuTk9uzgWK6pP+FdymhzemJFo4LoI+BMfa2bx13qkZLZr7NbDzOooE2U+MXeBr9FqJThK2h6LWMu/qym0CTisxfyWdGPeLVRnh96QyH0zFeXByH1dlEMSzZaqZ6kZsZvqbYUOpDk4TDLQ7mhLWKbHvVOynEl8/gIkpvVW4yEZePOuwh40a+euXWIxjmlbwzwelFs38GcJi4gRHCTDSODWIp+0UBpYajNVqADmSuBvFAkiNJ2Gj2SvhaLJ/SlCWafMdd3rOUrhPGJ9DGJH6zK7MAh24e2fft6lAuygcyssMu8ljtsCcTnrOqxXu1AtrGtiKIBNmat4yeArFKcfg4vAY50U3i4s21EuihkiKu3J0CPia4oTs6gMN233h0SDRBEaiQStfZB9+e5hEmnn6Uggki3Q==;5:HZy82fCozUfytLNLzSRysIcqGGJxULgLZGyREa8Xk7la+rHnMSI6f+BarQ70BqSC+iUSNOnjg3HYwADuLPBOLBrovJFMC4KK1+oysBLa/XoX0mQ+aSijxnbviUAH0c+fcDnsbB/O9jI1NNkg5a050zykNQrQSKf88jifqY6rCUQ=;24:SIsvJ9Y3/py7yciSLPwPfoMj7sM6Mmcd3AhSDaIbLrfLK/oqZ6CukRnWvcAQTkJS7sPMbFkoxTIPshbF7IkoIeVfsrMqAPynDwuYGmFHXfw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:d1sATWnAnD2it3TmThSf0ThhTR4fESru2hYicyJGlTj7pDrZrWqu2AoZiJmzi7wGq93pVf1/+gP3kiblsn9PUvEc/PV4fBObQcnBkvCqBtpHvgArH2bKrL+VO+I8MUZ7MKZLwpxshtWSFKCj5r/VTHfHgp51IGfnmjJ9coQGWvSIMxyQxKzY99rODz6YW0Y9BKpjBeAIdfTPyftuf/Amh/wcZf5qVnoM89j4WSQ9NORVdAuYOtp0AaNvbJa7t7ob;20:mdQxH1rF0kjftTDR4idyZZ4A9wADyuwyy4wagYjjoRsgp0JDryzWsF93GV3mE/A5znVQ/tSNelkV4fXNBv0qH/J/lEfeuWaOB/eGYgzSbMpreXjWfnYjpdb3PYxbFjsAnEAJwT9ixXQ0PGGhK/LXQc2DQjL28BqruAf6IM6stX8=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:09.3085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadd7f3a-14e3-4a70-be99-08d599833d92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define compare_commits_by_gen_then_commit_date(), which uses generation
numbers as a primary comparison and commit date to break ties (or as a
comparison when both commits do not have computed generation numbers).

Since the commit-graph file is closed under reachability, we know that
all commits in the file have generation at most GENERATION_NUMBER_MAX
which is less than GENERATION_NUMBER_UNDEF.

This change does not affect the number of commits that are walked during
the execution of paint_down_to_common(), only the order that those
commits are inspected. In the case that commit dates violate topological
order (i.e. a parent is "newer" than a child), the previous code could
walk a commit twice: if a commit is reached with the PARENT1 bit, but
later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
propagated to its parents. Using generation numbers avoids this extra
effort, even if it is somewhat rare.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 19 ++++++++++++++++++-
 commit.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 3e39c86abf..95ae7e13a3 100644
--- a/commit.c
+++ b/commit.c
@@ -624,6 +624,23 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
 	return 0;
 }
 
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
+{
+	const struct commit *a = a_, *b = b_;
+
+	if (a->generation < b->generation)
+		return 1;
+	else if (a->generation > b->generation)
+		return -1;
+
+	/* newer commits with larger date first */
+	if (a->date < b->date)
+		return 1;
+	else if (a->date > b->date)
+		return -1;
+	return 0;
+}
+
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
@@ -773,7 +790,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
 /* all input commits in one and twos[] must have been parsed! */
 static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
 {
-	struct prio_queue queue = { compare_commits_by_commit_date };
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
 	int i;
 
diff --git a/commit.h b/commit.h
index bc7a3186c5..cb97b7636a 100644
--- a/commit.h
+++ b/commit.h
@@ -332,6 +332,7 @@ extern int remove_signature(struct strbuf *buf);
 extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
 extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
-- 
2.17.0.rc0

