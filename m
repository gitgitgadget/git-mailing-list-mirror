From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] index-pack: support multithreaded delta resolving
Date: Sat, 25 Feb 2012 17:56:16 +0700
Message-ID: <1330167376-24859-5-git-send-email-pclouds@gmail.com>
References: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 11:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FGq-0000ck-8g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 11:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab2BYKy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 05:54:26 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49280 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab2BYKyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 05:54:25 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so390805pbc.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 02:54:25 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.130.134 as permitted sender) client-ip=10.68.130.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.130.134 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.130.134])
        by 10.68.130.134 with SMTP id oe6mr17584036pbb.93.1330167265036 (num_hops = 1);
        Sat, 25 Feb 2012 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QPd98fdMwN6kncVumaoTiMGjyz1akL9oTCnxjBn+AHE=;
        b=gq2lNOarRQpOkkjoV56ntlQHSs+8vI9wYK/ZxccXHGpFiHczZ+3ToAm68mOCxbQwCC
         Bi9oJSCZJlaNCZbsA5SH+RyKasvLuOMoNm5RQ+c3CQw57AdBSR2nGJCVNBUWMjOD4Pop
         L1jnL5RyPDTn1B9fEftG6uKAZIGcrbWdoS/2k=
Received: by 10.68.130.134 with SMTP id oe6mr14580434pbb.93.1330167264982;
        Sat, 25 Feb 2012 02:54:24 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id u9sm6920785pbj.39.2012.02.25.02.54.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 02:54:24 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 17:56:42 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191521>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt         |    4 +
 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  197 ++++++++++++++++++++++++++++++=
++------
 4 files changed, 182 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e55dae1..965304b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -445,6 +445,10 @@ for all users/operating systems, except on the lar=
gest projects.
 You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
