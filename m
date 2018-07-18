Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD64D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeGRVZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:25:00 -0400
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com ([104.47.32.112]:23886
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbeGRVY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGgBCWNecdblfGXCagTCCXUZfawPSq2tcoLosWT5CBE=;
 b=nder413iKi8zAXXPIWz0XXEyeu/gUYULB9GfN6JGxQ5EaHPrtv7gnVipqVFZwRpt0aXnHUxcCEEvwWzpmjBs1/5asVkJqClcNX8OqjptG4M2u1d0QKAKhvuoRMk0GL1CwCARdcVTeh9XPHCF7kipgJEjLldUMLeKhMBDHtdV3Fo=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0966.namprd21.prod.outlook.com (52.132.133.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Wed, 18 Jul 2018 20:45:17 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861%4]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 20:45:17 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 3/3] Add initial parallel version of unpack_trees()
Thread-Topic: [PATCH v1 3/3] Add initial parallel version of unpack_trees()
Thread-Index: AQHUHtg85Zh/whccg0WimNKQdGQvMA==
Date:   Wed, 18 Jul 2018 20:45:17 +0000
Message-ID: <20180718204458.20936-4-benpeart@microsoft.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
In-Reply-To: <20180718204458.20936-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:3:12b::18) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;6:wWlbfGok3hul1MJFoyaBQVGLiA6SXCmJgwxOUbqN+mNB6VdZJ+75pFRzdTEflv09wZylq+ANgZiSx8/YT80CucrCEsjfmbcY3dEqvQLZ17fGumEPiMvoqIe6gk3EmlyD87tuCINb5DXRle6wuDANU5Lt1uXi65PjrKuIUXLQ5wxl38zImpC00zBUCvT9EChvdbSSAx+gF7oy+AfsRQLcQWiwxm3OCyAGyou5X0PxZAXNf0KgRkOrQetPnPJLksk78QYgBhQiCG9VCmPDsKYJ6P9cgaSUO1h9GVhqB+SI9EPriJF2hHTuZ/FqO6hcjZCUOvIP6Li/7BhJdW82Wbn5uyHFQaeAmhRoUCVE0ou7TSZKT+A1lgj+/xkuLL2t4HRxbMqFZTxz+a5DeNweIF4xIfw1dIGh+20Byopi1DHb801vn6BsQ4FDC1eeKpXJfgcyQ+7+EHUb2cz6bFGXYDL4BA==;5:IvGQwD7v0+NIKUXogLrj4o/dXwX+gD2fXLadRnt+cxKCoV22rLHpUiZr5Aw2YqT6MH5KB6ixoOJcdGCIlTtiuxil8HKOURmbKsjGUps5FSaaeh9BKPaRqZaSSh8jh7MGLkZkDrH/+DCGtimxvJ1ybSHdMILjDS1Wrdr/enrqsf0=;7:Zc8gzkKOZae9usGjCRboQNmj3ISZmyOV3rOs0042RK27XkhP7Vn5OCvK3ZmVJ939BgqHzTzk6LaX0FEh+nU+96nyFXadnpRyNd2xrCT99s3CPIYxStNV/3qqXknmTWFl1f16ksVBhDJ/Nl5DnKhw40co88d6mmUSCdVlQfDxPCCKS3crgNMlhEqmxssNCJdLmNR8JvHDz1h2JkC6g/bWyDlkJANVlmLScva/6lQeF1s3U8XdXbhC1oMoYmrw5kgd
x-ms-office365-filtering-correlation-id: 68af7f59-383d-4699-bd46-08d5ecef5e9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB096601275D967752BA3E2D6DF4530@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(2351001)(5640700003)(105586002)(4326008)(6436002)(22452003)(106356001)(52116002)(5250100002)(76176011)(8936002)(1730700003)(8676002)(81166006)(81156014)(6486002)(478600001)(10290500003)(2616005)(72206003)(476003)(446003)(11346002)(486006)(66066001)(256004)(107886003)(14444005)(6512007)(53936002)(86612001)(99286004)(575784001)(305945005)(186003)(36756003)(2900100001)(14454004)(25786009)(7736002)(10090500001)(50226002)(1076002)(2501003)(2906002)(68736007)(97736004)(316002)(3846002)(6116002)(54906003)(5660300001)(6916009)(102836004)(26005)(386003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m45GJZgmxck0pN72OYLNcERXr6t3TZIkcOjwJHGxk93jbBTEHvEa3kqCaU8yRKB5iO6LYGjQUZWQmT7MatR9erQCGd0uQMyVqrTkWDibJLQbW2MUVHwxH17lepEggtVYmfuMU2uMjR2nFgy2O5iIZp2jA9zOIpWeBEnudTHWlLuDxg+gK9Z81vf9TruI9U9nfa4ZAn5WPNdjgcrgXt9n5yxe5ECw87H8mGRpjnEudhjNU+/CYiRx760gIUh1n/CkryFJAuklMEPDpU8FagaHZjhQSWsEhrw4Jl3Bc7/D/lrla8jW15HYK0F1VAL2VFHSE9xuNivj4Pt4mKCp1pLrFmQPNAzZUFxeA3QcVnFo37I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af7f59-383d-4699-bd46-08d5ecef5e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:45:17.7334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 cache.h        |   1 +
 config.c       |   5 +
 environment.c  |   1 +
 unpack-trees.c | 313 ++++++++++++++++++++++++++++++++++++++++++++++++-
 unpack-trees.h |  30 +++++
 5 files changed, 348 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d..4bfa35c497 100644
--- a/cache.h
+++ b/cache.h
@@ -815,6 +815,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
+extern int core_parallel_unpack_trees;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index f4a208a166..34d5506588 100644
--- a/config.c
+++ b/config.c
@@ -1346,6 +1346,11 @@ static int git_default_core_config(const char *var, =
const char *value)
 					 var, value);
 	}
