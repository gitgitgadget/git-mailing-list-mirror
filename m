Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB3B1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDQSLI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:11:08 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:60462
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752770AbeDQSKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CMwCCfa6evqewIc6lc16WMjGNUpTfLK7zjCp7ZVeVRo=;
 b=HYjYj5gs1zDWCZdmmAvyxajjJAUxFEXj+y7D7du6jt5+mfUSsMaxqhfOAOLGGWh9S3myLwo/81LpYT40yX9u1OLMI5Fy/lbs5ENk2+/ionocROAaGSOKdl5LWMYkogG4Wdkg5yUQ3UYKLM5UA5pxKSwTR7Xxa+ZHBVpUqz3rmZ4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:41 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:41 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 05/12] commit-graph: check fanout and lookup table
Thread-Topic: [RFC PATCH 05/12] commit-graph: check fanout and lookup table
Thread-Index: AQHT1ndldu6wEJy/T0epRsNWNa6Zog==
Date:   Tue, 17 Apr 2018 18:10:41 +0000
Message-ID: <20180417181028.198397-6-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:pdasGQVkgz6yRSN8sNK7bxyI6JY9bXomEyCctpGXxnxPHv3nAjpkLImobANUuGRZ6bY8CHx7FwMmhjZ1hKPn97sCvjHsuxWZDW8zTIyHfcgwdEy4a1OwgX0T3738PJyRQAMNX2UnVo1tNJqUB2Yd3Iqq9XtMYCAOOTpnadBkwhSUB4lftHbxJ5VsL4gzoN/jGS86Xs6WfmidmEOVc0URfPB7sbfhAjtSuVWIi5JAxemf65bwSqmdwv+9OE3sFhBF;20:BlhDzI1XQPicMecPpm2Quhy9Rcr7+DWbXjCwN9Qw3VppGhzlc6Xqv6o8uDnBv0qQ5JzjKkNePGx56uuJfsXU3n4xvP+vBnK2D59+eX9p2wzOvY8fwA7HABmj+4b6MTy8VdUE/2UObKrdvTH3WqYGVF8JPejR0sT17F02ad1vP2M=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0994B6F229F45A71B63E482BA1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(59450400001)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(575784001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RxutZqCmNL8L6nToQqeoRc1N/iwCEpptLGftfaHUnUxe1Fne2usZSKT6BmxOkJMNp9k7xpDeRtEDlvzn72+3YORf6E38Xzlvbt8ChprlRC7Sr4BN4fOxAgvYkFrm1A9g8DZLdWuPphiMHb0PF2YD1MvKoXA3GYgzCRSGZ+Eu2sGn0wimi5FLFOC4gUU5bMKm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0cef8a28-0df5-4365-7f71-08d5a48e878c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cef8a28-0df5-4365-7f71-08d5a48e878c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:41.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running 'git commit-graph check', verify that the object IDs
are listed in lexicographic order and that the fanout table correctly
navigates into that list of object IDs.

In anticipation of checking the commits in the commit-graph file
against the object database, parse the commits from that file in
advance. We perform this parse now to ensure the object cache contains
only commits from this commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6d0d303a7a..6e3c08cd5c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -835,6 +835,9 @@ static int check_commit_graph_error;
=20
 int check_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report(_("no commit-graph file loaded"));
 		return 1;
@@ -859,5 +862,36 @@ int check_commit_graph(struct commit_graph *g)
 	if (g->hash_len !=3D GRAPH_OID_LEN)
 		graph_report(_("commit-graph has incorrect hash length: %d"), g->hash_le=
n);
=20
+	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i > 0 && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report(_("commit-graph has incorrect oid order: %s then %s"),
+
+		oid_to_hex(&prev_oid),
+		oid_to_hex(&cur_oid));
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos=
);
+			if (i !=3D fanout_value)
+				graph_report(_("commit-graph has incorrect fanout value: fanout[%d] =
=3D %u !=3D %u"),
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+
+		graph_commit =3D lookup_commit(&cur_oid);
+
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report(_("failed to parse %s from commit-graph"), oid_to_hex(&cur=
_oid));
+
+		if (graph_commit->graph_pos !=3D i)
+			graph_report(_("graph_pos for commit %s is %u !=3D %u"), oid_to_hex(&cu=
r_oid),
+				     graph_commit->graph_pos, i);
+	}
+
 	return check_commit_graph_error;
 }
--=20
2.17.0.39.g685157f7fb

