Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF2320286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbdIGQ0t (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:26:49 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:26976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932110AbdIGQ0q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zxlvIT/am8SCUsc2rK8ANxZbkKpliv70oKo58pMinVA=;
 b=PQ/5/9OY3QApGdsAzIguLDArXzosT3jzJHPFQGDviBhHxJIFZyzhA11+CbZYuD/mfKwVKDlKNq0FOESnZOHGpxwvp1vyk6txCp/2u0rN2eeOJRuJ8cFMy1iop2i8islvbu1vch1oMgLN9Dt8AbAfq4pbGf/DSYUPfsEqHKxL8Y8=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.6; Thu, 7 Sep 2017 16:26:43 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v3 1/3] merge-recursive: fix memory leak
Date:   Thu,  7 Sep 2017 10:25:54 -0600
Message-Id: <20170907162556.61384-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.329.gcdd497e120.dirty
In-Reply-To: <20170907162556.61384-1-kewillf@microsoft.com>
References: <20170907162556.61384-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR08CA0069.namprd08.prod.outlook.com (10.171.251.162) To
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc294f03-f8ca-428e-139b-08d4f60d3a40
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0016;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;3:9uH8KUN4qsFPNLRitFZ7KbqjqBaR/TnQQNUF5lSNBH94TDAoQIDWiEukHDkpJIwAdF30jGgEIbbTvRG20lZnhuFODi+HjSTtW3S7hQZ5IWksJApxPP7QrFBWvpGbo20fQRHGpZ5hvkms2wZeiukepCDdssmgqjJKMCLxDDqTzjqGJ1T0zQajhQtXKRnGbjBV8md1IeRpISdw3dFlBWo6uy+1dD8m4Mn0v1ASxgwyWlXmpDDqieNbE5CZyDRQuuFJ;25:hvxITpFPOyOp42PYgNU42aWNJaCGzR0WH1W/hZZodMmBaBhZiInEnQbxmVMzPY0Hi8rr8J1MXfe2QgNyO4CnqqDWEQvu3iIZgLsU/5yZ9kcc4zAVwjGTHCcWJchgiwFAUThJ2BPRM0lTncY4j+60DQB5zjuOfzbPYHSGtWvdo4rrpZKa6xytOWWl88udAre14tQQfh7wUP4j0/8WdPOBrukdjegLjdtu4WZ8/nle7dsODSe3FVgxQcVEoR0MkCAP92w+lzAz/VWUXVbEN33Co/Euhrt1PEd97RCg8FeevbcvS5EQrFHfZ8oB505yFOSQlI6WPlV4S34pQQKaNWTkFg==;31:uEuSiULkL9Z6l1+TT+ZA+KWJqiWhHAS7ZeuVGof7FwT1BYdTWx9R5H3yl4UUm7MGuDfOv+l3KnMhl47X2aD4d9Xyyzf6WR8NqFeWP0WzReGBNr+lHEQgDHY54CCAG3fp+ZlaoDWOX+mFXtlY5VTc7++qhI4ciuXI4PYBB/7/dmDfJD871wB8XiMsua4llpU2i+041NFjlRGLZTqVQmSY6g/5cv2LtdbACQYLsLfyR4g=
X-MS-TrafficTypeDiagnostic: SN1PR21MB0016:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;20:MAVYXLkpUAXJZcws/65e1RWP2zuI/s0LS2qVsyVXSj8XmZ3fwz0Y0kFKWJqtj+XZ3Kw9MOWWGdcVjgnHc7Ct5VrdIGoZvoYe9ISaPbhY2IQzjjzk/jO23sz7/l04ImqyjYj21pqaBbIFy5yKraeLWvwTunxcb0IrVy+bGB6mDUEEu8ytM23hs+cL/YNH3ANWEHGsfHyddEc/Ozd3Z1rQuj6ej06siah0I21F2mXYxDYeGzH3s0cISioirXSh/1OiEIIG4DTBnA5p1nZbglv7EMwpMAmrGxWJBKmnoaFTGo+ufAqsy01qurV83RV2PmRSm1q/mAn130z4zJyb4j1e6dDCi9H3005CW2jPnyaacI/sy0buxg4OLHZVr6LqZf5B+OFFjeXzaLiympJO8YbRzkbF3aUOt+ywDPjr3F2c+2tcOnsH1Pq4Sfw39rlZISDpZ890jTd3OAEpX6tc6HWB4IR6nJdYUnjfv1u76Ru53UMRK58FK0BTAlHQSz1SsdtO;4:8zE9FcF95HO9aRFTwrDDW0HKoIWOWMI6VFh3JmXlV+dDn2GE/1R3hJkJeRMBJsMk3LAP21jxqvLTQc4DRLrkqozIqwFKf1DIMu5UGodcsKWbuoQO5eoSVAnXfSLs+QbUhUgpTN7hDhKfrOd1/ceAeC51o+BUdAzqTNZlf5cqJVopfYHO9woWLbGtGXKGWXs7AWIgnGGuDfnEfWNCI1wRWKcwY5eEuGqMdcF+JVg+HIMxUqEpc1IdNK0+sDPAmU/JVfxYMDM554Ve0XNvbvFp3pWA8EWjDJcdxjHEeAe97UA=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB00160198DD7D05291F9D9142B7940@SN1PR21MB0016.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0016;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0016;
X-Forefront-PRVS: 04238CD941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(47776003)(305945005)(106356001)(53936002)(68736007)(189998001)(66066001)(2361001)(7736002)(2351001)(33646002)(97736004)(105586002)(5660300001)(42186005)(50466002)(478600001)(10290500003)(48376002)(5003940100001)(6486002)(1076002)(3846002)(25786009)(4326008)(6116002)(8656003)(8936002)(107886003)(5005710100001)(110136004)(50226002)(8676002)(10090500001)(81166006)(2906002)(6666003)(2950100002)(81156014)(76176999)(6916009)(50986999)(101416001)(86612001)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0016;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0016;23:lMr9bPC40PLvkKfwCV805dmRXxEFpzAJ2KeLRC7RQ?=
 =?us-ascii?Q?x7+YpIjU5dHkTTjKtc6fjibDPkyGoZLO3jmXmc51CJdNgzPKgNX9Yxyug753?=
 =?us-ascii?Q?Kz2tKhHCFcFBqgoFgGBci61ptBsx7MviOYwhdEjYOS7gb64ujyr0XIwd8ZER?=
 =?us-ascii?Q?ayYtYNdvqRNnH7wrgWAuYzAB55+DFPGTO/yILCGnMpJv3ARE/Xi3UMgoy/cW?=
 =?us-ascii?Q?WZM7spXHjgAao6UEkqAItoPPf8U4ZN+kXq3Hs9TEJdQ/4QLZQWFEiT7QRhKl?=
 =?us-ascii?Q?Zk/nCDmuPqH7Zfwoe7vWpdchBQTI9K1iRzqfB/FDAyFUakC1a21whqqEDeZe?=
 =?us-ascii?Q?jFvVg3eCniiSpp7u90Cjl1iP/ruG7Diqz+WaclSnmRco7SCitMVjWUUkY3QZ?=
 =?us-ascii?Q?5yKt1l7UmSrjg+Jc0P8px6UwM3r7WPYctwzOH/sdp7cGhhY244IJjL2hErdW?=
 =?us-ascii?Q?jlcRjKo1+WftVJgX9TK/I2IF3TTqj1SYVisinTOgoS6+drt5R8Pdh8lnBqvF?=
 =?us-ascii?Q?dUXxEGhvWaFGutrQIX1BHruCmQ0jIMsoBPExx/BnPC4jJIMRtQC6jpk+6z7g?=
 =?us-ascii?Q?f/XYJJFgPBbVrWAQo0XiWW7Gp/jFXOnQogZHNRu81Aa1VRCH/Mz/5tq8k4PJ?=
 =?us-ascii?Q?Cbitc3Q5na5MqrMRqPXyEFPDGCZkoFLfs/hrMmN6Q+HA+I2Ur8Wzb2eZVk5f?=
 =?us-ascii?Q?FGIoGVPOTUG8VWscj/g8sbryqIbiS8oGTVnOI9GFDLLa9aozBzs2QHfKZWD0?=
 =?us-ascii?Q?w4t9DP4HaViAuZtCR9fKaAza8kNskTefAlaLNZRIt+QlDM3rvA28jfZxpKAY?=
 =?us-ascii?Q?d1By3D1yhB59CYkCSA2Y8HsAGuzPN5ikUwz7ztTwU3Pe5JpdQQ2U+aAN11rE?=
 =?us-ascii?Q?f+ikwlkTWwYoKnu6t9pRq2YO+2CawyrF7/VY40+5n1wFbOc6E7hMsEkgfq8o?=
 =?us-ascii?Q?IPqJuUnJofDk4+W5T5tEutHcpF7y8v0RqBt3iHB+AkF1BhO2GGYqlu+imivP?=
 =?us-ascii?Q?P34R+KffMXV+NFuO3z5ZZm9Ph2ri70vB5u/w79OMsy5mc5kaZTU/z7Io4Qks?=
 =?us-ascii?Q?AJMEhK59h/dyrp/Fq2JifZlhyWjkWorrI0HI8NRAaclbIQI3gz3cNaMNnFOS?=
 =?us-ascii?Q?fPxQmTisdxExSYk+zVzOiPNWCmfxP4G3gssy32RYE8LPqs0VwQ5WRrc758vK?=
 =?us-ascii?Q?+WrMwtT8RyM8UwkTlRwhxPHvf4VIeQkvsMTRuuhNPW9K+VBuel+6Mnim3T3M?=
 =?us-ascii?Q?g3AQ2OBLbj51SXlduE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;6:6lwjBFbBpTCg5HGZkRepFMwzemFsBp4zCi6IMNjwCvIfDtmAtrAmC93Cw96WyaHSJzKh8CP1eqK+bSM0UYklQuEGnrh4stzTYYKZptWg9ObUjmgLa6b3zokG8HLQEaxCuvxCMib2zh/QQ+osDYnsC2ziGdzIvo4kk2AmRNWlbxSJg09yWqQe6RTotfoyPjItHCuIksazYTYdjfKTH0SCo4athK9uHLnXHqUin+LLRx+1DEo/lIW3lOpMz9xgIPfI1W9ip7zGx4sHjKn1MS83860PycSnWjcjLi90J9MUE0cZMorimcLO0Yfxb7Cdu/ccDg7PEZ4XAWxJPn37Mhw9Kw==;5:QwI2CuIcjHlg6tB06bYWph1EK+m7QRLzTOemEyUvY1PJ+tHC3tKplnxvPnNSn/8qgN78C6g0rmdeWTyeBfJadhxaLJufrnQ+rbewL63i1BNUKxDlvATTnUEHUCDR+b8AWp7U3CXde/+zVVClQ6x/Ig==;24:yHMtxtFj26ee8onip/uGASl73ufEQOp6VjIfQap7gEw9Bz3uEk0lw0emKySoNBGRyLl4VIvxoY6BdOpyM8JYXv3tQjITeepgTIcDTG2bYqc=;7:ZsofaFa1B7UgWbjNH0bKL4Oo42DBTpS3k6rpe+Hq0m9j0Z9EKu+qQXjnaEBkpr/nN5FLRoOGOQYBLXu9O/dDiY6um5PmVVkY/VYE49ZjVtuhivUXC6YLEYeA7J/Dplp1vHwZaEYNik0UZ0ZVG0w7tx1trSVIyjQMLpfIpy4JG/qXNm93O+TOXONZnJeZ2eKksAqxkUYvwK4QwZ2Y9QWKdhKm/7/PyXR2Y3KoMeMIG7g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2017 16:26:43.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0016
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In merge_trees if process_renames or process_entry returns less
than zero, the method will just return and not free re_merge,
re_head, or entries.

This change cleans up the allocated variables before returning
to the caller.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb82..033d7cd406 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1956,7 +1956,7 @@ int merge_trees(struct merge_options *o,
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
 		if (clean < 0)
-			return clean;
+			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
@@ -1964,8 +1964,10 @@ int merge_trees(struct merge_options *o,
 				int ret = process_entry(o, path, e);
 				if (!ret)
 					clean = 0;
-				else if (ret < 0)
-					return ret;
+				else if (ret < 0) {
+					clean = ret;
+					goto cleanup;
+				}
 			}
 		}
 		for (i = 0; i < entries->nr; i++) {
@@ -1975,6 +1977,7 @@ int merge_trees(struct merge_options *o,
 				    entries->items[i].string);
 		}
 
+cleanup:
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
@@ -1982,6 +1985,9 @@ int merge_trees(struct merge_options *o,
 		free(re_merge);
 		free(re_head);
 		free(entries);
+
+		if (clean < 0)
+			return clean;
 	}
 	else
 		clean = 1;
-- 
2.14.1.329.gcdd497e120.dirty

