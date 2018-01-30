Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784551F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeA3XpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:45:20 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58648 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932164AbeA3XpS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:18 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN7r5025766;
        Tue, 30 Jan 2018 15:25:35 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dr-1;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B24B9221A57A;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A3B612CDEB4;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 13/31] merge-recursive: introduce new functions to handle rename logic
Date:   Tue, 30 Jan 2018 15:25:15 -0800
Message-Id: <20180130232533.25846-14-newren@gmail.com>
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
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The amount of logic in merge_trees() relative to renames was just a few
lines, but split it out into new handle_renames() and cleanup_renames()
functions to prepare for additional logic to be added to each.  No code o=
r
logic changes, just a new place to put stuff for when the rename detectio=
n
gains additional checks.

Note that process_renames() records pointers to various information (such
as diff_filepairs) into rename_conflict_info structs.  Even though the
rename string_lists are not directly used once handle_renames() completes=
,
we should not immediately free the lists at the end of that function
because they store the information referenced in the rename_conflict_info=
,
which is used later in process_entry().  Thus the reason for a separate
cleanup_renames().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2028dd113b..eac3041261 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1645,6 +1645,32 @@ static int process_renames(struct merge_options *o=
,
 	return clean_merge;
 }
=20
+struct rename_info {
+	struct string_list *head_renames;
+	struct string_list *merge_renames;
+};
+
+static int handle_renames(struct merge_options *o,
+			  struct tree *common,
+			  struct tree *head,
+			  struct tree *merge,
+			  struct string_list *entries,
+			  struct rename_info *ri)
+{
+	ri->head_renames  =3D get_renames(o, head, common, head, merge, entries=
);
+	ri->merge_renames =3D get_renames(o, merge, common, head, merge, entrie=
s);
+	return process_renames(o, ri->head_renames, ri->merge_renames);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	string_list_clear(re_info->head_renames, 0);
+	string_list_clear(re_info->merge_renames, 0);
+
+	free(re_info->head_renames);
+	free(re_info->merge_renames);
+}
+
 static struct object_id *stage_oid(const struct object_id *oid, unsigned=
 mode)
 {
 	return (is_null_oid(oid) || mode =3D=3D 0) ? NULL: (struct object_id *)=
oid;
@@ -2004,7 +2030,8 @@ int merge_trees(struct merge_options *o,
 	}
=20
 	if (unmerged_cache()) {
-		struct string_list *entries, *re_head, *re_merge;
+		struct string_list *entries;
+		struct rename_info re_info;
 		int i;
 		/*
 		 * Only need the hashmap while processing entries, so
@@ -2018,9 +2045,8 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
=20
 		entries =3D get_unmerged();
-		re_head  =3D get_renames(o, head, common, head, merge, entries);
-		re_merge =3D get_renames(o, merge, common, head, merge, entries);
-		clean =3D process_renames(o, re_head, re_merge);
+		clean =3D handle_renames(o, common, head, merge, entries,
+				       &re_info);
 		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
@@ -2045,16 +2071,13 @@ int merge_trees(struct merge_options *o,
 		}
=20
 cleanup:
-		string_list_clear(re_merge, 0);
-		string_list_clear(re_head, 0);
+		cleanup_renames(&re_info);
+
 		string_list_clear(entries, 1);
+		free(entries);
=20
 		hashmap_free(&o->current_file_dir_set, 1);
=20
-		free(re_merge);
-		free(re_head);
-		free(entries);
-
 		if (clean < 0)
 			return clean;
 	}
--=20
2.16.1.106.gf69932adfe

