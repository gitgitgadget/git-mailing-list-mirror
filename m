Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980C2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbeHGA7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:59:04 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44018 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732898AbeHGA7E (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:59:04 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76MgrwQ032164;
        Mon, 6 Aug 2018 15:47:48 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kn91kc2e3-1;
        Mon, 06 Aug 2018 15:47:47 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C5FAF228A033;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id BDF4F2CDE73;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 3/3] merge-recursive: provide more conflict hints for non-textual conflicts
Date:   Mon,  6 Aug 2018 15:47:45 -0700
Message-Id: <20180806224745.8681-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g44d6daf40a.dirty
In-Reply-To: <20180806224745.8681-1-newren@gmail.com>
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224745.8681-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=12 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For non-textual conflicts, provide additional information in the working
copy in the form of additional conflict markers and explanatory text
stating what type of non-textual conflict was involved.  In particular,
regular files involved in path-based conflicts would have something like
the following at the beginning of the file:

    <<<<<<<< HEAD
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
    =3D=3D=3D=3D=3D=3D=3D=3D
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
    >>>>>>>> BRANCH

When non regular files (binaries, symlinks, etc.) are involved in
conflicts, we instead put this information in a separate file that only
contains this conflict information.

The goals of providing this extra information are:
  * Make it clearer to users what conflicts they are dealing with and why
  * Enable new features like Thomas Rast' old remerge-diff proposal[1]

[1] https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 133 +++++++++++++++++++++++++++-
 t/t3031-merge-criscross.sh          |   2 +
 t/t6022-merge-rename.sh             |  39 ++------
 t/t6043-merge-rename-directories.sh |   4 +-
 t/t7610-mergetool.sh                |   4 +
 5 files changed, 144 insertions(+), 38 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4832234073..cdfe9824d2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -313,6 +313,96 @@ static void output_commit_title(struct merge_options=
 *o, struct commit *commit)
 	flush_output(o);
 }
