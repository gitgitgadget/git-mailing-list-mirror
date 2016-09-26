Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_CHARSET_FARAWAY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33BE209A9
	for <e@80x24.org>; Mon, 26 Sep 2016 19:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966611AbcIZTdC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:33:02 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57472 "EHLO
        homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966506AbcIZTc7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 15:32:59 -0400
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id 3AA6D60407C;
        Mon, 26 Sep 2016 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=novalis.org; bh=bwiAT
        /7WTpvSu2gSWnuzG/YtW3c=; b=kHl6CitL1O3dCDZ2PbiBdQu2oHHiy2/Eas8yW
        aQvdwd/OhASUaAeB3Y9rjvHxzDzjnx5ftT7zorrf+2STLKrk2T8aORAFRTTfOYeg
        YrQlg7N71keBMAAKhQhzrhUGU8IGZLQDL+P9KNhL3MOWIK63YR6J1ExpMN7uIqZe
        AcoGYQ=
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id 9FFB8604061;
        Mon, 26 Sep 2016 12:32:58 -0700 (PDT)
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 2/2] fsck: handle bad trees like other errors
Date:   Mon, 26 Sep 2016 15:32:45 -0400
Message-Id: <1474918365-10937-3-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <1474918365-10937-1-git-send-email-novalis@novalis.org>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twosigma.com>

Instead of dying when fsck hits a malformed tree object, log the error
like any other and continue.  Now fsck can tell the user which tree is
bad, too.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 fsck.c                                             |  18 +++--
 t/t1450-fsck.sh                                    |  17 ++++-
 .../307e300745b82417cc1a903f875c7d22e45ef907       |   4 +
 .../f506a346749bb96f52d8605ffba9fb93d46b5ffd       | Bin 0 -> 45 bytes
 tree-walk.c                                        |  83 +++++++++++++++=
+++---
 tree-walk.h                                        |   8 ++
 6 files changed, 111 insertions(+), 19 deletions(-)
 create mode 100644 t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e=
45ef907
 create mode 100644 t/t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d=
46b5ffd

