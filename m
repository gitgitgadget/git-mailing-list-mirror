From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/17] commit: add narrow's commit_tree version
Date: Sun,  5 Sep 2010 16:47:40 +1000
Message-ID: <1283669264-15759-14-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93Z-0008TD-7k
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab0IEGuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0IEGuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A766cUVh7HAfkX32t2lxBLaAfxwGuP/YqP2knwRUnvQ=;
        b=O/dFFTvZTn5t00Hb/gwuZkrhsvVkVfpPcsetg3m8tcCNo8ZR9MKjS0RaamU3s4qAQu
         RhFzX8Am96p08gY79BN3yXOz8A68qDvmP9nhMlbnIMdaAG3hlE1KYS3/4T3NAtpnpdf2
         GQ0JD1cceX6V2fvUgTxSg5Crsb7CIms3/VGM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lg5rRexOSg4UuCSWlu0dckLCQX+vlmZdMFyhD2VzY1JSqBiq1trYJgq7DMWQA33qHp
         xg9CdZgoksZua5hBerEzhTawRbduXihgLAv6svTPtCi6MnL4iTmJRBXrtgLG1TPjuqaP
         lOrbIFSKq/8DaxwYt35kOysRBcFuO+qd80jbc=
Received: by 10.114.103.18 with SMTP id a18mr1533511wac.38.1283669415362;
        Sat, 04 Sep 2010 23:50:15 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id k23sm8038856waf.5.2010.09.04.23.50.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:14 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:50:05 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155439>

As stated somewhere, the index in narrow repo is also narrowed. When a
users are done with his changes and about to commit, the new narrow
tree created from index will be grafted back to a base toplevel tree
(usually from parent commit). The result is a new toplevel tree with
user's changes and suitable for commits.

The narrow version uses join_narrow_tree() to recreate a full tree
from a base toplevel tree (typically commit parent's tree) and a tree
created from index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Equivalence to Elijah's 07/15 and 08/15. My way generates some throw a=
way
 trees at write_cache_as_tree(), not good.

 commit.c      |   16 +++++++++
 commit.h      |    5 +++
 narrow-tree.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 narrow-tree.h |    4 ++
 4 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..c7fe7fc 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "narrow-tree.h"
=20
 int save_commit_buffer =3D 1;
=20
@@ -864,3 +865,18 @@ int commit_tree(const char *msg, unsigned char *tr=
ee,
 	strbuf_release(&buffer);
 	return result;
 }
+
+int commit_narrow_tree(const char *msg, unsigned char *tree,
+		       const unsigned char *narrow_base,
+		       struct commit_list *parents, unsigned char *ret,
+		       const char *author)
+{
+	unsigned char sha1[20];
+
+	if (get_narrow_prefix()) {
+		if (join_narrow_tree(sha1, narrow_base, tree, get_narrow_prefix()))
+			die("Failed to join tree");
+		tree =3D sha1;
+	}
+	return commit_tree(msg, tree, parents, ret, author);
+}
diff --git a/commit.h b/commit.h
index 9113bbe..c718439 100644
--- a/commit.h
+++ b/commit.h
@@ -170,5 +170,10 @@ struct commit_list *reduce_heads(struct commit_lis=
t *heads);
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
+extern int commit_narrow_tree(const char *msg, unsigned char *tree,
+			      const unsigned char *narrow_base,
+			      struct commit_list *parents,
+			      unsigned char *ret,
+			      const char *author);
=20
 #endif /* COMMIT_H */
diff --git a/narrow-tree.c b/narrow-tree.c
index 85dbab4..110fac2 100644
--- a/narrow-tree.c
+++ b/narrow-tree.c
@@ -1,4 +1,14 @@
 #include "cache.h"
+#include "commit.h"
+#include "tree.h"
+#include "diff.h"
+#include "revision.h"
+#include "refs.h"
+#include "tag.h"
+#include "progress.h"
+#include "pack.h"
+#include "sha1-lookup.h"
+#include "csum-file.h"
 #include "narrow-tree.h"
=20
 static const char **narrow_prefix;
@@ -104,3 +114,94 @@ char *get_narrow_string()
 	}
 	return strbuf_detach(&sb, NULL);
 }
+
+/*
+ * The opposite of narrow_tree(). Put the subtree back to the original=
 tree.
+ */
+static int join_narrow_tree_rec(unsigned char *result,
+				const unsigned char *basetree,
+				const unsigned char *newtree,
+				const char **prefix,
+				char *base,
+				int baselen)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf buffer;
+	enum object_type type;
+	unsigned long size;
+	const char **p;
+	int len, found;
+	char *buf;
+
+	buf =3D read_sha1_file(basetree, &type, &size);
+	if (!buf || type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(basetree));
+
+	if (baselen)
+		base[baselen++] =3D '/';
+
+	init_tree_desc(&desc, buf, size);
+	strbuf_init(&buffer, 8192);
+	while (tree_entry(&desc, &entry)) {
+		strbuf_addf(&buffer, "%o %.*s%c", entry.mode, strlen(entry.path), en=
try.path, '\0');
+
+		if (!S_ISDIR(entry.mode)) {
+			strbuf_add(&buffer, entry.sha1, 20);
+			continue;
+		}
+
+		p =3D prefix;
+		len =3D strlen(entry.path);
+		found =3D 0;
+
+		while (*p) {
+			if (!strcmp(entry.path, *p)) {
+				found =3D 2;
+				break;
+			}
+			if (!prefixcmp(*p, entry.path)) {
+				found =3D 1;
+				break;
+			}
+			p++;
+		}
+		switch (found) {
+		case 1:
+			memcpy(base+baselen, entry.path, len+1);
+			join_narrow_tree_rec(result, entry.sha1, newtree,
+					     prefix, base, baselen+len+1);
+			break;
+		case 2:
+			if (!path_to_tree_sha1(result, newtree, *p))
+				die("Could not find tree %s in the new tree", *p);
+			break;
+		case 0:
+			hashcpy(result, entry.sha1);
+			break;
+		}
+
+		/* FIXME, what if placeholder tree does not exist? */
+
+		strbuf_add(&buffer, result, 20);
+	}
+
+	free(buf);
+	if (write_sha1_file(buffer.buf, buffer.len, tree_type, result)) {
+		base[baselen] =3D '\0';
+		error("Could not write tree %s", base);
+		strbuf_release(&buffer);
+		return 1;
+	}
+	strbuf_release(&buffer);
+	return 0;
+}
+
+int join_narrow_tree(unsigned char *result,
+		     const unsigned char *basetree,
+		     const unsigned char *newtree,
+		     const char **prefix)
+{
+	char path[PATH_MAX];
+	return join_narrow_tree_rec(result, basetree, newtree, prefix, path, =
0);
+}
diff --git a/narrow-tree.h b/narrow-tree.h
index 2097436..e7d84c4 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -1,3 +1,7 @@
 extern int valid_narrow_prefix(const char *prefix, const char *prev_pr=
efix, int quiet);
 extern int check_narrow_prefix();
 extern char *get_narrow_string();
+extern int join_narrow_tree(unsigned char *result,
+			    const unsigned char *base,
+			    const unsigned char *newtree,
+			    const char **prefix);
--=20
1.7.1.rc1.69.g24c2f7
