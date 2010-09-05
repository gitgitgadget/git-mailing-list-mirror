From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/17] merge: try to do local merge if possible in narrow repo
Date: Sun,  5 Sep 2010 16:47:43 +1000
Message-ID: <1283669264-15759-17-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93z-00008H-00
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab0IEGup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33654 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab0IEGuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1041169pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uRBo+6jevh86cW3IY2TLuHrLBuPg1eilnoyeAwS6Vfo=;
        b=wt4PBjAdVJses6+uT0VF/av0yhZDzsWeN/vj6hlea6BYhkLRjM03vZctzthEEu+U/P
         LN4rZ1XGMv/XAPYGSq+FhzaDQ8o65j50vGAOz2ClPJMvDKtmdTkc94kXxU2GlQx7wRuN
         RJLWrFRufNNQUjJU8RtACjLS9+FjDqrpFQFA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lthvSLcONe4aVjbJCcCNznC4GMLMQV3JqUs68OVTbp5nevm/pnZgGub5HEaAtb+Ib2
         e4Le2nC/JFvqpOnSfSDMrfNBwpXo6/Sgl1i6w/gktbW6VhukG9b0ACGgTEUJeHgSR+28
         K372Xg7vLSeMURiR1LHxbzDh76DnbR9eecD1g=
Received: by 10.114.134.9 with SMTP id h9mr1734980wad.5.1283669443939;
        Sat, 04 Sep 2010 23:50:43 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d38sm8039305wam.20.2010.09.04.23.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:50:33 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155442>

commit_narrow_tree() works with a single narrow base. Unfortunately a
merge may have more than one parent. If all parents have the same
trees outside $GIT_DIR/narrow tree, then it's actually "a single
narrow base".

Other than that, refuse to merge because we do not have enough trees
to peform a trivial merge outside narrow tree. A merge in such case
will need server support.

