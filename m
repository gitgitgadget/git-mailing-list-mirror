Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ED81F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeGTRWm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:42 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387858AbeGTRWl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs1na3Tx3BhXAATduwYyajXqhpYSwJpAtKmf9NeI1KY=;
 b=CGXwMqxKK7z5EQtJWX92LjpE5H9dQ4m/EjhoNDUN2ap+1ZfhOFF488ARlTqogX3JIed2SzjJA107cvTdDjwxFfCDMqnaR6874KpxosdNpjxzH4V29TLkGpZRedIhBBo5skN5Nlyywz+WLodM4dEdA7zPDM4eBPgyFQDAejxRMOo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:27 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:27 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 16/18] commit-reach: replace ref_newer logic
Thread-Topic: [PATCH v2 16/18] commit-reach: replace ref_newer logic
Thread-Index: AQHUIEdi7Tj8XIb3AUqvLBnYrub49w==
Date:   Fri, 20 Jul 2018 16:33:27 +0000
Message-ID: <20180720163227.105950-17-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:TN+RrXdlPbbwUhslVPeGXcRJH51OddaPfvY6aWMr/TBOYCKG3oMYu2XFXuGm8NF5MI3pZtI5Z+yYNidu/Ll2yn5Y/mkkz8+S96TFC11ilqrvU4MSdwAAsb7cZBv/WdU5CInMRNJ8fKE9q861cTvbTwI2g+A7pYiTxxIhPyOpWK2KwFaFcLMIkm6c+GVnlWwBqMj+Aw5MjdMeUDkxp49kt1MPdwr1J/AWERlI8xNsJ4SWSnj6LjTprJaWrZZvqntJMEZZLZnnP+8O4Z8wptE0HvjjXEKVbYjd3kdE698aQqgkGLX3+tdTnhgC2e0k7YZbtujifQ/RArirLSwmSnENRATsKNYlYujPTq0JzJoRcw8Pw9RLl0+QBDAHWLG/kBP3243jFzHKk4nE7Qlg0xz7s7okkXvSsBANg0G+hcQaQniLc2LfwVKzKKSH2akHGgqRKu7DR2taHtqK3tWtiX4cdQ==;5:40Yqcl2XXRaSiRnyAzkakSWJZSg5boNKS7MfqnzyQfbaurjbFupqDJn96S6IMGhj7a/bEp2c0/3niaEohAu4wYzarWjGN1Kax3xI/HWWU9I95X1BA8mnX+l4c8htYZ732hLxntECZ5ws3pga8n84DreuuZse8ju8Kys4EU3ago0=;7:75sst2+A7XAvpEHC2Dl7u71flO6XezZG9tmDxRjbGfp12V6UaTTOCyzUcwael0y4yIwWP0S8ttflpvQE0K891kawmL5bc50he57TWHn07ud1LczzjjcNFGMe5DapeL5qcleTCHRdlwzT3IDF7lmdkOx4d4UOg52JNC52QsdebwR9PLMsBZQ7VrhX1DroTmyu77Od69R60GZH0kE11YcM9Sm4ihaQLV1q7EjJagEdBfJCW2zH4Kn1KO4RWEBDrntO
x-ms-office365-filtering-correlation-id: bcf22e10-1c6f-4c25-a142-08d5ee5e84f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929D83100925EFCA7CC9DEDA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nAFsFnbd9W0jzl5DQCY/UVmoaFoG9/5KoMzzTXsbzRAC1KdhY10fPh0W1/XGCrtqvobLAaMpN1wR3R6D5wbd6t4VsW28xe5y7yt5vrkuNl+ZhBD44xt2sng2zhq1fTxW6bq5vjiH+S0/xxK5ngSiIbxHFzekBvt3IZcrtD/yHYoiHvByM88h7R05DWMxSIZhP0lZ72CBFyWhT/eR9KkipyKq3s2OddcJRudq7vy/MVaPdkyiGubsRR7JG1bqJPVcPeZ0K5gd4r22sFpaCZe/9kzEJOkFeMO/GlPRnPi7w7iRa2e3EieHMIi8uYMulxTOr/z5sBNFUWQATMkOz/JI6zfOZ+nRFoL2hCnLlHNkBb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf22e10-1c6f-4c25-a142-08d5ee5e84f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:27.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_newer method is used by 'git push' to check if a force-push is
required. This method does not use any kind of cutoff when walking, so
in the case of a force-push will walk all reachable commits.

The is_descendant_of method already uses paint_down_to_common along with
cutoffs. By translating the ref_newer arguments into the commit and
commit_list required by is_descendant_of, we can have one fewer commit
walk and also improve our performance!

For a copy of the Linux repository, 'test-tool reach ref_newer' presents
the following improvements with the specified input. In the case that
ref_newer returns 1, there is no improvement. The improvement is in the
second case where ref_newer returns 0.

Input:
A:v4.9
B:v3.19

Before: 0.09 s
 After: 0.09 s

To test the negative case, add a new commit with parent v3.19,
regenerate the commit-graph, and then run with B pointing at that
commit.

Before: 0.43 s
 After: 0.09 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 940fbf2e17..f5858944fd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -366,20 +366,11 @@ void reduce_heads_replace(struct commit_list **heads)
 	*heads =3D result;
 }
=20
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit *commit =3D pop_commit(&list);
-		commit->object.flags &=3D ~mark;
-	}
-}
-
 int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid)
 {
 	struct object *o;
 	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
-	int found =3D 0;
+	struct commit_list *old_commit_list =3D NULL;
=20
 	/*
 	 * Both new_commit and old_commit must be commit-ish and new_commit is de=
scendant of
@@ -400,19 +391,8 @@ int ref_newer(const struct object_id *new_oid, const s=
truct object_id *old_oid)
 	if (parse_commit(new_commit) < 0)
 		return 0;
=20
-	used =3D list =3D NULL;
-	commit_list_insert(new_commit, &list);
-	while (list) {
-		new_commit =3D pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new_commit, &used);
-		if (new_commit =3D=3D old_commit) {
-			found =3D 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
+	commit_list_insert(old_commit, &old_commit_list);
+	return is_descendant_of(new_commit, old_commit_list);
 }
=20
 /*
--=20
2.18.0.118.gd4f65b8d14

