From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 18/19] Add tracing to measure where most of the time is spent
Date: Thu,  5 May 2016 17:47:10 -0400
Message-ID: <1462484831-13643-19-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR80-0008DU-BU
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbcEEVr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:58 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33980 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757951AbcEEVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:49 -0400
Received: by mail-qg0-f43.google.com with SMTP id 90so47397549qgz.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7BOC4yq7Wll/Uw47a9UXaFIxRksRXz50rkO5LdXyoc=;
        b=Gbv7dSYRNWcT9UDd7/hIU3ZGlnBpzrkef4ZhOm3j4om4hTltiBUx08QlEtArZKkXEU
         BQEgw2NVb966kz/t7pXM6bBLSneaRazbjkDeQvh00dWuA8TWR0wvFs1NOGgvqQt44ik3
         9s1rj/6a298pogrn2sjsgLhOdQW6kXkXQpc4sc0yHaSU1VjZAUkneg/lhs6ARVoVQPwL
         r5K8wTXWlIgDE44WoduqL784LklBw7xX2WdBQt2I8ui+F4EnFjAZyi+iESPUqDtxyfY3
         bPXZM2DWa/+MLDEVahTtS3Rj7edRkYNcjgqwwQyN96CO5hhHibqIWWjX421aEMZCgnSy
         ZFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7BOC4yq7Wll/Uw47a9UXaFIxRksRXz50rkO5LdXyoc=;
        b=KsyXl6reErAzg73Lq76ChPMR7u3OneIXhZLjZO1zWKc99JYTlV7gsd2GsqS0FAaH87
         Qx4oci9Si9v2/jeo5r5Bchjv0soknh5ULqjoBsg3HCoHU2mgEaoi/ZtQ6eR2Gq3Lb8Lc
         ep9UqpLSeUY8pKUCnpQGs3AjTPY/x2795vXLrGRstIClGDX6K5oAN3OWD95mkar4YuvZ
         HgAnv0j/6bwA2yWtHLpiyhxKYhAvrvWSUA0zLQiOqY9i5cA+cWvVOrrNlakxIfQ0jTM4
         YmkyJiFa9VNZGGpfBiV5ngMJITFo/7J6sLiYQY+cmWFFmuf0CfnjDpgJ72VFs+bAMgp7
         LiQg==
X-Gm-Message-State: AOPr4FVeGK2fee6w4hzFcRGmEZdc8M+YdTi8C+h0AcUQcOdCE6C1ywD+wmsKpVtWgRmXfA==
X-Received: by 10.141.2.9 with SMTP id e9mr17862197qhd.18.1462484868343;
        Thu, 05 May 2016 14:47:48 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293697>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

All the known heavy code blocks are measured (except object database
access). This should help identify if an optimization is effective or
not. An unoptimized git-status would give something like below (92% of
time is accounted). To sum up the effort of making git scale better:

 - read cache line is being addressed by index-helper
 - preload/refresh index by watchman
 - read packed refs by lmdb backend
 - diff-index by rebuilding cache-tree
 - read directory by untracked cache and watchman
 - write index by split index
 - name hash potientially by index-helper

read-cache.c:2075         performance: 0.004058570 s: read cache .../in=
dex
preload-index.c:104       performance: 0.004419864 s: preload index
read-cache.c:1265         performance: 0.000185224 s: refresh index
refs/files-backend.c:1100 performance: 0.001935788 s: read packed refs
diff-lib.c:240            performance: 0.000144132 s: diff-files
diff-lib.c:506            performance: 0.013592000 s: diff-index
name-hash.c:128           performance: 0.000614177 s: initialize name h=
ash
dir.c:2030                performance: 0.015814103 s: read directory
read-cache.c:2565         performance: 0.004052343 s: write index, chan=
ged mask =3D 2
trace.c:420               performance: 0.048365509 s: git command: './g=
it' 'status'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 diff-lib.c           |  4 ++++
 dir.c                |  2 ++
 name-hash.c          |  2 ++
 preload-index.c      |  2 ++
 read-cache.c         | 11 +++++++++++
 refs/files-backend.c |  2 ++
 6 files changed, 23 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index bc49c70..7af7f9a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -90,6 +90,7 @@ int run_diff_files(struct rev_info *revs, unsigned in=
t option)
 	int diff_unmerged_stage =3D revs->max_count;
 	unsigned ce_option =3D ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	uint64_t start =3D getnanotime();
