Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEC91F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbeKPSLl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:41 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52924 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbeKPSLb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:31 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wIJN032736;
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ns2ddsqtp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:01 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 15 Nov 2018 23:59:58 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 15 Nov 2018 23:59:58 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 8C2DC221228E;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 11/11] fast-export: add a --show-original-ids option to show original names
Date:   Thu, 15 Nov 2018 23:59:56 -0800
Message-ID: <20181116075956.27047-12-newren@gmail.com>
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

Knowing the original names (hashes) of commits can sometimes enable
post-filtering that would otherwise be difficult or impossible.  In
particular, the desire to rewrite commit messages which refer to other
prior commits (on top of whatever other filtering is being done) is
very difficult without knowing the original names of each commit.

In addition, knowing the original names (hashes) of blobs can allow
filtering by blob-id without requiring re-hashing the content of the
blob, and is thus useful as a small optimization.

Once we add original ids for both commits and blobs, we may as well
add them for tags too for completeness.  Perhaps someone will have a
use for them.

This commit teaches a new --show-original-ids option to fast-export
which will make it add a 'original-oid <hash>' line to blob, commits,
and tags.  It also teaches fast-import to parse (and ignore) such
lines.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt |  7 +++++++
 Documentation/git-fast-import.txt | 16 ++++++++++++++++
 builtin/fast-export.c             | 20 +++++++++++++++-----
 fast-import.c                     | 12 ++++++++++++
 t/t9350-fast-export.sh            | 17 +++++++++++++++++
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index f65026662a..64c01ba918 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -122,6 +122,13 @@ marks the same across runs.
 	repository which already contains the necessary parent
 	commits.
 
+--show-original-ids::
+	Add an extra directive to the output for commits and blobs,
+	`original-oid <SHA1SUM>`.  While such directives will likely be
+	ignored by importers such as git-fast-import, it may be useful
+	for intermediary filters (e.g. for rewriting commit messages
+	which refer to older commits, or for stripping blobs by id).
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 7ab97745a6..43ab3b1637 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -385,6 +385,7 @@ change to the project.
 ....
 	'commit' SP <ref> LF
 	mark?
+	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
@@ -741,6 +742,19 @@ New marks are created automatically.  Existing marks can be moved
 to another object simply by reusing the same `<idnum>` in another
 `mark` command.
 
+`original-oid`
+~~~~~~~~~~~~~~
+Provides the name of the object in the original source control system.
+fast-import will simply ignore this directive, but filter processes
+which operate on and modify the stream before feeding to fast-import
+may have uses for this information
+
+....
+	'original-oid' SP <object-identifier> LF
+....
+
+where `<object-identifer>` is any string not containing LF.
+
 `tag`
 ~~~~~
 Creates an annotated tag referring to a specific commit.  To create
@@ -749,6 +763,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 ....
 	'tag' SP <name> LF
 	'from' SP <commit-ish> LF
+	original-oid?
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
@@ -823,6 +838,7 @@ assigned mark.
 ....
 	'blob' LF
 	mark?
+	original-oid?
 	data
 ....
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78fc67b03a..36c2575de5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static int reference_excluded_commits;
+static int show_original_ids;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
@@ -271,7 +272,10 @@ static void export_blob(const struct object_id *oid)
 
 	mark_next_object(object);
 
-	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\n", last_idnum);
+	if (show_original_ids)
+		printf("original-oid %s\n", oid_to_hex(oid));
+	printf("data %lu\n", size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die_errno("could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
@@ -635,8 +639,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		reencoded = reencode_string(message, "UTF-8", encoding);
 	if (!commit->parents)
 		printf("reset %s\n", refname);
-	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
-	       refname, last_idnum,
+	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
+	if (show_original_ids)
+		printf("original-oid %s\n", oid_to_hex(&commit->object.oid));
+	printf("%.*s\n%.*s\ndata %u\n%s",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
 	       (unsigned)(reencoded
@@ -814,8 +820,10 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
-	       name, tagged_mark,
+	printf("tag %s\nfrom :%d\n", name, tagged_mark);
+	if (show_original_ids)
+		printf("original-oid %s\n", oid_to_hex(&tag->object.oid));
+	printf("%.*s%sdata %d\n%.*s\n",
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
@@ -1096,6 +1104,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
+		OPT_BOOL(0, "show-original-ids", &show_original_ids,
+			    N_("Show original object ids of blobs/commits")),
 
 		OPT_END()
 	};
diff --git a/fast-import.c b/fast-import.c
index 555d49ad23..71b6cba00f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1814,6 +1814,13 @@ static void parse_mark(void)
 		next_mark = 0;
 }
 
+static void parse_original_identifier(void)
+{
+	const char *v;
+	if (skip_prefix(command_buf.buf, "original-oid ", &v))
+		read_next_command();
+}
+
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
 	const char *data;
@@ -1956,6 +1963,7 @@ static void parse_new_blob(void)
 {
 	read_next_command();
 	parse_mark();
+	parse_original_identifier();
 	parse_and_store_blob(&last_blob, NULL, next_mark);
 }
 
@@ -2579,6 +2587,7 @@ static void parse_new_commit(const char *arg)
 
 	read_next_command();
 	parse_mark();
+	parse_original_identifier();
 	if (skip_prefix(command_buf.buf, "author ", &v)) {
 		author = parse_ident(v);
 		read_next_command();
@@ -2711,6 +2720,9 @@ static void parse_new_tag(const char *arg)
 		die("Invalid ref name or SHA1 expression: %s", from);
 	read_next_command();
 
+	/* original-oid ... */
+	parse_original_identifier();
+
 	/* tagger ... */
 	if (skip_prefix(command_buf.buf, "tagger ", &v)) {
 		tagger = parse_ident(v);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d7d73061d0..5690fe2810 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -77,6 +77,23 @@ test_expect_success 'fast-export --reference-excluded-parents master~2..master'
 		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
 '
 
+test_expect_success 'fast-export --show-original-ids' '
+
+	git fast-export --show-original-ids master >output &&
+	grep ^original-oid output| sed -e s/^original-oid.// | sort >actual &&
+	git rev-list --objects master muss >objects-and-names &&
+	awk "{print \$1}" objects-and-names | sort >commits-trees-blobs &&
+	comm -23 actual commits-trees-blobs >unfound &&
+	test_must_be_empty unfound
+'
+
+test_expect_success 'fast-export --show-original-ids | git fast-import' '
+
+	git fast-export --show-original-ids master muss | git fast-import --quiet &&
+	test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	test $MUSS = $(git rev-parse --verify refs/tags/muss)
+'
+
 test_expect_success 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO8859-1 &&
-- 
2.19.1.1063.g1796373474.dirty

