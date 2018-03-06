Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A957A1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 11:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeCFLx4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 06:53:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbeCFLxy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Mar 2018 06:53:54 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w26BjL6k007142
        for <git@vger.kernel.org>; Tue, 6 Mar 2018 03:53:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=content-type : from : to
 : subject : date : message-id : content-transfer-encoding : mime-version;
 s=facebook; bh=LBgVlDxKXimY0D19EiMxKwdTyckMCXQZ0eXOnD4/SkY=;
 b=EQ4kuTJe+taT49sq7DipcCsHzCKRGkrUGUJvXS/1pRS8WfOuKVZDD/4701ywdnDXIBrU
 8S3cA/A+0y8gNRPQ+opbOud3hqhocX0KWNf2Yu/XVqTXa5aMJ2qd9wRRzbzJSPWX5lUx
 LQuIn6K1iEjOMPI0CGv/k6BXSzq2rqPm9iM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ghq7ggkc2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 03:53:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Mar 2018 06:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LBgVlDxKXimY0D19EiMxKwdTyckMCXQZ0eXOnD4/SkY=;
 b=aNrCDQ6PrxD/vOsID+qnno2Bg/V9WuAGoEmnLJQ8V2rLp+TJkCP890ubNDrPpZRKwhkhLByVCAzzgDFeKE7FN3WZSKMgiIBGGU5A11LL52Ln07ziiS6+QRmbzoAX8NvmPnvyOLWMNH8z4a6U765gVJejBjSjgaFRfHwP4k7agKw=
