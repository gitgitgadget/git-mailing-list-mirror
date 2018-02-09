Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C181F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeBIXOP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:14:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47474 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753073AbeBIXOP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Feb 2018 18:14:15 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19NDcdI002220;
        Fri, 9 Feb 2018 15:13:38 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2fwbtpshbj-1;
        Fri, 09 Feb 2018 15:13:37 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 96C912244D06;
        Fri,  9 Feb 2018 15:13:37 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id C67492CDEF0;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/3] fsck: Check HEAD of other worktrees as well
Date:   Fri,  9 Feb 2018 15:13:30 -0800
Message-Id: <20180209231330.4457-4-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.75.gc01c8fdd7d
In-Reply-To: <20180209231330.4457-1-newren@gmail.com>
References: <20180209231330.4457-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802090293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This takes advantage of the fact that "worktrees/$WORKTREE/HEAD" will
currently resolve as a ref, which may not be true in the future with
different ref backends.  I don't think it locks us in to supporting
resolving other worktree HEADs with this syntax, as I view the
user-visible error message as more of a pointer to a pathname that the
user will need to fix.  If the underlying ref storage changes, naturally
both this code and the hint may need to change to match.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fsck.c  | 60 +++++++++++++++++++++++++++++++++++++++++++++------=
------
 t/t1450-fsck.sh |  6 +++---
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4132034170..850b217e93 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -451,17 +451,51 @@ static int fsck_handle_ref(const char *refname, con=
st struct object_id *oid,
 	return 0;
 }
=20
-static int fsck_head_link(const char **head_points_at,
+static void get_worktree_names(struct string_list *names)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	dir =3D opendir(path.buf);
+	strbuf_release(&path);
+	if (dir) {
+		while ((d =3D readdir(dir)) !=3D NULL) {
+			if (!is_dot_or_dotdot(d->d_name))
+				string_list_append(names, d->d_name);
+		}
+		closedir(dir);
+	}
+}
+
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid);
=20
 static void get_default_heads(void)
 {
 	const char *head_points_at;
 	struct object_id head_oid;
+	struct string_list worktree_names =3D STRING_LIST_INIT_DUP;
+	struct string_list_item *worktree_item;
+	struct strbuf head_name =3D STRBUF_INIT;
=20
-	fsck_head_link(&head_points_at, &head_oid);
+	fsck_head_link("HEAD", &head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
+
+	get_worktree_names(&worktree_names);
+	for_each_string_list_item(worktree_item, &worktree_names) {
+		strbuf_reset(&head_name);
+		strbuf_addf(&head_name, "worktrees/%s/HEAD",
+			    worktree_item->string);
+		fsck_head_link(head_name.buf, &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid))
+			fsck_handle_ref(head_name.buf, &head_oid, 0, NULL);
+	}
+	strbuf_release(&head_name);
+
 	for_each_rawref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
@@ -553,34 +587,36 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
=20
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid)
 {
 	int null_is_error =3D 0;
=20
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf(stderr, "Checking %s link\n", head_ref_name);
=20
-	*head_points_at =3D resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	*head_points_at =3D resolve_ref_unsafe(head_ref_name, 0, head_oid, NULL=
);
 	if (!*head_points_at) {
 		errors_found |=3D ERROR_REFS;
-		return error("Invalid HEAD");
+		return error("Invalid %s", head_ref_name);
 	}
-	if (!strcmp(*head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, head_ref_name))
 		/* detached HEAD */
 		null_is_error =3D 1;
 	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |=3D ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
-			     *head_points_at);
+		return error("%s points to something strange (%s)",
+			     head_ref_name, *head_points_at);
 	}
 	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |=3D ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error("%s: detached HEAD points at nothing",
+				     head_ref_name);
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			*head_points_at + 11);
+		fprintf(stderr, "notice: %s points to an unborn branch (%s)\n",
+			head_ref_name, *head_points_at + 11);
 	}
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index fa94c59458..3da651be4c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -102,7 +102,7 @@ test_expect_success 'HEAD link pointing at a funny pl=
ace' '
 	grep "HEAD points to something strange" out
 '
=20
-test_expect_failure 'other worktree HEAD link pointing at a funny object=
' '
+test_expect_success 'other worktree HEAD link pointing at a funny object=
' '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo 0000000000000000000000000000000000000000 >.git/worktrees/other/HEA=
D &&
@@ -111,7 +111,7 @@ test_expect_failure 'other worktree HEAD link pointin=
g at a funny object' '
 	grep "worktrees/other/HEAD: detached HEAD points" out
 '
=20
-test_expect_failure 'other worktree HEAD link pointing at missing object=
' '
+test_expect_success 'other worktree HEAD link pointing at missing object=
' '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo "Contents missing from repo" | git hash-object --stdin >.git/workt=
rees/other/HEAD &&
@@ -120,7 +120,7 @@ test_expect_failure 'other worktree HEAD link pointin=
g at missing object' '
 	grep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
=20
-test_expect_failure 'other worktree HEAD link pointing at a funny place'=
 '
+test_expect_success 'other worktree HEAD link pointing at a funny place'=
 '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
--=20
2.16.1.75.gc01c8fdd7d

