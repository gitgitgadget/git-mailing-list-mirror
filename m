From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/3] index-pack: support multithreaded delta resolving
Date: Wed, 11 Apr 2012 12:49:48 +0700
Message-ID: <1334123388-6083-4-git-send-email-pclouds@gmail.com>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:51:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqSc-00049J-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 07:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab2DKFvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 01:51:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52384 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab2DKFvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 01:51:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so807121pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 22:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YYnPbO6+FMHdyIOLOp+9OevncNflUE+P+MxYDFkDouE=;
        b=heUitbspcpbOTQvsIirwk6wQM4HUrA7s6Y+OsaSZ0KzknSbL3xOnkKAUE1JK+AIXWV
         JvXJC9qT1Xugvcr3uaFVIX8sjEcCChyEiKJ4iY+WUT5lLSsRDf0gWuaqvc3Fi5xHO++/
         0MM3d8c2qvzFVOFpKVJKmy9fs3ClA86bnzFoOsa3s199V2lsa6J6LXsoQlAN9WuppGG5
         Y+IldzmN/LGu1VoraBx+qwBnJPt72Uda8sfdrCPmb+RyIAXsPL+6kLpLGbAHNvJhwKoz
         4nw+uuyQaGBycD44Gd+xUAg+L1+uTGZ2+mrBrLbJr04b7W2jqFllW3kfnZDH0tocz5nZ
         bIJw==
Received: by 10.68.193.231 with SMTP id hr7mr34959481pbc.44.1334123470657;
        Tue, 10 Apr 2012 22:51:10 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id y3sm1920708pbh.59.2012.04.10.22.51.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 22:51:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Apr 2012 12:50:23 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195149>

This puts delta resolving on each base on a separate thread, one base
cache per thread. Per-thread data is grouped in struct thread_local.
When running with nr_threads =3D=3D 1, no pthreads calls are made. The
system essentially runs in non-thread mode.

An experiment on a Xeon 24 core machine with git.git shows that
performance does not increase proportional to the number of cores. So
by default, we use maximum 3 cores. Some numbers with --threads from 1
to 16:

1..4
real    0m8.003s  0m5.307s  0m4.321s  0m3.830s
user    0m7.720s  0m8.009s  0m8.133s  0m8.305s
sys     0m0.224s  0m0.372s  0m0.360s  0m0.360s

5..8
real    0m3.727s  0m3.604s  0m3.332s  0m3.369s
user    0m9.361s  0m9.817s  0m9.525s  0m9.769s
sys     0m0.584s  0m0.624s  0m0.540s  0m0.560s

9..12
real    0m3.036s  0m3.139s  0m3.177s  0m2.961s
user    0m8.977s  0m10.205s 0m9.737s  0m10.073s
sys     0m0.596s  0m0.680s  0m0.684s  0m0.680s

13..16
real    0m2.985s  0m2.894s  0m2.975s  0m2.971s
user    0m9.825s  0m10.573s 0m10.833s 0m11.361s
sys     0m0.788s  0m0.732s  0m0.904s  0m1.016s

On an Intel dual core and linux-2.6.git

1..4
real    2m37.789s 2m7.963s  2m0.920s  1m58.213s
user    2m28.415s 2m52.325s 2m50.176s 2m41.187s
sys     0m7.808s  0m11.181s 0m11.224s 0m10.731s

Thanks Ramsay Jones for troubleshooting and support on MinGW platform.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  202 ++++++++++++++++++++++++++++++=
++++---
 t/perf/p5302-pack-index.sh       |   40 ++++++++
 4 files changed, 236 insertions(+), 18 deletions(-)
 create mode 100755 t/perf/p5302-pack-index.sh

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index 909687f..39e6d0d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -74,6 +74,16 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
=20
+--threads=3D<n>::
+	Specifies the number of threads to spawn when resolving
+	deltas. This requires that index-pack be compiled with
+	pthreads otherwise this option is ignored with a warning.
+	This is meant to reduce packing time on multiprocessor
+	machines. The required amount of memory for the delta search
+	window is however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and use maximum 3 threads.
+
=20
 Note
 ----
