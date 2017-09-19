Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373B020A28
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdIST24 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:56 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751397AbdIST2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/iZsCTiVyVhdS1X2aoHt0i+1d8/njfLxiyv68hhY/JU=;
 b=IBPUghKYPtoFFGCMwt3kOXsT/iMGW3rtk0euJN+g6Gnh6DAFHLVIeFE1lxPC/6GSiOgDOcsdnDA54tJZ1XLU/k097jzTuhJ177G+AzDVNbJ6w7vKKFk6D2w6c+yCHBbaFIJUb0/uZwf+8qMBix8ataHk6kjm4CDMtlZ5wHdRR4I=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:34 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 07/12] update-index: add fsmonitor support to update-index
Date:   Tue, 19 Sep 2017 15:27:39 -0400
Message-Id: <20170919192744.19224-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd5a5c0-1290-4a99-b431-08d4ff949f34
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:tfCp0Qh0aalO2hY9kKvv7wpOS9do2ptm+D9kJ/xnF9DXqfPWbkKl8lveblpf0/ubN7dGN/+R5UCZ7jOSPeaYy2YZmsgOhNauiSMIHARy4MZD0unHdkwea/Ow1uV4dCgozenbjLRXUWhofQn5dLGQGxsS7X/KhqEZA5b4gXiy/Zftol93EF0+lu+R4BUPZ1GGGfksYHL72ZABIh/azhZ1SfHqP0Pm2LJpAINqswiqyYnW8GVVnCCErCHgZ34Ae00B;25:COhPN3v365vaBxbIYQLm22tqUecJ2ao4z62s5sIAoL6XJXQZAFrChjnYeidYrxuu7Q1jxqpQBO5pH7oGCsTlL0mocevgJ0SPZHuECUGULw0tNuxIZGo+loDW0HP06Ix/9GhyPliD+zyqWLAFp1eYTKEb72gQkdNtd5POfKWuRIURkRYsLU0/3oNgFMUHXgxSPnFgQPp0C3SuHEEnzPQ8FEYCgVX1xLbsUMW/lHoQiZ/xsahMox/dAwceM5LdNiI2Tl/w/dWKS3FKxcrbwFqfi6laeujGykqjpH4Pg4FpW9Y8j399TyEZzksJZrlJFmz6Xhv5o96SJnfalX3xykTqgw==;31:/fWaxv0RhmEC7K1iLIxV8khkBnpX0w4AtukEzlvfQQMnGR4IMOrKneXPzqDzFB43a/PgvgbIDeSk+Dgd7I4Wp/6R1CGCGZmCX46Z23xY6ctSxnb5uNgpNmhhOAWq0OTfNpez3+9RNtvM7F5VVae1Djlfodt1s1nKn3Ye4c8foxKc+QCWu4BTDv/eJfZOUtKxRnVV8iU1AmOxkT6ATbNayLy3zbDzxClDmbWH/EKTDV4=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:v5hwj20NkcMgzlQu+iarvylvBZoTnB3Fj3ihUn6gy5WjW7wq8CBnmUV5JJEzD1rllEUUZV+Z5zTxA9jMqdKqn3ZXigA/zxtJfGEUEHNudOyO9XKUfcsSjHvn+7kc1xd3F3l8/ZPOavII86hMm7is9OldhNTT392GYBWrZf1lWhWhCUz6EZKZD6xsnDO40wmfqxgXCtd1tZz2NqHNNHW5HP69gNZogmoYv6oopA0bJQeWh3X6apV0rKSkrE8kLiH/kTBL5Mdls72rkhzAGfEEcoIR087SkOQf+hNtIynN5OHm1KVlmP/QbYHR+AWviNLZ+s+VLeSYZ7iKx2VRd24xx71aKjPuByAgHK2OYO9gjn3jMlZYFMQtlnHLi0WyWe68zpoSFSvyhMDKHWLw8ugtKuMvMq3xXQ+uAJVbLZa04MccOU3r0If1ysSWTGuiSuLHLSLWuEopr0I1dJnHhr7xbU+PmFVyRu8GAyPg/WOMXvIzUINI3O4TwxtzfJE/1ytV;4:h1m1pBMTLWnNkn26ahhPHyFE1gHu5EoQzgNmUH3/pR7eHVG+FC0VKp2mJfp40cMj5z4RqINmEowCpwIZFtoKZDTH1RwVmi5K27Bhk94GlAGjWO74fq/xDKtfMqjXCDelTKFPGLlDoG7lNJPHLIrybjPN9ZzsEXw8vinlrBhHQ2gwhsapnZ61ztR84U0hExCKbsFcPYBujzDZR3RpkPEzr/LDGR4BpWhUSL91+/MKRrZYJ6qYzQq8ZGZyarcISdBbUgKbFX/g79dsk5IwtSL8hqov9v/aCasnNCrwTMPMGcU=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04712A98FD73737B89289CDBF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(15650500001)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:avEu1MUdSZXYPezQRWJALzSmN12UW38ZvkeWaNeHu?=
 =?us-ascii?Q?QeAhAucI5HhGeiSqGVerBxFv7vlHbgPxlsaAiSmF64B18iXQbZlUldWZ8XYG?=
 =?us-ascii?Q?VDnrltIHCUjjac0Cqkl4KbF2DUagksu1D1puzRTkbXgig+nReTTvLRuZkctP?=
 =?us-ascii?Q?j/Mcuq28igHMePBqkYfnlNf1B2vVrnEWElUw8T0Xddho7eaNAGa8LYhu69Ax?=
 =?us-ascii?Q?3pRsips+xTtq5MC6ciDkt01QhLvpbojUhhDombvoNN5S6xL5QZVZ0zc00zkh?=
 =?us-ascii?Q?doOKgd3/IC8cN/HuQOzQb9pE9y4Uq//UvY5LCLpMFnXdebHQpXbnk5QQb4jt?=
 =?us-ascii?Q?U/sNLrQVMOOp29eFcTpHQXuHvbwb/fjyr36qGfddErptoRTnee/PBN1hbCc7?=
 =?us-ascii?Q?5Yf/69cBK/kk/L+L85GHEtE1ECPHZ12i8LjrUbwpVprMJHN3Xd5u+KViRbWN?=
 =?us-ascii?Q?rgeJPUmTI6zW6gRbTKzqVpmKBTukE2Lam9aBnxdNwofckegVMBMUcHTxwEc3?=
 =?us-ascii?Q?dAtv+vXZeFV/NG0clulMah1A/rtTQkXtEF5YYo4xAtp+6AQQoieeU2mDbHMn?=
 =?us-ascii?Q?bq+1sFeWXUUroW93HXOHropZpmSFo8DEqchto33SNZlYibiIO1ap6XeJWKMU?=
 =?us-ascii?Q?3/GDOD0ioMa6LSqpPDLwlibkNt8NfGiTSjBq1nxetyEqe7BI9KCuiKOSQewW?=
 =?us-ascii?Q?Hxqxjg4JrHDwJQyUZgt5SGTOB25+aWAkZz19xRic7T1zxkWTTO/lANHMiIsp?=
 =?us-ascii?Q?EqefL3RXA57rZf8rZWMOQdQHqSjQ4hy0Q6YyjjUGw9BaGRRFw5JmNNmbedzP?=
 =?us-ascii?Q?jLaDbTrc732JGTB9Fh6OXzn0CKzvcQCfTgz1CQI9MZxgpAFSQQWXpXHsyFxF?=
 =?us-ascii?Q?733sug5X9zHYjkVdRx+lbg4Z3t3f1tPeYrv5vB8LiQ4dyRMqm4RvFonTaVtQ?=
 =?us-ascii?Q?FQsq2Nu6Q625p6pDWDCHwkLFW8GcZlSHs10b8w0qQ2jtNJIySGpYhe9EYUob?=
 =?us-ascii?Q?ccHbWHrXJGSWjSBDPiXrgs3DIi4yO5E6RJr44JrshVSZIJV9rnKO6tUbbL5X?=
 =?us-ascii?Q?g5AYtKx8M+gBs9vlpZ7SzErj9XMmgo8zu63XPvbWgTsEPCFLW+7w5RR1iHTe?=
 =?us-ascii?Q?jmFPuAqAdLg3hD1f7TzBXDXUDCcGTQ/23ZtR7KDfxgI3zTnzRs9tmZvpmBRp?=
 =?us-ascii?Q?r3bVaTjXHkx50pprwHN10tSk/mbkZ5rN9uaVnHj/rgCttWvkvuJNeQBvhgWD?=
 =?us-ascii?Q?T2wEWc4iraRE3/I7k1QWdiuG9hUEqH7zPA4XurukyJ0OnLP6hrKR+zkUxMsF?=
 =?us-ascii?Q?qDNf6AOMsc7eu1eJvLodQgWVskbF9Wpn//OIvongBXithXYKY56kQGFNK4C3?=
 =?us-ascii?Q?kI3nduOdCGvJPlHTo7ENWkjZwGoZfQds6mgRBcGgGurgk1xU8Vp71S4aOzrp?=
 =?us-ascii?Q?o65B/nzIwnvuYF3RC2MMlVOE76SDdk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:HZljm0C6JBuahJw/9wiHASYYNZfJ2GZYYIWXUFHeWzd091TjzHdwaSkOrJp6W4y44ctf1Jvz4dvBVeOLmtjW0uHLslmMArmNmUbtprDfkSoPH+PU6CH2Bd48rPDM6hBVzgyFc1u0yUGoUX4yZcAKlWM3hV5HzJ6C6qVguPP9iW6VjzlsDgpJ10Zm9kfD07jZQNAS/eJR2si+A8IgmtVbvb8og0tNhlp3cVWXi/3wZvIy1vl3nWa46WRltCTtLTXJt+Gqg1AxRne1R4zkFYi0EhKlut7KExhryii3GUigizcGlC+lhoR02Hl+ENNjRsw1PMRgxyX+Di8g54WJQwdyWQ==;5:uZ0udECrQSBlzfcTlIc+W3BJe0ZdGUF4hQ7uhWScQCJLovIEBSwObRy0dDSZPMNwNNTDSq5xDTZMBVRJMCvHzH4SjRfRyx43mRjjUuvAmzoZClgCSp0SzcgFSYk5wE+c83bAZilXcHUOv8YJieqFcA==;24:yvi5wAXsCjiplfhIs8cHnh/qMp2yejP9na+sJW63clLhQpYLaA3CwVIp5fCAOAVlPQmNlOn9wcCeZ3dZ2BDRnJza5y4NAiTidiYZgyIC7Sw=;7:3M4by4mte9nRvemNGSoKxIsp5Uj9MnUpLVs3dLkM8z5MuHPq7vXDp3ksoohHZ0KyQXw3fhHR1RcCwQP/SmNrAQ8dETBNMfuCr69GwwfSpzgsCfqycwoGh7tPWw3LUQLgjI+76mR+eO7VxkitzjNZza7aDHlag0k1GfER0kswQYfQ24wNI/6NyRphvIJNUYTi8qZIqf0A7X2cQmoVLtVeKRIgkxtTYq1nkpqIPDBRUqU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:34.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support in update-index to manually add/remove the fsmonitor