=20
+static void write_conflict_notice(struct strbuf *buf,
+				  struct strbuf *notice,
+				  int use_crlf)
+{
+	int marker_size =3D 8;
+
+	strbuf_addchars(buf, '<', marker_size);
+	if (use_crlf)
+		strbuf_addch(buf, '\r');
+	strbuf_addch(buf, '\n');
+
+	strbuf_addbuf(buf, notice);
+	if (use_crlf)
+		strbuf_addch(buf, '\r');
+	strbuf_addch(buf, '\n');
+
+	strbuf_addchars(buf, '=3D', marker_size);
+	if (use_crlf)
+		strbuf_addch(buf, '\r');
+	strbuf_addch(buf, '\n');
+
+	strbuf_addbuf(buf, notice);
+	if (use_crlf)
+		strbuf_addch(buf, '\r');
+	strbuf_addch(buf, '\n');
+
+	strbuf_addchars(buf, '>', marker_size);
+	if (use_crlf)
+		strbuf_addch(buf, '\r');
+	strbuf_addch(buf, '\n');
+}
+
+static int create_non_textual_conflict_file(struct merge_options *o,
+					    struct strbuf *notice,
+					    const char *path,
+					    struct object_id *oid)
+{
+	struct strbuf contents =3D STRBUF_INIT;
+	int ret =3D 0;
+	int use_crlf =3D 0; /* FIXME: Determine platform default?? */
+
+	write_conflict_notice(&contents, notice, use_crlf);
+
+	if (write_object_file(contents.buf, contents.len, "blob", oid))
+		ret =3D err(o, _("Unable to add %s to database"), path);
+
+	strbuf_release(&contents);
+	return ret;
+}
+
+static int insert_non_textual_conflict_header(struct merge_options *o,
+					      struct strbuf *notice,
+					      const char *path,
+					      struct object_id *oid,
+					      unsigned int mode)
+{
+	struct strbuf header =3D STRBUF_INIT;
+	struct strbuf dst_buf =3D STRBUF_INIT;
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	char *end;
+	int use_crlf;
+	int ret =3D 0;
+
+	if (!S_ISREG(mode))
+		BUG("insert_non_textual_conflict_header called on file with wrong mode=
: %0d", mode);
+
+	buf =3D read_object_file(oid, &type, &size);
+	if (!buf)
+		return err(o, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
+	if (type !=3D OBJ_BLOB) {
+		return err(o, _("blob expected for %s '%s'"), oid_to_hex(oid), path);
+	}
+
+	end =3D strchrnul(buf, '\n');
+	use_crlf =3D (end > buf && end[-1] =3D=3D '\r');
+	write_conflict_notice(&header, notice, use_crlf);
+
+	strbuf_addbuf(&dst_buf, &header);
+	strbuf_add(&dst_buf, buf, size);
+
+	if (write_object_file(dst_buf.buf, dst_buf.len, type_name(type), oid))
+		ret =3D err(o, _("Unable to add %s to database"), path);
+
+	strbuf_release(&header);
+	strbuf_release(&dst_buf);
+	return ret;
+}
+
 static int add_cacheinfo(struct merge_options *o,
 			 unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage, int refresh, int options)
@@ -1464,6 +1554,9 @@ static int handle_change_delete(struct merge_option=
s *o,
 {
 	char *alt_path =3D NULL;
 	const char *update_path =3D path;
+	struct object_id new_oid;
+	struct strbuf sb =3D STRBUF_INIT;
+	int is_binary;
 	int ret =3D 0;
=20
 	if (dir_in_way(path, !o->call_depth && !S_ISGITLINK(changed_mode), 0) |=
|
@@ -1527,8 +1620,44 @@ static int handle_change_delete(struct merge_optio=
ns *o,
 		 * path.  We could call update_file_flags() with update_cache=3D0
 		 * and update_wd=3D0, but that's a no-op.
 		 */
-		if (change_branch !=3D o->branch1 || alt_path)
-			ret =3D update_file(o, 0, changed_oid, changed_mode, update_path);
+		oidcpy(&new_oid, changed_oid);
+		strbuf_addf(&sb, _("CONFLICT (%s/delete): %s deleted in %s and %s in %=
s."),
+			    change, path, delete_branch, change_past, change_branch);
+		 /*
+		  * FIXME: figure out if update_path's contents are binary;
+		  * buffer_is_binary() may help, though in the case of e.g.
+		  * add/add conflicts it'd be nice to avoid calling that
+		  * multiple times per buffer.
+		  */
+		is_binary =3D 0;
+		if (S_ISREG(changed_mode) && !is_binary) {
+			insert_non_textual_conflict_header(
+			    o,
+			    &sb,
+			    update_path,
+			    &new_oid,
+			    changed_mode);
+			ret =3D update_file_flags(o, &new_oid, changed_mode,
+						update_path,
+						/* update_cache */ 0,
+						/* update_wd */    1);
+		} else {
+			struct diff_filespec conflict_file;
+			char *conflict_path;
+			conflict_path =3D unique_path(o, update_path, "conflicts");
+
+			conflict_file.mode =3D S_IFREG | 0644;
+			create_non_textual_conflict_file(o, &sb, conflict_path,
+							 &conflict_file.oid);
+			ret =3D update_file_flags(o, &conflict_file.oid,
+						conflict_file.mode,
+						conflict_path,
+						/* update_cache */ 0,
+						/* update_wd */    1);
+			ret |=3D update_stages(o, conflict_path, &conflict_file,
+					     NULL, NULL);
+			free(conflict_path);
+		}
 	}
 	free(alt_path);
=20
diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
index e59b0a32d6..5c39339809 100755
--- a/t/t3031-merge-criscross.sh
+++ b/t/t3031-merge-criscross.sh
@@ -75,6 +75,7 @@ test_expect_success 'setup repo with criss-cross histor=
y' '
 	git checkout B &&
 	test_must_fail git merge E &&
 	# force-resolve
+	echo 9 >data/new-9 &&
 	git add data &&
 	git commit -m F &&
 	git branch F &&
@@ -83,6 +84,7 @@ test_expect_success 'setup repo with criss-cross histor=
y' '
 	git checkout C &&
 	test_must_fail git merge D &&
 	# force-resolve
+	echo 9 >data/new-9 &&
 	git add data &&
 	git commit -m G &&
 	git branch G
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b760c223c6..a065d79049 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -467,7 +467,7 @@ test_expect_success 'both rename source and destinati=
on involved in D/F conflict
 	test -f destdir/foo &&
 	test -f one &&
 	test -f destdir~HEAD &&
-	test "stuff" =3D "$(cat destdir~HEAD)"
+	grep "stuff" destdir~HEAD
 '
=20
 test_expect_success 'setup pair rename to parent of other (D/F conflicts=
)' '
@@ -510,8 +510,8 @@ test_expect_success 'pair rename to parent of other (=
D/F conflicts) w/ untracked
 	test -d one &&
 	test -f one~rename-two &&
 	test -f two &&
-	test "other" =3D $(cat one~rename-two) &&
-	test "stuff" =3D $(cat two)
+	grep "other" one~rename-two &&
+	grep "stuff" two
 '
=20
 test_expect_success 'pair rename to parent of other (D/F conflicts) w/ c=
lean start' '
@@ -529,8 +529,8 @@ test_expect_success 'pair rename to parent of other (=
D/F conflicts) w/ clean sta
=20
 	test -f one &&
 	test -f two &&
-	test "other" =3D $(cat one) &&
-	test "stuff" =3D $(cat two)
+	grep "other" one &&
+	grep "stuff" two
 '
=20
 test_expect_success 'setup rename of one file to two, with directories i=
n the way' '
@@ -704,35 +704,6 @@ test_expect_success 'avoid unnecessary update, dir->=
(file,nothing)' '
 	test_cmp expect actual # "df" should have stayed intact
 '
=20
-test_expect_success 'setup avoid unnecessary update, modify/delete' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	>irrelevant &&
-	>file &&
-	git add -A &&
-	git commit -mA &&
-
-	git checkout -b side &&
-	git rm -f file &&
-	git commit -m "Delete file" &&
-
-	git checkout master &&
-	echo bla >file &&
-	git add -A &&
-	git commit -m "Modify file"
-'
-
-test_expect_success 'avoid unnecessary update, modify/delete' '
-	git checkout -q master^0 &&
-	test-tool chmtime --get =3D1000000000 file >expect &&
-	test_must_fail git merge side &&
-	test-tool chmtime --get file >actual &&
-	test_cmp expect actual # "file" should have stayed intact
-'
-
 test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 	git rm -rf . &&
 	git clean -fdqx &&
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 4a71f17edd..c5e1874df1 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1908,8 +1908,8 @@ test_expect_success '7e-check: transitive rename in=
 rename/delete AND dirs in th
 			 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d &&
 		test_cmp expect actual &&
=20
-		git hash-object y/d~B^0 >actual &&
-		git rev-parse O:x/d >expect &&
+		tail -n +6 y/d~B^0 >actual &&
+		git cat-file -p O:x/d >expect &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 047156e9d5..10c0c903c6 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -374,6 +374,7 @@ test_expect_success 'deleted vs modified submodule' '
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
+	( yes "d" | git mergetool submod~conflicts ) &&
 	rmdir submod && mv submod-movedaside submod &&
 	test "$(cat submod/bar)" =3D "branch1 submodule" &&
 	git submodule update -N &&
@@ -391,6 +392,7 @@ test_expect_success 'deleted vs modified submodule' '
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
+	( yes "d" | git mergetool submod~conflicts ) &&
 	test ! -e submod &&
 	output=3D"$(git mergetool --no-prompt)" &&
 	test "$output" =3D "No files need merging" &&
@@ -405,6 +407,7 @@ test_expect_success 'deleted vs modified submodule' '
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
+	( yes "d" | git mergetool submod~conflicts ) &&
 	test ! -e submod &&
 	test -d submod.orig &&
 	git submodule update -N &&
@@ -421,6 +424,7 @@ test_expect_success 'deleted vs modified submodule' '
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
+	( yes "d" | git mergetool submod~conflicts ) &&
 	test "$(cat submod/bar)" =3D "master submodule" &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" =3D "master submodule" &&
--=20
2.18.0.550.g44d6daf40a.dirty

