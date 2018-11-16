Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461341F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbeKPSLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:31 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47628 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbeKPSLa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:30 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7xbKt022964;
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by3kq5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 16 Nov 2018 02:59:59 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 16 Nov 2018 02:59:59 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 74A8E221228B;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 08/11] fast-export: ensure we export requested refs
Date:   Thu, 15 Nov 2018 23:59:53 -0800
Message-ID: <20181116075956.27047-9-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g1796373474.dirty
In-Reply-To: <20181116075956.27047-1-newren@gmail.com>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If file paths are specified to fast-export and a ref points to a commit
that does not touch any of the relevant paths, then that ref would
sometimes fail to be exported.  (This depends on whether any ancestors
of the commit which do touch the relevant paths would be exported with
that same ref name or a different ref name.)  To avoid this problem,
put *all* specified refs into extra_refs to start, and then as we export
each commit, remove the refname used in the 'commit $REFNAME' directive
from extra_refs.  Then, in handle_tags_and_duplicates() we know which
refs actually do need a manual reset directive in order to be included.

This means that we do need some special handling for excluded refs; e.g.
if someone runs
   git fast-export ^master master
then they've asked for master to be exported, but they have also asked
for the commit which master points to and all of its history to be
excluded.  That logically means ref deletion.  Previously, such refs
were just silently omitted from being exported despite having been
explicitly requested for export.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 54 ++++++++++++++++++++++++++++++++----------
 t/t9350-fast-export.sh | 16 ++++++++++---
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 227488ae84..d71e0333d4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
+static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 static struct revision_sources revision_sources;
@@ -612,6 +613,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
 	refname = *revision_sources_at(&revision_sources, commit);
+	/*
+	 * FIXME: string_list_remove() below for each ref is overall
+	 * O(N^2).  Compared to a history walk and diffing trees, this is
+	 * just lost in the noise in practice.  However, theoretically a
+	 * repo may have enough refs for this to become slow.
+	 */
+	string_list_remove(&extra_refs, refname, 0);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
@@ -815,7 +823,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
 			parse_object(the_repository, &tag->object.oid);
-			string_list_append(&extra_refs, full_name)->util = tag;
+			string_list_append(&tag_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
 		if (!tag)
@@ -874,25 +882,30 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		}
 
 		/*
-		 * This ref will not be updated through a commit, lets make
-		 * sure it gets properly updated eventually.
+		 * Make sure this ref gets properly updated eventually, whether
+		 * through a commit or manually at the end.
 		 */
-		if (*revision_sources_at(&revision_sources, commit) ||
-		    commit->object.flags & SHOWN)
+		if (e->item->type != OBJ_TAG)
 			string_list_append(&extra_refs, full_name)->util = commit;
+
 		if (!*revision_sources_at(&revision_sources, commit))
 			*revision_sources_at(&revision_sources, commit) = full_name;
 	}
+
+	string_list_sort(&extra_refs);
+	string_list_remove_duplicates(&extra_refs, 0);
 }
 
-static void handle_tags_and_duplicates(void)
+static void handle_tags_and_duplicates(struct string_list *extras)
 {
 	struct commit *commit;
 	int i;
 
-	for (i = extra_refs.nr - 1; i >= 0; i--) {
-		const char *name = extra_refs.items[i].string;
-		struct object *object = extra_refs.items[i].util;
+	for (i = extras->nr - 1; i >= 0; i--) {
+		const char *name = extras->items[i].string;
+		struct object *object = extras->items[i].util;
+		int mark;
+
 		switch (object->type) {
 		case OBJ_TAG:
 			handle_tag(name, (struct tag *)object);
@@ -913,8 +926,24 @@ static void handle_tags_and_duplicates(void)
 				       name, oid_to_hex(&null_oid));
 				continue;
 			}
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+
+			mark = get_object_mark(&commit->object);
+			if (!mark) {
+				/*
+				 * Getting here means we have a commit which
+				 * was excluded by a negative refspec (e.g.
+				 * fast-export ^master master).  If the user
+				 * wants the branch exported but every commit
+				 * in its history to be deleted, that sounds
+				 * like a ref deletion to me.
+				 */
+				printf("reset %s\nfrom %s\n\n",
+				       name, oid_to_hex(&null_oid));
+				continue;
+			}
+
+			printf("reset %s\nfrom :%d\n\n", name, mark
+			       );
 			show_progress();
 			break;
 		}
@@ -1102,7 +1131,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	handle_tags_and_duplicates();
+	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates(&tag_refs);
 	handle_deletes();
 
 	if (export_filename && lastimportid != last_idnum)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 299120ba70..50c2fceef4 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -544,10 +544,20 @@ test_expect_success 'use refspec' '
 	test_cmp expected actual
 '
 
-test_expect_success 'delete refspec' '
+test_expect_success 'delete ref because entire history excluded' '
 	git branch to-delete &&
-	git fast-export --refspec :refs/heads/to-delete to-delete ^to-delete > actual &&
-	cat > expected <<-EOF &&
+	git fast-export to-delete ^to-delete >actual &&
+	cat >expected <<-EOF &&
+	reset refs/heads/to-delete
+	from 0000000000000000000000000000000000000000
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'delete refspec' '
+	git fast-export --refspec :refs/heads/to-delete >actual &&
+	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
 	from 0000000000000000000000000000000000000000
 
-- 
2.19.1.1063.g1796373474.dirty

