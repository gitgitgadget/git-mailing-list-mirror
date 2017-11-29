Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E6420954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbdK2BnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:23 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55354 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752795AbdK2BnU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:20 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1dBhp004738;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm12-2;
        Tue, 28 Nov 2017 17:42:38 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C527022157C2;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id BE5352CDF15;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 19/34] merge-recursive: split out code for determining diff_filepairs
Date:   Tue, 28 Nov 2017 17:42:22 -0800
Message-Id: <20171129014237.32570-20-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
In-Reply-To: <20171129014237.32570-1-newren@gmail.com>
References: <20171129014237.32570-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, get_diffpairs() to compute the diff_filepairs
between two trees.  While these are currently only used in
get_renames(), I want them to be available to some new functions.  No
actual logic changes yet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 86 +++++++++++++++++++++++++++++++++++++++++--------=
------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index da7c67eb82..4adff2d538 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1312,24 +1312,15 @@ static int conflict_rename_rename_2to1(struct mer=
ge_options *o,
 }
=20
 /*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_=
tree.
+ * Get the diff_filepairs changed between o_tree and tree.
  */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
+static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
+					       struct tree *o_tree,
+					       struct tree *tree)
 {
-	int i;
-	struct string_list *renames;
+	struct diff_queue_struct *ret;
 	struct diff_options opts;
=20
-	renames =3D xcalloc(1, sizeof(struct string_list));
-
 	diff_setup(&opts);
 	opts.flags.recursive =3D 1;
 	opts.flags.rename_empty =3D 0;
@@ -1345,10 +1336,43 @@ static struct string_list *get_renames(struct mer=
ge_options *o,
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit =3D opts.needed_rename_limit;
-	for (i =3D 0; i < diff_queued_diff.nr; ++i) {
+
+	ret =3D malloc(sizeof(struct diff_queue_struct));
+	ret->queue =3D diff_queued_diff.queue;
+	ret->nr =3D diff_queued_diff.nr;
+	/* Ignore diff_queued_diff.alloc; we won't be changing size at all */
+
+	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr =3D 0;
+	diff_queued_diff.queue =3D NULL;
+	diff_flush(&opts);
+	return ret;
+}
+
+/*
+ * Get information of all renames which occurred in 'pairs', making use =
of
+ * any implicit directory renames inferred from the other side of histor=
y.
+ * We need the three trees in the merge ('o_tree', 'a_tree' and 'b_tree'=
)
+ * to be able to associate the correct cache entries with the rename
+ * information; tree is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct diff_queue_struct *pairs,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+
+	renames =3D xcalloc(1, sizeof(struct string_list));
+
+	for (i =3D 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
 		struct rename *re;
-		struct diff_filepair *pair =3D diff_queued_diff.queue[i];
+		struct diff_filepair *pair =3D pairs->queue[i];
=20
 		if (pair->status !=3D 'R') {
 			diff_free_filepair(pair);
@@ -1373,9 +1397,6 @@ static struct string_list *get_renames(struct merge=
_options *o,
 		item =3D string_list_insert(renames, pair->one->path);
 		item->util =3D re;
 	}
-	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr =3D 0;
-	diff_flush(&opts);
 	return renames;
 }
=20
@@ -1646,15 +1667,36 @@ static int handle_renames(struct merge_options *o=
,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	struct diff_queue_struct *head_pairs, *merge_pairs;
+	int clean;
+
 	ri->head_renames =3D NULL;
 	ri->merge_renames =3D NULL;
=20
 	if (!o->detect_rename)
 		return 1;
=20
-	ri->head_renames  =3D get_renames(o, head, common, head, merge, entries=
);
-	ri->merge_renames =3D get_renames(o, merge, common, head, merge, entrie=
s);
-	return process_renames(o, ri->head_renames, ri->merge_renames);
+	head_pairs =3D get_diffpairs(o, common, head);
+	merge_pairs =3D get_diffpairs(o, common, merge);
+
+	ri->head_renames  =3D get_renames(o, head_pairs, head,
+					 common, head, merge, entries);
+	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
+					 common, head, merge, entries);
+	clean =3D process_renames(o, ri->head_renames, ri->merge_renames);
+
+	/*
+	 * Some cleanup is deferred until cleanup_renames() because the
+	 * data structures are still needed and referenced in
+	 * process_entry().  But there are a few things we can free now.
+	 */
+
+	free(head_pairs->queue);
+	free(head_pairs);
+	free(merge_pairs->queue);
+	free(merge_pairs);
+
+	return clean;
 }
=20
 static void cleanup_rename(struct string_list *rename)
--=20
2.15.0.408.g850bc54b15

