From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/32] unpack_trees: only unpack $GIT_DIR/narrow subtree in narrow repository
Date: Wed, 25 Aug 2010 08:20:05 +1000
Message-ID: <1282688422-7738-16-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uJ-00030j-VH
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336Ab0HXWWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab0HXWWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:35 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OV2FT0Z/vB9ylZ3P1AEPp0rrModnM1on2MdLmEjDDoA=;
        b=b1Hyge89P9RIYZOpYp1SbOmFmAH9TEjIrS6LNOuX8oZzlXPeUCK0M8dFoodckzDb5k
         IcfZRQxFpMdMIXvGlrv7iGsJbkKyHZz3IcAzbIFCjEZzZSg83avZ9TCSfPAVgNDtDYO3
         CVx6iv8isSNrS5SYHACfGJk2M+FM5nw/+yZ0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dcoGMLX34m+48JESDqUfBd4yzng4mfIN6Mxt1l4oF4lvHtwBPEABZHXQe7r5Q37pMx
         HyEhKvDrKYoNYw7MtnQIWI/Lr339mR3B9Ca39r9L6kdvQ/po99Dp45cE+YRfBh5Xisyy
         1MCaCYa2goWAY4fb2UdZYkn9TBUcBjuAh6hGk=
Received: by 10.115.16.2 with SMTP id t2mr8435964wai.211.1282688555566;
        Tue, 24 Aug 2010 15:22:35 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c24sm950773wam.7.2010.08.24.15.22.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:29 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154360>

By definition, narrow repository is incomplete. It does not even have
enough tree for a single commit. So populating a full index is
impossible.

Because of this, unpack_trees() is modified to only unpack trees
within $GIT_DIR/narrow, which narrow repo has all needed trees. This
makes the resulting index unsuitable for creating commits later on.
This is the reason index version is increased to 4, to avoid older
git from using it.

The resulting tree objects created from the index is only part of the
full tree. Manipulation will be needed at commit time to create proper
tree for commits.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1013-read-tree-narrow.sh |   72 +++++++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.c              |   70 +++++++++++++++++++++++++++++++++++=
++++++-
 2 files changed, 141 insertions(+), 1 deletions(-)
 create mode 100755 t/t1013-read-tree-narrow.sh

diff --git a/t/t1013-read-tree-narrow.sh b/t/t1013-read-tree-narrow.sh
new file mode 100755
index 0000000..1921985
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
+	echo 0 > f0 &&
+	echo 10 > t1/f10 &&
+	echo 120 > t1/t12/f120 &&
+	echo 20 > t2/f20
+	git add t1 t2 f0 && git commit -m initial &&
+	HEAD=3D`git rev-parse HEAD` &&
+	git rev-parse HEAD | git pack-objects --revs --narrow-tree=3Dt1/t12 p=
ack &&
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
+	echo modified >> t1/t12/f120 &&
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
index f561d88..661fcb7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -713,7 +713,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
  */
-int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_tree=
s_options *o)
+static int unpack_trees_1(unsigned len, struct tree_desc *t, struct un=
pack_trees_options *o)
 {
 	int i, ret;
 	static struct cache_entry *dfc;
@@ -839,6 +839,74 @@ return_failed:
 	goto done;
 }
=20
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
+				return find_tree(entry.sha1, newsha1, slash+1);
+			else {
+				hashcpy(newsha1, entry.sha1);
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_tree=
s_options *o)
+{
+	if (!get_narrow_prefix())
+		return unpack_trees_1(len, t, o);
+	else {
+		struct tree_desc *t2;
+		struct unpack_trees_options o2;
+		char *prefix =3D NULL;
+		void **buf;
+		int i, ret;
+		t2 =3D xmalloc(sizeof(*t2)*len);
+		buf =3D xmalloc(sizeof(*buf)*len);
+		for (i =3D 0; i < len; i++) {
+			unsigned char sha1[20];
+			unsigned long size;
+			enum object_type type;
+
+			if (!find_tree_desc(t+i, sha1, get_narrow_prefix()))
+				return -1;
+			buf[i] =3D read_sha1_file(sha1, &type, &size);
+			if (type !=3D OBJ_TREE)
+				return -1;
+			init_tree_desc(t2+i, buf[i], size);
+		}
+		o2 =3D *o;
+		if (!o->prefix)
+			o2.prefix =3D xstrdup(get_narrow_prefix());
+		else {
+			prefix =3D xmalloc(strlen(get_narrow_prefix()) + strlen(o->prefix)+=
1);
+			strcpy(prefix, o->prefix);
+			strcat(prefix, get_narrow_prefix());
+			o2.prefix =3D prefix;
+		}
+		ret =3D unpack_trees_1(len, t2, &o2);
+		for (i =3D 0; i < len; i++) {
+			free(buf[i]);
+		}
+		free(prefix);
+		free(t2);
+		free(buf);
+		return ret;
+	}
+}
+
 /* Here come the merge functions */
=20
 static int reject_merge(struct cache_entry *ce, struct unpack_trees_op=
tions *o)
--=20
1.7.1.rc1.69.g24c2f7
