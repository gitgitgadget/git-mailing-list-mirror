Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B19F1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeDQRAc (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:32 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:60686
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752952AbeDQRAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1xZf30oOib2SeUOePZ46ZAbz8GsXnV84KaeqO1LckSk=;
 b=Wn6NaA5jTUOXHl/4/uFTCQJovTS8lkpiBzitit2Z7HaignvPtV3eRa3T8/tcOLGUE+KPsoWnbGaYR9PF5PWQKyexV2gz9vsBNgmttXp/LcZ+u0nowrA6zyIK5WCaZIBPnNfLy7kyc4REu+aA/vL6PCV5GoUzZo3dnO9THQL5Shs=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:21 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 2/9] commit-graph: compute generation numbers
Thread-Topic: [PATCH v3 2/9] commit-graph: compute generation numbers
Thread-Index: AQHT1m2QNezXwDjbC0uYTtPe2+uQxQ==
Date:   Tue, 17 Apr 2018 17:00:18 +0000
Message-ID: <20180417170001.138464-3-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:eAPB8+ojTnGuatKtdulxRjyrtvt+gXKv3BbTY9rRhDPZcKIIXC+vj4oLkhr2HDRSMAjEMaj8oKb6wpD4L78mXFBAm4KfPSsIMW96Km806wJtQg5MWtGIx0+YxDDWkiTxCk8Geyd9CHmBxN/OF+Y3OvRR7otkWKCN63biJ/D7ajYxtyigVoe3rhlBfiDFfT7+7XWomTtuiDryNMTDNCA1Z6APLKmFGQzrMVeoTE+ZK9gT+GL0ryAecKrvbhQaQRWK;20:U9cGF+rU3RLEUKB/605iYD1gndLRjMZ0pm1Xciw4utZjWFtQzSKHGtIkCFC9lznhIjKi38mmPfvwRJ95QAXvlq+GGPkx+lDHDFOq4YFSLV1Wuvmlo2fwEOg0V4LbMGS1aYghavQ9trePu/zQ23bXVNWJux9J+BI46WaIFSD/pa0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1074FEC6BB97BF2161C96EA1A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(59450400001)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(6666003)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: etzgi3uhafFa8nR4zxM/gTK3QkPAN/fZuT05iFq6T48N5K5EoQyzWWqbxQ8iWoa37QhirLgg7ub779ZSZVF0IJuG6t2TUZ3RClKj/lxZVGRjK2TjW+Asu7B2fzB55SSrHAZZlV4wyqEzccYPMgBm/8jOFr9wsjb3O/FZhYVPjJDHbXBEOl/LHzOPKQ0qT055
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 185a842f-0dd6-47bc-349c-08d5a484b294
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185a842f-0dd6-47bc-349c-08d5a484b294
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:18.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits to be written into a commit-graph file, compute
the generation numbers using a depth-first strategy.

The only commits that are walked in this depth-first search are those
without a precomputed generation number. Thus, computation time will be
relative to the number of new commits to the commit-graph file.

If a computed generation number would exceed GENERATION_NUMBER_MAX, then
use GENERATION_NUMBER_MAX instead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 9ad21c3ffb..688d5b1801 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -439,6 +439,10 @@ static void write_graph_chunk_data(struct hashfile *f,=
 int hash_len,
 		else
 			packedDate[0] =3D 0;
=20
+		if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY) {
+			packedDate[0] |=3D htonl((*list)->generation << 2);
+		}
+
 		packedDate[1] =3D htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
=20
@@ -571,6 +575,46 @@ static void close_reachable(struct packed_oid_list *oi=
ds)
 	}
 }
=20
+static void compute_generation_numbers(struct commit** commits,
+				       int nr_commits)
+{
+	int i;
+	struct commit_list *list =3D NULL;
+
+	for (i =3D 0; i < nr_commits; i++) {
+		if (commits[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
+		    commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
+			continue;
+
+		commit_list_insert(commits[i], &list);
+		while (list) {
+			struct commit *current =3D list->item;
+			struct commit_list *parent;
+			int all_parents_computed =3D 1;
+			uint32_t max_generation =3D 0;
+
+			for (parent =3D current->parents; parent; parent =3D parent->next) {
+				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
+				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
+					all_parents_computed =3D 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				} else if (parent->item->generation > max_generation) {
+					max_generation =3D parent->item->generation;
+				}
+			}
+
+			if (all_parents_computed) {
+				current->generation =3D max_generation + 1;
+				pop_commit(&list);
+			}
+
+			if (current->generation > GENERATION_NUMBER_MAX)
+				current->generation =3D GENERATION_NUMBER_MAX;
+		}
+	}
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
@@ -694,6 +738,8 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >=3D GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
=20
+	compute_generation_numbers(commits.list, commits.nr);
+
 	graph_name =3D get_commit_graph_filename(obj_dir);
 	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
=20
--=20
2.17.0.39.g685157f7fb

