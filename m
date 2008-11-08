From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] diffcore-rename: support rename cache
Date: Sat,  8 Nov 2008 18:27:32 +0700
Message-ID: <1226143653-3758-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:30:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kym1K-0000uk-Bd
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 12:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbYKHL1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 06:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbYKHL1r
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 06:27:47 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:12909 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYKHL1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 06:27:46 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1730477wfd.4
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=hvSdIlXzwXP6iVEMdoiQ8gpFcLspNvFM8TdQ53GXCQ8=;
        b=iqYQNc4P4qw+eoQUdsTxRNIGDxA7e5Hj/0H/iy6loSsxMepceHIjyAYzksHXPa2sEN
         OlcAh3NQqQf/MG/1t4HMsJpgUut6CXJy4oaZcgylscvocBemwpDuJir28+dTZtutOSRK
         +bcQYQtxE0uzcQjVqt3BnOYNiGUXnpo2Rbv1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Okrq0I2EBlcOqWBs6KA1/P0viZ1BAaGWDy7y8szf7mCUG6BR/OK9+fksbO9+CEPSD/
         faNv4l1XWQuXPZ59auFnIASmDyg8yvpWOzw+A6BkLPNuMn88VoJpPMtcmCi06xwDPlER
         4yVOF5Q6LKWdKL2RWHZNFQiKsV4bGyMOeHhdY=
Received: by 10.142.188.4 with SMTP id l4mr1385649wff.271.1226143665542;
        Sat, 08 Nov 2008 03:27:45 -0800 (PST)
Received: from pclouds@gmail.com ([117.5.61.191])
        by mx.google.com with ESMTPS id 29sm6062799wfg.0.2008.11.08.03.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 03:27:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  8 Nov 2008 18:27:33 +0700
X-Mailer: git-send-email 1.6.0.3.892.g83538
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100394>

This patch teaches diffcore_rename() to look into
$GIT_DIR/rename-cache and make use of it to recreate diff_filepair.
With proper cache, there should be no available entry for estimation
after exact matching.

Rename caching is per commit. I don't think abitrary tree-tree caching
is worth it.

$GIT_DIR/rename-cache spans out like $GIT_DIR/objects. Each file
corresponds to one commit. Its content consists of lines like this

<Destination SHA-1> <SPC> <Source SHA-1> <SPC> <Score in decimal> <NL>

This can be used to:

 - Make --find-copies-harder pratically usable for moderate-size
   repositories. The first "git show" on a linux kernel commit was 5.3
   sec, it then went down to 0.13 sec.
 - Give git-svn a chance to (locally) import explicit renames from
   Subversion
 - People may correct rename results for better diff, if automatic
   rename detection is not good enough.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 >  > > Has anybody thought about interaction between that caching and =
pathspec
 >  > >  limited operation?
 >  > >
 >  >
 >  > I didn't. But I think all out-of-pathspec diff pairs are removed
 >  > before it reaches diffcore_rename() so the cache has nothing to d=
o
 >  > with it (except it still loads full cache for a commit).
 >
 >
 > Well, it could be that an out-of-pathspec pair would have a better
 >  score than an in-pathspec one.  Maybe cache recording should be tur=
ned
 >  off when doing pathspec limitation ?

 Changes from v1:
  - rebased to next to avoid conflict
  - no longer generate cache if pathspec is used

 diff.h                  |    2 +
 diffcore-rename.c       |  142 +++++++++++++++++++++++++++++++++++++++=
+++++++-
 log-tree.c              |    2 +
 t/t4031-rename-cache.sh |   56 ++++++++++++++++++
 4 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100755 t/t4031-rename-cache.sh

diff --git a/diff.h b/diff.h
index 42582ed..64a1edd 100644
--- a/diff.h
+++ b/diff.h
@@ -111,6 +111,8 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
+
+	struct commit *commit;
 };
=20
 enum color_diff {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 168a95b..598cc8d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "commit.h"
=20
 /* Table of rename/copy destinations */
=20
@@ -409,13 +410,130 @@ static void record_if_better(struct diff_score m=
[], struct diff_score *o)
 		m[worst] =3D *o;
 }