extension via --[no-]fsmonitor flags.

Add support in update-index to manually set/clear the fsmonitor
valid bit via --[no-]fsmonitor-valid flags.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6f39ee9274..41618db098 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -33,6 +33,7 @@ static int force_remove;
 static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
+static int mark_fsmonitor_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
@@ -229,12 +230,12 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
+		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
 		if (mark)
 			active_cache[pos]->ce_flags |= flag;
 		else
 			active_cache[pos]->ce_flags &= ~flag;
 		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
-		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
 		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
@@ -460,6 +461,11 @@ static void update_one(const char *path)
 			die("Unable to mark file %s", path);
 		return;
 	}
+	if (mark_fsmonitor_only) {
+		if (mark_ce_flags(path, CE_FSMONITOR_VALID, mark_fsmonitor_only == MARK_FLAG))
+			die("Unable to mark file %s", path);
+		return;
+	}
 
 	if (force_remove) {
 		if (remove_file_from_cache(path))
@@ -918,6 +924,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int lock_error = 0;
 	int split_index = -1;
 	int force_write = 0;
+	int fsmonitor = -1;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1011,6 +1018,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_SET_INT(0, "force-write-index", &force_write,
 			N_("write out the index even if is not flagged as changed"), 1),
+		OPT_BOOL(0, "fsmonitor", &fsmonitor,
+			N_("enable or disable file system monitor")),
+		{OPTION_SET_INT, 0, "fsmonitor-valid", &mark_fsmonitor_only, NULL,
+			N_("mark files as fsmonitor valid"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
+		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
+			N_("clear fsmonitor valid bit"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
 		OPT_END()
 	};
 
@@ -1152,6 +1167,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
+	if (fsmonitor > 0) {
+		if (git_config_get_fsmonitor() == 0)
+			warning(_("core.fsmonitor is unset; "
+				"set it if you really want to "
+				"enable fsmonitor"));
+		add_fsmonitor(&the_index);
+		report(_("fsmonitor enabled"));
+	} else if (!fsmonitor) {
+		if (git_config_get_fsmonitor() == 1)
+			warning(_("core.fsmonitor is set; "
+				"remove it if you really want to "
+				"disable fsmonitor"));
+		remove_fsmonitor(&the_index);
+		report(_("fsmonitor disabled"));
+	}
+
 	if (active_cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
-- 
2.14.1.windows.1