Some simple cases though can be handled local. One of such cases are
where the narrow base of head and ancestor are exactly the same (IOW
we don't change anything outside narrow tree) we can just use remote
as narrow base. This case happens when we work on narrow repo then do
a pull.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-merge.txt |   16 +++++++++
 builtin/merge.c             |   60 ++++++++++++++++++++++++++++++---
 narrow-tree.c               |   78 +++++++++++++++++++++++++++++++++++=
++++++++
 narrow-tree.h               |    1 +
 4 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..4285f18 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -239,6 +239,22 @@ You can work through the conflict with a number of=
 tools:
    version.
=20
=20
+MERGE IN NARROW REPOSITORIES
+----------------------------
+
+Because narrow repositories do not have all tree objects, abitrary
+merge may not work in these repositories. A merge can only be
+performed local in such a repository if
+
+ * There are two commits given
+
+ * A single common commit is found
+
+ * The commit content outside narrow area must be the same as in the
+   other commit, or in the common commit
+
+Merges that do not meet these requirements cannot be done locally.
+
 EXAMPLES
 --------
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 47e705b..c6dfb44 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "narrow-tree.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -56,6 +57,7 @@ static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static int verbosity;
 static int allow_rerere_auto;
+static unsigned char narrow_base[20];
=20
 static struct strategy all_strategy[] =3D {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -781,7 +783,8 @@ static int merge_trivial(void)
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_narrow_tree(merge_msg.buf, result_tree, narrow_base,
+			   parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -810,7 +813,8 @@ static int finish_automerge(struct commit_list *com=
mon,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
+	commit_narrow_tree(merge_msg.buf, result_tree, narrow_base,
+			   parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
@@ -886,6 +890,48 @@ static int evaluate_result(void)
 	return cnt;
 }
=20
+static struct commit_list *find_narrow_base(struct commit *head, struc=
t commit_list *remoteheads)
+{
+	struct commit_list *remote =3D remoteheads;
+	const char **narrow_prefix =3D get_narrow_prefix();
+
+	if (!narrow_prefix)
+		return NULL;
+
+	parse_commit(head);
+	while (remote) {
+		parse_commit(remote->item);
+		if (!same_narrow_base(head->tree->object.sha1,
+				      remote->item->tree->object.sha1,
+				      narrow_prefix))
+			break;
+		remote =3D remote->next;
+	}
+
+	if (!remote) {		/* all same narrow base */
+		hashcpy(narrow_base, head->tree->object.sha1);
+		return NULL;
+	}
+
+	/*
+	 * If it's three-way merge and head has the same narrow base
+	 * as in common, then we could just use remote as the base
+	 * because we haven't changed anything outside narrow tree.
+	 */
+	if (remoteheads && !remoteheads->next) {
+		struct commit_list *common;
+		common =3D get_merge_bases(head, remoteheads->item, 1);
+		if (common && !common->next &&
+		    same_narrow_base(head->object.sha1,
+				     common->item->object.sha1,
+				     narrow_prefix)) {
+			hashcpy(narrow_base, remoteheads->item->tree->object.sha1);
+			return common;
+		}
+	}
+	die("Different narrow base, couldn't do merge (yet)");
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1050,9 +1096,13 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 			allow_trivial =3D 0;
 	}
=20
-	if (!remoteheads->next)
-		common =3D get_merge_bases(lookup_commit(head),
-				remoteheads->item, 1);
+	common =3D find_narrow_base(lookup_commit(head), remoteheads);
+
+	if (!remoteheads->next) {
+		if (!common) /* might have been calculated in find_narrow_base */
+			common =3D get_merge_bases(lookup_commit(head),
+						 remoteheads->item, 1);
+	}
 	else {
 		struct commit_list *list =3D remoteheads;
 		commit_list_insert(lookup_commit(head), &list);
diff --git a/narrow-tree.c b/narrow-tree.c
index 110fac2..76581f2 100644
--- a/narrow-tree.c
+++ b/narrow-tree.c
@@ -205,3 +205,81 @@ int join_narrow_tree(unsigned char *result,
 	char path[PATH_MAX];
 	return join_narrow_tree_rec(result, basetree, newtree, prefix, path, =
0);
 }
+
+static int same_narrow_base_rec(const unsigned char *t1,
+				const unsigned char *t2,
+				const char **prefix,
+				char *base, int baselen)
+{
+	struct tree_desc desc1, desc2;
+	struct name_entry entry1, entry2;
+	char *buf1, *buf2;
+	enum object_type type;
+	unsigned long size;
+
+	if (baselen)
+		base[baselen++] =3D '/';
+
+	buf1 =3D read_sha1_file(t1, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(t1));
+	init_tree_desc(&desc1, buf1, size);
+
+	buf2 =3D read_sha1_file(t2, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(t2));
+	init_tree_desc(&desc2, buf2, size);
+
+	while (tree_entry(&desc1, &entry1) && tree_entry(&desc2, &entry2)) {
+		if (strcmp(entry1.path, entry2.path) ||
+		    entry1.mode !=3D entry2.mode) {
+			free(buf1);
+			free(buf2);
+			return 0;
+		}
+
+		if (!hashcmp(entry1.sha1, entry2.sha1))
+			continue;
+
+		if (S_ISDIR(entry1.mode)) {
+			int len =3D strlen(entry1.path);
+			const char **p =3D prefix;
+			int found =3D 0;
+			while (*p) {
+				if (!strcmp(entry1.path, *p)) {
+					found =3D 2;
+					break;
+				}
+				if (!prefixcmp(*p, entry1.path)) {
+					found =3D 1;
+					break;
+				}
+				p++;
+			}
+
+			if (found =3D=3D 2) /* narrow area */
+				continue;
+			else if (found =3D=3D 1) {
+				memcpy(base+baselen, entry1.path, len+1);
+				if (same_narrow_base_rec(entry1.sha1, entry2.sha1,
+							 prefix, base, baselen+len))
+					continue;
+			}
+		}
+
+		free(buf1);
+		free(buf2);
+		return 0;
+	}
+	free(buf1);
+	free(buf2);
+	return !desc1.size && !desc2.size;
+}
+
+int same_narrow_base(const unsigned char *t1,
+		     const unsigned char *t2,
+		     const char **prefix)
+{
+	char path[PATH_MAX];
+	return same_narrow_base_rec(t1, t2, prefix, path, 0);
+}
diff --git a/narrow-tree.h b/narrow-tree.h
index e7d84c4..c574227 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -5,3 +5,4 @@ extern int join_narrow_tree(unsigned char *result,
 			    const unsigned char *base,
 			    const unsigned char *newtree,
 			    const char **prefix);
+int same_narrow_base(const unsigned char *t1, const unsigned char *t2,=
 const char **prefix);
--=20
1.7.1.rc1.69.g24c2f7
