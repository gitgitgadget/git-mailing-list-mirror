From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/17] unpack-trees: support unpack trees in narrow repository
Date: Sun,  5 Sep 2010 16:47:35 +1000
Message-ID: <1283669264-15759-9-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92l-00089u-JG
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab0IEGt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37408 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0IEGt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:28 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1040881pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HBa0Sc7pFw625H1KNojM1FkP+uL2m7rr6XSTRGdRKNI=;
        b=QQtb18QyS4uYr/HrYqt5ar7ygCthphne9p7bUbEQaBthIUkTkxNQ7tFBTXE0lgILx7
         CZNKWbL8gOYPsd/4EAla2crLS9A8zgv8AZfzYFpc2nspBHbMO188AyEBlunMIvbE2h4N
         dPSxCLrI8QQxgMJBvp6bTrjZ282n4zbxkZX0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AKIy3KTirAm9TYoS+ThTpMoOwSXvEX7T2uxbLFuQauSqI6HVuRNKtNumBHBneqBMik
         hd2+Q7PJW2qnFrUhcrYtT7WxQXcxgInX6BW+9WdsimT0vfMFsMZa7ztIVc83NEVDpyon
         e9e+8xQGb/UgmfDgwLOB7I2XnlZtTRH7ckgXg=
Received: by 10.114.13.9 with SMTP id 9mr1734587wam.195.1283669367957;
        Sat, 04 Sep 2010 23:49:27 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d38sm8036527wam.8.2010.09.04.23.49.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:26 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:18 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155434>

By definition, narrow repository is incomplete. It does not even have
enough tree for a single commit. So populating a full index is
impossible.

Because of this, unpack_trees() is modified to only unpack trees
specified in $GIT_DIR/narrow, which narrow repo has all needed trees
and blobs. This makes the result index unsuitable for creating commits
(you would have "narrow commits", which are not what anybody
wants). An extra step will be needed to create a proper commit.

On the other hand, because all paths in narrow index are reachable,
and other worktree/index or tree/index operations rely on
unpack_trees() to traverse, which is already narrow-adapted, most
operations will not need modification to work in narrow repositories.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Will probably drop this and the previous patch in favor of Elijah's
 04/15 and 05/15.


 t/t1013-read-tree-narrow.sh |   72 ++++++++++++++++++++++++++++++++++
 unpack-trees.c              |   91 +++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 162 insertions(+), 1 deletions(-)
 create mode 100755 t/t1013-read-tree-narrow.sh

diff --git a/t/t1013-read-tree-narrow.sh b/t/t1013-read-tree-narrow.sh
new file mode 100755
index 0000000..8fa37d9
--- /dev/null
+++ b/t/t1013-read-tree-narrow.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description=3D'read-tree in narrow mode'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	test_commit 1 &&
+	mkdir t1 t2 t1/t12 &&
+	echo 0 >f0 &&
+	echo 10 >t1/f10 &&
+	echo 120 >t1/t12/f120 &&
+	echo 20 >t2/f20
+	git add t1 t2 f0 && git commit -m initial &&
+	HEAD=3D`git rev-parse HEAD` &&
+	git rev-parse HEAD | git pack-objects --revs pack -- t1/t12 &&
+	test_create_repo narrow &&
+	mv pack-* narrow/.git/objects/pack &&
+	cd narrow &&
+	echo $HEAD >.git/refs/heads/master &&
+	echo "ref: refs/heads/master" >.git/HEAD &&
+	echo t1/t12 >.git/narrow
+'
+
+test_expect_failure ls-tree '
+	git ls-tree -r HEAD &&
+	git ls-files --stage >result &&
+	echo "100644 blob 52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4	t1/t12/f12=
0" >expected &&
+	test_cmp expected result
+'
+
+test_expect_success read-tree '
+	git read-tree HEAD &&
+	git ls-files --stage >result &&
+	echo "100644 52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 0	t1/t12/f120" =
>expected &&
+	test_cmp expected result
+'
+
+test_expect_success checkout '
+	git checkout . &&
+	test_cmp ../t1/t12/f120 t1/t12/f120
+'
+
+cat <<EOF >diff.expected
+diff --git a/t1/t12/f120 b/t1/t12/f120
+index 52bd8e4..645fb94 100644
+--- a/t1/t12/f120
++++ b/t1/t12/f120
+@@ -1 +1,2 @@
+ 120
++modified
+EOF
+
+test_expect_success diff '
+	echo modified >>t1/t12/f120 &&
+	git diff >result &&
+	test_cmp diff.expected result
+'
+
+test_expect_success 'diff HEAD' '
+	git diff HEAD >result &&
+	test_cmp diff.expected result
+'
+
+test_expect_success 'diff --cached' '
+	git add -u . &&
+	git diff --cached >result &&
+	test_cmp diff.expected result
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 4889e24..f945e5f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -792,7 +792,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
 	return mask;
 }