diff --git a/Makefile b/Makefile
index be1957a..4d7a3de 100644
--- a/Makefile
+++ b/Makefile
@@ -2160,7 +2160,7 @@ builtin/branch.o builtin/checkout.o builtin/clone=
=2Eo builtin/reset.o branch.o tra
 builtin/bundle.o bundle.o transport.o: bundle.h
 builtin/bisect--helper.o builtin/rev-list.o bisect.o: bisect.h
 builtin/clone.o builtin/fetch-pack.o transport.o: fetch-pack.h
-builtin/grep.o builtin/pack-objects.o transport-helper.o thread-utils.=
o: thread-utils.h
+builtin/index-pack.o builtin/grep.o builtin/pack-objects.o transport-h=
elper.o thread-utils.o: thread-utils.h
 builtin/send-pack.o transport.o: send-pack.h
 builtin/log.o builtin/shortlog.o: shortlog.h
 builtin/prune.o builtin/reflog.o reachable.o: reachable.h
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 918684f..45bc5db 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,6 +9,7 @@
 #include "progress.h"
 #include "fsck.h"
 #include "exec_cmd.h"
+#include "thread-utils.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -38,6 +39,14 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
=20
+struct thread_local {
+#ifndef NO_PTHREADS
+	pthread_t thread;
+#endif
+	struct base_data *base_cache;
+	size_t base_cache_used;
+};
+
 /*
  * Even if sizeof(union delta_base) =3D=3D 24 on 64-bit archs, we real=
ly want
  * to memcmp() only the first 20 bytes.
@@ -54,11 +63,13 @@ struct delta_entry {
=20
 static struct object_entry *objects;
 static struct delta_entry *deltas;
-static struct base_data *base_cache;
-static size_t base_cache_used;
+static struct thread_local nothread_data;
 static int nr_objects;
+static int nr_processed;
 static int nr_deltas;
 static int nr_resolved_deltas;
+static int nr_threads;
+static int threads_active;
=20
 static int from_stdin;
 static int strict;
@@ -75,6 +86,75 @@ static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+#ifndef NO_PTHREADS
+
+static struct thread_local *thread_data;
+
+static pthread_mutex_t read_mutex;
+#define read_lock()		lock_mutex(&read_mutex)
+#define read_unlock()		unlock_mutex(&read_mutex)
+
+static pthread_mutex_t counter_mutex;
+#define counter_lock()		lock_mutex(&counter_mutex)
+#define counter_unlock()	unlock_mutex(&counter_mutex)
+
+static pthread_mutex_t work_mutex;
+#define work_lock()		lock_mutex(&work_mutex)
+#define work_unlock()		unlock_mutex(&work_mutex)
+
+static pthread_key_t key;
+
+static inline void lock_mutex(pthread_mutex_t *mutex)
+{
+	if (threads_active)
+		pthread_mutex_lock(mutex);
+}
+
+static inline void unlock_mutex(pthread_mutex_t *mutex)
+{
+	if (threads_active)
+		pthread_mutex_unlock(mutex);
+}
+
+/*
+ * Mutex and conditional variable can't be statically-initialized on W=
indows.
+ */
+static void init_thread(void)
+{
+	init_recursive_mutex(&read_mutex);
+	pthread_mutex_init(&counter_mutex, NULL);
+	pthread_mutex_init(&work_mutex, NULL);
+	pthread_key_create(&key, NULL);
+	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+	threads_active =3D 1;
+}
+
+static void cleanup_thread(void)
+{
+	if (!threads_active)
+		return;
+	threads_active =3D 0;
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&counter_mutex);
+	pthread_mutex_destroy(&work_mutex);
+	pthread_key_delete(key);
+	free(thread_data);
+}
+
+#else
+
+#define read_lock()
+#define read_unlock()
+
+#define counter_lock()
+#define counter_unlock()
+
+#define work_lock()
+#define work_unlock()
+
+#endif
+
+
 static int mark_link(struct object *obj, int type, void *data)
 {
 	if (!obj)
@@ -223,6 +303,17 @@ static NORETURN void bad_object(unsigned long offs=
et, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
=20
+static struct thread_local *get_thread_data()
+{
+#ifndef NO_PTHREADS
+	if (threads_active)
+		return pthread_getspecific(key);
+#endif
+	assert(!threads_active &&
+	       "This should only be reached when all threads are gone");
+	return &nothread_data;
+}
+
 static struct base_data *alloc_base_data(void)
 {
 	struct base_data *base =3D xmalloc(sizeof(struct base_data));
@@ -237,15 +328,16 @@ static void free_base_data(struct base_data *c)
 	if (c->data) {
 		free(c->data);
 		c->data =3D NULL;
-		base_cache_used -=3D c->size;
+		get_thread_data()->base_cache_used -=3D c->size;
 	}
 }
=20
 static void prune_base_data(struct base_data *retain)
 {
 	struct base_data *b;
-	for (b =3D base_cache;
-	     base_cache_used > delta_base_cache_limit && b;
+	struct thread_local *data =3D get_thread_data();
+	for (b =3D data->base_cache;
+	     data->base_cache_used > delta_base_cache_limit && b;
 	     b =3D b->child) {
 		if (b->data && b !=3D retain)
 			free_base_data(b);
@@ -257,12 +349,12 @@ static void link_base_data(struct base_data *base=
, struct base_data *c)
 	if (base)
 		base->child =3D c;
 	else
-		base_cache =3D c;
+		get_thread_data()->base_cache =3D c;
=20
 	c->base =3D base;
 	c->child =3D NULL;
 	if (c->data)
-		base_cache_used +=3D c->size;
+		get_thread_data()->base_cache_used +=3D c->size;
 	prune_base_data(c);
 }
=20
@@ -272,7 +364,7 @@ static void unlink_base_data(struct base_data *c)
 	if (base)
 		base->child =3D NULL;
 	else
-		base_cache =3D NULL;
+		get_thread_data()->base_cache =3D NULL;
 	free_base_data(c);
 }
=20
@@ -461,19 +553,24 @@ static void sha1_object(const void *data, unsigne=
d long size,
 			enum object_type type, unsigned char *sha1)
 {
 	hash_sha1_file(data, size, typename(type), sha1);
+	read_lock();
 	if (has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
 		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
+		read_unlock();
 		if (!has_data)
 			die("cannot read existing object %s", sha1_to_hex(sha1));
 		if (size !=3D has_size || type !=3D has_type ||
 		    memcmp(data, has_data, size) !=3D 0)
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
 		free(has_data);
-	}
+	} else
+		read_unlock();
+
 	if (strict) {
+		read_lock();
 		if (type =3D=3D OBJ_BLOB) {
 			struct blob *blob =3D lookup_blob(sha1);
 			if (blob)
@@ -507,6 +604,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			}
 			obj->flags |=3D FLAG_CHECKED;
 		}
+		read_unlock();
 	}
 }
=20
@@ -552,7 +650,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -568,7 +666,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -596,7 +694,9 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
+	counter_lock();
 	nr_resolved_deltas++;
+	counter_unlock();
 }
