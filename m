Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D771F442
	for <e@80x24.org>; Thu,  9 Nov 2017 14:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbdKIOSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 09:18:13 -0500
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45724
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754958AbdKIOSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 09:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xDsaFXgxYW3j+nYXd+kJ8dSzUKtsqupR7WCY6Gc+aO8=;
 b=Hx6yw5cAzBnJGHEpQvTG7AIeRCEtLgPgIpZ65NGb2FkatNy2dWbXebAS1kS2FTJzIUycScVQZ6gc2k/vSWVLkXQV4bvZoKYHoBTybkv8QF40nYrNFQncLnge6qVyKtQJpxhurGadexkrOpjg92kf68Fdin3XFMidxspNvw+qahA=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Thu, 9 Nov 2017 14:18:05 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 2/4] update-index: add fastindex support to update-index
Date:   Thu,  9 Nov 2017 09:17:35 -0500
Message-Id: <20171109141737.47976-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20171109141737.47976-1-benpeart@microsoft.com>
References: <20171109141737.47976-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR13CA0015.namprd13.prod.outlook.com (10.175.123.25) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-Office365-Filtering-Correlation-Id: 25af272b-4bda-42c5-54a3-08d5277cb281
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:aFXK6oHC/yskgowl7PN8a3IqWePhY/80ZarYOMTM2lyfqnQzLJUYChYMaOQ1Cm2c3JG7/gGMrSuPvprG9mTeeSlN+h7+HaWPxQPifP0rySqArQh5UgbTwf2MFRr6TQeeKdDewTtG4f08ZOhOWr27tgD3VM7aNZ7CQzyL+Ne6PdHek7g2XYqSpq8SnUcZhB10bBMb+zwyFGVNOD5s0Jk6VnHl+dhTjsmVU5VMzrB2sPaaG6TGVuoxzt06YWmiOCU6;25:K6ydFMLlYy+tC/vRDnvHa/pBA8VD0vDvPzas5sx9qwsq88yOsk1YwU57efAPNWJzZ541JLVajWlWrcfEZH26JtAcE6N+dNJ7/nlySdWHAbkRxk7QyaV7hAEFAUmrTOnMkaxOUpzV8oZBLP8k9cvEopYcG/LJTq9UAmgLKzHs/Iqp7j/aevo0Jnx8T3Q+/jLPSm/wxV67LxmwqIBFjVQdZRSQkbV8HoXG+/Uor/Ga5NcrlJEmWJ2DWDcG8Dakh6SOKdCBO8184sGs17MEbuBYhyeQCtFnqpEMcrMygJfzvHLBfgfShm6AsUHZDczIutuuaUAbsW4QeCoEO2AXkucihQ==;31:5F4w8IebW7NCaJzD7wwdVsiA2Ru3fwwxWJ+pEbSIGbEhYXsRS6Apo/H4JTDQ/QxYRUEW1ylwlbC6wNQQq3QYQBEAsWWB7VXm2DPi3LAcObQ4Z4txwwlsd8jTJpgB6RMfWNtSVjluLjQuurrr0fIwJ3ra0ckLrIu7V0Q8XPA9fI6gWj2k57rqluDKaJWKQ6UTZi/5eULnBoXO957+ZXD+dsqHZCCKIkDQZIsNrhWf3aM=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:GCrJMV1UkIgg4u+gqZ32rwRWAFPeZAioglMRvBucesC52rrAVgd1tI/Bup+ijRIHbD4DTnFQ0l6aVliT2/jQxDym6PlaEgt1AYzGgBKv0sUzrT9TbLeC/v9Dwa+1+JUZWNxlgYQjT+IGI33mjAiG2ejBYZEzPLwi7oOH/LNmOdeTWpR/1T98V6zthoDOBvpa4dbqbAAEnaSnTTHPYpm5KiPPlm3hfJxiAajhhvD8eGcWYKQOY8IkroGCcDSfTDS2gP/+M0R/nHZzdCsm99phPEYxxt+oxsl0lzslgFasskmUwuzkWgtU/YBhVju8pD3LazjXcwqrHj0+45PJ2INetMlQzARhMn1HKKfFUGsdUk4VL814zRZOTknSQ0X5yyhQR/vv1uosGBrM6n36Fs8LAeVFrlnVpA81fvR+kBrwgT5+qPeKQwTCc5V+YT5Ij/bZT/sO5ZytZTIT+7+x78U0sqh6tPLuaKeJ7gacR/GP0zpxbygVZika32dWk6qUNXXd;4:WQKpuk9uq760lRfbSYUWdpxqex59z6m4k2Olpfb8qHiklx51jFEffmIo21I5w1UaeOAFIcr6Ua3N/gAUwr1PnrF/ihYEtf36vVVfhnEYsXhl5pSR4Oln0mVsND9N7vcGzyDk9Q5gF7iiqyrg9URod/0FN1S0M9cs3tIbgJ+Hmn3hnMHNCedWrsiWOZZPbWPb1Qr8F+UhezEKohUYPLcVVle0286XzBZdzLrhjTYm31gkWifV7CxgboN5DE9KQVQpgHJ3JE6AGq6K94Z5j5TQjvCMfbqMtdoiGHwHfX5w6gfAVuntiLdIGIaCiopY1kly
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471790353DB809951C1A0F2F4570@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(3231021)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(47760400005)(199003)(189002)(5660300001)(53936002)(8656006)(47776003)(68736007)(15650500001)(66066001)(48376002)(107886003)(101416001)(50986999)(4326008)(6116002)(8666007)(39060400002)(76176999)(81166006)(50226002)(8676002)(7736002)(16526018)(36756003)(2361001)(105586002)(1076002)(305945005)(106356001)(81156014)(6512007)(2906002)(8936002)(10290500003)(189998001)(10090500001)(2351001)(3846002)(478600001)(22452003)(16586007)(6506006)(33646002)(316002)(72206003)(6486002)(5003940100001)(6916009)(97736004)(6666003)(86612001)(25786009)(50466002)(2950100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:TIspKg13kga6P28NcmWj8N8vZKqIhs9H4l9M4rihr?=
 =?us-ascii?Q?otSZPf3ZkRlrlO0NuWbd/nFkdKjUwTOEuu064fy1x0PFOvuCWJ/936w+nz+L?=
 =?us-ascii?Q?+PrwA2UF8fPaP3OR1IP/S80b9z1Yjzy9eJnJcF84KOx3zab5swCVc4ibUI9F?=
 =?us-ascii?Q?cMpaE5AdpnRZ/FdG5ai7TlZfkLPVmncGg10vnwAmDtAjvPPjBnghoLBmGwUb?=
 =?us-ascii?Q?PusTwbzhv5JyDlSMuS9Enskzad+03g4GU/81zYjNu3fqeXTstuT95tO9nsTT?=
 =?us-ascii?Q?zAQa4/bke9fEg7BcPhiBN/kikIeG+Gjtuo6kLtI1pbks5yf8VNLLPvIJ7wia?=
 =?us-ascii?Q?JxxTTvFdT0Y9mOU0RTmX9JdJJz2em81TQuXItg2a9QszBU7gcY6ZICC6JJ9C?=
 =?us-ascii?Q?s8NaCP2Z49qb3q+FnUecmHIajhk8Xf+PcrWHBsff+WDstNG7KQuPHkBRW8yy?=
 =?us-ascii?Q?0ERUq2hXQ1mjg/CME18N1d3DFP4XOF4nhwNihrsstyHcNGVnTJINEEZ7g3ii?=
 =?us-ascii?Q?zxPIOepp362hMBFT7dCdyB+ZqCqvnfQ/azsbwF/Grkhk8rBYrO3KfFRpKWUv?=
 =?us-ascii?Q?1gFuJnCSXsZA4TLdE5IJZGwqawc+W3/AbSyBgob0Q0nNrt5ylH6fzUkRicUC?=
 =?us-ascii?Q?Y8IL24N3M+asBjZXkzZf+RdAjmoRiVOQr7XuenSn86jko1PWjcf2Zh7mnXvl?=
 =?us-ascii?Q?qOu5OzAn6gJWGGPzHHzy4JNVnipapW+qebHK8OA6Z+ujAAh4EZg65Xl/+d14?=
 =?us-ascii?Q?qlKPs8iuSKblEj7qvgZ8kUPzOM/jITOErA873medrsp+777hB4I6O8xtZY+c?=
 =?us-ascii?Q?sICiZ4VNgjrqFownsmHcfw9Q7Tu4bEgOvxGvsHQTRfIEcCpTO/45id2Ve1o6?=
 =?us-ascii?Q?p3oN3ulv/NlKuCfihhnZDSj3gWEyRpeDJwmCO7PTCzKQF+smxcIbvODtC5lL?=
 =?us-ascii?Q?NynQRJJUA0S0qZP55IUsxpbKg80zlLzMMCyOFeCR+PlAXxHvWR2dwLt4240X?=
 =?us-ascii?Q?KRg72ei8DA3EYKU0dh1PwGKdxEZVqe+WgJOBSdKkjqieiKOi4AshR7hQb0KJ?=
 =?us-ascii?Q?A8BL9BKkBPM/iigiAfE/9sbfpZCeuAYiaG9ToARDi/qrKLpM5cj+/bE2ER7O?=
 =?us-ascii?Q?WRDr06Jox2bEkOqJ1TO8/iDe+wqPkhb1mWHQwE/Y3D566PvGEfgFuVKa6DXv?=
 =?us-ascii?Q?ccEhcU5fsSZNvlwiqMgMBwQm51l1yRcSttsSqtAzEWPUkereaWxTPv4QIq9H?=
 =?us-ascii?Q?BpKclyuB+lf93y+JTJSmrLRWR4sdHk0vvTaqTtmrpIGYMJjyUA3b3GL3a53t?=
 =?us-ascii?Q?VW0I7O2vR8IZRKUyQGom1meFPXtF6H7Gf31silgYpX5LZ4tvJqi/hg5u1WKk?=
 =?us-ascii?Q?KjU6gM9cX2pj/hvYNuU/RRK9ts+PkO9awXvu865mnO6JlAZ0+qgbkCj7Vo6P?=
 =?us-ascii?Q?jirDSoSsw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:2rFLGtKzK8wklCyP9L3a0FlQ4LfyKx4R8pNzzPAP24C5hdA1lZTLbdu3R/90TbZ4OK+SMyDEnu2pBbJxey1EADH86h9ErZnHv2aUKShH0kSYRNy0rp5eMKB2G+BfSoLV5F72K9XXOhCOfu+ZUHAnDegYr215/UaYnjk9p0JCBh3zJEkpBbqNkBW7XoS+r3MC+yf/d8djwq6hF2WkHgZxt9VNGZx4Txrrc+tAiqK4GTaNBgWNlpgJ0732fw6FhmYnfW7dBVhnNCjdRMJIgiuntQRzT58fHsYWPEbflhD3etIPuu2KXhiwfjfAleZvfXplIIyyl/boXblfYaFybhsF0x57OjHL0e4kWwqEh/+clwg=;5:GG0O7B2aPWvoCtrOpn0w3ect4IE6mgvPpZFqsTuvKJ1KEf02Xy6E2b4Jiz2V8PHjGOj4FdzVbNMwMKs8PK6MObRReht4X+EliVF4kRt6wel3Wm/lL1UzbSeFu5wFsiOCyMV3RQ4B4rukShrQ9CBMcBniUG5halRYIz8tUkDrdgM=;24:x5rdvwQXfnCEdepq5NSv/cPqfJDCQx/rxKkpOry6/bhomEUrs8Zg1BlP0bUzA+OmJEZvSJSTj/aOxdVBX2cWdgaxkEe7vIkZ1i4jMVMsZgE=;7:14C560YJwP65ZsiNFVuhzPGp6KBfYUyx8CU++F9VV2C36FxFUi1irzUv7yqJobSmWID2aBxMI6QM3qYBHDpx35RQ6NlSxBSpLwgZpSJQmSXLIteEQAWaIzjrpT/XZL+CQmbkTJtGcoh9hR1FKHG8T9nzD2KWP+2q4axOU6mGA3D2xT2xXSMsLxK28oNNNYWpQMqNKbfsZWcosfvXeqzvQsTUGPgScv2Iz7RXyKNbgQWoMCwLZQPBgQjHVsXJo25s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 14:18:05.0947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25af272b-4bda-42c5-54a3-08d5277cb281
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support in update-index to manually add/remove the fastindex
extension via --[no-]fastindex flags.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fefbe60167..63b7f18807 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -917,6 +917,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
+	int fast_index = -1;
 	struct lock_file lock_file = LOCK_INIT;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1008,6 +1009,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
+		OPT_BOOL(0, "fastindex", &fast_index,
+			N_("enable or disable fast index parsing")),
 		OPT_END()
 	};
 
@@ -1146,6 +1149,25 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
+	if (fast_index > 0) {
+		if (git_config_get_fast_index() == 0)
+			warning(_("core.fastindex is unset; "
+				"set it if you really want to "
+				"enable fastindex"));
+		core_fast_index = 1;
+		active_cache_changed |= SOMETHING_CHANGED;
+		report(_("fastindex enabled"));
+	}
+	else if (!fast_index) {
+		if (git_config_get_fast_index() == 1)
+			warning(_("core.fastindex is set; "
+				"remove it if you really want to "
+				"disable fastindex"));
+		core_fast_index = 0;
+		active_cache_changed |= SOMETHING_CHANGED;
+		report(_("fastindex disabled"));
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
-- 
2.15.0.windows.1