++
+When gitlink:git-index-pack[1] runs on more than one thread, this
+value is applied per thread so the total amount of used memory depends
+on how many threads are used.
=20
 core.bigFileThreshold::
 	Files larger than this size are stored deflated, without
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index 909687f..7e5f61b 100644
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
+	and set the number of threads accordingly.
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
index e1e858a..120195a 100644
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
@@ -38,6 +39,15 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
=20
+struct thread_local {
+#ifndef NO_PTHREADS
+	pthread_t thread;
+#endif
+	struct base_data *base_cache;
+	size_t base_cache_used;
+	int nr_resolved_deltas;
+};
+
 /*
  * Even if sizeof(union delta_base) =3D=3D 24 on 64-bit archs, we real=
ly want
  * to memcmp() only the first 20 bytes.
@@ -54,11 +64,12 @@ struct delta_entry {
=20
 static struct object_entry *objects;
 static struct delta_entry *deltas;
-static struct base_data *base_cache;
-static size_t base_cache_used;
+static struct thread_local *thread_data;
 static int nr_objects;
+static int nr_processed;
 static int nr_deltas;
 static int nr_resolved_deltas;
+static int nr_threads;
=20
 static int from_stdin;
 static int strict;
@@ -76,6 +87,42 @@ static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+#ifndef NO_PTHREADS
+
+static pthread_mutex_t read_mutex;
+#define read_lock()		pthread_mutex_lock(&read_mutex)
+#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+
+static pthread_mutex_t work_mutex;
+#define work_lock()		pthread_mutex_lock(&work_mutex)
+#define work_unlock()		pthread_mutex_unlock(&work_mutex)
+
+/*
+ * Mutex and conditional variable can't be statically-initialized on W=
indows.
+ */
+static void init_thread(void)
+{
+	init_recursive_mutex(&read_mutex);
+	pthread_mutex_init(&work_mutex, NULL);
+}
+
+static void cleanup_thread(void)
+{
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&work_mutex);
+}
+
+#else
+
+#define read_lock()
+#define read_unlock()
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
@@ -224,6 +271,18 @@ static NORETURN void bad_object(unsigned long offs=
et, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
=20
+static struct thread_local *get_thread_data()
+{
+#ifndef NO_PTHREADS
+	int i;
+	pthread_t self =3D pthread_self();
+	for (i =3D 1; i < nr_threads; i++)
+		if (self =3D=3D thread_data[i].thread)
+			return &thread_data[i];
+#endif
+	return &thread_data[0];
+}
+
 static struct base_data *alloc_base_data(void)
 {
 	struct base_data *base =3D xmalloc(sizeof(struct base_data));
@@ -238,15 +297,16 @@ static void free_base_data(struct base_data *c)
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
@@ -258,22 +318,23 @@ static void link_base_data(struct base_data *base=
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
 static void unlink_base_data(struct base_data *c)
 {
-	struct base_data *base =3D c->base;
+	struct base_data *base;
+	base =3D c->base;
 	if (base)
 		base->child =3D NULL;
 	else
-		base_cache =3D NULL;
+		get_thread_data()->base_cache =3D NULL;
 	free_base_data(c);
 }
=20
@@ -503,19 +564,25 @@ static void sha1_object(const void *data, unsigne=
d long size,
 {
 	if (data)
 		hash_sha1_file(data, size, typename(type), sha1);
-	if (data && (strict || !verify) && has_sha1_file(sha1)) {
-		void *has_data;
-		enum object_type has_type;
-		unsigned long has_size;
-		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
-		if (!has_data)
-			die("cannot read existing object %s", sha1_to_hex(sha1));
-		if (size !=3D has_size || type !=3D has_type ||
-		    memcmp(data, has_data, size) !=3D 0)
-			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
-		free(has_data);
+	if (data && (strict || !verify)) {
+		read_lock();
+		if (has_sha1_file(sha1)) {
+			void *has_data;
+			enum object_type has_type;
+			unsigned long has_size;
+			has_data =3D read_sha1_file(sha1, &has_type, &has_size);
+			read_unlock();
+			if (!has_data)
+				die("cannot read existing object %s", sha1_to_hex(sha1));
+			if (size !=3D has_size || type !=3D has_type ||
+			    memcmp(data, has_data, size) !=3D 0)
+				die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+			free(has_data);
+		} else
+			read_unlock();
 	}
 	if (strict) {
+		read_lock();
 		if (type =3D=3D OBJ_BLOB) {
 			struct blob *blob =3D lookup_blob(sha1);
 			if (blob)
@@ -549,6 +616,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			}
 			obj->flags |=3D FLAG_CHECKED;
 		}
+		read_unlock();
 	}
 }
=20
@@ -589,7 +657,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -605,7 +673,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -633,7 +701,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
-	nr_resolved_deltas++;
+	get_thread_data()->nr_resolved_deltas++;
 }
=20
 static struct base_data *find_unresolved_deltas_1(struct base_data *ba=
se,
@@ -745,7 +813,30 @@ static void second_pass(struct object_entry *obj)
 	base_obj->obj =3D obj;
 	base_obj->data =3D NULL;
 	find_unresolved_deltas(base_obj);
-	display_progress(progress, nr_resolved_deltas);
+}
+
+static void *threaded_second_pass(void *arg)
+{
+	struct thread_local *data =3D get_thread_data();
+	for (;;) {
+		int i;
+		work_lock();
+		nr_resolved_deltas +=3D data->nr_resolved_deltas;
+		display_progress(progress, nr_resolved_deltas);
+		data->nr_resolved_deltas =3D 0;
+		while (nr_processed < nr_objects &&
+		       is_delta_type(objects[nr_processed].type))
+			nr_processed++;
+		if (nr_processed =3D=3D nr_objects) {
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
@@ -804,14 +895,26 @@ static void parse_pack_objects(unsigned char *sha=
1)
=20
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
-	for (i =3D 0; i < nr_objects; i++) {
-		struct object_entry *obj =3D &objects[i];
-
-		if (is_delta_type(obj->type))
-			continue;
=20
-		second_pass(obj);
+	nr_processed =3D 0;
+#ifndef NO_PTHREADS
+	if (nr_threads > 1) {
+		init_thread();
+		for (i =3D 1; i < nr_threads; i++) {
+			int ret =3D pthread_create(&thread_data[i].thread, NULL,
+						 threaded_second_pass, NULL);
+			if (ret)
+				die("unable to create thread: %s", strerror(ret));
+		}
+		for (i =3D 1; i < nr_threads; i++) {
+			pthread_join(thread_data[i].thread, NULL);
+			thread_data[i].thread =3D 0;
+		}
+		cleanup_thread();
+		return;
 	}
+#endif
+	threaded_second_pass(thread_data);
 }
=20
 static int write_compressed(struct sha1file *f, void *in, unsigned int=
 size)
@@ -1017,6 +1120,17 @@ static int git_index_pack_config(const char *k, =
const char *v, void *cb)
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
+#endif
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
=20
@@ -1175,6 +1289,16 @@ int cmd_index_pack(int argc, const char **argv, =
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
+#endif
 			} else if (!prefixcmp(arg, "--pack_header=3D")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1246,6 +1370,19 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	if (strict)
 		opts.flags |=3D WRITE_IDX_STRICT;
=20
+#ifndef NO_PTHREADS
+	if (!nr_threads)
+		nr_threads =3D online_cpus();
+	/* reserve thread_data[0] for the main thread */
+	if (nr_threads > 1)
+		nr_threads++;
+#else
+	if (nr_threads !=3D 1)
+		warning("no threads support, ignoring --threads");
+	nr_threads =3D 1;
+#endif
+	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
--=20
1.7.8.36.g69ee2
