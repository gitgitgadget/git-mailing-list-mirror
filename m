Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC6E1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 01:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBYBfI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 20:35:08 -0500
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:63040
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751474AbeBYBfG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 20:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vDKIv8gpzegFqaafYXoKnMOysFVN9jXpK1AXPYkEKKk=;
 b=f0IiM1N2fi4Ew3mhd4OqF0z32CesHDJPmZy+iLGCPN6xb755juOEyzWud70U8/WyudD1AIFpJwFWi0xf6igMnY+G3utV4MShTIb9YOIXBVGTZ8dHg1ML8YJGMz5Ug6LA3DuTfeymktxIZlGw54z3BFHrVa5lgjjeaFuMtC+Y5xY=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 MW2PR2101MB1018.namprd21.prod.outlook.com (2603:10b6:302:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.567.2; Sun, 25 Feb
 2018 01:35:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] revision.c: reduce object database queries
Date:   Sat, 24 Feb 2018 20:34:56 -0500
Message-Id: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: BN6PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:404:b9::18) To MW2PR2101MB1018.namprd21.prod.outlook.com
 (2603:10b6:302:4::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3804efe7-7b4b-40c7-d440-08d57beffea6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;3:/dLPh4mMiTA+8h+Ha8rBtK3jOFpOpS16DoPyhbuqzQSLU2aQyG5DKSCyeQgXyqJJNDxVvNuSfcH+260eXjMkgEz8iPDhUuor8OTinG+9lyayzEycaC7k4EHS1A1BEWWvLD0QjXm0YaZdQARtbE9ERPX429QeawlffMIAPFML8LED5SuBvOMzQ9FxwNoZfF5boRsW5aZk3j4ho0epAJ8HS175CAgsqkhxLlZ2s35D6HN4+82L8uu5aax3kkWZyHOO;25:jgMFuI4qPixvwICuRcWT27LAAWvsxsyGMm+SUnYqFk/D+f03gnhkL/HDCNDT3QlO4p+J8+4Aupnml/e6gY970paYU7gS0YeXsIyxte50mOWLX38ZovlxCIk0d8Tp/6T8JQTd+uDnM+NhheF5QMbIRgIIP0GDJ7d1SgeVWm03Qdqbfdl3h+9tPKeq2QnH2bhkaVIHcawMCsJIjeExQFga6JXeRT7GoFx+oTdS9rBOeioROp3NktUo0PMmFdGCWl+PXZUbxiaQjJo8xpyHl+Ub8TIwzAaL9O62/GaaWgd3dl5iVsmjc1sFYaX509WgBAUNtGsvFmN9yN1SKVVNPwgqSw==;31:fDLFLGI0ah5althGVw14oV+bophG1oOcA4ZkIpfxdwTWqbVqitX7P4TeWoJIaHT0eUtjXpudanQ19i5xJRCG38wpnIfmypuRN4Mo8j4jZ/EnJiPOSQPUnpNatsjw7vC9PnlzUINoqS4ZY9cBojYNyzWTkZ6jMQdjtuCW6p9ilubbS+HDx8ud9Mtf0hSV1gW5Ss1Bylrzc/sReNBlb6og66MagRMMMKd+69f5MnM1uRA=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1018:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;20:EUYiI7O6rglNSGx6WjM4Peu8T8a7WV1v41d/cr6txlYre6sNqM1qCns7Peod7saUaAhQzv9Vepx6hhXaQgSosd1KpVc8xssqrwF/fqWk8SI+T6FQYzGL8R10W+A1A76JQMBVBsbepajMjkqyzG/fveu9FmS5oCdJlcCYekV7TGKAQPAGtlsqkVbQUqdmioUIb/5BHRpF3lFOB2LhTclhHvDAlK76uqiDlHP5u/pjIeNgFYks4rvs7J1sMYUZzT7JfTAfWfJt6zxCHYU0z0NTLT74rQJJhl2eDgygsZOjbuLir38pSBXROCWu9At/UsZ++yu0wUQQqlj0CTrUee2CkjEcKlgNCUIZnNUjAJ2qaHdDNebSxk1WsFlVkT35z2HjfU/G9Ih2ZYf0HtwXqnEUKInaOOXZnsFM4hBe9t8TOI/+iaspzNwi7jFbDUEDI6tYIZ8QTGAkxmggsr9oROKyoQNDO7dYz9WDQN1/p4SYZhfAFpiVXRXF6jBp4HinuSe1;4:xBSnLje5jO5Chg8OJ7/noWT2VcFztbBnS4cG6KgW/F4tJCRXz58ybcvCNghlit3COu+VF8y48lKi2jqI+osrogVYcNZieu9jz2rNfffQkPa4kQB3Rnz6Izc3HAvXKI7EeFNDrRemLtKwzvEamcV8WE+p5Ig7SaDXJyvUykAtWh91RYDquNDFgqPvmOkfKbTMK+j4cSfgsLSjQM7ZxE7D4mS54INVFXdNqfHyx1fdUgO+yE+dgQ4qmrx4MuuEphFsxYSFbv285XYg3Dgp3uxUWTh6CSmKpvML3M/bNH614bxULED8n0hDrVdpN6YcJ/My2Jt0TgOVJwMDxPmhooLz52aNkuXgvEVRQWQ0FQVX4v8=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB1018C20FCEAB610BF2F8C809A1C20@MW2PR2101MB1018.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501184)(52105095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
X-Forefront-PRVS: 05947791E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(396003)(39860400002)(189003)(199004)(1857600001)(6486002)(53936002)(10090500001)(22452003)(86612001)(8656006)(16586007)(316002)(2361001)(47776003)(106356001)(6666003)(6916009)(2351001)(48376002)(36756003)(68736007)(105586002)(50466002)(52396003)(25786009)(5660300001)(50226002)(97736004)(59450400001)(2906002)(81166006)(81156014)(386003)(305945005)(86362001)(8676002)(51416003)(7736002)(52116002)(7696005)(8936002)(4326008)(107886003)(10290500003)(6116002)(6346003)(186003)(478600001)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1018;23:2mxlA4E24oEgcJ2kwdNx08x+U2qsxr+HxAg6PX9?=
 =?us-ascii?Q?TnI8KegOAg8i8qsQ1xeKU0CiLPyzP1vBiuOakQudB1ZzQDGn+CoxR+pKp6qh?=
 =?us-ascii?Q?3BZ3wRJpPiiPhGHY5lm2PDAN4XDwZln23gQk8IrCZtROd0gb55JkklZuX4fA?=
 =?us-ascii?Q?FEpmEPt0ruqs2h00IJmHur0IHHFGCXAxqO9N/HGQVXjBeS7hW2mKuG9YxQos?=
 =?us-ascii?Q?dTEcsHzwoFx6xzB4ILhWv8F4WI93AZSMuZ4xEmPiPMXq2Ebzm0knWNrA5L95?=
 =?us-ascii?Q?q3kXpkkyPVXyOSzN5VrHnw1tEKhR3Gk9YQCqROdU53lFwc+M0s/Q0dMIbo6O?=
 =?us-ascii?Q?aszL2uxqMrEEWbZqD3+NTlru15SKZg8gZUaJMHvrwMMKY3yDif1SSuSaXGJP?=
 =?us-ascii?Q?RDfedXge04t9AA3eCM4EM6+yXib3MNVji+/Tx+3202l/64GZ5KfurXnwp9O8?=
 =?us-ascii?Q?rn03Cv0E56FKuk99/+Q0ufXNFcDMT9Po1VRxrJEa5WFvnr9hTkVDHbC09h7P?=
 =?us-ascii?Q?O6/RxZpBZB9GQlQT5yF4Q3BawHTO8kL7F75rzmIK5/gkn4tMQm7BMQfPkX9s?=
 =?us-ascii?Q?I90DIZopnbe/ms1+bkFJlHwbyvUg7msMp1hdGvG+7TMLCGtGBqlU2v5U1qLN?=
 =?us-ascii?Q?HykT0vrfGE3Z820WRbhhnfW/7ohLcIxSQupeVP9FzCHfgqRBIxocTe0JlB1/?=
 =?us-ascii?Q?LJISLFm/lOamjQYOYkUdbaK4g001h6dtdXq6SPgQkvK2gG1evPhwy4WhCXtk?=
 =?us-ascii?Q?9kzJWABmAW+v2AuL/QVifNioLhYh573EYq4YNk4tFgkWPetlOfNVFDQt6L/4?=
 =?us-ascii?Q?kEemXTQAgJSjWiB2VO5HpRuFLedyJeCsDndoX5zKEW0pfLcHsf5QmGMjunz0?=
 =?us-ascii?Q?JmR8+OEGgUN16eP4LiTUo6TBM6/CrDeIOEsSo+XJPAxI8MwbvHT9zjcmdHhZ?=
 =?us-ascii?Q?rujNvkwrCVnK6AyTCupJe7rG+JUMnCZkWA1pTtP3g9hAvZ9xk8hZON38McP1?=
 =?us-ascii?Q?z9PM1UjW8hIk+mfLT2bAJj4F6CtxoVnGcR6v4NzPNJNnZBbapz60otEF0VDZ?=
 =?us-ascii?Q?6r+BHzIyNicHJnvqXgImymltmal50RKpV+26RXS/k1x1czu9uPNF66woisSN?=
 =?us-ascii?Q?IJo2oL4s4OrLRCtyC+UWEujCoKlsYQIVUS+JFKXawNBpTs58o0Dl965s3yHs?=
 =?us-ascii?Q?vE2rrNUJXBlxP0qk4wowONRRx+QU3Fq0lIWrUrHNea3R01SFE6lRyxy8q5ZR?=
 =?us-ascii?Q?i7QgnSaWMHRrevj5BLSI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;6:+/L+4XlQp8E5FPljcPJCOxYOaGw/PdSg94saer0rUS0qT3lY2Na6BivEvmM9XjokJLnyJgXpeG7esu9Zfq7XjKJBAiZtY1OLZqDOb6MY/B3OXp+puuSmfCKMCeR2GQtSc7VqbaRBFOh2QnInkVIfh+JfVuiwFHIK5uiXqM8AsdmtefjTEhs5+hqeOO4Rr+f+u6D1l8Qsr0AF2h+uOcoR60lx7UQghQuS2v5+PLFodpGaVWrda52Un0Xydnb3LDSwVZEXvTI7/bi6r1VtAOETjXecppMjmmtbRe2H6H8t3agU7SIhDqDpUH5f41Tgf0KPj5isZBqUNfa5xKHBoMJmPF5TF1HNAT5f0Is2jfhrECk=;5:tDhAPArGZwPDCsv3g/qW/oFgyu38iooZpWdK1yKuHeB7dDSSlSIe9ppixcHwnuZ2iPqDteZE7CJWbvT3VAEZXyUcS2YMsvyqXDCP9P/aTR6vNlI672cYRkAeeu2E1AvhCABfky4L+tl/MSzG1dx66rUlgGVKfl4VcUAyzyGG0Sc=;24:+Y0NhIQCc9vuic1vMIo/sN9rPzLFSoFV3bwPN/zd5RNQbp3CYRHu9FNSFcQvD/owOWazM89eXBLHxIoUgYsDiLPs5kXnAeZKsiuB1ioxio8=;7:dtAeLzoZQzdpiCc+6Nbs+gho0z91O0mU6i7IDY2tvMtafnfWd5BPKpqW4eyl7BP+o9RDfxLWtt6rLwv7PfFRfn1NjXuoUDmeot/9Gq53tq2bl4Lu20J/SW0DCtRrO+YDyEjEwZO9FB7em0ZYnPmQ1fAYcSBlr/+xpa/r0mYJiHypFkDaVKAQ6dP7EqsxzQp26ulwfAJWvJoUi7ot1ejQPIvZ3qOhaaOV0t2PnyAp924139xiEXrsVp4znKv7f9fu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2018 01:35:03.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804efe7-7b4b-40c7-d440-08d57beffea6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In mark_parents_uninteresting(), we check for the existence of an
object file to see if we should treat a commit as parsed. The result
is to set the "parsed" bit on the commit.

Modify the condition to only check has_object_file() if the result
would change the parsed bit.

When a local branch is different from its upstream ref, "git status"
will compute ahead/behind counts. This uses paint_down_to_common()
and hits mark_parents_uninteresting(). On a copy of the Linux repo
with a local instance of "master" behind the remote branch
"origin/master" by ~60,000 commits, we find the performance of
"git status" went from 1.42 seconds to 1.32 seconds, for a relative
difference of -7.0%.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 5ce9b93..bc7def5 100644
--- a/revision.c
+++ b/revision.c
@@ -113,7 +113,8 @@ void mark_parents_uninteresting(struct commit *commit)
 			 * it is popped next time around, we won't be trying
 			 * to parse it and get an error.
 			 */
-			if (!has_object_file(&commit->object.oid))
+			if (!commit->object.parsed &&
+			    !has_object_file(&commit->object.oid))
 				commit->object.parsed = 1;
 
 			if (commit->object.flags & UNINTERESTING)
-- 
2.7.4