=20
+	if (!strcmp(var, "core.parallelunpacktrees")) {
+		core_parallel_unpack_trees =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 2a6de2330b..1eb0a05074 100644
--- a/environment.c
+++ b/environment.c
@@ -68,6 +68,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_commit_graph;
 int core_apply_sparse_checkout;
+int core_parallel_unpack_trees;
 int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition() *=
/
 unsigned long pack_size_limit_cfg;
diff --git a/unpack-trees.c b/unpack-trees.c
index 1f58efc6bb..2333626efd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "submodule-config.h"
 #include "fsmonitor.h"
 #include "fetch-object.h"
+#include "thread-utils.h"
=20
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -641,6 +642,98 @@ static inline int are_same_oid(struct name_entry *name=
_j, struct name_entry *nam
 	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
 }
=20
+#ifndef NO_PTHREADS
+
+struct traverse_info_parallel {
+	struct mpmcq_entry entry;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	void *buf[MAX_UNPACK_TREES];
+	struct traverse_info info;
+	int n;
+	int nr_buf;
+	int ret;
+};
+
+static int traverse_trees_parallel(int n, unsigned long dirmask,
+				   unsigned long df_conflicts,
+				   struct name_entry *names,
+				   struct traverse_info *info)
+{
+	int i;
+	struct name_entry *p;
+	struct unpack_trees_options *o =3D info->data;
+	struct traverse_info_parallel *newinfo;
+
+	p =3D names;
+	while (!p->mode)
+		p++;
+
+	newinfo =3D xmalloc(sizeof(struct traverse_info_parallel));
+	mpmcq_entry_init(&newinfo->entry);
+	newinfo->info =3D *info;
+	newinfo->info.prev =3D info;
+	newinfo->info.pathspec =3D info->pathspec;
+	newinfo->info.name =3D *p;
+	newinfo->info.pathlen +=3D tree_entry_len(p) + 1;
+	newinfo->info.df_conflicts |=3D df_conflicts;
+	newinfo->nr_buf =3D 0;
+	newinfo->n =3D n;
+
+	/*
+	 * Fetch the tree from the ODB for each peer directory in the
+	 * n commits.
+	 *
+	 * For 2- and 3-way traversals, we try to avoid hitting the
+	 * ODB twice for the same OID.  This should yield a nice speed
+	 * up in checkouts and merges when the commits are similar.
+	 *
+	 * We don't bother doing the full O(n^2) search for larger n,
+	 * because wider traversals don't happen that often and we
+	 * avoid the search setup.
+	 *
+	 * When 2 peer OIDs are the same, we just copy the tree
+	 * descriptor data.  This implicitly borrows the buffer
+	 * data from the earlier cell.
+	 */
+	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
+		if (i > 0 && are_same_oid(&names[i], &names[i - 1]))
+			newinfo->t[i] =3D newinfo->t[i - 1];
+		else if (i > 1 && are_same_oid(&names[i], &names[i - 2]))
+			newinfo->t[i] =3D newinfo->t[i - 2];
+		else {
+			const struct object_id *oid =3D NULL;
+			if (dirmask & 1)
+				oid =3D names[i].oid;
+
+			/*
+			 * fill_tree_descriptor() will load the tree from the
+			 * ODB. Accessing the ODB is not thread safe so
+			 * serialize access using the odb_mutex.
+			 */
+			pthread_mutex_lock(&o->odb_mutex);
+			newinfo->buf[newinfo->nr_buf++] =3D
+				fill_tree_descriptor(newinfo->t + i, oid);
+			pthread_mutex_unlock(&o->odb_mutex);
+		}
+	}
+
+	/*
+	 * We can't play games with the cache bottom as we are processing
+	 * the tree objects in parallel.
+	 * newinfo->bottom =3D switch_cache_bottom(&newinfo->info);
+	 */
+
+	/* All I really need here is fetch_and_add() */
+	pthread_mutex_lock(&o->work_mutex);
+	o->remaining_work++;
+	pthread_mutex_unlock(&o->work_mutex);
+	mpmcq_push(&o->queue, &newinfo->entry);
+
+	return 0;
+}
+
+#endif
+
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
@@ -995,6 +1088,108 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
=20
+static int unpack_callback_parallel(int n, unsigned long mask,
+				    unsigned long dirmask,
+				    struct name_entry *names,
+				    struct traverse_info *info)
+{
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D {
+		NULL,
+	};
+	struct unpack_trees_options *o =3D info->data;
+	const struct name_entry *p =3D names;
+
+	/* Find first entry with a real name (we could use "mask" too) */
+	while (!p->mode)
+		p++;
+
+	if (o->debug_unpack)
+		debug_unpack_callback(n, mask, dirmask, names, info);
+
+	/* Are we supposed to look at the index too? */
+	if (o->merge) {
+		while (1) {
+			int cmp;
+			struct cache_entry *ce;
+
+			if (o->diff_index_cached)
+				ce =3D next_cache_entry(o);
+			else
+				ce =3D find_cache_entry(info, p);
+
+			if (!ce)
+				break;
+			cmp =3D compare_entry(ce, info, p);
+			if (cmp < 0) {
+				int ret;
+
+				pthread_mutex_lock(&o->unpack_index_entry_mutex);
+				ret =3D unpack_index_entry(ce, o);
+				pthread_mutex_unlock(&o->unpack_index_entry_mutex);
+				if (ret < 0)
+					return unpack_failed(o, NULL);
+				continue;
+			}
+			if (!cmp) {
+				if (ce_stage(ce)) {
+					/*
+					 * If we skip unmerged index
+					 * entries, we'll skip this
+					 * entry *and* the tree
+					 * entries associated with it!
+					 */
+					if (o->skip_unmerged) {
+						add_same_unmerged(ce, o);
+						return mask;
+					}
+				}
+				src[0] =3D ce;
+			}
+			break;
+		}
+	}
+
+	pthread_mutex_lock(&o->unpack_nondirectories_mutex);
+	int ret =3D unpack_nondirectories(n, mask, dirmask, src, names, info);
+	pthread_mutex_unlock(&o->unpack_nondirectories_mutex);
+	if (ret < 0)
+		return -1;
+
+	if (o->merge && src[0]) {
+		if (ce_stage(src[0]))
+			mark_ce_used_same_name(src[0], o);
+		else
+			mark_ce_used(src[0], o);
+	}
+
+	/* Now handle any directories.. */
+	if (dirmask) {
+		/* special case: "diff-index --cached" looking at a tree */
+		if (o->diff_index_cached && n =3D=3D 1 && dirmask =3D=3D 1 &&
+		    S_ISDIR(names->mode)) {
+			int matches;
+			matches =3D cache_tree_matches_traversal(
+				o->src_index->cache_tree, names, info);
+			/*
+			 * Everything under the name matches; skip the
+			 * entire hierarchy.  diff_index_cached codepath
+			 * special cases D/F conflicts in such a way that
+			 * it does not do any look-ahead, so this is safe.
+			 */
+			if (matches) {
+				o->cache_bottom +=3D matches;
+				return mask;
+			}
+		}
+
+		if (traverse_trees_parallel(n, dirmask, mask & ~dirmask, names, info) < =
0)
+			return -1;
+		return mask;
+	}
+
+	return mask;
+}
+
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmas=
k, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
@@ -1263,6 +1458,116 @@ static void mark_new_skip_worktree(struct exclude_l=
ist *el,
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
 			 struct unpack_trees_options *);