=20
+struct cached_filepair {
+	unsigned char dst[20];
+	unsigned char src[20];
+	int score;
+};
+
+static int free_cached_filepair(void *p)
+{
+	free(p);
+	return 0;
+}
+
+static void load_rename_cache(struct diff_queue_struct *q,
+			      struct diff_queue_struct *cacheq,
+			      struct diff_options *options)
+{
+	char *sha1_hex;
+	FILE *fp;
+	struct hash_table filepair_table;
+	struct hash_table src_table;
+	struct cached_filepair *pp;
+	int i, hash;
+	static int no_cache_available =3D -1;
+	struct stat st;
+	char *path;
+
+	if (no_cache_available =3D=3D -1)
+		no_cache_available =3D stat(git_path("rename-cache"), &st) || !S_ISD=
IR(st.st_mode);
+
+	/* return soon so we don't need to waste CPU */
+	if (no_cache_available > 0)
+		return;
+
+
+	/* src_table initialization */
+	init_hash(&src_table);
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		if (DIFF_FILE_VALID(p->one)) {
+			unsigned int hash =3D hash_filespec(p->one);
+			insert_hash(hash, p, &src_table);
+		}
+	}
+
+	/* filepair_table initialization */
+	init_hash(&filepair_table);
+	sha1_hex =3D sha1_to_hex(options->commit->object.sha1);
+	path =3D git_path("rename-cache/%c%c/%s",sha1_hex[0], sha1_hex[1], sh=
a1_hex+2);
+	if (stat(path, &st))
+		fp =3D NULL;
+	else
+		fp =3D fopen(path, "r");
+	if (fp) {
+		char src_sha1_hex[41], dst_sha1_hex[41];
+		struct cached_filepair p;
+
+		src_sha1_hex[40] =3D dst_sha1_hex[40] =3D '\0';
+		while (fscanf(fp, "%40c %40c %d\n", dst_sha1_hex, src_sha1_hex, &p.s=
core) =3D=3D 3) {
+			if (get_sha1_hex(src_sha1_hex, p.src) ||
+			    get_sha1_hex(dst_sha1_hex, p.dst))
+				break;
+
+			pp =3D xmalloc(sizeof(*pp));
+			memcpy(pp, &p, sizeof(*pp));
+			memcpy(&hash, p.dst, sizeof(hash));
+			insert_hash(hash, pp, &filepair_table);
+		}
+		fclose(fp);
+	}
+
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		struct diff_filepair *dp, *src;
+
+		/* find remote_dst */
+		if (DIFF_FILE_VALID(p->one) ||
+		    !DIFF_FILE_VALID(p->two) ||
+		    (options->single_follow && strcmp(options->single_follow, p->two=
->path)))
+			continue;
+
+		memcpy(&hash, p->two->sha1, sizeof(hash));
+		pp =3D lookup_hash(hash, &filepair_table);
+		if (!pp || memcmp(p->two->sha1, pp->dst, 20))
+			continue;
+
+		/* create pair */
+		if (is_null_sha1(pp->src)) {
+			if (DIFF_FILE_VALID(p->one))
+				continue;
+			diff_q(cacheq, p);
+			q->queue[i] =3D NULL;
+			continue;
+		}
+
+		memcpy(&hash, pp->src, sizeof(hash));
+		src =3D lookup_hash(hash, &src_table);
+		if (!src || memcmp(pp->src, src->one->sha1, 20))
+			continue;
+
+		src->one->rename_used++;
+		src->one->count++;
+		p->two->count++;
+
+		dp =3D diff_queue(NULL, src->one, p->two);
+		dp->renamed_pair =3D 1;
+		dp->score =3D pp->score;
+
+		diff_q(cacheq, dp);
+		q->queue[i] =3D NULL;
+		diff_free_filepair(p);
+	}
+
+	for_each_hash(&filepair_table, free_cached_filepair);
+	free_hash(&src_table);
+	free_hash(&filepair_table);
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename =3D options->detect_rename;
 	int minimum_score =3D options->rename_score;
 	int rename_limit =3D options->rename_limit;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue_struct outq, cacheq;
 	struct diff_score *mx;
 	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
