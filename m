Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC5F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeKNK1C (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:02 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38452 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731033AbeKNK1C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:02 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0IbQx024221;
        Tue, 13 Nov 2018 16:26:04 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by051r-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Nov 2018 16:26:04 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 13 Nov 2018 16:25:56 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 13 Nov 2018 16:25:56 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 4D5202212292;
        Tue, 13 Nov 2018 16:26:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 11/11] fast-export: add --always-show-modify-after-rename
Date:   Tue, 13 Nov 2018 16:26:00 -0800
Message-ID: <20181114002600.29233-12-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g2b8e4a4f82.dirty
In-Reply-To: <20181114002600.29233-1-newren@gmail.com>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanted a way to gather all the following information efficiently
(with as few history traversals as possible):
  * Get all blob sizes
  * Map blob shas to filename(s) they appeared under in the history
  * Find when files and directories were deleted (and whether they
    were later reinstated, since that means they aren't actually gone)
  * Find sets of filenames referring to the same logical 'file'. (e.g.
    foo->bar in commit A and bar->baz in commit B mean that
    {foo,bar,baz} refer to the same 'file', so someone wanting to just
    "keep baz and its history" need all versions of those three
    filenames).  I need to know about things like another foo or bar
    being introduced after the rename though, since that breaks the
    connection between filenames)
and then I would generate various aggregations on the data and display
some type of report for the user.

The only way I know of to get blob sizes is via
  cat-file --batch-all-objects --batch-check

The rest of the data would traditionally be gathered from a log command,
e.g.

  git log --format='%H%n%P%n%cd' --date=short --topo-order --reverse \
      -M --diff-filter=RAMD --no-abbrev --raw -c

however, parsing log output seems slightly dangerous given that it is a
porcelain command.  While we have specified --format and --raw to try
to avoid the most obvious problems, I'm still slightly concerned about
--date=short, the combinations of --raw and -c, options that might
colorize the output, and also the --diff-filter (there is no current
option named --no-find-copies or --no-break-rewrites, but what if those
turn on by default in the future much as we changed the default with
detecting renames?).  Each of those is a small worry, but they add up.

A command meant for data serialization, such as fast-export, seems like
a better candidate for this job.  There's just one missing item: in
order to connect blob sizes to filenames, I need fast-export to tell me
the blob sha1sum of any file changes.  It does this for modifies, but
not always for renames.  In particular, if a file is a 100% rename, it
only prints
    R oldname newname
instead of
    R oldname newname
    M 100644 $SHA1 newname
as occurs when there is a rename+modify.  Add an option which allows us
to force the latter output even when commits have exact renames of
files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 11 ++++++++++
 builtin/fast-export.c             |  7 +++++-
 t/t9350-fast-export.sh            | 36 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 64c01ba918..b663b6f8af 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -129,6 +129,17 @@ marks the same across runs.
 	for intermediary filters (e.g. for rewriting commit messages
 	which refer to older commits, or for stripping blobs by id).
 
+--always-show-modify-after-rename::
+	When a rename is detected, fast-export normally issues both a
+	'R' (rename) and a 'M' (modify) directive.  However, if the
+	contents of the old and new filename match exactly, it will
+	only issue the rename directive.  Use this flag to have it
+	always issue the modify directive after the rename, which may
+	be useful for tools which are using the fast-export stream as
+	a mechanism for gathering statistics about a repository.  Note
+	that this option only has effect when rename detection is
+	active (see the -M option).
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0f794811e..31ad43077a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static int reference_excluded_commits;
+static int always_show_modify_after_rename;
 static int show_original_ids;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
@@ -407,7 +408,8 @@ static void show_filemodify(struct diff_queue_struct *q,
 				putchar('\n');
 
 				if (oideq(&ospec->oid, &spec->oid) &&
-				    ospec->mode == spec->mode)
+				    ospec->mode == spec->mode &&
+				    !always_show_modify_after_rename)
 					break;
 			}
 			/* fallthrough */
@@ -1105,6 +1107,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
 			    N_("Show original sha1sums of blobs/commits")),
+		OPT_BOOL(0, "always-show-modify-after-rename",
+			    &always_show_modify_after_rename,
+			 N_("Always provide 'M' directive after 'R'")),
 
 		OPT_END()
 	};
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..5c20065e39 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -630,4 +630,40 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 	)
 '
 
+test_expect_success 'rename detection and --always-show-modify-after-rename' '
+	test_create_repo renames &&
+	(
+		cd renames &&
+		test_seq 0  9  >single_digit &&
+		test_seq 10 98 >double_digit &&
+		git add . &&
+		git commit -m initial &&
+
+		echo 99 >>double_digit &&
+		git mv single_digit single-digit &&
+		git mv double_digit double-digit &&
+		git add double-digit &&
+		git commit -m renames &&
+
+		# First, check normal fast-export -M output
+		git fast-export -M --no-data master >out &&
+
+		grep double-digit out >out2 &&
+		test_line_count = 2 out2 &&
+
+		grep single-digit out >out2 &&
+		test_line_count = 1 out2 &&
+
+		# Now, test with --always-show-modify-after-rename; should
+		# have an extra "M" directive for "single-digit".
+		git fast-export -M --no-data --always-show-modify-after-rename master >out &&
+
+		grep double-digit out >out2 &&
+		test_line_count = 2 out2 &&
+
+		grep single-digit out >out2 &&
+		test_line_count = 2 out2
+	)
+'
+
 test_done
-- 
2.19.1.1063.g2b8e4a4f82.dirty

