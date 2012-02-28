From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] index-pack: support multithreaded delta resolving
Date: Tue, 28 Feb 2012 11:36:53 +0700
Message-ID: <1330403813-2770-2-git-send-email-pclouds@gmail.com>
References: <1330403813-2770-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 05:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Eox-0000Yx-FX
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 05:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab2B1Ehr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 23:37:47 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50622 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2B1EhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 23:37:25 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so2845664pbc.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 20:37:25 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.218.231 as permitted sender) client-ip=10.68.218.231;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.218.231 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.218.231])
        by 10.68.218.231 with SMTP id pj7mr48812662pbc.63.1330403845040 (num_hops = 1);
        Mon, 27 Feb 2012 20:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z1+QeQajSBr1/Kl6ti4EvXoWjyzSQmmjNtakUbBLdow=;
        b=Ft6nV4UykUqbeDuFVLdURoBq+pO0OhHVHXKE3mHjCiXLnmsOv9s6j++TfTuhWq6zCl
         yUBRFQk7wj1E7a+fU4MuuBH5oTHoB2wm23dFUbQTSA9BDKcRf3/Us319xutJTxWm/m2l
         XPNJiYLhijDQjq98qL0Pw4ZuHyBjFKu6i2360=
Received: by 10.68.218.231 with SMTP id pj7mr41168816pbc.63.1330403844985;
        Mon, 27 Feb 2012 20:37:24 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g3sm14569798pbt.41.2012.02.27.20.37.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 20:37:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Feb 2012 11:37:02 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330403813-2770-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191699>

This puts delta resolving on each base on a separate thread, one base
cache per thread.

An experiment on a 24 core machine with git.git shows that performance
does not increase proportional to the number of cores. So by default,
we use maximum 3 cores.

$ /usr/bin/time ~/t/git index-pack --threads=3D1 -v --stdin < XXX.pack
Receiving objects: 100% (146564/146564), 53.99 MiB | 17.47 MiB/s, done.
Resolving deltas: 100% (109205/109205), done.
pack    d5471e8365717a5812cbc81ec7277cb697a80f08
11.58user 0.37system 0:12.04elapsed 99%CPU (0avgtext+0avgdata 375088max=
resident)k
0inputs+118592outputs (0major+56894minor)pagefaults 0swaps

$ ... --threads=3D2 ...
14.58user 0.47system 0:09.99elapsed 150%CPU (0avgtext+0avgdata 411536ma=
xresident)k
0inputs+118592outputs (0major+79961minor)pagefaults 0swaps

$ ... --threads=3D3 ...
14.36user 0.64system 0:08.12elapsed 184%CPU (0avgtext+0avgdata 393312ma=
xresident)k
0inputs+118592outputs (0major+50998minor)pagefaults 0swaps

$ ... --threads=3D4 ...
15.81user 0.71system 0:08.17elapsed 202%CPU (0avgtext+0avgdata 419152ma=
xresident)k
0inputs+118592outputs (0major+54907minor)pagefaults 0swaps

$ ... --threads=3D5 ...
14.76user 0.72system 0:07.06elapsed 219%CPU (0avgtext+0avgdata 414112ma=
xresident)k
0inputs+118592outputs (0major+59547minor)pagefaults 0swaps

$ ... --threads=3D8 ...
15.98user 0.81system 0:07.71elapsed 217%CPU (0avgtext+0avgdata 429904ma=
xresident)k
0inputs+118592outputs (0major+66221minor)pagefaults 0swaps

$ ... --threads=3D12 ...
15.81user 0.74system 0:09.60elapsed 172%CPU (0avgtext+0avgdata 442336ma=
xresident)k
0inputs+118592outputs (0major+61353minor)pagefaults 0swaps

$ ... --threads=3D16 ...
15.41user 0.57system 0:11.62elapsed 137%CPU (0avgtext+0avgdata 451728ma=
xresident)k
0inputs+118592outputs (0major+63569minor)pagefaults 0swaps

$ ... --threads=3D24 ...
15.84user 0.63system 0:12.83elapsed 128%CPU (0avgtext+0avgdata 475728ma=
xresident)k
0inputs+118592outputs (0major+58013minor)pagefaults 0swaps

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On linux-2.6.git, 2 cores, real time from 3m18 went down to around 2m.

 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  188 ++++++++++++++++++++++++++++++=
++++----
 3 files changed, 180 insertions(+), 20 deletions(-)

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
index 918684f..e331f23 100644
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
@@ -75,6 +86,42 @@ static git_SHA_CTX input_ctx;
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
@@ -223,6 +270,18 @@ static NORETURN void bad_object(unsigned long offs=
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
@@ -237,15 +296,16 @@ static void free_base_data(struct base_data *c)
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
@@ -257,22 +317,23 @@ static void link_base_data(struct base_data *base=
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
@@ -461,19 +522,24 @@ static void sha1_object(const void *data, unsigne=
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
@@ -507,6 +573,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			}
 			obj->flags |=3D FLAG_CHECKED;
 		}
+		read_unlock();
 	}
 }
=20
@@ -552,7 +619,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -568,7 +635,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -596,7 +663,7 @@ static void resolve_delta(struct object_entry *delt=
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
@@ -696,7 +763,35 @@ static void second_pass(struct object_entry *obj)
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
+		int i, nr =3D 16;
+		work_lock();
+		nr_resolved_deltas +=3D data->nr_resolved_deltas;
+		display_progress(progress, nr_resolved_deltas);
+		data->nr_resolved_deltas =3D 0;
+		while (nr_processed < nr_objects &&
+		       is_delta_type(objects[nr_processed].type))
+			nr_processed++;
+		if (nr_processed >=3D nr_objects) {
+			work_unlock();
+			break;
+		}
+		i =3D nr_processed;
+		nr_processed +=3D nr;
+		work_unlock();
+
+		for (; nr && i < nr_objects; i++, nr--) {
+			if (is_delta_type(objects[i].type))
+				continue;
+			second_pass(&objects[i]);
+		}
+	}
+	return NULL;
 }
=20
 /* Parse all objects and return the pack content SHA1 hash */
@@ -755,13 +850,30 @@ static void parse_pack_objects(unsigned char *sha=
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
+
+		/* stop get_thread_data() from looking up beyond the
+		   first item, when fix_unresolved_deltas() runs */
+		nr_threads =3D 1;
+		return;
 	}
+#endif
+	threaded_second_pass(thread_data);
 }
=20
 static int write_compressed(struct sha1file *f, void *in, unsigned int=
 size)
@@ -967,6 +1079,17 @@ static int git_index_pack_config(const char *k, c=
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
+#endif
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
=20
@@ -1125,6 +1248,16 @@ int cmd_index_pack(int argc, const char **argv, =
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
@@ -1196,6 +1329,23 @@ int cmd_index_pack(int argc, const char **argv, =
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
1.7.3.1.256.g2539c.dirty
