From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v2 3/4] unpack_trees(): add support for sparse checkout
Date: Mon, 10 Aug 2009 22:19:21 +0700
Message-ID: <1249917562-5931-4-git-send-email-pclouds@gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
 <1249917562-5931-2-git-send-email-pclouds@gmail.com>
 <1249917562-5931-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWfT-0002vZ-JY
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbZHJPTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZHJPTs
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:19:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:22103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZHJPTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:19:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1021748rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QQdlLad/NnBY3KUjaewPacZw4mQyabxE4ZuSSCROJlA=;
        b=cKFMhgrYPczDBKU7zFkHQzTxMwQht0MlYJybYBcQmvlqpSuOKkjv9QhHYxDua5nH8W
         vxv8oBHu2FCcNnCrrH5BNw8QkC80m+ex2wmTe0zItwSHLGq719TeIZeR2fT9N5A9zTe7
         NW5Bwg9fjWRjiJWYUY+Bqf24d6/WDuczMd0JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s3kTwWL7HxzQoBfyLaKA6OJlvwzwxQLpqT1QKEP093LZDZdDZI/Q3mMieN6rWYVUv1
         u+O86OVbB77+rwIM+s72vkOkNTVrNvEXaqshyYfeSijdStmNTGJ+bwzOe1EjXsyIZWrX
         U8LNyq0Dzgf2khlDtWwzBrfHB2cBKrCAOSauM=
Received: by 10.141.37.10 with SMTP id p10mr1356788rvj.190.1249917588519;
        Mon, 10 Aug 2009 08:19:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.231.150])
        by mx.google.com with ESMTPS id g31sm25703617rvb.16.2009.08.10.08.19.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:19:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 10 Aug 2009 22:19:41 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1249917562-5931-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125459>

This patch teaches unpack_trees() to checkout/remove entries on
working directories appropriately when sparse checkout area is
changed. Hook "sparse" is needed to help determine which entry will be
checked out, which will not be.

When the hook is run, it is prepared with a pseudo index. The hook then
can use "git update-index --[no-]assume-unchanged" to manipulate the in=
dex.
It should not do anything else on the index. Assume unchanged informati=
on
from the index will be used to shape working directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                     |    3 +
 t/t1009-read-tree-sparse.sh |   42 ++++++++++++
 unpack-trees.c              |  152 +++++++++++++++++++++++++++++++++++=
++++++--
 unpack-trees.h              |    2 +
 4 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse.sh

diff --git a/cache.h b/cache.h
index 1a2a3c9..dfad54a 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/t/t1009-read-tree-sparse.sh b/t/t1009-read-tree-sparse.sh
new file mode 100755
index 0000000..b613a89
--- /dev/null
+++ b/t/t1009-read-tree-sparse.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description=3D'sparse hook tests'
+
+. ./test-lib.sh
+
+make_hook() {
+	echo "#!/bin/sh" > .git/hooks/sparse &&
+	echo "$1" >> .git/hooks/sparse &&
+	chmod u+x .git/hooks/sparse
+}
+
+test_expect_success setup '
+	echo one > one &&
+	echo two > two &&
+	git add one two &&
+	git commit -m onetwo &&
+	echo three > three &&
+	git add three &&
+	git commit -m three
+'
+
+mkdir .git/hooks
+
+test_expect_success 'failed hook' '
+	make_hook "exit 1" &&
+	test_must_fail git read-tree -u -m HEAD
+'
+
+test_expect_success 'remove one' '
+	make_hook "git update-index --assume-unchanged one"
+	git read-tree -u -m HEAD &&
+	test ! -f one
+'
+
+test_expect_success 're-add one' '
+	make_hook "git update-index --no-assume-unchanged one" &&
+	git read-tree -u -m HEAD &&
+	test -f one
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..f407bf5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "run-command.h"
=20
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -32,6 +33,12 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
=20
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Orphaned working tree file '%s' would be %s by sparse checkout updat=
e.",
 };
=20
 #define ERRORMSG(o,fld) \
