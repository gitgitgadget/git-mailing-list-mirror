Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE93202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdIVQhk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:37:40 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752531AbdIVQgY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rQdauzdtnqtgKi4qI+dhypcjXB1Z4xO2gzoRyDocB38=;
 b=D2zQVuS5VJSwTJGKae7WE/kCR7EfyU6VyeaM7iYjZUvB/ycoeucbNCPRP7WkOQxhjSNtyZkjdNycpUG5F72fCyEZpFBw7ZoaEfnKNgDiYkc3T4UmNdwWxlwDh9NZyqgIWbfk/rbjlrG0Y4LLWg33jZk95lBJOLz5bIp0dvAEtp0=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:13 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 07/12] update-index: add fsmonitor support to update-index
Date:   Fri, 22 Sep 2017 12:35:43 -0400
Message-Id: <20170922163548.11288-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: ccdecb97-5512-46df-c510-08d501d80a4c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:fFQLf64lkEt3zU9+hzRdikWwrB06A6fqyFkhAuJMALjR8a3WDaApbUD9/xJVmX51B9MqbUTh7v7J+764g7Wr1eVbmbDtERlttyARiczin2s4BjR8YR1kM5to8FRM/AmaOOd/HcWTNtVEiPiIvF5Z7xUDzcivh/M/hz6Skt/n+dRtXcEYE7l6CylgzPc4fmcL1OdCtKsi0ypFzuxbMbrPLiJ3mB/P77j0/7Cd4IKVpNnmTBtHqEV5rODji1wXTygH;25:9AuY90RTjQ1EOMWKbN1R9Qaw0F6S0kW9Xqumm0JG3DDBFiLQPjOq9RQessM95cg4v2VMbcNWIDlagbpgWoDq+Y7lVWdTu+TTfoAmZBHRchXBOmEbdCsT5i7ArMxx58shH/GJtn4AWhwa+ARe9NBZ1nt9PDXrjA5TiapZaUugbe1jCM65hZfd3l+XA4o47P/cDaAFgXQ/V1X3S/RlckXjBNrVBpDwmdKxDDB6nANksDJzSbLjjBp2Q3gbs7QuTlZIba2JguB4xD8wpbs/laF26NA7HLinXTWqlXxdUzgzX9Q5ISctkGm5jxqm2c5/O/0VLwLH5pBBUH8p8z6Z1NWrhg==;31:b3GvbdOAxzsnoRJ3iTENmT9/DX+B/m7jcQ0jbSg+/q2VGAeEjZ+chW9iozaKYbfTL30NuDJiZ5BafbjkzUeNGdomXWf5a1YINXYFo3P39Khz3/4TBREUHnYHvZJqHMfEwcRWAv0+fDNY1Is1aGXLOitKH8ZsnZfqZuOu7YpotM1N0wnao0Gsn6iW8iQswyOYpwYEKOWBb90nfptVwk5PI5xyGeGkZQVXJEW0pc/RP1U=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:9SRawv7tsP/q2ENs22ncj/a9QEQLtCiecRTLIRydbYuJKhCKPtusnUUzrYq83SZu51drCrS5CwSvBQkBhWBpPgNe2lrvTxnWIzoMu9wfVufLSaPZj87kGQ9nIRKR4Yk4zcbqYdZWHKhMY+J06uU1/0hpCUK9ZBeFGcFLkfq2c5ZtRXpzNZRMBTKijL+ICk6vuIvTR388H483zNSeiCvaNzm+iF68MTyOHmbJhB5xg8Q5ThCD9nSa6KvgosjD4to1MV13ssfl8CFY603FMByT4/7mHIb5+JCknUH89U9tL93F6ZFtWsxg/0UZBX7fkvHoK2fQlbIUflkFy2SxwfpXeDwQzXWS3CYNirxLD7+2Vc2nImg76yfBXVK/hhS4gt5J9jrO49wwkOyEhxrrgSXRvmOSDoyR2qBqQ2Oa81n7cWKDiYOQm/rduCKgV9RMXpDCj2Ak++bumvtdKgwug5HymTOACHm9jm1rZQwm9XxUR359EPvVCsanppWKEwub1QLX;4:THB9v5wgqtXF9DDONTJeFc/z1ujgQB4Lz5FJ5yqKojIUdfDGJpwLEzP8RiPJCUZMPblGOWjbe0ERvWaMgefWU+SEnK8rNYMsgl3j9fUw/K4wsK88IQch1CjRF6ICqaHfHNJ42CcmBBL8MWT0m48xeLIu/7UeIoCds8MmmNG/ewtLYJaYVYZyloO01YYUjVG5tyd6qgsP+VkjQbBjLRQz96xL4uYZSt60QvW2hhdgeQz42UeSCK4sOITe+m/tjnF+QofUWMsz5NL3+FRjG4XZfn0pKLKZ5Rxp3DWbbSISX2M=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB046604D362BD8F384376964BF4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(15650500001)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:hQGHTSMs9qBoovPPNPRQabB8y2DDJMF/JR6mLpT6u?=
 =?us-ascii?Q?xAAwa4ek0KO3AK8+BK4flF3EyVeBPwvlx8vnfiSmSRCqMCMMEA5rBP9RcRU/?=
 =?us-ascii?Q?xb80il7ANYxC+vgCtdy0eCxr+/Uyl4CZSzcgBt4FVFivAuDbfDJWF/SEC02Z?=
 =?us-ascii?Q?VzDLXwqDKaAX5HxJHX9L29Le3gJ7s5ppamoiOQdmg6Yo7ARr3cnplo9Xt8oH?=
 =?us-ascii?Q?XHHJwJruaKEU2Uy/q+AZMd3U+ysTB7PLOeLfaajwSyTs0sjUKcMUStqDR9dM?=
 =?us-ascii?Q?xkXTEMpq84Y1CWmlcgbP7f+2TfjiaU8ql5Ro3zq+J1DNNqhfutCdhn/uBeH4?=
 =?us-ascii?Q?7U/zKbrizWaeWc6SILqltBdnAdosX6xe3Z407k4b1UDFxAdZpicWTlFrsOJU?=
 =?us-ascii?Q?pJqV7QAkCbeM0b61pMmx0TJ8rcjKkvxPjaDDnGLxqfbpEY4BVP65N0jsS2J+?=
 =?us-ascii?Q?pysQOmtqmpP+xl7BmStc7HBdazt/93WtnWlbT//jIEx+K5ETGWcxGsYFA0uN?=
 =?us-ascii?Q?yjKOdxKxyIc0Xa0iLO+fvY5gQlQIenFoCnilygACgd42zM67/qClNH4O7J2K?=
 =?us-ascii?Q?ZK3lUClP7PBCLcyMg8P/nOoEbJjJy8yuosC06QDwC4RXaff9HtXABtpCNFfz?=
 =?us-ascii?Q?chNrACDRyfepiZjFUL+svLwIPElv6J5r2ipvC9o1KnYnfW553s06JzHYLeKC?=
 =?us-ascii?Q?jy8tDpC/s/9zEXEzwyywVCQSEicQSpgohJ0fn3ZlIDYw7ks8d5u8ZsvwbR9U?=
 =?us-ascii?Q?mUghJIm0RNOku5EdGjF8n7bH4aWYhPRCu6afzNoPaUOzIBqbLZ5ZNe8WkGUu?=
 =?us-ascii?Q?U85OvTgot0KqtbOCpIkNxthtJkSRQQJFG2E7LeALgyIF8l36cVFGEe4s5IHH?=
 =?us-ascii?Q?LS30VMCsRf6K5eb9859C8fvuUqJpNNBdwruLaNOrE1N6RcbqzNLJYtVuuPID?=
 =?us-ascii?Q?Zz0t4/TpwH8hUgBFu1R+QKYFkR4mWQCkzpsy++QtfMNnrpzMuQYU/5u+zJ1g?=
 =?us-ascii?Q?1CgxYwjB8ugZpI3D5jsmPsmkRfBfM1yzty7JqBAaOgUuqx55fqfiuawIeFIl?=
 =?us-ascii?Q?iVBz/FXcMXAYHZ67ZjUpo4Q19+nSF879joD0GCKnCv8IgnhpJD/KJOcq1NuT?=
 =?us-ascii?Q?7Za7+IqDGYdYC2XeSttu8dbcwFWoo3z/oVPHvQ8Yh8Vb5xiMjG38lhQwiQ7v?=
 =?us-ascii?Q?L7ELdwbqicZce8ZXVI2+v9Lu0cIzJYyKl05fQoOxd6jG7FaYobvFwoND4G2P?=
 =?us-ascii?Q?YrDs5QavL5hP4t/MzwekNfagqZZlby34qF9OOHR/Jz8RXOePPTGhZNLN9r6a?=
 =?us-ascii?Q?GNgqAI886/o5GyhJ5szD6jvC/F3fT3xH3vE1TN3PWIWE1KZH4MMPSGdrrNYL?=
 =?us-ascii?Q?Lbm8hbsZQaS4uDyjoWZdv/qazkIkQFIqoTfT7K3umeI8wqcsReZmob4SdxpU?=
 =?us-ascii?Q?5KT0gMdZIMQ6zdONncLRbLb7+lSf3pPnnvJDWXrnQqcwiyrJJdn?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:Kx+s6vgRBx9R9oqjzi0YH45db0CcnS/qnp2gleY541KWWqvmWjZt9Irc7hq80W+d0u8tddSJwMa5EcN1v2DNOmD7LExQKK4HcgnaSQZWzOoVoMaBhamheeK0Yy1Xmvh4xfSXoX9OHuH7GCP1+iIZ4tOHTAQczSy3FoWS8yjQCIZ8VxAQaJP9qyvy+L2LAovjVVifX9F+Q7Z04b2Tvq94oz0JHM3usudPij6RXb7InBKobFg2LVl/dMH8a15uHeemLMIpwPN+mx7oE9kiRD36XA+EqDjSAlszHfyGaBqW7qRMNQQ8yz9HjnYKa6h9dLK7OnPoXX8MgwXP2cD/bhpUTg==;5:H7bnik8YLD9T6fVzQSftrSdgGhZrGsR8+eVMpyZ/rcNTkjB2D1qMCmxB8wCvDkhy+A+MvU60oeOIUUlSVf7hxHnk9FUsAxGyjiE4OHkpS/jQZ2DSU0X2cvgVUupzBghcKA+Kpksp47cSP1UTNVd9lg==;24:VdXKrGmLjWQHbORfn+wNvTKw541vNaCJU34vA4K/8y46FzMw/BHd8RjXdpbSVZ5wt0AN9UsoqkTTTsjls0gkev7C5Q9OTpdMu1BSpZ0U/tE=;7:Ux+7xNXyjMTPLMHneqTPTM2Ej4QMjwFgRfDxi9A3LM3EDzDib68Ue3J7C9wcJ4r8F7LYI78DycyW0w9QhJvNkABbjl+7viExyka95Kl1izsLNzvea+4xmIU6W4oe2E45RafcC/X1DiafjQl+Ph810GkRykBavIOBCXmm4bN7GTTGLhUeIYvZmzdVUDCJyNvoq6FG76gwBuGtZ2rahLwvbaBMsaBKHpHIl7jfjHSR2WM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:13.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
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
2.14.1.549.g6ff7ed0467

