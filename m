From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Mon, 16 Mar 2015 20:56:46 +0700
Message-ID: <1426514206-30949-1-git-send-email-pclouds@gmail.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 14:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXVKC-0007yI-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 14:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbbCPNow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 09:44:52 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33371 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbCPNov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 09:44:51 -0400
Received: by pdnc3 with SMTP id c3so58835832pdn.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4lE85HrV/CwLzB8s/9g98LDa8Op4zVmbg1GOeuXe5Ss=;
        b=QwHLzixNfhsq1EWGR+ROhsxV+X1nrCSY7fSr+2h/X2RY3H9Idks4yTHK6n47Oe/0qI
         g0qx6kt5QSTdqQXs63ZY/5XgdWTtlZbV+Y+qp5JJMmEPEVnFYlBL7dorA/1PGTkE97mQ
         kJS8kQ4qs8KZcVqhYTL6xpa3fPzUfryVRL4XkMmhyH/B4fLSomjQF29aLOUm+RiKHJu9
         0L6GXPNoxfImIMbGQV/5NM7qWBT9M9aO/ydcSmJnP7JaLmhgSaSYAvT9jDayvAaOPVJm
         gvs3fWdty315r7lD3YKBAjTNxD47/jEnem31psmF7U9NPbjovAcD0/xL+5RdU2ukCvua
         i67Q==
X-Received: by 10.66.119.193 with SMTP id kw1mr139644390pab.64.1426513490856;
        Mon, 16 Mar 2015 06:44:50 -0700 (PDT)
Received: from lanh ([115.73.218.182])
        by mx.google.com with ESMTPSA id c9sm17490631pdo.13.2015.03.16.06.44.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 06:44:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 16 Mar 2015 20:57:04 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265558>

Entries added by "git add -N" are reminder for the user so that they
don't forget to add them before committing. These entries appear in
the index even though they are not real. Their presence in the index
leads to a confusing "git status" like this:

    On branch master
    Changes to be committed:
            new file:   foo

    Changes not staged for commit:
            modified:   foo

If you do a "git commit", "foo" will not be included even though
"status" reports it as "to be committed". This patch changes the
output to become

    On branch master
    Changes not staged for commit:
            new file:   foo

    no changes added to commit

The two hunks in diff-lib.c adjust "diff-index" and "diff-files" so
that i-t-a entries appear as new files in diff-files and nothing in
diff-index.

Due to this change, diff-files may start to report "new files" for the
first time. "add -u" needs to be told about this or it will die in
denial, screaming "new files can't exist! Reality is wrong." Luckily,
it's the only one among run_diff_files() callers that needs fixing.

The test "cache-tree invalidates i-t-a paths" is marked failure
because I don't think removing "--cached" from "git diff" is the right
fix. This test relies on "diff --cached" behavior but the behavior now
has changed. We may need to revisit this test at some point in future.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c           |  1 +
 diff-lib.c              | 12 ++++++++++++
 t/t2203-add-intent.sh   | 21 ++++++++++++++++++---
 t/t4011-diff-symlink.sh | 10 ++++++----
 4 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..ee370b0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -63,6 +63,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
+		case DIFF_STATUS_ADDED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
diff --git a/diff-lib.c b/diff-lib.c
index a85c497..714501a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,6 +212,11 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
+			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -376,6 +381,13 @@ static void do_oneway_diff(struct unpack_trees_opt=
ions *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* i-t-a entries do not actually exist in the index */
+	if (idx && (idx->ce_flags & CE_INTENT_TO_ADD)) {
+		idx =3D NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached =3D o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..42827b8 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description=3D'Intent to add'
 . ./test-lib.sh
=20
 test_expect_success 'intent to add' '
+	test_commit 1 &&
+	git rm 1.t &&
+	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif
+	git add elif &&
+	git add -N 1.t
+'
+
+test_expect_success 'git status' '
+	git status --porcelain | grep -v actual >actual &&
+	cat >expect <<-\EOF &&
+	DA 1.t
+	A  elif
+	 A file
+	EOF
+	test_cmp expect actual
 '
=20
 test_expect_success 'check result of "add -N"' '
@@ -43,7 +57,8 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 0 &&
+	test $(git diff --name-only -- nitfol | wc -l) =3D 1
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
@@ -62,7 +77,7 @@ test_expect_success 'can "commit -a" with an i-t-a en=
try' '
 	git commit -a -m all
 '
=20
-test_expect_success 'cache-tree invalidates i-t-a paths' '
+test_expect_failure 'cache-tree invalidates i-t-a paths' '
 	git reset --hard &&
 	mkdir dir &&
 	: >dir/foo &&
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 13e7f62..7452fce 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks with=
 attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config =
by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	index e69de29..d95f3ad 100644
-	Binary files a/file.bin and b/file.bin differ
+	new file mode 100644
+	index 0000000..d95f3ad
+	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	index e69de29..dce41ec 120000
-	--- a/link.bin
+	new file mode 120000
+	index 0000000..dce41ec
+	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
--=20
2.3.0.rc1.137.g477eb31
