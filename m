Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21C91F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeFHN40 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:26 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:7405
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeFHN4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBS+4Cqn1m/ivQhLIqEwNh3M1IPiZ9yoXQvLG2y3O4I=;
 b=lHbcOHWZ0Dk/ROr+BgX/C5J+M3juaI15JXAsSTVuKx0YIzUx5hHY6OIhriFPQu/6huIn9FuArUhTzDeafWmkp6eDUodao2iV8dQ4Kpzzpm6QJ3+msG6jpmDuTEmmWZZAp8EGjWVykwIlqMqtfWAE44z6lSFLMYhWp9ch9MjFJVY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:20 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 09/21] commit-graph: verify corrupt OID fanout and lookup
Thread-Topic: [PATCH v6 09/21] commit-graph: verify corrupt OID fanout and
 lookup
Thread-Index: AQHT/zB6ckouWo3K+USsNlZ4q2+Ycw==
Date:   Fri, 8 Jun 2018 13:56:20 +0000
Message-ID: <20180608135548.216405-10-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:4UfaWCdrPEq0r97tCh4xXXnufkTladmIqxVSrS+xpe+/KfwlGbyRGxnQJRofkf+gF7TBXhxOs/24dDVpL1ZW0QKfoKVW8V6BRogaUDTDz8+/gAfl2jOEsesi9k+CPt4kHYiul27om0FY7vPujC829HXDhLtZAKVP9LdQg0N+tRfo09aEzuq7d+1BVSSqrd/PNnb8XecPHresfqaBAVTALaNGev5irjHNv1ShVANhZO83yBbHeZTQHKaN8bVh14L1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB097957F7F08DC11494FFD3B8A17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(15650500001)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /v9XwXR0DeJksaHz9lnRNMhDFkXQnAbIMsl0xWFWZdJG8RCFy28Cl5nPjF/Pybepepv+wjNoChZjcFNAB1OQn7fLh1406wU5qlGlb1vNRavRYD605SpCNEslkLB3GgXYVF/+vZph+XWyPIITyIer3d0ra6L0bKa1Vrg19wpT3+jG0GIax9uTfLSAP2kdeLc5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 69e83476-afe0-41d6-64fd-08d5cd479cb0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e83476-afe0-41d6-64fd-08d5cd479cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:20.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit-graph file, the OID fanout chunk provides an index into
the OID lookup. The 'verify' subcommand should find incorrect values
in the fanout.

Similarly, the 'verify' subcommand should find out-of-order values in
the OID lookup.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index f30b4ccee9..866a9e7e41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -843,6 +843,9 @@ static void graph_report(const char *fmt, ...)
=20
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -857,5 +860,38 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report("commit-graph is missing the Commit Data chunk");
=20
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report("commit-graph has incorrect OID order: %s then %s",
+				     oid_to_hex(&prev_oid),
+				     oid_to_hex(&cur_oid));
+
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos=
);
+			if (i !=3D fanout_value)
+				graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D =
%u !=3D %u",
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+	}
+
+	while (cur_fanout_pos < 256) {
+		uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos)=
;
+
+		if (g->num_commits !=3D fanout_value)
+			graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D %=
u !=3D %u",
+				     cur_fanout_pos, fanout_value, i);
+
+		cur_fanout_pos++;
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c03792a8ed..4809cc881f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
=20
+HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
 GRAPH_BYTE_CHUNK_COUNT=3D6
@@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFS=
ET + \
 			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
 GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
 			     2 * $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_FANOUT_OFFSET=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+		       $GRAPH_CHUNK_LOOKUP_WIDTH * $GRAPH_CHUNK_LOOKUP_ROWS))
+GRAPH_BYTE_FANOUT1=3D$(($GRAPH_FANOUT_OFFSET + 4 * 4))
+GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 * 255))
+GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 * 256))
+GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8)=
)
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chunk'=
 '
 		"missing the Commit Data chunk"
 '
=20
+test_expect_success 'detect incorrect fanout' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect fanout final value' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect OID order' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
+		"incorrect OID order"
+'
+
 test_done
--=20
2.18.0.rc1