@@ -423,8 +541,19 @@ void diffcore_rename(struct diff_options *options)
 	if (!minimum_score)
 		minimum_score =3D DEFAULT_RENAME_SCORE;
=20
+	cacheq.queue =3D NULL;
+	cacheq.nr =3D cacheq.alloc =3D 0;
+
+	if (detect_rename && options->commit)
+		load_rename_cache(q, &cacheq, options);
+
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filepair *p =3D q->queue[i];
+
+		/* was consumed by rename cache */
+		if (!p)
+			continue;
+
 		if (!DIFF_FILE_VALID(p->one)) {
 			if (!DIFF_FILE_VALID(p->two))
 				continue; /* unmerged */
@@ -563,10 +692,17 @@ void diffcore_rename(struct diff_options *options=
)
 	 */
 	outq.queue =3D NULL;
 	outq.nr =3D outq.alloc =3D 0;
-	for (i =3D 0; i < q->nr; i++) {
+	for (i =3D j =3D 0; i < q->nr; i++) {
 		struct diff_filepair *p =3D q->queue[i];
 		struct diff_filepair *pair_to_free =3D NULL;
=20
+		if (!p) {
+			if (j >=3D cacheq.nr)
+				die("Internal error: running out of cacheq.");
+			diff_q(&outq, cacheq.queue[j++]);
+			continue;
+		}
+
 		if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			/*
 			 * Creation
@@ -635,6 +771,8 @@ void diffcore_rename(struct diff_options *options)
 	diff_debug_queue("done copying original", &outq);
=20
 	free(q->queue);
+	if (cacheq.queue)
+		free(cacheq.queue);
 	*q =3D outq;
 	diff_debug_queue("done collapsing", q);
=20
diff --git a/log-tree.c b/log-tree.c
index 5444f08..040e095 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -522,6 +522,7 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 	log.commit =3D commit;
 	log.parent =3D NULL;
 	opt->loginfo =3D &log;
+	opt->diffopt.commit =3D commit;
=20
 	shown =3D log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
@@ -531,5 +532,6 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 	}
 	opt->loginfo =3D NULL;
 	maybe_flush_or_die(stdout, "stdout");
+	opt->diffopt.commit =3D NULL;
 	return shown;
 }
diff --git a/t/t4031-rename-cache.sh b/t/t4031-rename-cache.sh
new file mode 100755
index 0000000..f7c53fd
--- /dev/null
+++ b/t/t4031-rename-cache.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguyen Thai Ngoc Duy
+#
+
+test_description=3D'Test diff rename cache'
+. ./test-lib.sh
+
+cat >expected <<EOF
+ create mode 100644 sub/c
+ copy a =3D> sub/d (100%)
+EOF
+test_expect_success 'setup' '
+	echo a > a
+	echo b > b
+	mkdir sub
+	echo c > sub/c
+	cp a sub/d
+	A_SHA1=3D$(git hash-object a)
+	B_SHA1=3D$(git hash-object b)
+	C_SHA1=3D$(git hash-object sub/c)
+	D_SHA1=3D$(git hash-object sub/d)
+	git add a b
+	test_tick
+	git commit -m first
+	git add sub
+	git commit -m second
+	git show --pretty=3Doneline --summary -C -M --find-copies-harder HEAD=
|sed 1d > result
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+ copy a =3D> sub/c (100%)
+ copy a =3D> sub/d (100%)
+EOF
+test_expect_success 'load rename pair cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	mkdir -p $(dirname $P)
+	echo $C_SHA1 $A_SHA1 60000 >> $P
+	git show --pretty=3Doneline --summary -C -M --find-copies-harder HEAD=
|sed 1d > result
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+ copy a =3D> sub/c (100%)
+ create mode 100644 sub/d
+EOF
+test_expect_success 'load create pair cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	mkdir -p $(dirname $P)
+	echo $D_SHA1 0000000000000000000000000000000000000000 0 >> $P
+	git show --pretty=3Doneline --summary -C -M --find-copies-harder HEAD=
|sed 1d > result
+	test_cmp expected result
+'
+
+test_done
--=20
1.6.0.3.892.g83538