@@ -78,7 +85,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -92,6 +99,13 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -118,6 +132,106 @@ static int check_updates(struct unpack_trees_opti=
ons *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion, struct unpack_trees_options *o);
+static int run_sparse_hook(struct unpack_trees_options *o)
+{
+	struct index_state *index =3D &o->result;
+	struct index_state sparse_index =3D *index;
+	struct cache_entry *ce, *sparse_ce;
+	char sparse_index_file[PATH_MAX];
+	char sparse_index_env[PATH_MAX];
+	const char *argv[2], *env[2];
+	struct child_process cp;
+	int fd, i, j;
+
+	if (access(git_path("hooks/sparse"), X_OK) < 0)
+		return 0;
+
+	strcpy(sparse_index_file, git_path("sparse"));
+	fd =3D open(sparse_index_file, O_WRONLY | O_CREAT, 0600);
+	if (fd < 0) {
+		error("Unable to open %s for writing", sparse_index_file);
+		return -1;
+	}
+	/* FIXME: write_index may change something */
+	if (write_index(&sparse_index, fd)) {
+		error("Unable to write index to %s", sparse_index_file);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	memset(&cp, 0, sizeof(cp));
+	argv[0] =3D git_path("hooks/sparse");
+	argv[1] =3D NULL;
+	cp.argv =3D argv;
+	cp.no_stdin =3D 1;
+	cp.stdout_to_stderr =3D 1;
+	snprintf(sparse_index_env, sizeof(sparse_index_env), "GIT_INDEX_FILE=3D=
%s", sparse_index_file);
+	env[0] =3D sparse_index_env;
+	env[1] =3D NULL;
+	cp.env =3D env;
+	if (run_command(&cp)) {
+		error("Failed to run hook 'sparse'");
+		unlink(sparse_index_file);
+		return -1;
+	}
+
+	discard_index(&sparse_index);
+	read_index_from(&sparse_index, sparse_index_file);
+	unlink(sparse_index_file);
+
+	ce =3D index->cache[0];
+	sparse_ce =3D sparse_index.cache[0];
+	for (i =3D j =3D 0; i < index->cache_nr; i++, ce++) {
+		int was_checkout =3D !(ce->ce_flags & CE_VALID);
+
+		if (ce_stage(ce))
+			continue;
+
+		/*
+		 * We only care about files getting into the checkout area
+		 * If merge strategies want to remove some, go ahead
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		while (j < sparse_index.cache_nr &&
+		       cache_name_compare(sparse_ce->name, sparse_ce->ce_flags, ce->=
name, ce->ce_flags) < 0) {
+			sparse_ce++;
+			j++;
+		}
+		if (j < sparse_index.cache_nr &&
+		    !cache_name_compare(sparse_ce->name, sparse_ce->ce_flags, ce->na=
me, ce->ce_flags))
+			ce->ce_flags =3D (ce->ce_flags & ~CE_VALID) | (sparse_ce->ce_flags =
& CE_VALID);
+
+		/* Update worktree, add/remove entries if needed */
+
+		if (was_checkout && ce->ce_flags & CE_VALID) {
+			/*
+			 * If CE_UPDATE is set, verify_uptodate() must be called already
+			 * also stat info may have lost after merged_entry() so calling
+			 * verify_uptodate() again may fail
+			 */
+			if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+				return -1;
+			ce->ce_flags |=3D CE_WT_REMOVE;
+		}
+		if (!was_checkout && !(ce->ce_flags & CE_VALID)) {
+			if (verify_absent_sparse(ce, "overwritten", o))
+				return -1;
+			ce->ce_flags |=3D CE_UPDATE;
+		}
+
+		/* merge strategies may set CE_UPDATE outside checkout area */
+		if (ce->ce_flags & CE_VALID)
+			ce->ce_flags &=3D ~CE_UPDATE;
+
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -416,6 +530,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
=20
+	if (run_sparse_hook(o))
+		return unpack_failed(o, NULL);
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -445,8 +562,9 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_generic(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
=20
@@ -471,7 +589,18 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno =3D=3D ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, not_uptodate_file))=
;
+}
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_generic(ce, o, ERRORMSG(o, sparse_not_uptodate=
_file));
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -579,8 +708,9 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_generic(struct cache_entry *ce, const char *a=
ction,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
=20
@@ -660,6 +790,16 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_un=
tracked));
+}
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_generic(ce, action, o, ERRORMSG(o, would_lose_or=
phaned));
+}
=20
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..ad21823 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -14,6 +14,8 @@ struct unpack_trees_error_msgs {
 	const char *not_uptodate_dir;
 	const char *would_lose_untracked;
 	const char *bind_overlap;
+	const char *sparse_not_uptodate_file;
+	const char *would_lose_orphaned;
 };
=20
 struct unpack_trees_options {
--=20
1.6.3.GIT
