Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAE01F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeHTVny (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:43:54 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:43773
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbeHTVny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NizdcCaJeNnf2+OysCKQoV5l5qgHsxJM6wuRoYPSg2g=;
 b=o0YgoUc3zBLDy2msE3bP91ChXxNNinpW7mdUKAmOVXUJldT2Ncx5FHoRf+7xXL/GwXOO6RJtJJL7isYVgFpat0Xo3y6zyIiXnQLNLL7iuxABR41AbblerfYw3C2hwdfQBNwUB4lmDWoAai3yf9rktK/CFr0zhKYv3Domcts0zys=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/8] refs.c: migrate internal ref iteration to pass thru
 repository argument
Thread-Topic: [PATCH v2 1/8] refs.c: migrate internal ref iteration to pass
 thru repository argument
Thread-Index: AQHUOLMAS0ncA1sA4k2+ErLtgZeiyA==
Date:   Mon, 20 Aug 2018 18:24:16 +0000
Message-ID: <20180820182359.165929-2-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:2vqoChTbpuY4NPXNzXisWE8eBs6woFigBVZ/yom1FODQV9xq39k2CE63pOKjziXGdCrlGtpLu/e0BoSv5OOFQsM60FIUuTmRgpZmvXRvjxhGzzIZR7emjmRm4X8+sH1Ox964Km7Qg/QD7paRb1VSmU5ekVF0M6u2RVq6UpzFQv2bbpBsGh32ks4YP3ZXiH5Vf3FvNXC35xgg0xeihggfXHLdgHjR7Vot3EKhcL36QiofSizcrWTeme8aYbkpJge7kxq1bEHp2KqOEf0aZfknW6StrzODINeOL2Y8HVUvHyzI1EHOBPMioOnbbBXj6lzF9ePymuqVN8TOu/kq5c6bO06tP2ioloM+DqfgSBRsdVaTU9GplH2lQ7/+WPVPKnRCPE6vQEWtBYzfM4EojZQOlk/pdr/XDjrPLE7KyDQcnJGG61yM6OqR/qOHurgZKqPNJ5gbYAGfMmxm7gYYfZI7Hw==;5:dQsKl3XSLacxArmdknN4GmMZhwTnuvmwD5iDUR34AU/wJgAF0pTtSpss1RxrKkzY/IpxcwVuOMIhgSFLOGBxYvDTwiGdl56M19W05U2uFuIDE/MdakJwdgJka79wgS9i9ZEA3m5C9IwJvnX1Z/T1/qt6oRsrESj0PBno8POk1K0=;7:8BgwWmYnWhJGjmczMHpmnw9/zw1sYtRn4lxSbi5WPhH7sMxctChnTQYJeTNiy+mTpLZyRHeWnYYA9c+BSakPL/17WQ3rlBCIQEuZyqLkvKtGt73XVVZh9T55U3QnKUFmtKqclMbYa59kDONpzb/VubxJ0iDMXQy+bST+xlxNBNJXbjPn9mrEummerG8/Q4mzp/UweEY8X9oH7Imry8vmhKvrPYVauyAIKnS5nyVOTC/BFv+CdUDg2hqhmB+V/Zgc
x-ms-office365-filtering-correlation-id: 662e3508-4ac5-4dd1-fd7a-08d606ca2329
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09958314EFE80096DC95F948A1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(6486002)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(551934003)(6512007)(2900100001)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(14444005)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6G2zweehFgJP3Kme4rdim4DnvW9O0Zrl0rxkt1z8EhKLkdrje9HyX5HGImvzTZF84S3BKF0YDL5LtoO1Xc31B9MGCIRNTM9iiLkq+tCokor5g6c7vjkpvExiJiSfrAkUiPC5gJhSPoCs6vKmWbZEEMTu8i+0smEuFw8y/Vd89PzBpxwhTdSiPaWHH957DI3AJRtmbUY2QHXpwgPmDGR8htixPtGSMtF4q6aIlPdPEhNzmoPYGFd5x620tpD4uTPyrh6W3IG0jCyJdV8b5UGT7wpOfwar3HUYg9czCblTDsaigbk+Kc1egzwgruceMSu6KgSnI6cwuc3lRk5LXWIsdhQPiHk0eVpTLHGGGOavz5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662e3508-4ac5-4dd1-fd7a-08d606ca2329
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:16.7592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

