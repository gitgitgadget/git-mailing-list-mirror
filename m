Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFFD1F7E4
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeFFLgh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:37 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751911AbeFFLgc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0JcheKDUJY2OBK7UvnipT6HoDrqjK+8OoO488NhxZo=;
 b=c6ClvmLhRuqWNZUzNj2NzhG4iOOnlbDjdaL/PIklLXMDDaAYCOdY0ca58YOjvTKu2clGhlpnrU1LVRHvR7hRv4JjfyS4RFhBAsBRGid10PrTFiKK9ta0JsLoYQe3d7yiXocz/xHC8o9rHRRpcPweGhRUoxuMebX9aLr3KlBduFE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 09/21] commit-graph: verify corrupt OID fanout and lookup
Thread-Topic: [PATCH v5 09/21] commit-graph: verify corrupt OID fanout and
 lookup
Thread-Index: AQHT/YqcOPFtbd4SI0aBTQ5CN1eFgw==
Date:   Wed, 6 Jun 2018 11:36:30 +0000
Message-ID: <20180606113611.87822-10-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
In-Reply-To: <20180606113611.87822-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:403:1::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:fA/zvlXPo+tNgAEhl/WpmYdWnvINHX4c/4Z2AYKVozFnEyNCmOoAk9s4nfqxKzvUGOqQ36GWJc2/T6fwpphP+JP7MNhx+ZB0HZZZ8BViBWzYjlWiztaPiCeJdAl6YJaTjT9tEn4p1r5YUXTIx41W2/en6+HaQwKtD6IISHjmbxdiK+OSVCU6QvV+W7MjI4Igjkc5mHkOR8mO4jJi2cDQe4wzoK9Cs6vd3CeCk4D4pQk59HQLHHbIh1Z8si2hpTxm
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB104428FCA5AF167E697A0F45A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MZaoUh45biM0++TtA9lS3pSOwkzVLR+6i7VU7A55npzElDsoFw3EvPRDOnxaeFkl0jEXeRxmuYFQ/k7KG07dl8z6NbjEFaLGoMkL4e11SXlS7oQ0Gx2v5qj+y44upYVZ2F+2u5tfber4F4nsTqS2mJ7CU6RpnR+SssbRdg7QsO8OYSbeu9tnj+HrMdUed/0a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 15fd49e4-7427-4030-7eb8-08d5cba1bf00
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fd49e4-7427-4030-7eb8-08d5cba1bf00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:30.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
index f41d5a0504..d7a5b50a6c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -843,6 +843,9 @@ static void graph_report(const char *fmt, ...)
=20
 int verify_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -857,5 +860,38 @@ int verify_commit_graph(struct commit_graph *g)
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
index 846396665e..c29eae47c9 100755
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
 			    1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
 GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
 			     2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_FANOUT_OFFSET=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+		       $GRAPH_CHUNK_LOOKUP_WIDTH \* $GRAPH_CHUNK_LOOKUP_ROWS))
+GRAPH_BYTE_FANOUT1=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 4))
+GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 255))
+GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 256))
+GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8=
))
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

