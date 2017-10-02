Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B85C20281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdJBO5J (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:09 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:1204
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751877AbdJBO5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JzhSPS25pTP/fiExfV2Lwjgeekqb4K3d3h2HuMLTtA0=;
 b=KlecVueetZKTQQiyuzCKfcXwvr1JM067EH52+guEzNW0r/yzn9ifcZ34eMpPgzj2Xq/2XIpjWukqneCsG/TAcou2DjtkZmAnZKhUIx1HS+Q5SmnV2PdwOZ5fWXN2LJWdxHdkfWQrbQLOyrHIWQDv8ayNi2dmtgPhYkrVUD+aUrY=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 2/5] p0008-abbrev.sh: Test find_unique_abbrev() perf
Date:   Mon,  2 Oct 2017 10:56:48 -0400
Message-Id: <20171002145651.204984-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To MWHPR2101MB0731.namprd21.prod.outlook.com
 (2603:10b6:301:81::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1341fedc-8488-4785-3d1b-08d509a5d84e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:r40DkdhMTPPuhWnzndyNtX7L2rOiuYns+teuWP3nPdciQnLQ0m28bdfFwdFwpx1nSWjhCJB79ZxZvD+EzWo6GMzX9iM852qlfS3FbUJIUuqfAboSJgaDTdNPbE/oolvOpfix7de7bpoWnnem/1noY0ZDbFDOel775GDZTCbVN9Oy/lRHrumdinWPT8iFEUcQ54q2PVxbaKsdJuKzPvkxd8QMatGqK2sq77JZ6TidnzF6syK44sbKDoMtwGC9kXI7;25:45fmIoEiqhyfV1uxZXHCyEGi76l/CUuZHkvaA1Hr+wcUX0SYNa2Iu7u9Br5qSWKsaVeybB2fjVfmpeVV8OBVdQn8daggYup1Kh/VAjnpEz1/DgfdDDncoWs05U+eGO+UofuPQLAtmxoIlhHh+4YItiAmy8fbp2ha2rsfxjbcwLM4QMTnyZhiYs8ARJPdVNE1bkgqGHHbd78gZywA13+hZeJwCO0SOPlxQA5XopBqpmRglO0RAnWi4B7f5Z2tvq3tDLs/Dnvquet/LFxTlF+FXI1q+EM4gG4cXDdtJOdYPAyy4H/yBl9TJ0F5P7mBzJxhHtlWU8At4zkTE2bR0RXSWA==;31:aokDRyk9fv6AOgfPCWgkqKZZBO4g8C+QfrelX5L0JoRB8nlpBG2JU0NCTdDlgHxUIaVJ9OOrOLAo+OUhkpWdfKkDyQ6KUpHzPE+OEmyL1hQC6iqfm/cNANig4xMPoi0GGKkfN2g6dqSelztTnx7wflK0ZqlgiVZipb51eU/oH96VES1C0EqkX+ZqTeexQ96jiJff4ZTZuTWUucw1FwK+xertkqnuaIlNnQQyvK7g5Es=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:8JBDBmIP0ebAYFNO6tA9/6422cyFnoKwHpm1WVhbUhtOiz5fDTRPi8L217qv+mhk405o2/dH3t8SeZsGmgQDpMHCag54ky0UgRBVe3Z0wcLO0TKZYjF8Nc5UNXr7fMGB1DrTiE7aXQY3pnH8YXwDR4Q2JxlnGbcYoD8V29zaOhrzqFdTxlPh2BimJcfxoOiHOGjWmbWXcvm7oDT6xqxjrZEoX5qzKr11Dd0RdGJB66LZdLEzvXiSie9mTXScELr2rs/GXJ0rY3ytxZgnTbYJrg/Uh0Ghd20Y8q/UbxgSMLIi/+8QLhwC399YCnChPt5oK0Nr6vSLY99tdLXot6CXa3/hy7GeWa8EuyhNCRCnhe7EgJC6aiqtgFRHgv4Q1kYwmcglKZBHAJyKCSxCtkZp2iT4FckBkNo9+HnGVhbmZB3pc0VpFQ4eg+kRKSW9jNufdzA2OBxeAchK2DPARRJ2szhlRtfWjPqZcZpN298M8Tg7gTxx3CM/AT0qTR/hHDAb;4:z9TfSic+//WTrlLN/gc+gphFHVcf/WWXj6Uefxt9Y/sTYnS+uhpr9IdE0DNv3Up8d6f7PO3YRbUe7R2tkP1Mn7pqlQsuvv57F8bUKFsomNK/+HkA1fHAIoL14XmoxArFVnY59monkrSyrzIN9evKwEhWUkoj69HZu1ymLue/T7SQPfexKM4nDQc4KZ66HcDJW8NfdGAlwlWafIdDlcJXJA4zZVlgMyWCuX62veWqTBmBr8wVS5g28ePDarkOABJWQvN3Ux0HJ4zbnhvG4zTmDxSPKgmw8hTaTSgPlacaTiw=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0731E6EAE572E4E67B461C6EA17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:CXA5ye8RH9ZmPMlCWgn3N4hC2gn8678JFoXGBRA?=
 =?us-ascii?Q?HnyTTeQm1Br7HTb+CAK2/qVIbiayJ8FizbCSzt3sRdlcxYdoefRKm8HSC7fr?=
 =?us-ascii?Q?jVjrRtlbpk71YIwruMVQyVK4dWeL6FivEKKQNJV07t6Ju2PSQ4MH9LXpkp8X?=
 =?us-ascii?Q?jGq9Ef/VBBfof7p48C1Q9cKXVHHm7ImJneP1R49B65HufwBOQmCRCmiY3Qlp?=
 =?us-ascii?Q?Lg51WADhqYmAKOKIDwjlvrJ5rwYqp2jTnf+8UUFW8uIJfN4DgJUajufZ4H+y?=
 =?us-ascii?Q?eBShegF5pCFUfOIofAx7UypVB9o2ceeCh+P8k6Ba98Lm1fS+JNqFm1oeCFea?=
 =?us-ascii?Q?L8t9aUnxm1x9YEOr8lcwxLL/YBcdvJhjIFz23vvEMMPQQPV5M4orUDFNplTr?=
 =?us-ascii?Q?BthSaJP7sSyhR4oxyUzA1nDjCa/ngxPMyP4r04nvGwE88lR65su+SwecmmLB?=
 =?us-ascii?Q?7PYZArDvkWIqwLVWIH1aUlB25AwgEueB5W1ugmyCxoeUzfxQFuCeYesPMQSW?=
 =?us-ascii?Q?ncWAy0ztW1IrOMXxjbAXs8+Y4cvJ0b3EBZ5KtBPov0lB4BRs6slDEVdmNC5m?=
 =?us-ascii?Q?MS9DEsGbd0wH9aFukWDmD4Wbli+GO77aVS1S1/X2H4oxIKLxumFqe1B+sVgN?=
 =?us-ascii?Q?kYbRg+9nGPxDpQPPFmmfa82eRLusBkR/d/PckG8MmNSae6vxsaFYPDzczDMo?=
 =?us-ascii?Q?0Ay3FtNS1ic86Hlc6u6atMuZpiH3p1IudSIPsPoLi+SeZD1ANcDyRY00JtYr?=
 =?us-ascii?Q?ivQjXrOYg3mxObJWZoHKHpHgw+wFeVF3sWcHUas3I/0CH6ni8ezaLR0bD28o?=
 =?us-ascii?Q?sCmitEK6BNigMIWEzaVW2m+zoyPsSDdT9uf6OWc9xJh8uS6TKB3KpFWugQHc?=
 =?us-ascii?Q?9hTJrLc1ed6lV6H0l0I0MCPt7l4KxmAbV/qdX94M4bRhiVqh/7ctG7zT+1Oc?=
 =?us-ascii?Q?wS09ey38mvAS1ijG69Ul7vRWh0wxCg0xGaCxv10PtdtARH9QsUNvWtshTht5?=
 =?us-ascii?Q?0SS6Ys+G93j9ufENHP4HtJg450GjvQwlJB0oCajH7keMCGnfo4hKFXqCLtZY?=
 =?us-ascii?Q?6qO2hzJ4usBZRI6r+lhRsmyQZ92qbmy4WnZqYixvnYqsWC99q29CNbjytY7P?=
 =?us-ascii?Q?VHfaYoWaxLsdJHqY6P9gVtuWd9N+y7l+2fWU8fWas1w540m+V/nG8Z9KKl0S?=
 =?us-ascii?Q?4070FYaffJPuQ/SpdLi/zdnpRCC7fkCJpnq7LKakC4nyvGCkbhY3CSjrobTj?=
 =?us-ascii?Q?/0PC35kGEkydzZA7vXr8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:3x1oQIn+4z9y5J5T4G+7+80H2mvNTAi6P0iL3Z3ESpnJ+QUCmMZYUtPizWbTNxyWWA8Z6iR9ExTASXm/waGF+RAhzbBFrXAtyl7Ok7Q1f7JXjxDcJR/DJNOj9kRuO6nJZbtHujLLwXjwdmj2ocEatpQBw4gLtEAZS7SwcKXIo5Mpv12YQzOPUyIClwGP5D7c+XzqTqkOWL3jQg3Me+SGvu0hYsdt7SuJK3/ee5J/dsv7oDEMb3aSM2SM5yTRhbHpJ3bPVlxHD4/fjLw6qoEc9TSfO1toldaPxI2a1Vdg58vUXeObZUQv4RS9B0Z1PBVUQ2NBqaRxY4BGmoM6RoP/EA==;5:M7M9eeSD+8M7F8524NuYCpbQQIWbqcuiSVrT12Bt3mWCRqWOY5rg07JnLm62Kd6xcvY1mA8a1wysHlf+hYp0jqjt39oIl+uZ5PGzRwzCsqG7oN2idYSYlUwlW0/IMyjNQnQuugQa1J1iZIht9voIJw==;24:KKSwfXAN1ocvijLklt9TfIYWl2Q1I73fGqetxfKg3Yv8Im0IVX5RLd1lAOoW0E1WXjxkKmf3++Al07mkMwqCqsyTyy2jn0/07S08keuJY/8=;7:HAS7Mt90V9f8rDCLhAVZ73DTgsVtYej/GzgO87ZBXY9BtWv7Zh7g3SIwlJdK3JGvXpKLVf5Nr7POpyp/bg+9gzpUWi+p7ZcfExBhBcNovYfB3AaV0D+85xXl97yPY85SiyvgGQJFIYGep/2CYyVvckNYkcgpwLeSMGvqawApYZovVYq7pYhxqqE6DsSwmLsKepur0TJ32l+ggNTYAzAZ6sggqMjGu3AIDmDEqwY77Ds=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:03.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helper program test-abbrev to compute the minimum length of a
disambiguating short-sha for an input list of object ids.

Perf test p0008-abbrev.sh runs test-abbrev for 100,000 object ids. For
test 0008.1, these objects exist. For test 0008.2 these objects do not
exist in the repo (with high probability).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile               |  1 +
 t/helper/.gitignore    |  1 +
 t/helper/test-abbrev.c | 18 ++++++++++++++++++
 t/perf/p0008-abbrev.sh | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100755 t/perf/p0008-abbrev.sh

diff --git a/Makefile b/Makefile
index 50a2eab80..63438a44e 100644
--- a/Makefile
+++ b/Makefile
@@ -638,6 +638,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_PROGRAMS_NEED_X += test-abbrev
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 9696f54bb..2190781ff 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,3 +1,4 @@
+/test-abbrev
 /test-chmtime
 /test-ctype
 /test-config
diff --git a/t/helper/test-abbrev.c b/t/helper/test-abbrev.c
new file mode 100644
index 000000000..3ad88611a
--- /dev/null
+++ b/t/helper/test-abbrev.c
@@ -0,0 +1,18 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	struct object_id oid;
+	char hex[GIT_MAX_HEXSZ + 2];
+	const char *end;
+
+	setup_git_directory();
+
+	while (fgets(hex, GIT_MAX_HEXSZ + 2, stdin)) {
+		hex[GIT_MAX_HEXSZ] = 0;
+		if (!parse_oid_hex(hex, &oid, &end))
+			find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
+	}
+
+	exit(0);
+}
diff --git a/t/perf/p0008-abbrev.sh b/t/perf/p0008-abbrev.sh
new file mode 100755
index 000000000..5cbc8a888
--- /dev/null
+++ b/t/perf/p0008-abbrev.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+test_description='Test object disambiguation through abbreviations'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test-list-objects 100000 > objs.txt
+
+test_perf 'find_unique_abbrev() for existing objects' '
+	test-abbrev < objs.txt
+'
+
+test-list-objects --missing 100000 > objs.txt
+
+test_perf 'find_unique_abbrev() for missing objects' '
+	test-abbrev < objs.txt
+'
+
+rm objs.txt
+
+test_done
-- 
2.14.1.538.g56ec8fc98.dirty

