Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17D91F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeA3XqR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:46:17 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58664 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932202AbeA3XpS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:18 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN1n2025717;
        Tue, 30 Jan 2018 15:25:35 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dq-1;
        Tue, 30 Jan 2018 15:25:34 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A2D06221A568;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 99E562CDE88;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 12/31] merge-recursive: move the get_renames() function
Date:   Tue, 30 Jan 2018 15:25:14 -0800
Message-Id: <20180130232533.25846-13-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.106.gf69932adfe
In-Reply-To: <20180130232533.25846-1-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to re-use some other functions in the file without moving those
other functions or dealing with a handful of annoying split function
declarations and definitions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 139 +++++++++++++++++++++++++++---------------------=
------
 1 file changed, 70 insertions(+), 69 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9d53f30111..2028dd113b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -537,75 +537,6 @@ struct rename {
 	unsigned processed:1;
 };
=20
-/*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_=
tree.
- */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
-{
-	int i;
-	struct string_list *renames;
-	struct diff_options opts;
-
-	renames =3D xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
-
-	diff_setup(&opts);
-	opts.flags.recursive =3D 1;
-	opts.flags.rename_empty =3D 0;
-	opts.detect_rename =3D DIFF_DETECT_RENAME;
-	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_li=
mit :
-			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
-			    1000;
-	opts.rename_score =3D o->rename_score;
-	opts.show_rename_progress =3D o->show_rename_progress;
-	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&opts);
-	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
-	diffcore_std(&opts);
-	if (opts.needed_rename_limit > o->needed_rename_limit)
-		o->needed_rename_limit =3D opts.needed_rename_limit;
-	for (i =3D 0; i < diff_queued_diff.nr; ++i) {
-		struct string_list_item *item;
-		struct rename *re;
-		struct diff_filepair *pair =3D diff_queued_diff.queue[i];
-		if (pair->status !=3D 'R') {
-			diff_free_filepair(pair);
-			continue;
-		}
-		re =3D xmalloc(sizeof(*re));
-		re->processed =3D 0;
-		re->pair =3D pair;
-		item =3D string_list_lookup(entries, re->pair->one->path);
-		if (!item)
-			re->src_entry =3D insert_stage_data(re->pair->one->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->src_entry =3D item->util;
-
-		item =3D string_list_lookup(entries, re->pair->two->path);
-		if (!item)
-			re->dst_entry =3D insert_stage_data(re->pair->two->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->dst_entry =3D item->util;
-		item =3D string_list_insert(renames, pair->one->path);
-		item->util =3D re;
-	}
-	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr =3D 0;
-	diff_flush(&opts);
-	return renames;
-}
-
 static int update_stages(struct merge_options *opt, const char *path,
 			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
@@ -1389,6 +1320,76 @@ static int conflict_rename_rename_2to1(struct merg=
e_options *o,
 	return ret;
 }
=20
+/*
+ * Get information of all renames which occurred between 'o_tree' and
+ * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
+ * 'b_tree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either a_tree or b_=
tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+	struct diff_options opts;
+
+	renames =3D xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
+	diff_setup(&opts);
+	opts.flags.recursive =3D 1;
+	opts.flags.rename_empty =3D 0;
+	opts.detect_rename =3D DIFF_DETECT_RENAME;
+	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_li=
mit :
+			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
+			    1000;
+	opts.rename_score =3D o->rename_score;
+	opts.show_rename_progress =3D o->show_rename_progress;
+	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opts);
+	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
+	diffcore_std(&opts);
+	if (opts.needed_rename_limit > o->needed_rename_limit)
+		o->needed_rename_limit =3D opts.needed_rename_limit;
+	for (i =3D 0; i < diff_queued_diff.nr; ++i) {
+		struct string_list_item *item;
+		struct rename *re;
+		struct diff_filepair *pair =3D diff_queued_diff.queue[i];
+
+		if (pair->status !=3D 'R') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		re =3D xmalloc(sizeof(*re));
+		re->processed =3D 0;
+		re->pair =3D pair;
+		item =3D string_list_lookup(entries, re->pair->one->path);
+		if (!item)
+			re->src_entry =3D insert_stage_data(re->pair->one->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->src_entry =3D item->util;
+
+		item =3D string_list_lookup(entries, re->pair->two->path);
+		if (!item)
+			re->dst_entry =3D insert_stage_data(re->pair->two->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->dst_entry =3D item->util;
+		item =3D string_list_insert(renames, pair->one->path);
+		item->util =3D re;
+	}
+	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr =3D 0;
+	diff_flush(&opts);
+	return renames;
+}
+
 static int process_renames(struct merge_options *o,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
--=20
2.16.1.106.gf69932adfe