=20
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
=20
@@ -236,6 +237,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-files");
 	return 0;
 }
=20
@@ -491,6 +493,7 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
+	uint64_t start =3D getnanotime();
=20
 	ent =3D revs->pending.objects;
 	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
@@ -500,6 +503,7 @@ int run_diff_index(struct rev_info *revs, int cache=
d)
 	diffcore_fix_diff_index(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-index");
 	return 0;
 }
=20
diff --git a/dir.c b/dir.c
index 5058b29..c56a8b9 100644
--- a/dir.c
+++ b/dir.c
@@ -2183,6 +2183,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 {
 	struct path_simplify *simplify;
 	struct untracked_cache_dir *untracked;
+	uint64_t start =3D getnanotime();
=20
 	/*
 	 * Check out create_simplify()
@@ -2224,6 +2225,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	trace_performance_since(start, "read directory %.*s", len, path);
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/name-hash.c b/name-hash.c
index 6d9f23e..b3966d8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -115,6 +115,7 @@ static int cache_entry_cmp(const struct cache_entry=
 *ce1,
 static void lazy_init_name_hash(struct index_state *istate)
 {
 	int nr;
+	uint64_t start =3D getnanotime();
=20
 	if (istate->name_hash_initialized)
 		return;
@@ -124,6 +125,7 @@ static void lazy_init_name_hash(struct index_state =
*istate)
 	for (nr =3D 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized =3D 1;
+	trace_performance_since(start, "initialize name hash");
 }
=20
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
diff --git a/preload-index.c b/preload-index.c
index c1fe3a3..7bb4809 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -72,6 +72,7 @@ static void preload_index(struct index_state *index,
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
+	uint64_t start =3D getnanotime();
=20
 	if (!core_preload_index)
 		return;
@@ -100,6 +101,7 @@ static void preload_index(struct index_state *index=
,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	trace_performance_since(start, "preload index");
 }
 #endif
=20
diff --git a/read-cache.c b/read-cache.c
index d91742c..a32bd54 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1189,6 +1189,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
+	uint64_t start =3D getnanotime();
=20
 	modified_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1263,6 +1264,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
=20
 		replace_index_entry(istate, i, new);
 	}
+	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
=20
@@ -2087,12 +2089,15 @@ int read_index_from(struct index_state *istate,=
 const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	uint64_t start;
=20
 	/* istate->initialized covers both .git/index and .git/sharedindex.xx=
x */
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	start =3D getnanotime();
 	ret =3D do_read_index(istate, path, 0);
+	trace_performance_since(start, "read cache %s", path);
=20
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
@@ -2107,6 +2112,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index->base->keep_mmap =3D istate->keep_mmap;
 	split_index->base->to_shm    =3D istate->to_shm;
 	split_index->base->from_shm  =3D istate->from_shm;
+	start =3D getnanotime();
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -2118,6 +2124,9 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	trace_performance_since(start, "read cache %s",
+				git_path("sharedindex.%s",
+					 sha1_to_hex(split_index->base_sha1)));
=20
 done:
 	if (ret > 0 && istate->from_shm && istate->last_update)
@@ -2463,6 +2472,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
 	int watchman =3D 0;
+	uint64_t start =3D getnanotime();
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2583,6 +2593,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
+	trace_performance_since(start, "write index, changed mask =3D %x", is=
tate->cache_changed);
 	return 0;
 }
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f8..57571ce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1048,6 +1048,7 @@ static void read_packed_refs(FILE *f, struct ref_=
dir *dir)
 	struct ref_entry *last =3D NULL;
 	struct strbuf line =3D STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled =3D PEELED_NON=
E;
+	uint64_t start =3D getnanotime();
=20
 	while (strbuf_getwholeline(&line, f, '\n') !=3D EOF) {
 		unsigned char sha1[20];
@@ -1096,6 +1097,7 @@ static void read_packed_refs(FILE *f, struct ref_=
dir *dir)
 	}
=20
 	strbuf_release(&line);
+	trace_performance_since(start, "read packed refs");
 }
=20
 /*
--=20
2.4.2.767.g62658d5-twtrsrc