+
+#ifndef NO_PTHREADS
+static void *traverse_trees_parallel_thread_proc(void *_data)
+{
+	struct unpack_trees_options *o =3D _data;
+	struct traverse_info_parallel *info;
+	int i;
+
+	while (1) {
+		info =3D (struct traverse_info_parallel *)mpmcq_pop(&o->queue);
+		if (!info)
+			break;
+
+		info->ret =3D traverse_trees(info->n, info->t, &info->info);
+		/*
+		 * We can't play games with the cache bottom as we are processing
+		 * the tree objects in parallel.
+		 * restore_cache_bottom(&info->info, info->bottom);
+		 */
+
+		for (i =3D 0; i < info->nr_buf; i++)
+			free(info->buf[i]);
+		/*
+		 * TODO: Can't free "info" when thread is done because it can be used
+		 * as ->prev link in child info objects.  Ref count?  Free all at end?
+		free(info);
+		 */
+
+		/* All I really need here is fetch_and_add() */
+		pthread_mutex_lock(&o->work_mutex);
+		o->remaining_work--;
+		if (o->remaining_work =3D=3D 0)
+			mpmcq_cancel(&o->queue);
+		pthread_mutex_unlock(&o->work_mutex);
+	}
+
+	return NULL;
+}
+
+static void init_parallel_traverse(struct unpack_trees_options *o,
+				   struct traverse_info *info)
+{
+	/*
+	 * TODO: Add logic to bypass parallel path when not needed.
+	 *			- not enough CPU cores to help
+	 *			- 'git status' is always fast - how to detect?
+	 *			- small trees (may be able to use index size as proxy, small index l=
ikely means small commit tree)
+	 */
+	if (core_parallel_unpack_trees) {
+		int t;
+
+		mpmcq_init(&o->queue);
+		o->remaining_work =3D 0;
+		pthread_mutex_init(&o->unpack_nondirectories_mutex, NULL);
+		pthread_mutex_init(&o->unpack_index_entry_mutex, NULL);
+		pthread_mutex_init(&o->odb_mutex, NULL);
+		pthread_mutex_init(&o->work_mutex, NULL);
+		o->nr_threads =3D online_cpus();
+		o->pthreads =3D xcalloc(o->nr_threads, sizeof(pthread_t));
+		info->fn =3D unpack_callback_parallel;
+
+		for (t =3D 0; t < o->nr_threads; t++) {
+			if (pthread_create(&o->pthreads[t], NULL,
+					   traverse_trees_parallel_thread_proc,
+					   o))
+				die("unable to create traverse_trees_parallel_thread");
+		}
+	}
+}
+
+static void wait_parallel_traverse(struct unpack_trees_options *o)
+{
+	/*
+	 * The first tree (root directory) is processed on the main thread.
+	 * This function is called after it has completed.  If there is no
+	 * remaining work, we know we are finished.
+	 */
+	if (core_parallel_unpack_trees) {
+		int t;
+
+		pthread_mutex_lock(&o->work_mutex);
+		if (o->remaining_work =3D=3D 0)
+			mpmcq_cancel(&o->queue);
+		pthread_mutex_unlock(&o->work_mutex);
+
+		for (t =3D 0; t < o->nr_threads; t++) {
+			if (pthread_join(o->pthreads[t], NULL))
+				die("unable to join traverse_trees_parallel_thread");
+		}
+
+		free(o->pthreads);
+		pthread_mutex_destroy(&o->work_mutex);
+		pthread_mutex_destroy(&o->odb_mutex);
+		pthread_mutex_destroy(&o->unpack_index_entry_mutex);
+		pthread_mutex_destroy(&o->unpack_nondirectories_mutex);
+		mpmcq_destroy(&o->queue);
+	}
+}
+#else
+static void init_parallel_traverse(struct unpack_trees_options *o)
+{
+	return;
+}
+
+static void wait_parallel_traverse(struct unpack_trees_options *o)
+{
+	return;
+}
+#endif
+
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to manipu=
late the
  * resulting index, -2 on failure to reflect the changes to the work tree.
