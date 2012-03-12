From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Mon, 12 Mar 2012 09:32:29 +0700
Message-ID: <1331519549-28090-3-git-send-email-pclouds@gmail.com>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 03:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6v4f-0002nR-4M
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 03:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab2CLCdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 22:33:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35049 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2CLCdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 22:33:15 -0400
Received: by mail-pz0-f46.google.com with SMTP id r28so4490235daj.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AmxVzMbFB9yBF/t036kR6buehpch9M40pACDw5G7c54=;
        b=M01tdcg4uJmQWVO7LlEDhvVeLItxahLpJWnENZDbnQUq+8yVJASXy5C2YNI5uw8G7Q
         dVAs7GgPffHvI98utkzwI17oSpzJsSlGMNz7gieaCwpj+KPla7IW4JeD/8kygRMhnB3b
         A6665cg/Ub0en8dvLPVvsGAVnKcqTH3GrgjEZjiYU5Dv56vb0U8K77CVEYWGw6EZxm20
         SK5zXZo3PYlzOVMXZwvjOGBKl8E6FxjGyZwHaR/ioMlrotko54BMtUhml/crt3uWQDVS
         ZBFQ/+Wj87Akx0cvywQHwJB4NCcl/Q22sXJeHkth/HaidJDY8DppUhTgtvggeGUhQGgI
         Na8Q==
Received: by 10.68.72.9 with SMTP id z9mr17433321pbu.124.1331519595067;
        Sun, 11 Mar 2012 19:33:15 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 9sm9229554pbx.67.2012.03.11.19.33.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 19:33:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 12 Mar 2012 09:32:44 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192837>

This puts delta resolving on each base on a separate thread, one base
cache per thread. Per-thread data is grouped in struct thread_local.
When running with nr_threads =3D=3D 1, no pthreads calls are made. The
system essentially runs in non-thread mode.

An experiment on a Xeon 24 core machine with linux-2.6.git shows that
performance does not increase proportional to the number of cores. So
by default, we use maximum 3 cores. Some numbers with --threads from 1
to 16:

1..4
real    1m16.310s  0m48.183s  0m37.866s  0m32.834s
user    1m13.773s  1m15.537s  1m15.781s  1m16.233s
sys     0m2.480s   0m3.936s   0m4.448s   0m4.852s

5..8
real    0m33.170s  0m30.369s  0m28.406s  0m26.968s
user    1m31.474s  1m30.322s  1m29.562s  1m28.694s
sys     0m6.096s   0m6.268s   0m6.684s   0m7.172s

9..12
real    0m26.288s  0m26.207s  0m26.239s  0m24.945s
user    1m29.530s  1m36.146s  1m43.134s  1m34.182s
sys     0m8.129s   0m8.437s   0m9.697s   0m10.201s

13..16
real    0m25.110s  0m25.043s  0m23.955s  0m25.746s
user    1m39.262s  1m43.598s  1m38.350s  1m59.775s
sys     0m10.997s  0m11.553s  0m11.949s  0m13.689s

Thanks to Ramsay Jones for troubleshooting on MinGW platform.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I changed Ramsay's mutex patch a little bit and incorporate it here.
 Ramsay, it'd be great if you could try it again on MinGW

 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  198 ++++++++++++++++++++++++++++++=
++++----
 3 files changed, 192 insertions(+), 18 deletions(-)

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
index 1fb1705..5fae875 100644
--- a/Makefile
+++ b/Makefile
@@ -2159,7 +2159,7 @@ builtin/branch.o builtin/checkout.o builtin/clone=
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
index 918684f..c6712cb 100644
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
@@ -54,11 +63,12 @@ struct delta_entry {
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
=20
 static int from_stdin;
 static int strict;
@@ -75,6 +85,72 @@ static git_SHA_CTX input_ctx;
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
+	if (nr_threads > 1)
+		pthread_mutex_lock(mutex);
+}
+
+static inline void unlock_mutex(pthread_mutex_t *mutex)
+{
+	if (nr_threads > 1)
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
+}
+
+static void cleanup_thread(void)
+{
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&counter_mutex);
+	pthread_mutex_destroy(&work_mutex);
+	pthread_key_delete(key);
+	nr_threads =3D 1;
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
@@ -223,6 +299,17 @@ static NORETURN void bad_object(unsigned long offs=
et, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
=20
+static struct thread_local *get_thread_data()
+{
+#ifndef NO_PTHREADS
+	if (nr_threads > 1)
+		return pthread_getspecific(key);
+#endif
+	assert(nr_threads =3D=3D 1 &&
+	       "This should only be reached when all threads are gone");
+	return &nothread_data;
+}
+
 static struct base_data *alloc_base_data(void)
 {
 	struct base_data *base =3D xmalloc(sizeof(struct base_data));
@@ -237,15 +324,16 @@ static void free_base_data(struct base_data *c)
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
@@ -257,12 +345,12 @@ static void link_base_data(struct base_data *base=
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
@@ -272,7 +360,7 @@ static void unlink_base_data(struct base_data *c)
 	if (base)
 		base->child =3D NULL;
 	else
-		base_cache =3D NULL;
+		get_thread_data()->base_cache =3D NULL;
 	free_base_data(c);
 }
=20
@@ -461,19 +549,24 @@ static void sha1_object(const void *data, unsigne=
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
@@ -507,6 +600,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			}
 			obj->flags |=3D FLAG_CHECKED;
 		}
+		read_unlock();
 	}
 }
=20
@@ -552,7 +646,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -568,7 +662,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -596,7 +690,9 @@ static void resolve_delta(struct object_entry *delt=
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
@@ -696,7 +792,31 @@ static void second_pass(struct object_entry *obj)
 	base_obj->obj =3D obj;
 	base_obj->data =3D NULL;
 	find_unresolved_deltas(base_obj);
-	display_progress(progress, nr_resolved_deltas);
+}
+
+static void *threaded_second_pass(void *arg)
+{
+#ifndef NO_PTHREADS
+	if (nr_threads > 1)
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
@@ -755,13 +875,25 @@ static void parse_pack_objects(unsigned char *sha=
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
+	if (nr_threads > 1) {
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
@@ -967,6 +1099,18 @@ static int git_index_pack_config(const char *k, c=
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
@@ -1125,6 +1269,17 @@ int cmd_index_pack(int argc, const char **argv, =
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
@@ -1196,6 +1351,15 @@ int cmd_index_pack(int argc, const char **argv, =
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
--=20
1.7.3.1.256.g2539c.dirty