=20
-static int unpack_traverse(unsigned len, struct tree_desc *t, struct u=
npack_trees_options *o)
+static int unpack_traverse_1(unsigned len, struct tree_desc *t, struct=
 unpack_trees_options *o)
 {
 	const char *prefix =3D o->prefix ? o->prefix : "";
 	struct traverse_info info;
@@ -826,6 +826,95 @@ static int unpack_traverse(unsigned len, struct tr=
ee_desc *t, struct unpack_tree
 }
=20
 /*
+ * path_to_tree_sha1() does not accept tree_desc, so we need to
+ * process the first tree. path_to_tree_sha1() can then do the rest
+ */
+static int find_tree_desc(struct tree_desc *desc, unsigned char *newsh=
a1, const char *path)
+{
+	struct name_entry entry;
+	const char *slash;
+	int len;
+
+	slash =3D strchr(path, '/');
+	len =3D slash ? slash - path : strlen(path);
+
+	while (tree_entry(desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+		if (!strncmp(entry.path, path, len)) {
+			if (slash)
+				return path_to_tree_sha1(newsha1, entry.sha1, slash+1);
+			else {
+				hashcpy(newsha1, entry.sha1);
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+static int unpack_traverse_narrow(unsigned len, struct tree_desc *t,
+				  struct unpack_trees_options *o,
+				  const char *narrow_prefix)
+{
+	struct tree_desc *t2;
+	char *prefix =3D NULL;
+	const char *old_prefix;
+	void **buf;
+	int i, ret;
+	t2 =3D xmalloc(sizeof(*t2)*len);
+	buf =3D xmalloc(sizeof(*buf)*len);
+	for (i =3D 0; i < len; i++) {
+		unsigned char sha1[20];
+		unsigned long size;
+		enum object_type type;
+
+		if (!find_tree_desc(t+i, sha1, narrow_prefix))
+			return -1;
+		buf[i] =3D read_sha1_file(sha1, &type, &size);
+		if (type !=3D OBJ_TREE)
+			return -1;
+		init_tree_desc(t2+i, buf[i], size);
+	}
+	old_prefix =3D o->prefix;
+	if (!old_prefix)
+		prefix =3D xstrdup(narrow_prefix);
+	else {
+		prefix =3D xmalloc(strlen(narrow_prefix) + strlen(o->prefix)+1);
+		strcpy(prefix, o->prefix);
+		strcat(prefix, narrow_prefix);
+	}
+	o->prefix =3D prefix;
+	ret =3D unpack_traverse_1(len, t2, o);
+	o->prefix =3D old_prefix;
+	for (i =3D 0; i < len; i++)
+		free(buf[i]);
+	free(prefix);
+	free(t2);
+	free(buf);
+	return ret;
+}
+
+static int unpack_traverse(unsigned len, struct tree_desc *t, struct u=
npack_trees_options *o)
+{
+	const char **p =3D get_narrow_prefix();
+
+	if (!len)
+		return 0;
+
+	if (!p)
+		return unpack_traverse_1(len, t, o);
+
+	while (*p) {
+		int ret =3D unpack_traverse_narrow(len, t, o, *p);
+		if (ret)
+			return ret;
+		p++;
+	}
+	return 0;
+}
+
+/*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
  */
--=20
1.7.1.rc1.69.g24c2f7