@@ -1327,6 +1632,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, s=
truct unpack_trees_options
 		const char *prefix =3D o->prefix ? o->prefix : "";
 		struct traverse_info info;
 		uint64_t start;
+		int ret;
=20
 		setup_traverse_info(&info, prefix);
 		info.fn =3D unpack_callback;
@@ -1352,9 +1658,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, =
struct unpack_trees_options
 		}
=20
 		start =3D getnanotime();
-		if (traverse_trees(len, t, &info) < 0)
-			goto return_failed;
+		init_parallel_traverse(o, &info);
+		ret =3D traverse_trees(len, t, &info);
+		wait_parallel_traverse(o);
 		trace_performance_since(start, "traverse_trees");
+		if (ret < 0)
+			goto return_failed;
 	}
=20
 	/* Any left-over entries in the index? */
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..b7140099fa 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -3,6 +3,11 @@
=20
 #include "tree-walk.h"
 #include "argv-array.h"
+#ifndef NO_PTHREADS
+#include "git-compat-util.h"
+#include <pthread.h>
+#include "mpmcqueue.h"
+#endif
=20
 #define MAX_UNPACK_TREES 8
=20
@@ -80,6 +85,31 @@ struct unpack_trees_options {
 	struct index_state result;
=20
 	struct exclude_list *el; /* for internal use */
+#ifndef NO_PTHREADS
+	/*
+	 * Speed up the tree traversal by adding all discovered tree objects
+	 * into a queue and have a pool of worker threads process them in
+	 * parallel.  Since there is no upper bound on the size of a tree and
+	 * each worker thread will be adding discovered tree objects to the
+	 * queue, we need an unbounded multi-producer-multi-consumer queue.
+	 */
+	struct mpmcq queue;
+
+	int nr_threads;
+	pthread_t *pthreads;
+
+	/* need a mutex as we don't have fetch_and_add() */
+	int remaining_work;
+	pthread_mutex_t work_mutex;
+
+	/* The ODB is not thread safe so we must serialize access to it */
+	pthread_mutex_t odb_mutex;
+
+	/* various functions that are not thread safe and must be serialized for =
now */
+	pthread_mutex_t unpack_index_entry_mutex;
+	pthread_mutex_t unpack_nondirectories_mutex;
+
+#endif
 };
=20
 extern int unpack_trees(unsigned n, struct tree_desc *t,
--=20
2.17.0.gvfs.1.123.g449c066