Received: from localhost (69.181.140.208) by
 BY2PR15MB0805.namprd15.prod.outlook.com (10.164.171.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.548.13; Tue, 6 Mar 2018 11:53:50 +0000
Content-Type: text/plain; charset="UTF-8"
From:   Jun Wu <quark@fb.com>
To:     git <git@vger.kernel.org>
Subject: [PATCH] xdiff: improve trimming preprocessing
Date:   Tue, 6 Mar 2018 03:53:46 -0800
Message-ID: <1520337165-sup-4504@x1c>
User-Agent: Sup/g7607543
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Originating-IP: [69.181.140.208]
X-ClientProxiedBy: CY4PR20CA0009.namprd20.prod.outlook.com (10.173.116.147) To
 BY2PR15MB0805.namprd15.prod.outlook.com (10.164.171.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1213dd82-ea14-4c42-d6f4-08d58358ed5c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0805;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0805;3:1sk8yr5nlrvXfHhOq75xVwL87Se2qouGZV1aJnRxl5qqMt494HAOQYif3/PZ9TsUmp3OWmMKSLvgW8xvYpa0Set2YeTAgX1C1hL6O1MRxEAznyA1Z0iILXjhecKz5sws49Q2U+4oIJw299if0igvNQUKSF0xdU8t9/fNLaUchuZvCoWncjcEo9Woi6lavQ0hUYHrd8uDSSsg8N7JQPQDsnsfEIFw3mLEC5pJ1Xf2HIDHNWwVCY8f1fRem+wqM6qD;25:8v+3mxNZm/vt0DoM+1OqU8ObEcG3t90boQfoxevawmtm+gjPP4SVctZU4oNLdnoyhxyd6uV/8PgiWPmolUDqvgA9wecqWnZu/5W8B/9l9s32lVc8tFiqIH1PX8zF2o8y/Qz04s35iLIkAEZ/Mdn41sXYaydNdjxSA20YXuDP5N46Scut7Z5TgwNpBJExRdd7S9YtSJs6wAUwk+2C+cq61AE37BCtizog51hYAh6zlrxKMqnuSHK3vhf+0IesB76oiIqC4Ds2ZkMC1+dVbi2L7rWzGyEkCN+2a72B8avj1F7dzHm+ESh3gipDEvUS+a4a8e2drOGXsZktggWi5Fzp2Q==;31:IobBjOTg9V44VVpTMqkQu1U9d7uEzhsc96uXk2gGTvkMx0h+40EnlgFhSlw8Oy7cFCjGj2cv3u6dBWH0dPMVJfNHKAxgAtxj5WERL3u35//vCk67bW/mBDGgJXceSH9l4mdsehSZn3n/+t1l+KI7sAZFS4M+gTPd5+PB9HFKkynOSxUKoSYpEljp7TmPMMCnP262NqVNnIteIzcIqJsfyHOea2zbEtwn7YU+q2duy+Q=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0805:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0805;20:LmkrLe4O1WWATgRD2iDR07YSvDG2BmEZd7Wf/Q9P+eKFQrW1BB27//R3p+KloBCUFb4Msl4ALaiHk/5NWNRIXH5AhyORYRZ/Dd2bsYELbVlt2K/8tWnS4mOUzLCNVUtM4SCvkIRBiR6+Y5RupheisP0mqFcZxCz3Q/Sc1x7F9R8c1H7UtcnSQXhj4tqYD3V0tANCrKpYYWVPvmoY2fo7QWqdcYLehdk67jVTvDhMgKv5pWZUq5tKix4eZQhh7v4iL9XK0YzCvMQDfLCKLmw/k+OC36yn5Ejwydm3zecjzSM4uim9jmU1nkkEDhexPO9OqfNR8MSz2+PPTxcyxoyvI4IdZe6+tLHNVqhqWsBdYtHjVOJ+x+u6JC5S2Mqvux+EMBEKimXx4s4AFG4wSVHdRoaYfyTanWIPI+d/+oI8yTueEd9f11yfNt2squ9YvYJhQ9lUuooOxAa1mqlEiRlOJ/cAHlm0i5HCVmXAC19nhN+a9XqF+fsQGZJQUaWf7V8e;4:LrvZrvqG47ICtBKYEpBmAnwE2HYqw6DzzjONL2gvXifbgLbeHJtmt6fU+sBuavRfbz7lIZ97qhUGTHl3qAiKa7IqxZdjbmD1enLazFO8sJYyTuvHG05o0aXdmoIM6N6/bjIwIMt672Dc1UKTu5dbHi1sf5okks6IZao9mbv4HZoI/fGqRHPXnkviYG0jML+t4f+dFZwPKV22+ifkagehCsfDs3AFLngzF1lq0f/N6a1mi+a1XU1b80UFmN4HCi5Z3Re5UWyjWIIAC2zNAQoj2PoSS0x33PSF+JOUl2mMGQO5wH309RpnYTfRfIk8Yut5
X-Microsoft-Antispam-PRVS: <BY2PR15MB0805BAD03C5B127DDB0305B1CDD90@BY2PR15MB0805.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(3002001)(6041288)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR15MB0805;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0805;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39380400002)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(478600001)(86362001)(58126008)(966005)(386003)(6496006)(52116002)(23676004)(16526019)(53936002)(186003)(9686003)(26005)(33896004)(33716001)(1857600001)(97736004)(2906002)(6916009)(316002)(47776003)(6486002)(3846002)(305945005)(5660300001)(68736007)(2870700001)(7736002)(66066001)(25786009)(50466002)(106356001)(81156014)(81166006)(6666003)(8936002)(6116002)(8676002)(76506005)(105586002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0805;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjE1TUIwODA1OzIzOm9SanhvcEhKQ3F3RklzNlFaTWpzanQ5RlpB?=
 =?utf-8?B?NmNNcG1GYjFEblRZR2Y0MnpleWNza1hHa1huV0dsalNQK093RTVZYjVBU1hz?=
 =?utf-8?B?eDNzR1VXUEw4QkQ5UFFqUjJtUVVEdzlJc2hqYWJ3RTI3bHdVMy9KakphQXBG?=
 =?utf-8?B?QndOU1NBamFsRm9CSW4zOUhQcmtsMWxSanFtMjdzbkdkdzV0dFp4Ty90YXZs?=
 =?utf-8?B?Zk5jN1VVaDVpWHpjUzN6eXQ0QXVycnFUVE1kWS9TMU5reHNiT3Q1SkN2OERJ?=
 =?utf-8?B?RndtREd5b2dBWUJNTHl4SkhZeXNYL08yV3Y4d0dVRmRhTzhRMmgwSUNTbFJO?=
 =?utf-8?B?VHo2REtWQTJUdkRXcXZNeGQ4elkzcFNyTGlvSTNjc0dJZkg2bnhSenVxNkdR?=
 =?utf-8?B?MnZXakV2UFFxQTlRNlpNL09mMTdVRGljNkx5L1RZNzdScjZpZTNiMmJIdjNS?=
 =?utf-8?B?cDVXcWR0QmhxdjBncHFRa2lmTnNhTVcrMnp3aGlQYi8wbXJ4K1l5V0kwbGxG?=
 =?utf-8?B?ajhpWjBNOWR0Q050b0RxSGpiaUN5alBJLzdjZHFoN0c2S0Y3aW9KSXMrT01m?=
 =?utf-8?B?QXdGZVBNL0pHdjNDS1JYYVBmVEZVSUowRE41WURHTzFqaGZXK2I5S0tmczFm?=
 =?utf-8?B?Zkp1dXlNK2JmeGd6cGNIZDR2TWZYQWxjUkttRjJTQm4weGdtWU1weTBzVVVU?=
 =?utf-8?B?YWdYWWpzeEFKaDZnYjl1c2R2Rm00YnpIN3pVNEhYWVhDNzRaRjI1eUM3K0lX?=
 =?utf-8?B?akVZa1RMNmIrVnhheVBCOW5WMFYvNGw1dC9PbmNMek44UkptZXdxZnh3Nkox?=
 =?utf-8?B?RGhQOFBvU3VrMlc0b1hPTGtMYlJ6b3hHd2tyMnFjZkhSaWY1bEM0V2RqMWZR?=
 =?utf-8?B?dnJBajlFQWZXWWoyMVI3UnJZSkxhc29EUXZWTTY3dkpJWkFHMkZ3N2lFTUZ2?=
 =?utf-8?B?RDJnY0tmcm0vdXFaR3BnZ1F2WTVGRnJCai9ZUzd0N0JqbHovWS9ReFBXc2k5?=
 =?utf-8?B?MXIvM1gyaWF5WVl1a2ozWjV3NDBXUFgrQzJsOFNEOHpMYlRvalkxMmt3MVUw?=
 =?utf-8?B?RUlSMGxFUG1XK0lBcXBVVEFJQXNIaWxVL3VKMHgvNTg0OFRmZWtvUG9NZWVv?=
 =?utf-8?B?Si96Ync3VXZVN3BmQXZkWTQvVDlNS1NOaE90MlRhSVZZeEthQWlHdTY0c0FE?=
 =?utf-8?B?ejdRQXptWVJaMTM3ZnBzZEQyTkZ2LzE4M0Q5enB2NHY0czBmS1dWb3ZIOWtj?=
 =?utf-8?B?cWhab0c0aUNITTh5VEdYQlRhTXd3dk4zOWtBYlQ5eHhhWnludVlyeGo4Q3p3?=
 =?utf-8?B?SGVNWlZVYW1oczBOOFIrcVdQQXpRaEtFK2tCdzM0amhBMmdXejZHc3NQTFRq?=
 =?utf-8?B?NTFHN1lHR1ZuWEdCWG5NRzh6VXlDcyt2c2I2YitDeFFhWUo0bHZzUkE1OUFQ?=
 =?utf-8?B?T0FreVA4MmpFdnF5RmNJK0ExL2tOZHVnM3lWcTF3dHZaTDFNS3NQamhSRzZU?=
 =?utf-8?B?elFTdFRJZXpQQXRLMFpDSlBHOXhud2tjcGxybUp6eVJNYkhJSXl3alVYVUdo?=
 =?utf-8?B?cDhCb29jdUcyRHR1Z010WG1teFpJblE9PQ==?=
X-Microsoft-Antispam-Message-Info: uY4LAsuuiwNzDjoUBksX2ANY2XmYhb4L7nkoxB9HFjZXY1LCKd/I8GKAaBjKM1PR+9oK/Gcd6/AC8p5jP48g+0h4RfbV09dXC5U1F/IxpxfawwU62RndDBs5ov0d67RfrWJeufLhTk6paiA2NpPBqghSnJrjKbZE+/JlW6o6wa0wKHbQK11jG5cQfLrda1CF
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0805;6:cYSYGKuIal6mTaBqzn+EbWwdl3m8EK+2vjhsklkFiA4dNogaCKU2q/x7qQkpbq2c66STHn5KGQt2JrHhxhZYWZczZOkJ3PuGbjzQmWhK9SVkq7Z2p89M8EqKQOAoNAiEpJC4JCMmt0lTQp/khIH5AtbXRPv1y1nxkVGBriNbvSurfJJsjbTkQ0N9Dgv8WcrDpIT9xP1EJDt851EyHH+8Ap6FhkeDqQKSyvFae/evvBSXofGX+pgavCWeatL5Gv4Va3mfaj7kc9vz2tlv6iwNSrz71Pu8bLh9NznOld2BRvU5Pddv+NcgCKu/DZBP28Y5S22w1GjMjWRwWDbCrTxXbxzGxKW8s3g5Z0gEoXrgfT4=;5:Uq2ZxdSK4C184VXpEwdQzCbTRHvL+Ks4a5EBLZZtY+tFvfWoa5UWztBZdkOzHTy/aFLMn5o8RDuYRzwow9vcwpnLmXqcujjrheZJnJsJiuStLVKD2XRCHa8FLRiANXa1F9kvuswlEKlHmpZximKEk/Utm6yTURSdY0JBEXoBZ/Y=;24:1xZUiTvoqlMMeiyy/FCYXK5ljAYF95Frsw4yyME2DHs39G5WWA/2kKqNpdb4S+H99v+WmXg23hw6agTEYMD+AbysLxPIit5ZY9Ow8C2vbzU=;7:eT2eG3WBYIK2BCrIo2QTAhfg1HpRxltA+F7mAh8Qt0nqzfmOJ3d/BV+Hs5BNpSbss1v+L+5ah4UwLu//yc4sxOL0GOXjK9yv0T/3uU6yU50FvdCtnjg5d1gLcy+YPta9XKexL1iASNl0WQ64bivazT++kShDRCCuLzECdR01ZjQFW7EGnpnT7QuXfQDXeL7EDhS8fdpqRZDNMRAI3CIlTOMYqw/DKUyRwt0rTwGsUccWWbaT2KV/dEgo4FhJIZ4W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0805;20:R87Ifn2UU0JUvyZoN0UV8u03IObsllPe6BovX0j/KtvBec04U21I+ZTOZ69YwJOFNOm8UI1ix/Cl40tlTDflGhm/W9OXZHb4xVkPhQFxbJYftNnS9v+dialTiFwUDcSsfuM1PogODKIp2Kwpo0wzOdkf6YvagPnxmOxAcFfNd44=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 11:53:50.2625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1213dd82-ea14-4c42-d6f4-08d58358ed5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xdiff-interface trims common suffix if ctxlen is 0. Teach it to also
trim common prefix, and trim less lines if ctxlen > 0. So it can benefit
the default diff command, as seen by profiling:

  $ GIT_PERF_REPEAT_COUNT=10 ./run origin/master . -- p4000-diff-algorithms.sh
  [...]
  Test                                  origin/master     this tree
  ------------------------------------------------------------------------------
  4000.1: log -3000 (baseline)          0.07(0.06+0.01)   0.06(0.05+0.01) -14.3%
  4000.2: log --raw -3000 (tree-only)   0.31(0.28+0.02)   0.31(0.27+0.02) +0.0%
  4000.3: log -p -3000 (Myers)          2.25(2.05+0.17)   1.66(1.52+0.11) -26.2%
  4000.4: log -p -3000 --histogram      2.51(2.36+0.10)   1.90(1.79+0.09) -24.3%
  4000.5: log -p -3000 --patience       2.63(2.44+0.16)   1.70(1.56+0.12) -35.4%

Diff shifting behaviors (hunk merging, indent heuristic, shift towards
the end for repetitive content) are preserved as a best effort by:

  1. Reserve extra 100 lines to not be trimmed. Leave room for shifting.
  2. Calculate common prefix first. Disallow suffix overlap with prefix
     in the smaller file. So diff hunk tends to be shifted down.

Add tests for those. Make sure they fail on the old code.

Backported from a Mercurial patch [1]. Adjusted to git's existing
xdiff-interface.c (which isn't ported to Mercurial).

Note: xdl_trim_ends does a similar job. But too late - it's after line
splitting, hashing, correcting hash values. Those steps have visible
overhead.

[1]: https://phab.mercurial-scm.org/D2686

Signed-off-by: Jun Wu <quark@fb.com>
---
 t/t4066-diff-trimming.sh | 49 +++++++++++++++++++++++++++++++++++++++
 xdiff-interface.c        | 60 +++++++++++++++++++++++++++++++++---------------
 xdiff/xdiff.h            |  3 +++
 xdiff/xdiffi.c           |  5 ++--
 xdiff/xemit.c            |  3 ++-
 5 files changed, 98 insertions(+), 22 deletions(-)
 create mode 100755 t/t4066-diff-trimming.sh

diff --git a/t/t4066-diff-trimming.sh b/t/t4066-diff-trimming.sh
new file mode 100755
index 000000000..3d90175ac
--- /dev/null
+++ b/t/t4066-diff-trimming.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='diff trimming optimization'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+  printf "x\n%.0s" {1..1000} >a &&
+  printf "x\n%.0s" {1..1001} >b &&
+  cat >c <<EOF1 && cat >d <<EOF2 &&\
+  printf "x%.0s" {1..934} >>c &&\
+  printf "x%.0s" {1..934} >>d # pad common suffix to 1024 bytes
+  try:
+      import foo
+  except ImportError:
+      pass
+  try:
+      import bar
+  except ImportError:
+      pass
+EOF1
+  try:
+      import foo
+  except ImportError:
+      pass
+  try:
+      import baz
+  except ImportError:
+      pass
+  try:
+      import bar
+  except ImportError:
+      pass
+EOF2
+'
+
+test_expect_success 'git diff -U0 shifts hunk towards the end' '
+	test_expect_code 1 git diff -U0 --no-index a b |\
+    fgrep "@@ -1000,0 +1001 @@" &&
+	test_expect_code 1 git diff -U0 --no-index b a |\
+    fgrep "@@ -1001 +1000,0 @@"
+'
+
+test_expect_success 'git diff -U0 --indent-heuristic' '
+	test_expect_code 1 git diff -U0 --no-index --indent-heuristic c d |\
+    fgrep "@@ -4,0 +5,4 @@"
+'
+
+test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 770e1f7f8..a4141e2db 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -101,42 +101,64 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 }
 
 /*
- * Trim down common substring at the end of the buffers,
- * but end on a complete line.
+ * Trim down common prefix and suffix, except for reserved lines.
+ * Align to line boundary.
  */
-static void trim_common_tail(mmfile_t *a, mmfile_t *b)
+static void trim_common(mmfile_t *a, mmfile_t *b, long reserved,
+			xdemitconf_t *xecfg)
 {
 	const int blk = 1024;
-	long trimmed = 0, recovered = 0;
-	char *ap = a->ptr + a->size;
-	char *bp = b->ptr + b->size;
+	long i = 0, lines = 0;
+	char *ap = a->ptr, *ae = a->ptr + a->size - 1;
+	char *bp = b->ptr, *be = b->ptr + b->size - 1;
 	long smaller = (a->size < b->size) ? a->size : b->size;
+	size_t prefix = 0, suffix = 0;
 
-	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
-		trimmed += blk;
-		ap -= blk;
-		bp -= blk;
+	if (smaller == 0)
+		return;
+
+	/* prefix - need line count for xecfg->ptrimmed */
+	for (i = 0; ++i < smaller && *ap == *bp;) {
+		lines += (*ap == '\n');
+		ap++, bp++;
+	}
+	for (i = 0; i <= reserved && --ap >= a->ptr;)
+		i += (*ap == '\n');
+	if (ap > a->ptr) {
+		prefix = ap + 1 - a->ptr;
+		xecfg->ptrimmed = lines + 1 - i;
 	}
 
-	while (recovered < trimmed)
-		if (ap[recovered++] == '\n')
-			break;
-	a->size -= trimmed - recovered;
-	b->size -= trimmed - recovered;
-}
+	/* suffix - no line count, but do not overlap with prefix */
+	for (i = bp - b->ptr; (i += blk) < smaller && !memcmp(ae - blk, be - blk, blk);)
+		ae -= blk, be -= blk;
+	for (i = 0; i <= reserved && ++ae < a->ptr + a->size;)
+		i += (*ae == '\n');
+	if (ae < a->ptr + a->size)
+		suffix = a->ptr + a->size - 1 - ae;
+
+	a->size -= prefix + suffix;
+	b->size -= prefix + suffix;
+	a->ptr += prefix;
+	b->ptr += prefix;
+};
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
 	mmfile_t a = *mf1;
 	mmfile_t b = *mf2;
+	xdemitconf_t ecfg = *xecfg;
 
 	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
 		return -1;
 
-	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
-		trim_common_tail(&a, &b);
+	if (!(xecfg->flags & XDL_EMIT_FUNCCONTEXT)) {
+		/* reserve 100 lines for hunk shifting */
+		long reserved = xecfg->ctxlen + 100;
+		trim_common(&a, &b, reserved, &ecfg);
+	}
 
-	return xdl_diff(&a, &b, xpp, xecfg, xecb);
+	return xdl_diff(&a, &b, xpp, &ecfg, xecb);
 }
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c1937a291..737d96607 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -110,6 +110,9 @@ typedef struct s_xdemitconf {
 	find_func_t find_func;
 	void *find_func_priv;
 	xdl_emit_hunk_consume_func_t hunk_func;
+
+	/* prefix lines trimmed */
+	long ptrimmed;
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463..d62c5769e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -981,13 +981,14 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			      xdemitconf_t const *xecfg)
 {
 	xdchange_t *xch, *xche;
+	long p = xecfg->ptrimmed;
 
 	for (xch = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(&xch, xecfg);
 		if (!xch)
 			break;
-		if (xecfg->hunk_func(xch->i1, xche->i1 + xche->chg1 - xch->i1,
-				     xch->i2, xche->i2 + xche->chg2 - xch->i2,
+		if (xecfg->hunk_func(xch->i1 + p, xche->i1 + xche->chg1 - xch->i1,
+				     xch->i2 + p, xche->i2 + xche->chg2 - xch->i2,
 				     ecb->priv) < 0)
 			return -1;
 	}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 7778dc2b1..45d4ab073 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -167,6 +167,7 @@ static int is_empty_rec(xdfile_t *xdf, long ri)
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
+	long p = xecfg->ptrimmed + 1;
 	xdchange_t *xch, *xche;
 	long funclineprev = -1;
 	struct func_line func_line = { 0 };
@@ -261,7 +262,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 				      s1 - 1, funclineprev);
 			funclineprev = s1 - 1;
 		}
-		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
+		if (xdl_emit_hunk_hdr(s1 + p, e1 - s1, s2 + p, e2 - s2,
 				      func_line.buf, func_line.len, ecb) < 0)
 			return -1;
 
-- 
2.16.2


