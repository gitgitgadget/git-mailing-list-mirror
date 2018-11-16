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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1688B1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKPSLg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:36 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47646 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbeKPSLb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:31 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wrCS022772;
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by3kq4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 16 Nov 2018 00:00:02 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 15 Nov 2018 23:59:58 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 7C8B9221228C;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 09/11] fast-export: add --reference-excluded-parents option
Date:   Thu, 15 Nov 2018 23:59:54 -0800
Message-ID: <20181116075956.27047-10-newren@gmail.com>
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

git filter-branch has a nifty feature allowing you to rewrite, e.g. just
the last 8 commits of a linear history
  git filter-branch $OPTIONS HEAD~8..HEAD

If you try the same with git fast-export, you instead get a history of
only 8 commits, with HEAD~7 being rewritten into a root commit.  There
are two alternatives:

  1) Don't use the negative revision specification, and when you're
     filtering the output to make modifications to the last 8 commits,
     just be careful to not modify any earlier commits somehow.

  2) First run 'git fast-export --export-marks=somefile HEAD~8', then
     run 'git fast-export --import-marks=somefile HEAD~8..HEAD'.

Both are more error prone than I'd like (the first for obvious reasons;
with the second option I have sometimes accidentally included too many
revisions in the first command and then found that the corresponding
extra revisions were not exported by the second command and thus were
not modified as I expected).  Also, both are poor from a performance
perspective.

Add a new --reference-excluded-parents option which will cause
fast-export to refer to commits outside the specified rev-list-args
range by their sha1sum.  Such a stream will only be useful in a
repository which already contains the necessary commits (much like the
restriction imposed when using --no-data).

Note from Peff:
  I think we might be able to do a little more optimization here. If
  we're exporting HEAD^..HEAD and there's an object in HEAD^ which is
  unchanged in HEAD, I think we'd still print it (because it would not
  be marked SHOWN), but we could omit it (by walking the tree of the
  boundary commits and marking them shown).  I don't think it's a
  blocker for what you're doing here, but just a possible future
  optimization.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 17 +++++++++++--
 builtin/fast-export.c             | 42 +++++++++++++++++++++++--------
 t/t9350-fast-export.sh            | 11 ++++++++
 3 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index fda55b3284..f65026662a 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -110,6 +110,18 @@ marks the same across runs.
 	the shape of the history and stored tree.  See the section on
 	`ANONYMIZING` below.
 
+--reference-excluded-parents::
+	By default, running a command such as `git fast-export
+	master~5..master` will not include the commit master{tilde}5
+	and will make master{tilde}4 no longer have master{tilde}5 as
+	a parent (though both the old master{tilde}4 and new
+	master{tilde}4 will have all the same files).  Use
+	--reference-excluded-parents to instead have the the stream
+	refer to commits in the excluded range of history by their
+	sha1sum.  Note that the resulting stream can only be used by a
+	repository which already contains the necessary parent
+	commits.
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
@@ -119,8 +131,9 @@ marks the same across runs.
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
 	current master reference to be exported along with all objects
-	added since its 10th ancestor commit and all files common to
-	master{tilde}9 and master{tilde}10.
+	added since its 10th ancestor commit and (unless the
+	--reference-excluded-parents option is specified) all files
+	common to master{tilde}9 and master{tilde}10.
 
 EXAMPLES
 --------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d71e0333d4..78fc67b03a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -37,6 +37,7 @@ static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
 static int full_tree;
+static int reference_excluded_commits;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
@@ -597,7 +598,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    (get_object_mark(&commit->parents->item->object) != 0 ||
+	     reference_excluded_commits) &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
 		diff_tree_oid(get_commit_tree_oid(commit->parents->item),
@@ -645,13 +647,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	unuse_commit_buffer(commit, commit_buffer);
 
 	for (i = 0, p = commit->parents; p; p = p->next) {
-		int mark = get_object_mark(&p->item->object);
-		if (!mark)
+		struct object *obj = &p->item->object;
+		int mark = get_object_mark(obj);
+
+		if (!mark && !reference_excluded_commits)
 			continue;
 		if (i == 0)
-			printf("from :%d\n", mark);
+			printf("from ");
+		else
+			printf("merge ");
+		if (mark)
+			printf(":%d\n", mark);
 		else
-			printf("merge :%d\n", mark);
+			printf("%s\n", oid_to_hex(anonymize ?
+						  anonymize_oid(&obj->oid) :
+						  &obj->oid));
 		i++;
 	}
 
@@ -932,13 +942,22 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				/*
 				 * Getting here means we have a commit which
 				 * was excluded by a negative refspec (e.g.
-				 * fast-export ^master master).  If the user
+				 * fast-export ^master master).  If we are
+				 * referencing excluded commits, set the ref
+				 * to the exact commit.  Otherwise, the user
 				 * wants the branch exported but every commit
-				 * in its history to be deleted, that sounds
-				 * like a ref deletion to me.
+				 * in its history to be deleted, which basically
+				 * just means deletion of the ref.
 				 */
-				printf("reset %s\nfrom %s\n\n",
-				       name, oid_to_hex(&null_oid));
+				if (!reference_excluded_commits) {
+					/* delete the ref */
+					printf("reset %s\nfrom %s\n\n",
+					       name, oid_to_hex(&null_oid));
+					continue;
+				}
+				/* set ref to commit using oid, not mark */
+				printf("reset %s\nfrom %s\n\n", name,
+				       oid_to_hex(&commit->object.oid));
 				continue;
 			}
 
@@ -1075,6 +1094,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
+		OPT_BOOL(0, "reference-excluded-parents",
+			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
+
 		OPT_END()
 	};
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 50c2fceef4..d7d73061d0 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -66,6 +66,17 @@ test_expect_success 'fast-export master~2..master' '
 
 '
 
+test_expect_success 'fast-export --reference-excluded-parents master~2..master' '
+
+	git fast-export --reference-excluded-parents master~2..master >actual &&
+	grep commit.refs/heads/master actual >commit-count &&
+	test_line_count = 2 commit-count &&
+	sed "s/master/rewrite/" actual |
+		(cd new &&
+		 git fast-import &&
+		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
+'
+
 test_expect_success 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO8859-1 &&
-- 
2.19.1.1063.g1796373474.dirty

