Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F831F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeFHN4c (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:32 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752478AbeFHN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rggUxrTRvH6zSRgu0a6nzPz3DNNTqMz+6UtsaJEKe5w=;
 b=Duf+rOvj3OWMDpfd6lBBI2tE2vOCQ/loXxB2SWRiu8U7cPiLkACa7uz1JvWPLVDSN02pB7MRTKhsXrtZrPVmdmrVWsvd+IH5oa/DPtcXUcdTdmAfoaYDToe3RKF9qqCWZIf5aauRqdIZzRIXEDAca7rPjnETcKx3vHKdO8yAmsI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:23 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:23 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 12/21] commit-graph: verify parent list
Thread-Topic: [PATCH v6 12/21] commit-graph: verify parent list
Thread-Index: AQHT/zB7lVaC1tpjKECMudcWpe9O4g==
Date:   Fri, 8 Jun 2018 13:56:22 +0000
Message-ID: <20180608135548.216405-13-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:6QvqH3jFt6uBZnNQkcheMSZS83BR174+M7+oLFM56C3i0q57x342TTlJayuKk86fBNPKTDIu+2Udp9kablxhUHY4+ZzLT0kLePe5R4Lo+0aRCF7Hf9bFVXKJWcvk6J0Dd8ZApzfo/cuPMJl/ld3pXaZtMpfivzSY0/yuTjGdk4PLU1WIfXQ8oXbeHddydI0Vlo/39M8AnWBBY0zrVsOBXCxJpFMqSVQj8WEjqgSEOaVVaksMJI7KEAlPdTUH6NjI
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0963C6227D3B0EFE1B830377A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(15650500001)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MyVGD2wkU5h1BF2iz7sWZPF16oHyS1dzjPWCWVDt+/0wtX0JDKzCu51wFaQMjed6pCqYGhMmpLapYR3m66HaNcDpmGeE3PuyLCXhnfQVMDemuLqsRWnzGaXhufRBGxiW2+6VraJNwiarodzI/3+r/VY/A1+7Lj2ZEmH/EuwChJYoKP2EtW8tP0XtEwg/E7n5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 499dc665-f059-4ca8-d72c-08d5cd479e4a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499dc665-f059-4ca8-d72c-08d5cd479e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:22.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file stores parents in a two-column portion of the
commit data chunk. If there is only one parent, then the second column
stores 0xFFFFFFFF to indicate no second parent.

The 'verify' subcommand checks the parent list for the commit loaded
from the commit-graph and the one parsed from the object database. Test
these checks for corrupt parents, too many parents, and wrong parents.

Add a boundary check to insert_parent_or_die() for when the parent
position value is out of range.

The octopus merge will be tested in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 28 ++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5df18394f9..6d8d774eb0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -244,6 +244,9 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 	struct commit *c;
 	struct object_id oid;
=20
+	if (pos >=3D g->num_commits)
+		die("invalid parent position %"PRIu64, pos);
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -907,6 +910,7 @@ int verify_commit_graph(struct repository *r, struct co=
mmit_graph *g)
=20
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -924,6 +928,30 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     oid_to_hex(get_commit_tree_oid(graph_commit)),
 				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		graph_parents =3D graph_commit->parents;
+		odb_parents =3D odb_commit->parents;
+
+		while (graph_parents) {
+			if (odb_parents =3D=3D NULL) {
+				graph_report("commit-graph parent list for commit %s is too long",
+					     oid_to_hex(&cur_oid));
+				break;
+			}
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object=
.oid))
+				graph_report("commit-graph parent for %s is %s !=3D %s",
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents =3D graph_parents->next;
+			odb_parents =3D odb_parents->next;
+		}
+
+		if (odb_parents !=3D NULL)
+			graph_report("commit-graph parent list for commit %s terminates early",
+				     oid_to_hex(&cur_oid));
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2b9214bc83..9a3481c30f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFS=
ET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * =
4 + 10))
 GRAPH_COMMIT_DATA_OFFSET=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_=
COMMITS))
 GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
+GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
+GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
+GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -348,4 +351,19 @@ test_expect_success 'detect incorrect tree OID' '
 		"root tree OID for commit"
 '
=20
+test_expect_success 'detect incorrect parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_PARENT "\01" \
+		"invalid parent"
+'
+
+test_expect_success 'detect extra parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_EXTRA_PARENT "\00" \
+		"is too long"
+'
+
+test_expect_success 'detect wrong parent' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
+		"commit-graph parent for"
+'
+
 test_done
--=20
2.18.0.rc1