=20
 static struct base_data *find_unresolved_deltas_1(struct base_data *ba=
se,
@@ -696,7 +796,31 @@ static void second_pass(struct object_entry *obj)
 	base_obj->obj =3D obj;
 	base_obj->data =3D NULL;
 	find_unresolved_deltas(base_obj);
-	display_progress(progress, nr_resolved_deltas);
+}
+
+static void *threaded_second_pass(void *arg)
+{
+#ifndef NO_PTHREADS
+	if (threads_active)
+		pthread_setspecific(key, arg);
+#endif
+	for (;;) {
+		int i;
+		work_lock();
+		display_progress(progress, nr_resolved_deltas);
+		while (nr_processed < nr_objects &&
+		       is_delta_type(objects[nr_processed].type))
+			nr_processed++;
+		if (nr_processed >=3D nr_objects) {
+			work_unlock();
+			break;
+		}
+		i =3D nr_processed++;
+		work_unlock();
+
+		second_pass(&objects[i]);
+	}
+	return NULL;
 }
=20
 /* Parse all objects and return the pack content SHA1 hash */
@@ -755,13 +879,25 @@ static void parse_pack_objects(unsigned char *sha=
1)
=20
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
-	for (i =3D 0; i < nr_objects; i++) {
-		struct object_entry *obj =3D &objects[i];
=20
-		if (is_delta_type(obj->type))
-			continue;
-		second_pass(obj);
+	nr_processed =3D 0;
+#ifndef NO_PTHREADS
+	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
+		init_thread();
+		for (i =3D 0; i < nr_threads; i++) {
+			int ret =3D pthread_create(&thread_data[i].thread, NULL,
+						 threaded_second_pass, thread_data + i);
+			if (ret)
+				die("unable to create thread: %s", strerror(ret));
+		}
+		for (i =3D 0; i < nr_threads; i++)
+			pthread_join(thread_data[i].thread, NULL);
+
+		cleanup_thread();
+		return;
 	}
