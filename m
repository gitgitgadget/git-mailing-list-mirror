Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEA41F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCOPZk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:25:40 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:45625
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752313AbeCOPZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CglgrlbZ6hBJff7lA5ST2LyYjtzJvQpZ957g5+K3maI=;
 b=TL4mq0ddwh65pYSwESuv+l1UMpZEXMt2nA5WR5cdHIU7d93J1OflpNHQuCQpxrSAMNCsa53wrKKtirnPPiZ3BcMOgFSIseCgb4Ol6s1Qq+zVNi6FWMQ1iviftjVSIlf5iaFH3wRvmIjsA6RMHKfprJ5S7nEmOGp2E0xsKddo7fw=
Received: from localhost.localdomain (70.33.148.227) by
 SN6PR2101MB1024.namprd21.prod.outlook.com (2603:10b6:805:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.609.2; Thu, 15 Mar
 2018 15:25:35 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com, blees@dcon.de,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] Fix bugs preventing adding updated cache entries to the name hash
Date:   Thu, 15 Mar 2018 11:25:20 -0400
Message-Id: <20180315152520.23264-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.16.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: MWHPR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:300:94::32) To SN6PR2101MB1024.namprd21.prod.outlook.com
 (2603:10b6:805:a::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7df07e22-167b-49bd-53bb-08d58a890040
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SN6PR2101MB1024;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1024;3:vhqNBVxp8eudMDDz3U4HmGc0Xz++dYum3JGsPUNEJZT8bM7PThR9P193h5cwYLnyWhxpZpRY29zJrSKVi/TY/esY4bltuK60MTKNOnKkj7+wvEVfw8OxSIGrNcjD7r2DucdbRkOlH7u9SOK7aOwGvg5sFnky+zVSWOfaFfcAHX4jjjKmpOozQ7VKu/g8dEfi8hy5Nh2oXYQbEwg2WMFpuZ4mHRB3Ljk8PEhvE2OQCGqEAnAe7tl1nfwyPMlUkiXW;25:u105tKKJ3T5LMxGcZFz9LtitcY2atV14SK9qFgJDwU6WQCPx3bhAuVoosUQ9K0yhE9Olry9X1jH56EDfpw9LZVoRvnmSFot9SGVvn7RmjpspBMJWU8LWhWBnS7BL/urGRmwUSmNmk+d5pA6knweleCLn6qdW4Eaq9RiwYMzCUfgMs5K/Xia0KW1TbFByAWBeFsp07cYlaJYiHjwYVEAqsJC/ZRPHKPY0WdLDhJ4/n1t34BEWd6s5i1N+TXrzuo8ejntZlPe1KQdC8/J2uatehrP/g91IZpRMScjYiAtG9fOxM15K5Bpl9KR8M7pRe9eDNmrCmQGGeh4zrurgK1sjnw==;31:FgeVq+8MO7sFgyqJrM2SGOzjkF52pC3mgBsucs5gQ24ahWqQNIdeuKAFQgF1u9HTk5Ww7vix3faKdSG0FjOkysKLdILAhlBTXr0Oy0lLrQNWUWaAcBjfdbnZ25e26yBQf8kOhlILjymYDKIGKo0TcRz04E4+GiZ6qqjWsXt3xCJ09RrGgFst0IHyom3CRWfM4uLO5/OAmrpGKvHWx6Rj7L7BoXccZDfD70u7mgBaBIw=
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1024:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1024;20:CFYR+UbpWcmf7Js3hSN7K7lkMXRgmxwy8DuvgYUlnEYrtgb53p1t2djssk18qQ9jrGkExHU1x8VMAEjGtf1gus8rTxww1na5dsnVJLJ8nRY0nwMFiNFB2TvFGTeiDjI4m2RBPg0EMigOZENAMrNy+p7liBqeK5CNhjglZ2DXnSUWBYHy/RALGnGXebrv0AP08NZl0kxk0oHEIoKhOg8lXv4tCFz2JqW4FmuxOiqpV2MFl/hpSoFUJl/XcMIXu7GXF1rHmqHrqbG8fBmKHByMJ7uFwNI2MkQsuplVaK9/jxXAtSORgbSosRmyyBUbHVG6qPbdrnUDWc+CwOUf5HLJp3oypM2WGLkc0aXa7cVg1LrH8MvnQAM+iLOId1npAVeW2bkEw0Ktu/CfUfByRNOeSg+0sfxv1O3d0qdrqvlqwhFBdzGzSMnuY13i4ZlofC0mqPqjiN4J67g2t5ZpMzVySS3Qjs8Qtt3/YYeUbdEEHbequvv0IBZ8GIsqd6ycsToL;4:4xOMd9xP1jHazIUwpIQ9oH7tCBBxVveUKA7FZJ+YCRoEZvIeicseyNj0tj+I+dJp9qPuz0BWHURr/Cczii2NfnSDj0bQ+W2q7+kpRr9U7YIwxVRpbQse3hC9TyHWnuWHN67IMj29FIBtWDl/gBYI8/xu7aDrK0N3p7oear24mDKB/5j+m+tGExFBLSxxEbkR2d78qHSDdR2ZJmo51Hm5q2TWmXZ66LfTnpCDrKBFkylt3CUTTuRj8fJ+PpnrAjj5tYqMnVVtdCCJP+Qny9NErUWFQFf3f9C4s8G5SDCBPhMZR/ZwAsiQ2+9VIuPOFdKU2mTyLShzjM95SscQME211VIwcfUzjjp8tI8JluMS1S8vW2+8LFJ05VJ9DtKKfmOfbG/3zaXYwRXIhQ9+sW/8Fd+ajKyhp6hd5f/5QZKj72g=
X-Microsoft-Antispam-PRVS: <SN6PR2101MB102420646179718C67C69F36F4D00@SN6PR2101MB1024.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501270)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:SN6PR2101MB1024;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1024;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(199004)(189003)(5660300001)(966005)(8676002)(39060400002)(8936002)(81166006)(15650500001)(105586002)(50226002)(81156014)(50466002)(6506007)(2351001)(72206003)(2361001)(1076002)(386003)(478600001)(106356001)(6116002)(10290500003)(7736002)(36756003)(59450400001)(4326008)(48376002)(68736007)(305945005)(316002)(2906002)(16586007)(86612001)(16526019)(52116002)(25786009)(26005)(3846002)(6666003)(6916009)(186003)(107886003)(8656006)(575784001)(47776003)(53936002)(66066001)(6346003)(6486002)(22452003)(51416003)(10090500001)(97736004)(6306002)(6512007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1024;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR2101MB1024;23:BhddSqKw+UhVvgZ5QxhtUByB4p4zQd04RiUDP9P?=
 =?us-ascii?Q?fMoqpL5Nq2rNqIsX+pvmxbOZcsvQLB4u8nrPYsNpyiLn5wZgXxMO50+zlX4x?=
 =?us-ascii?Q?Lzx5U8ivxUgcyg3wYLhBoTAC6e+tooESXQYeqMIUGWUD2hxnPg/YMRCLMXv+?=
 =?us-ascii?Q?mu0yxiibgmbKqUIIjQp8rblPc/jctAfjCb35ViKqiBF3lfdC4MRvT6XuMunT?=
 =?us-ascii?Q?NkuzCPquwTvwmDfATVJcPdv73y4+ujjJaQcPsgY8hhcAwIcLQ09dn4i0RpNa?=
 =?us-ascii?Q?jMKLGz3lMVqzw6+JAFyKB/DPqvJtJw1HdmfgPfEuehO05weJYu2SDeqVUah6?=
 =?us-ascii?Q?PCdAt2/38VjstOFxSI9DpbQ82U3w/FnjdGlrfwSoA6aCpmbwY83Uf+BzPwTr?=
 =?us-ascii?Q?wkUMxo5KjyMQ8ciItMNewggol47+1m0nh37o5+g7iZDCbyRjcetvGoLRerOR?=
 =?us-ascii?Q?Hgd57lS5XvWkODmnTPFuIjzl/roXnGBorE66a77hadtS7/CJspytXvh/otMI?=
 =?us-ascii?Q?ekawEbwW0beG4CUYQC2t356dGUCnA1PGkqX8UnCvrIq99PoFT8rchRZTh4iV?=
 =?us-ascii?Q?/4PWO7mPBYogsW6bjSQCfqA4RP1BVlA6W+U53dVfjm/2mvKiIwp2jo1lPZOY?=
 =?us-ascii?Q?/CxaNthRivcp8HTw3SFXtQzObfwN0YFsCk8eoKiQ4CBwVxIR+5AUeo6521nk?=
 =?us-ascii?Q?L9V6RkZ0TRuuwbcHZCJNnxw9na4JsGhIuwm3XGRByU+5YD4e+I4r0sdI9QRL?=
 =?us-ascii?Q?uGoNccwiv14sQbKUiLB06W1q/tsNiystH7Wc7YxwWQlXdnhO2tF4GgfnvRzn?=
 =?us-ascii?Q?XgesrjLDInDllHFloc0BGYB+dHEp+PwHDSdEaCVrc93CuvrNAs/CFBQMuywW?=
 =?us-ascii?Q?fl62X1CIV3u5JSy81ETbmxQNPS4ZqEOfnRoBXKFUvUBh5SQFJVO16A42lmCf?=
 =?us-ascii?Q?I/kssMd+QJovpOyG0SJ+wAbkTlI9DmTkZtlVIkotEJiC9rLpzrcBqVE/g3QT?=
 =?us-ascii?Q?PtKmX8gvUJ0GkNMlHxPWFlek+PqmCXU1gVC6nIyY+3qZE1IO1epYUiU6TDCF?=
 =?us-ascii?Q?LgOl5LTDC8hiA+s9sBIZxq5Iw2eImmh9A3fszEMXAIq8167zbASfbRxLquqc?=
 =?us-ascii?Q?KulJOprLNugUr28uPIGMHr2ePJSDxztCfW+sPgg+2rwZSzdvTGDCEpIpniWN?=
 =?us-ascii?Q?o82oSqNLEp1aDjCH9kqOCsnA/oAC9KlsoJ1bsWIgwAq928YXDI17Bjgs0+kC?=
 =?us-ascii?Q?xj8laslfnseQdS5XcwuuoEkWLvw2X8lDocz04sf/ca5EgpzuHqxpOa5Fffmj?=
 =?us-ascii?Q?eEtP8PdYYTq0ioXKOy/iQz7SMf+2di9ET29/IIIEeVBsLipZARepPcfi0MKv?=
 =?us-ascii?Q?/ENGJphEmBgv0eHGn/40Y0hXvg0IJi2EweNgOwik2gEEtAEtYrcvs+YNUFxM?=
 =?us-ascii?Q?rUw5cc6sTTbjAoFjzOwS8hx/aR1N1ilU=3D?=
X-Microsoft-Antispam-Message-Info: hQ1fUOQbvFUNnQl7UGrvrGWHN4xgA+1erqDSkiafwXGlvsLI94Hz340M0y9a86+eS39Q9uv6jlKCeznsHqd+ZwU3yvAysGZeOS9RQ0V/VkGA4LViqgtYnvHY5v2nsO/cw1hAWp7cjMmg4KsPIYQOW54Nr/cucFZ7cyvSQkHCgD3S3Nxfnsu5aEJJB8LvT6Qj
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1024;6:Vjv+6icCarb7wag838LBXaXc78WLHTZAwrVdP1xjo7WzFIXIysCE7gKYLWkHEAeBjCpxaEYA9ouAJhVgDe/lXxQImvwynJJpZTkFg1Hv7nFNn5CHVoJjnTj4kbJ2n69EVJGcazVBzsCyBkkmuxuZD9dAqGZ2ClqAZ014IGbzzg4Lr72dw5ERKlC9uM1iMmJs9p53ii0aMfKLgvMdcv9rjDtk+x4RTh6eWrHTpJ+ej8abE6LZdPG6IBdcOpmw0gFs3RNoALIfAU2IolH1gXGIKzx1f+RxuE5pDLKnasDOx9rg/k0GQviRGm70n5cy8+92ElvZFrjgZRLKZrWJ0wAyWllEZXFDDbL8qkfJpnk10/fmMWHfnLBXPnmbpkYO6CX61Vj6C94W28H4zq/s1MktX9ix9f7JIFQ9DcCMJ/7USNK0Y5b+ZO0nmTWjnLMYT9MSD54XCOTZHvTFQbZckZNhgw==;5:5alr7Vb0n7Wc6QP9ZXeSmU2ZU8feRm3UVJVTuFjrU2qyYyR5mpHGXNkql08dIPlUTf/W4buZRtVo1umtesWVXWlUVsjuYVL8bYs6TqXVNiXBlhG/8dUNl7XVpj8LIGXjq3Zudvk/lxsP/xrLm8w7d1KPlJJJY59k0rwIEBhD5is=;24:AsmkZeWgSLBQcdhCfLJZw6V5nSTZF7H/xZa0WT1ftLedCD/ocHNgjElGQ5E9ATpCf8ZKF0iR9L1WoKh/PpHRyaWUgSxArcrbSp7iOcZm098=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1024;7:jFNTAjuZ4/sTVyc4I+1NZIrG9jwF5zSBw0FpaPi0/RrF3uMtLPYGI3DTBUKleX1DRdkMSJE1On2lm7gOeVanBs0/1PHGDGWJYVm31JaKuuZaP8zGLsAItTtXCxIqBMU9JF9exwZf33ybc//8HnOYK9PlO7dBscHEcCuCXE2tw+MWebNCVoUaC2BQM5tLp9NCKylgDav2sYfByuKArQFphnJRlNSz5cEzJoKgyUhlrfi3Et/YsJElOPnHa7TFvHMJ;20:C/Wf9uq+jLP7cCjxGPx8G2s5ibNXP5vHi/2x6f1Y4jHzBazksuDx48HQEcvWASpYMKsCx9zQpM7I6TlIKx8b0Vv+ZYShyMMfBK7ZfjwP0jZbrSUHba5JosO/mqKhZx2OyBYuvfDWJLxjvevesrySz29Narou9zph0s8e21hXhsY=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 15:25:35.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df07e22-167b-49bd-53bb-08d58a890040
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1024
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update replace_index_entry() to clear the CE_HASHED flag from the new cache
entry so that it can add it to the name hash in set_index_entry()

Fix refresh_cache_ent() to use the copy_cache_entry() macro instead of memcpy()
so that it doesn't incorrectly copy the hash state from the old entry.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/079be4ac07
    Checkout: git fetch https://github.com/benpeart/git ce_hashed-v1 && git checkout 079be4ac07

 read-cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 977921d90c..bdfa552861 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -62,6 +62,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 	replace_index_entry_in_base(istate, old, ce);
 	remove_name_hash(istate, old);
 	free(old);
+	ce->ce_flags &= ~CE_HASHED;
 	set_index_entry(istate, nr, ce);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
 	mark_fsmonitor_invalid(istate, ce);
@@ -1324,7 +1325,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 
 	size = ce_size(ce);
 	updated = xmalloc(size);
-	memcpy(updated, ce, size);
+	copy_cache_entry(updated, ce);
+	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
 	fill_stat_cache_info(updated, &st);
 	/*
 	 * If ignore_valid is not set, we should leave CE_VALID bit

base-commit: d0db9edba0050ada6f6eac68061599690d2a4333
-- 
2.16.2.windows.1

