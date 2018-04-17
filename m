Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE421F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeDQRAg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:36 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:1472
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752952AbeDQRAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tnYkm26L4wBJ0hoSgSq7NdU2K2DPtAS8kcdvxvn2S/g=;
 b=doN6G8IV+TmasIxUoGpIb9tXXCqvULIj2Ocdz5vCqAzaT+G1vWLp1ky6OWkBbNwG2DyhAEkKnGxaKRrmxtOYIVLUp0O+UiJ8lR2V9tpGE6HplhLQgB804xBGxyu4XXk//IFT7XdEcersgLgJGmny4oxyMMHjRoV3SR73YLKi4VQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:30 +0000
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
Subject: [PATCH v3 6/9] commit: use generation numbers for in_merge_bases()
Thread-Topic: [PATCH v3 6/9] commit: use generation numbers for
 in_merge_bases()
Thread-Index: AQHT1m2XC8Aq4oNTmEKdtuaR4BO4YA==
Date:   Tue, 17 Apr 2018 17:00:30 +0000
Message-ID: <20180417170001.138464-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:05g5/gD4amu+qr/BHML8j2thc2u3wIvphL6XOLWbluxwtkDMAALbU75/nkjub1S38rW/+8BEqPnoW18fXriWOwX6B7wCSnaKTUZkgfP/GbIwV2rjwm1oH0BlyS4UwTGep3B7+yYFMCSl72Or9wUTMWBgoREZnpp8fhiVwx0AGj+ww07FbQjzZVRCcJjd5R3z7rIJcWfOZQEQumBkc7uxP+nML12VwiX2V6YRRFRk62Yx/A6TPiH7TY0UCkehoI23;20:8p/hjxtfk4lx0e4mF3gljlxext3jr6wYaHPBVl03hZvbkG+WLYMET59IDVszeO0TM3/rqTwmwbkTYZSEjOJvDjC11HzNlILTPYjpbphiCxCvqOY2zeqXjVSX3hg2BnMmqGihr/o9NxXsXyf0UIFR+p2rgl5/uDebot7xGcVi/Xc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10749BB72FA85B09348246BAA1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(59450400001)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OFbJe/qR4/Ud1pLUGEw1F7PEcQ8Cl1zYaItAZCxx/g/VaE4+i/USOu+P0UwbO25IJo8MPQSXp7UIrPfCWtByomMtjejqCzn6YQ19xTInNFSMdFYC7iUNufXNkbqgvM5ZGKfIKn2vgbKdLNUuf6FO2J99FCB5DiCSfKDhZwxPOOFa3Oi58bBRJkwlygFRUZFe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1cba81bc-3d33-437f-514c-08d5a484b978
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cba81bc-3d33-437f-514c-08d5a484b978
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:30.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The containment algorithm for 'git branch --contains' is different
from that for 'git tag --contains' in that it uses is_descendant_of()
instead of contains_tag_algo(). The expensive portion of the branch
algorithm is computing merge bases.

When a commit-graph file exists with generation numbers computed,
we can avoid this merge-base calculation when the target commit has
a larger generation number than the target commits.

Performance tests were run on a copy of the Linux repository where
HEAD is contained in v4.13 but no earlier tag. Also, all tags were
copied to branches and 'git branch --contains' was tested:

Before: 60.0s
After:   0.4s
Rel %: -99.3%

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index a44899c733..bceb79c419 100644
--- a/commit.c
+++ b/commit.c
@@ -1053,12 +1053,19 @@ int in_merge_bases_many(struct commit *commit, int =
nr_reference, struct commit *
 {
 	struct commit_list *bases;
 	int ret =3D 0, i;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 	if (parse_commit(commit))
 		return ret;
-	for (i =3D 0; i < nr_reference; i++)
+	for (i =3D 0; i < nr_reference; i++) {
 		if (parse_commit(reference[i]))
 			return ret;
+		if (min_generation > reference[i]->generation)
+			min_generation =3D reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return 0;
=20
 	bases =3D paint_down_to_common(commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
--=20
2.17.0.39.g685157f7fb