+#endif
+	threaded_second_pass(NULL);
 }
=20
 static int write_compressed(struct sha1file *f, void *in, unsigned int=
 size)
@@ -967,6 +1103,18 @@ static int git_index_pack_config(const char *k, c=
onst char *v, void *cb)
 			die("bad pack.indexversion=3D%"PRIu32, opts->version);
 		return 0;
 	}
+	if (!strcmp(k, "pack.threads")) {
+		nr_threads =3D git_config_int(k, v);
+		if (nr_threads < 0)
+			die("invalid number of threads specified (%d)",
+			    nr_threads);
+#ifdef NO_PTHREADS
+		if (nr_threads !=3D 1)
+			warning("no threads support, ignoring %s", k);
+		nr_threads =3D 1;
+#endif
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
=20
@@ -1125,6 +1273,17 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 				keep_msg =3D "";
 			} else if (!prefixcmp(arg, "--keep=3D")) {
 				keep_msg =3D arg + 7;
+			} else if (!prefixcmp(arg, "--threads=3D")) {
+				char *end;
+				nr_threads =3D strtoul(arg+10, &end, 0);
+				if (!arg[10] || *end || nr_threads < 0)
+					usage(index_pack_usage);
+#ifdef NO_PTHREADS
+				if (nr_threads !=3D 1)
+					warning("no threads support, "
+						"ignoring %s", arg);
+				nr_threads =3D 1;
+#endif
 			} else if (!prefixcmp(arg, "--pack_header=3D")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1196,6 +1355,15 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	if (strict)
 		opts.flags |=3D WRITE_IDX_STRICT;
=20
+#ifndef NO_PTHREADS
+	if (!nr_threads) {
+		nr_threads =3D online_cpus();
+		/* An experiment showed that more threads does not mean faster */
+		if (nr_threads > 3)
+			nr_threads =3D 3;
+	}
+#endif
+
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
new file mode 100755
index 0000000..6cb5b0d
--- /dev/null
+++ b/t/perf/p5302-pack-index.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D"Tests index-pack performance"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'repack' '
+	git repack -ad &&
+	PACK=3D`ls .git/objects/pack/*.pack | head -n1` &&
+	test -f "$PACK" &&
+	export PACK
+'
+
+test_perf 'index-pack 0 threads' '
+	GIT_DIR=3Dt1 git index-pack --threads=3D1 --stdin < $PACK
+'
+
+test_perf 'index-pack 1 thread ' '
+	GIT_DIR=3Dt2 GIT_FORCE_THREADS=3D1 git index-pack --threads=3D1 --std=
in < $PACK
+'
+
+test_perf 'index-pack 2 threads' '
+	GIT_DIR=3Dt3 git index-pack --threads=3D2 --stdin < $PACK
+'
+
+test_perf 'index-pack 4 threads' '
+	GIT_DIR=3Dt4 git index-pack --threads=3D4 --stdin < $PACK
+'
+
+test_perf 'index-pack 8 threads' '
+	GIT_DIR=3Dt5 git index-pack --threads=3D8 --stdin < $PACK
+'
+
+test_perf 'index-pack default number of threads' '
+	GIT_DIR=3Dt6 git index-pack --stdin < $PACK
+'
+
+test_done
--=20
1.7.3.1.256.g2539c.dirty
