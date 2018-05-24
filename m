Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B58200B9
	for <e@80x24.org>; Thu, 24 May 2018 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033612AbeEXQ0J (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:09 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030872AbeEXQ0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtR6r4J6Mhgh6uKcAAIEtCpEv/hwSyx/T0XFetOx/HY=;
 b=kcxYnLHF5p1Q3H35wKmuFSCmZ2Sq24uiQE9ouWX2r1Zmvm5TTA9II64+VKIg4EzRdTGXK2oTsbKKkjE9h3AeJ/+O5mojgFFtDgXiZMz8cCA+y6riNwPJOpZZOIXtkuKfFtDDMssz6ntvSiiFz7lTrFyNGgTXKcygJMBOZUArk70=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:56 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:56 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 11/20] commit-graph: verify root tree OIDs
Thread-Topic: [PATCH v3 11/20] commit-graph: verify root tree OIDs
Thread-Index: AQHT83vgCfN4NMyv1EK4AvmwONu+Cg==
Date:   Thu, 24 May 2018 16:25:49 +0000
Message-ID: <20180524162504.158394-12-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:+Pxjclh/4nTXtPUC+HRB+x4oWOEgMirCMSqqFyh/UX7LwCkLrFEeJL2F9UhBPQ0Yernh7GlUs/sFf3s0TEC0bzHQnym4gkFxJapJXJonJ2QqCFX5nZFNtze3Jabi7GL9MBM2bhGOAVz/Ia4B/yWgL0wPPoN+hhZppyQPpi/7S5ipaypW5fmJTMP+dRfuxFHX5tYVgEhVhkc1hFfSZ+cHG77o01yKBoCG8fC8/L/cMXLVTiM617NNAdlzZiQXFZo1;20:iuzOYqF4QFYeTRQrBfMw74Y9QL7mpByP7X5MHnNqNj/Ll2gH1s6ZOTr7Y0IW2faIc1iYLZ+ZV/SX/1FHaPaHxW1XARGBUluVsLHYt9mheMM7I9xjSrYpqR1jNfT8CoTdr33AEK8YiARHZ7t5brqScB7rxaH7ZnP3aIBeNuaayNM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB109164045AF70B30F369A9D1A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6666003)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wm58Kz/xClx6Ar3VHTePWlP0ppWC3G1ki8E1QfqcmchzP0nTdx4ZJPNQJCojlEec0D9fKZfOy9m3xeUk+KOIK5Ag+PabDPKWE+3kZ+T8Gv2zzJDst4ARmv0l3IhVkDFCPJNfNQqdETH+Lz3Rh2/zBnX6AihIwmRW5WSy/qrw3uc0duC2wjU23Q8xdDCX4/Zg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4ac6a01b-e4c8-437e-2df7-08d5c19302bf
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6a01b-e4c8-437e-2df7-08d5c19302bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:49.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'verify' subcommand must compare the commit content parsed from the
commit-graph and compare it against the content in the object database.
Use lookup_commit() and parse_commit_in_graph_one() to parse the commits
from the graph and compare against a commit that is loaded separately
and parsed directly from the object database.

Add checks for the root tree OID.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 17 ++++++++++++++++-
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0420ebcd87..19ea369fc6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -880,6 +880,8 @@ int verify_commit_graph(struct commit_graph *g)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
 		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
@@ -897,6 +899,11 @@ int verify_commit_graph(struct commit_graph *g)
=20
 			cur_fanout_pos++;
 		}
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report("failed to parse %s from commit-graph",
+				     oid_to_hex(&cur_oid));
 	}
=20
 	while (cur_fanout_pos < 256) {
@@ -913,16 +920,24 @@ int verify_commit_graph(struct commit_graph *g)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
-		struct commit *odb_commit;
+		struct commit *graph_commit, *odb_commit;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
+		graph_commit =3D lookup_commit(&cur_oid);
 		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report("failed to parse %s from object database",
 				     oid_to_hex(&cur_oid));
 			continue;
 		}
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report("root tree OID for commit %s in commit-graph is %s !=3D %s=
",
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 996a016239..21cc8e82f3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -267,6 +267,8 @@ GRAPH_BYTE_FANOUT2=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* =
255`
 GRAPH_OID_LOOKUP_OFFSET=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
 GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \=
* 8`
 GRAPH_BYTE_OID_LOOKUP_MISSING=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN=
 \* 4 + 10`
+GRAPH_COMMIT_DATA_OFFSET=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $=
NUM_COMMITS`
+GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -341,4 +343,9 @@ test_expect_success 'detect OID not in object database'=
 '
 		"from object database"
 '
=20
+test_expect_success 'detect incorrect tree OID' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_TREE "\01" \
+		"root tree OID for commit"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