diff --git a/fsck.c b/fsck.c
index c9cf3de..4a3069e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -347,8 +347,9 @@ static int fsck_walk_tree(struct tree *tree, void *da=
ta, struct fsck_options *op
 		return -1;
=20
 	name =3D get_object_name(options, &tree->object);
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	while (tree_entry(&desc, &entry)) {
+	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+		return -1;
+	while (tree_entry_gently(&desc, &entry)) {
 		struct object *obj;
 		int result;
=20
@@ -520,7 +521,7 @@ static int verify_ordered(unsigned mode1, const char =
*name1, unsigned mode2, con
=20
 static int fsck_tree(struct tree *item, struct fsck_options *options)
 {
-	int retval;
+	int retval =3D 0;
 	int has_null_sha1 =3D 0;
 	int has_full_path =3D 0;
 	int has_empty_name =3D 0;
@@ -535,7 +536,10 @@ static int fsck_tree(struct tree *item, struct fsck_=
options *options)
 	unsigned o_mode;
 	const char *o_name;
=20
-	init_tree_desc(&desc, item->buffer, item->size);
+	if (init_tree_desc_gently(&desc, item->buffer, item->size)) {
+		retval +=3D report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot =
be parsed as a tree");
+		return retval;
+	}
=20
 	o_mode =3D 0;
 	o_name =3D NULL;
@@ -556,7 +560,10 @@ static int fsck_tree(struct tree *item, struct fsck_=
options *options)
 			       is_hfs_dotgit(name) ||
 			       is_ntfs_dotgit(name));
 		has_zero_pad |=3D *(char *)desc.buffer =3D=3D '0';
-		update_tree_entry(&desc);
+		if (update_tree_entry_gently(&desc)) {
+			retval +=3D report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot=
 be parsed as a tree");
+			break;
+		}
=20
 		switch (mode) {
 		/*
@@ -597,7 +604,6 @@ static int fsck_tree(struct tree *item, struct fsck_o=
ptions *options)
 		o_name =3D name;
 	}
=20
-	retval =3D 0;
 	if (has_null_sha1)
 		retval +=3D report(options, &item->object, FSCK_MSG_NULL_SHA1, "contai=
ns entries pointing to null sha1");
 	if (has_full_path)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8f52da2..f456963 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -188,8 +188,7 @@ test_expect_success 'commit with NUL in header' '
 	grep "error in commit $new.*unterminated header: NUL at offset" out
 '
=20
-test_expect_success 'malformatted tree object' '
-	test_when_finished "git update-ref -d refs/tags/wrong" &&
+test_expect_success 'tree object with duplicate entries' '
 	test_when_finished "remove_object \$T" &&
 	T=3D$(
 		GIT_INDEX_FILE=3Dtest-index &&
@@ -208,6 +207,20 @@ test_expect_success 'malformatted tree object' '
 	grep "error in tree .*contains duplicate file entries" out
 '
=20
+test_expect_success 'unparseable tree object' '
+	test_when_finished "git update-ref -d refs/heads/wrong" &&
+	test_when_finished "remove_object 307e300745b82417cc1a903f875c7d22e45ef=
907" &&
+	test_when_finished "remove_object f506a346749bb96f52d8605ffba9fb93d46b5=
ffd" &&
+	mkdir -p .git/objects/30 mkdir -p .git/objects/f5 &&
+	cp ../t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907 .git/o=
bjects/30/7e300745b82417cc1a903f875c7d22e45ef907 &&
+	cp ../t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d46b5ffd .git/o=
bjects/f5/06a346749bb96f52d8605ffba9fb93d46b5ffd &&
+	git update-ref refs/heads/wrong 307e300745b82417cc1a903f875c7d22e45ef90=
7 &&
+	test_must_fail git fsck 2>out &&
+	grep "warning: empty filename in tree entry" out &&
+	grep "f506a346749bb96f52d8605ffba9fb93d46b5ffd" out &&
+	! grep "fatal: empty filename in tree entry" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
diff --git a/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907=
 b/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907
new file mode 100644
index 0000000..6e23d62
--- /dev/null
+++ b/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907
@@ -0,0 +1,4 @@
+x=01=9D=8EA=0E=C2 =10E]s=8A=B9=80f=B0@=9D=C4=18=17=1E=C1=0B0=05Z=12[=12
+=F5=FA=A2=E9	\=FD=FC=C5{=FF=0Fi=9Ec=01I=F2P=B2=F7=104=1A=DB)=D3+b&=13=F4=
=D9]=0C=EA=10=D8R`=EA=9C2=DC=9A=13=B6=96)ex=D8-:x=D6=BC=F8=0C=D7%m=F6=15=D7=
=FB=9E=A7=94=C7=1BH=D5d=12{-=E1=88
+Q=0C=BF=CD=D2=80=7F=E8=1D=87w,=13p=1A=EB
+=DF=E7=E2=03&=EB?=DE
\ No newline at end of file
diff --git a/t/t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d46b5ffd=
 b/t/t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d46b5ffd
new file mode 100644
index 0000000000000000000000000000000000000000..9111a7fc3c8578906e13c930a=
0fbd3cae047762e
GIT binary patch
literal 45
zcmb=3DJqpj)X8)~pA!NA18z}PS_p~CF@#W%j<>n*Fxv)5_&?<#!Z>Hoon;loq@NdS%f
B6F2|>

literal 0
HcmV?d00001

diff --git a/tree-walk.c b/tree-walk.c
index ba544cf..0fb830b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -22,33 +22,60 @@ static const char *get_mode(const char *str, unsigned=
 int *modep)
 	return str;
 }
=20
-static void decode_tree_entry(struct tree_desc *desc, const char *buf, u=
nsigned long size)
+static int decode_tree_entry(struct tree_desc *desc, const char *buf, un=
signed long size, struct strbuf *err)
 {
 	const char *path;
 	unsigned int mode, len;
=20
-	if (size < 23 || buf[size - 21])
-		die("too-short tree object");
+	if (size < 23 || buf[size - 21]) {
+		strbuf_addstr(err, "too-short tree object");
+		return -1;
+	}
=20
 	path =3D get_mode(buf, &mode);
-	if (!path)
-		die("malformed mode in tree entry for tree");
-	if (!*path)
-		die("empty filename in tree entry for tree");
+	if (!path) {
+		strbuf_addstr(err, "malformed mode in tree entry");
+		return -1;
+	}
+	if (!*path) {
+		strbuf_addstr(err, "empty filename in tree entry");
+		return -1;
+	}
 	len =3D strlen(path) + 1;
=20
 	/* Initialize the descriptor entry */
 	desc->entry.path =3D path;
 	desc->entry.mode =3D canon_mode(mode);
 	desc->entry.oid  =3D (const struct object_id *)(path + len);
+
+	return 0;
 }
=20
-void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned=
 long size)
+static int init_tree_desc_internal(struct tree_desc *desc, const void *b=
uffer, unsigned long size, struct strbuf *err)
 {
 	desc->buffer =3D buffer;
 	desc->size =3D size;
 	if (size)
-		decode_tree_entry(desc, buffer, size);
+		return decode_tree_entry(desc, buffer, size, err);
+	return 0;
+}
+
+void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned=
 long size)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	if (init_tree_desc_internal(desc, buffer, size, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
+}
+
+int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, un=
signed long size)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	int result =3D init_tree_desc_internal(desc, buffer, size, &err);
+	if (result)
+		warning("%s", err.buf);
+	strbuf_release(&err);
+	return result;
 }
=20
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *=
sha1)
@@ -75,7 +102,7 @@ static void entry_extract(struct tree_desc *t, struct =
name_entry *a)
 	*a =3D t->entry;
 }
