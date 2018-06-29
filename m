Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C2B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966915AbeF2QNI (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:08 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:50703
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966880AbeF2QNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3g2kZIne9TCAahTS731YSEBFBNICVMKbfawjiBujME=;
 b=C0WSuYfkgT8Mynp6V2cNnTLuijKv6SAQpfcZ2miXO5yy4zMCldrPxIf4DLdqnCY+9Li9/zEevrOEUYZxIJSfECYGPmyOrY7RC3oSer280TWdf31NktCH7bavWipGpJMpYdeH3ftAqmpAl8d1zfsYYO+KKN8OvEMpQ/alMCwmPm8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:13:02 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:13:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 12/13] commit-reach: use is_descendant_of for ref_newer
Thread-Topic: [RFC PATCH 12/13] commit-reach: use is_descendant_of for
 ref_newer
Thread-Index: AQHUD8QNbiVtT1uO9kiIpmR8bxhrhA==
Date:   Fri, 29 Jun 2018 16:13:01 +0000
Message-ID: <20180629161223.229661-13-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:8Zt3l7rnZXk5zV7fWvio1AB6/ii7NhnSAU+WTaehXbFP4GdWPiTbfCnOdN33uyDrRQfc3p+0D+VD0F+9/VOpP1wsMgaBbmjTTkjQya8Tzio4XN6mTt0TlJeTwGojgEbXaj4DQV4dH3XtP6xTWuMGV/r+ZMi6rTFYXUTRNK+X2WD3XxlCoUSAP9ZoCI0LeLRROregyPpf5o5pgHkewN+qeeSUYuPPIor8yoG+fXl14ek+wZEhzZyqUT1z9AXWBRkL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e4b0de7-e1ed-4723-2654-08d5dddb3007
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044CA404FDB473E5CB797E0A14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(14444005)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(575784001)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: TrnHObBB1RZz6bFvdkMuI+thAqhurQfI12KoHQezQxlmiYEWcm5YuyTPpI5D9B/y9Cplpnr/FaVvD2eyul8P3RWuKMz2kRemhGaFyddv+pdLP8o0YIwg9nno7j8Z5js6BHVkLqx6snxVjrGfnfSXLuigRMTkx52GLpFj15GbVTV8Vpbe3xWon4SAirAi4TtiozWOKxJFQKV8OnC+xlPZcK2l/ARu+wyo/QfUkukL98jP99b87ACrAtXqDjCM7+euI751Yu6NvzZRzZsbRpAmwDMgK+fwPFhAS9D3mJrTTqgGi+nn4pHWe0EsMH6gtJ5xYADxTm1az+aLK2iZSD799wn/aU+F8HeXVlncarQb+G4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4b0de7-e1ed-4723-2654-08d5dddb3007
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:13:01.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_newer method is used by 'git push' to detect if a force-push is
requried. This method does not use any kind of cutoff when walking, so
in the case of a force-push will walk all reachable commits.

The is_descendant_of method already uses paint_down_to_common along with
cutoffs. By translating the ref_newer arguments into the commit and
commit_list required by is_descendant_of, we can have one fewer commit
walk and also improve our performance!

For a copy of the Linux repository, 'test-tool reach ref_newer' presents
the following improvements with the specified input.

Input
-----
A:v4.9
B:v3.19

Before: 0.11 s
 After: 0.10 s

To test the negative case, add a new commit with parent v3.19,
regenerate the commit-graph, and then run with B pointing at that
commit.

Before: 0.52 s
 After: 0.12 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 17 ++++-------------
 commit.c       |  7 +++++--
 commit.h       |  6 +++++-
 fetch-pack.c   |  3 ++-
 sha1-name.c    |  3 ++-
 walker.c       |  3 ++-
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 8e24455d9f..249e9a4fac 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -376,7 +376,7 @@ int ref_newer(const struct object_id *new_oid, const st=
ruct object_id *old_oid)
 {
 	struct object *o;
 	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
+	struct commit_list *list =3D NULL;
 	int found =3D 0;
=20
 	/*
@@ -396,18 +396,9 @@ int ref_newer(const struct object_id *new_oid, const s=
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
+	commit_list_insert(old_commit, &list);
+	found =3D is_descendant_of(new_commit, list);
+	free_commit_list(list);
 	return found;
 }
=20
diff --git a/commit.c b/commit.c
index d4ddaf4879..9870682673 100644
--- a/commit.c
+++ b/commit.c
@@ -556,7 +556,8 @@ void commit_list_sort_by_date(struct commit_list **list=
)
 }
=20
 struct commit *pop_most_recent_commit(struct commit_list **list,
-				      unsigned int mark)
+				      unsigned int mark,
+				      uint32_t min_generation)
 {
 	struct commit *ret =3D pop_commit(list);
 	struct commit_list *parents =3D ret->parents;
@@ -565,7 +566,9 @@ struct commit *pop_most_recent_commit(struct commit_lis=
t **list,
 		struct commit *commit =3D parents->item;
 		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |=3D mark;
-			commit_list_insert_by_date(commit, list);
+
+			if (commit->generation >=3D min_generation)
+				commit_list_insert_by_date(commit, list);
 		}
 		parents =3D parents->next;
 	}
diff --git a/commit.h b/commit.h
index 7e0f273720..5eaeded5e2 100644
--- a/commit.h
+++ b/commit.h
@@ -159,9 +159,13 @@ extern const char *skip_blank_lines(const char *msg);
=20
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
+ *
+ * The parents are not added if their generation number is strictly
+ * lower than min_generation.
  **/
 struct commit *pop_most_recent_commit(struct commit_list **list,
-				      unsigned int mark);
+				      unsigned int mark,
+				      uint32_t min_generation);
=20
 struct commit *pop_commit(struct commit_list **stack);
=20
diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce9872..351e3d4bcd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -600,7 +600,8 @@ static void mark_recent_complete_commits(struct fetch_p=
ack_args *args,
 	while (complete && cutoff <=3D complete->item->date) {
 		print_verbose(args, _("Marking %s as complete"),
 			      oid_to_hex(&complete->item->object.oid));
-		pop_most_recent_commit(&complete, COMPLETE);
+		pop_most_recent_commit(&complete, COMPLETE,
+				       GENERATION_NUMBER_ZERO);
 	}
 }
=20
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..471a54464d 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1141,7 +1141,8 @@ static int get_oid_oneline(const char *prefix, struct=
 object_id *oid,
 		struct commit *commit;
 		int matches;
=20
-		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
+		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN,
+						GENERATION_NUMBER_ZERO);
 		if (!parse_object(&commit->object.oid))
 			continue;
 		buf =3D get_commit_buffer(commit, NULL);
diff --git a/walker.c b/walker.c
index 0b162a09b9..e243fc8768 100644
--- a/walker.c
+++ b/walker.c
@@ -78,7 +78,8 @@ static int process_commit(struct walker *walker, struct c=
ommit *commit)
 		return -1;
=20
 	while (complete && complete->item->date >=3D commit->date) {
-		pop_most_recent_commit(&complete, COMPLETE);
+		pop_most_recent_commit(&complete, COMPLETE,
+				       GENERATION_NUMBER_ZERO);
 	}
=20
 	if (commit->object.flags & COMPLETE)
--=20
2.18.0.118.gd4f65b8d14

