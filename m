Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60B21F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDQRA2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:28 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:24896
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753800AbeDQRAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AgQvT0/vLTYqKa5/gVQKspTYRuLuYTfJXXk6nk7xuCA=;
 b=b37o1UwG3mBF2IJZZy0uquxLH8sj4s9ga0zk9z2SvNdowkc5mCdt6/Y4n9j1rCBUwKW3ofy5uG5sZOWukXTnQiHgYFW6zvq57sAKhjXl7n64WHQ5PZbssdlIKA91MSNLuMq2gb31i7CGFh5SeJT7qcRuZydebm0NQdScRVgkRcE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1073.namprd21.prod.outlook.com (52.132.24.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:22 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:22 +0000
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
Subject: [PATCH v3 3/9] commit: use generations in paint_down_to_common()
Thread-Topic: [PATCH v3 3/9] commit: use generations in paint_down_to_common()
Thread-Index: AQHT1m2SutNzcG1/eUuwVm6Zh+oZMw==
Date:   Tue, 17 Apr 2018 17:00:21 +0000
Message-ID: <20180417170001.138464-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1073;7:8LO4Bs7S73xK1ZhpsFCJmVkjAcn/GzOboDn6skpwr3HLEQBXsLocZRgXYFJwvyvL3wlgkkMeYZ6X+GPfrh10W3lpIiEBBmRW0fX5QsY9hMGChxbcCysz1LLJW0W+Us9oFaLGsK1hz8fRFchQxRHQ8W/LVlaTm2PKCkL4MolUOGDiolqGDODZIOmtDfE9xQIAt/+e6Bij6CH4f0LM9V9vpTHd8eRW4iv8PTBhlU5QpFB3yKA8N+lefqbPnUv3WHJs;20:B0FwPyNTBqSV140nMHqPYJ8vXv0xwvDQBYU+cKY9Q9ASiN3QdAGoS9PvoJLgDVWsOWSkGN6hbXaEg3ydqB3nQymUlW3jJkEFfMEMNpmGUKdhpZOqAZ4nXyo3uubMFsKRHDBGQmpR36xiBLXFBEIZOgIqgFbYoeJrsf4q8Bgzmvo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1073;
x-ms-traffictypediagnostic: BL0PR2101MB1073:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10734DB479840B200880746EA1B70@BL0PR2101MB1073.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1073;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(189003)(199004)(6436002)(5640700003)(6916009)(54906003)(8676002)(8656006)(5660300001)(36756003)(81156014)(99286004)(81166006)(2501003)(5250100002)(1730700003)(2351001)(3280700002)(316002)(97736004)(86362001)(2616005)(2900100001)(1076002)(86612001)(478600001)(446003)(486006)(476003)(10290500003)(2906002)(25786009)(11346002)(46003)(6116002)(22452003)(107886003)(39060400002)(386003)(6506007)(4326008)(186003)(68736007)(76176011)(6512007)(52116002)(105586002)(10090500001)(6486002)(305945005)(106356001)(8936002)(59450400001)(102836004)(53936002)(3660700001)(7736002)(14454004)(7416002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1073;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FY4gKGR+AUQ5HD96cFtOx9ukNR4CED26I5ijlC/dubQ1/tkPnPgXytomXdcSfkIsS70q/W9wcvasq/gm/eONr/3RO1o5sHVkGK2V79AxjMlpnSS2V9sdCE4A4H5cAmUb3GWYrujV5pu1K379zIdY1CMVlEaowBH7giuj8YShjyHMbVkEzkds6qsVRrP5s+yP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9efce1eb-0bef-48f2-c6f5-08d5a484b484
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efce1eb-0bef-48f2-c6f5-08d5a484b484
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:21.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define compare_commits_by_gen_then_commit_date(), which uses generation
numbers as a primary comparison and commit date to break ties (or as a
comparison when both commits do not have computed generation numbers).

Since the commit-graph file is closed under reachability, we know that
all commits in the file have generation at most GENERATION_NUMBER_MAX
which is less than GENERATION_NUMBER_INFINITY.

This change does not affect the number of commits that are walked during
the execution of paint_down_to_common(), only the order that those
commits are inspected. In the case that commit dates violate topological
order (i.e. a parent is "newer" than a child), the previous code could
walk a commit twice: if a commit is reached with the PARENT1 bit, but
later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
propagated to its parents. Using generation numbers avoids this extra
effort, even if it is somewhat rare.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 20 +++++++++++++++++++-
 commit.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 711f674c18..a44899c733 100644
--- a/commit.c
+++ b/commit.c
@@ -640,6 +640,24 @@ static int compare_commits_by_author_date(const void *=
a_, const void *b_,
 	return 0;
 }
=20
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused)
+{
+	const struct commit *a =3D a_, *b =3D b_;
+
+	/* newer commits first */
+	if (a->generation < b->generation)
+		return 1;
+	else if (a->generation > b->generation)
+		return -1;
+
+	/* use date as a heuristic when generataions are equal */
+	if (a->date < b->date)
+		return 1;
+	else if (a->date > b->date)
+		return -1;
+	return 0;
+}
+
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *u=
nused)
 {
 	const struct commit *a =3D a_, *b =3D b_;
@@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
 /* all input commits in one and twos[] must have been parsed! */
 static struct commit_list *paint_down_to_common(struct commit *one, int n,=
 struct commit **twos)
 {
-	struct prio_queue queue =3D { compare_commits_by_commit_date };
+	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result =3D NULL;
 	int i;
=20
diff --git a/commit.h b/commit.h
index aac3b8c56f..64436ff44e 100644
--- a/commit.h
+++ b/commit.h
@@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
 extern int check_commit_signature(const struct commit *commit, struct sign=
ature_check *sigc);
=20
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *u=
nused);
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused);
=20
 LAST_ARG_MUST_BE_NULL
 extern int run_commit_hook(int editor_is_used, const char *index_file, con=
st char *name, ...);
--=20
2.17.0.39.g685157f7fb