In 60ce76d3581 (refs: add repository argument to for_each_replace_ref,
2018-04-11) and 0d296c57aec (refs: allow for_each_replace_ref to handle
arbitrary repositories, 2018-04-11), for_each_replace_ref learned how
to iterate over refs by a given arbitrary repository.
New attempts in the object store conversion have shown that it is useful
to have the repository handle available that the refs iteration is
currently iterating over.

To achieve this goal we will need to add a repository argument to
each_ref_fn in refs.h. However as many callers rely on the signature
such a patch would be too large.

So convert the internals of the ref subsystem first to pass through a
repository argument without exposing the change to the user. Assume
the_repository for the passed through repository, although it is not
used anywhere yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++++--
 refs.h               | 10 ++++++++++
 refs/iterator.c      |  6 +++---
 refs/refs-internal.h |  5 +++--
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 457fb78057..7cd76f72d2 100644
--- a/refs.c
+++ b/refs.c
@@ -1386,17 +1386,50 @@ struct ref_iterator *refs_ref_iterator_begin(
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
+static int do_for_each_repo_ref(struct repository *r, const char *prefix,
+				each_repo_ref_fn fn, int trim, int flags,
+				void *cb_data)
+{
+	struct ref_iterator *iter;
+	struct ref_store *refs =3D get_main_ref_store(r);
+
+	if (!refs)
+		return 0;
+
+	iter =3D refs_ref_iterator_begin(refs, prefix, trim, flags);
+
+	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
+}
+
+struct do_for_each_ref_help {
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int do_for_each_ref_helper(struct repository *r,
+				  const char *refname,
+				  const struct object_id *oid,
+				  int flags,
+				  void *cb_data)
+{
+	struct do_for_each_ref_help *hp =3D cb_data;
+
+	return hp->fn(refname, oid, flags, hp->cb_data);
+}
+
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp =3D { fn, cb_data };
=20
 	if (!refs)
 		return 0;
=20
 	iter =3D refs_ref_iterator_begin(refs, prefix, trim, flags);
=20
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					do_for_each_ref_helper, &hp);
 }
=20
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_dat=
a)
@@ -2025,10 +2058,12 @@ int refs_verify_refname_available(struct ref_store =
*refs,
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_=
data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp =3D { fn, cb_data };
=20
 	iter =3D refs->be->reflog_iterator_begin(refs);
=20
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					     do_for_each_ref_helper, &hp);
 }
=20
 int for_each_reflog(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index cc2fb4c68c..80eec8bbc6 100644
--- a/refs.h
+++ b/refs.h
@@ -274,6 +274,16 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
=20
+/*
+ * The same as each_ref_fn, but also with a repository argument that
+ * contains the repository associated with the callback.
+ */
+typedef int each_repo_ref_fn(struct repository *r,
+			     const char *refname,
+			     const struct object_id *oid,
+			     int flags,
+			     void *cb_data);
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
diff --git a/refs/iterator.c b/refs/iterator.c
index 2ac91ac340..629e00a122 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -407,15 +407,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct=
 ref_iterator *iter0,
=20
 struct ref_iterator *current_ref_iter =3D NULL;
=20
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data)
+int do_for_each_repo_ref_iterator(struct repository *r, struct ref_iterato=
r *iter,
+				  each_repo_ref_fn fn, void *cb_data)
 {
 	int retval =3D 0, ok;
 	struct ref_iterator *old_ref_iter =3D current_ref_iter;
=20
 	current_ref_iter =3D iter;
 	while ((ok =3D ref_iterator_advance(iter)) =3D=3D ITER_OK) {
-		retval =3D fn(iter->refname, iter->oid, iter->flags, cb_data);
+		retval =3D fn(r, iter->refname, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 04425d6d1e..89d7dd49cd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -474,8 +474,9 @@ extern struct ref_iterator *current_ref_iter;
  * adapter between the callback style of reference iteration and the
  * iterator style.
  */
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
+int do_for_each_repo_ref_iterator(struct repository *r,
+				  struct ref_iterator *iter,
+				  each_repo_ref_fn fn, void *cb_data);
=20
 /*
  * Only include per-worktree refs in a do_for_each_ref*() iteration.
--=20
2.18.0.118.gd4f65b8d14