=20
-void update_tree_entry(struct tree_desc *desc)
+static int update_tree_entry_internal(struct tree_desc *desc, struct str=
buf *err)
 {
 	const void *buf =3D desc->buffer;
 	const unsigned char *end =3D desc->entry.oid->hash + 20;
@@ -89,7 +116,30 @@ void update_tree_entry(struct tree_desc *desc)
 	desc->buffer =3D buf;
 	desc->size =3D size;
 	if (size)
-		decode_tree_entry(desc, buf, size);
+		return decode_tree_entry(desc, buf, size, err);
+	return 0;
+}
+
+void update_tree_entry(struct tree_desc *desc)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	if (update_tree_entry_internal(desc, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
+}
+
+int update_tree_entry_gently(struct tree_desc *desc)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	if (update_tree_entry_internal(desc, &err)) {
+		warning("%s", err.buf);
+		strbuf_release(&err);
+		/* Stop processing this tree after error */
+		desc->size =3D 0;
+		return -1;
+	}
+	strbuf_release(&err);
+	return 0;
 }
=20
 int tree_entry(struct tree_desc *desc, struct name_entry *entry)
@@ -102,6 +152,17 @@ int tree_entry(struct tree_desc *desc, struct name_e=
ntry *entry)
 	return 1;
 }
=20
+int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
+{
+	if (!desc->size)
+		return 0;
+
+	*entry =3D desc->entry;
+	if (update_tree_entry_gently(desc))
+		return 0;
+	return 1;
+}
+
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	int pathlen =3D strlen(base);
diff --git a/tree-walk.h b/tree-walk.h
index 97a7d69..68bb78b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -25,14 +25,22 @@ static inline int tree_entry_len(const struct name_en=
try *ne)
 	return (const char *)ne->oid - ne->path - 1;
 }
=20
+/*
+ * The _gently versions of these functions warn and return false on a
+ * corrupt tree entry rather than dying,
+ */
+
 void update_tree_entry(struct tree_desc *);
+int update_tree_entry_gently(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned lo=
ng size);
+int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsig=
ned long size);
=20
 /*
  * Helper function that does both tree_entry_extract() and update_tree_e=
ntry()
  * and returns true for success
  */
 int tree_entry(struct tree_desc *, struct name_entry *);
+int tree_entry_gently(struct tree_desc *, struct name_entry *);
=20
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *=
sha1);
=20
--=20
2.8.0.rc4.22.g8ae061a

