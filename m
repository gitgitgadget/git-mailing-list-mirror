From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Fri,  2 Mar 2012 20:42:24 +0700
Message-ID: <1330695744-13854-1-git-send-email-pclouds@gmail.com>
References: <7v4nu7ilee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 14:42:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Ski-0000T9-9t
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 14:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab2CBNmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 08:42:20 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52307 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2CBNmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 08:42:18 -0500
Received: by dajr28 with SMTP id r28so2015261daj.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 05:42:18 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.216.132 as permitted sender) client-ip=10.68.216.132;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.216.132 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.216.132])
        by 10.68.216.132 with SMTP id oq4mr16636676pbc.41.1330695738026 (num_hops = 1);
        Fri, 02 Mar 2012 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kV7MMMKpGktoCgCUAch9y8UET6wdarKdOd7PfbmHpZg=;
        b=k1vIyDvOcSQ2iwhFWsltZbU17uVnF1CQho3QcQLd/DCqsjk1l9N7DEH4Y0kvPQM21a
         729pZ5vAc/d2ywMQLW0iIMwqrQlkUBo7emaG4ikhNp0bKYiJf38MVt7gEGLCST1EyyX1
         /ZnWssGqPASwbVO7EaMUSraA2vBGRQePFPqLBykQAI/+DLqcwWqjGuJCpJxv3iIxy1pz
         BTfRnWIjL1hh/+1z0xSs51y4MnpUwk78I2336X5TaXfsP32WKc052f3DCaEuXU8CHejt
         dZv5AWBRE3duwcGtgUULFXQ/qWIWS/86ckfKaRcWFWstMhlBFF+4ALk8BiqWBaUEEfdn
         3WgQ==
Received: by 10.68.216.132 with SMTP id oq4mr13904913pbc.41.1330695737293;
        Fri, 02 Mar 2012 05:42:17 -0800 (PST)
Received: from tre ([115.74.34.94])
        by mx.google.com with ESMTPS id y9sm5073717pbi.3.2012.03.02.05.42.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 05:42:15 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 02 Mar 2012 20:42:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7v4nu7ilee.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192041>

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
 2012/3/2 Junio C Hamano <gitster@pobox.com>:
 > When applied to 25a7850 and then merged to 'pu', the result fails to
 > correctly produce pack .idx file.
 >
 > I spent an hour or so this afternoon, scratching my head, staring at=
 the
 > output from tests added to t5510 by today's tr/maint-bundle-boundary=
 topic
 > to see where it breaks.  Its last test creates a bundle that has thr=
ee
 > objects, extracts a pack from it, and runs "index-pack --fix-thin" o=
n it.
 >
 > This topic makes it fail with "fatal: pack has 1 unresolved deltas".

 And it thought it was good enough to CC you. Apparently parallel
 programming is hard. I make two mistakes:

 1. I make each thread save resolved delta counter in
    thread_data[].nr_resolved_deltas, then accumulate all of them to
    global nr_resolved_deltas later. This plan does not work with
    fix_unresolved_deltas() because it runs in single thread mode. It
    stores the counter in thread_data[0], but the counter is never
    added back to global nr_resolved_deltas. This makes t5510 fail.

 2. The reason I put nr_resolved_deltas to thread-local struct is to
    avoid locking. But I'm wrong. I still have two places where
    thread_data[].nr_resolved_deltas can be changed: increment in
    resolve_delta() and and reset in threaded_second_pass().

 So locking is required for changing nr_resolved_deltas anyway, I have
 removed thread_data[].nr_resolved_deltas and do the locking on global
 nr_resolved_deltas properly. "pu" seems to be happy with the updated
 series.

 One other thing. I did not consider to run fix_unresolved_deltas() in
 parallel originally because I didn't think it could be done. It can.
 But I'm not sure it's worth the effort. Anyway we can do that later
 if it turns out worth it.

 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  214 ++++++++++++++++++++++++++++++=
++++----
 3 files changed, 206 insertions(+), 20 deletions(-)

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
index 918684f..edd7cbd 100644
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
@@ -39,6 +40,19 @@ struct base_data {
 };
=20
 /*
+ * Thread-local data for find_unresolved_deltas(). The main process
+ * also takes thread_data[0] to run find_unresolved_deltas() as part
+ * of fix_unresolved_deltas().
+ */
+struct thread_local {
+#ifndef NO_PTHREADS
+	pthread_t thread;
+#endif
+	struct base_data *base_cache;
+	size_t base_cache_used;
+};
+
+/*
  * Even if sizeof(union delta_base) =3D=3D 24 on 64-bit archs, we real=
ly want
  * to memcmp() only the first 20 bytes.
  */
@@ -54,11 +68,12 @@ struct delta_entry {
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
@@ -75,6 +90,49 @@ static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+#ifndef NO_PTHREADS
+
+static pthread_mutex_t read_mutex;
+#define read_lock()		pthread_mutex_lock(&read_mutex)
+#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+
+static pthread_mutex_t counter_mutex;
+#define counter_lock()		pthread_mutex_lock(&counter_mutex)
+#define counter_unlock()		pthread_mutex_unlock(&counter_mutex)
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
@@ -223,6 +281,36 @@ static NORETURN void bad_object(unsigned long offs=
et, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
=20
+static struct thread_local *get_thread_data(void)
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
+static void resolve_one_delta(void)
+{
+#ifndef NO_PTHREADS
+	int i;
+	pthread_t self =3D pthread_self();
+	for (i =3D 1; i < nr_threads; i++)
+		if (self =3D=3D thread_data[i].thread) {
+			counter_lock();
+			nr_resolved_deltas++;
+			counter_unlock();
+			return;
+		}
+#endif
+	assert(nr_threads =3D=3D 1 &&
+	       "This should only be reached when all threads are gone");
+	nr_resolved_deltas++;
+}
+
 static struct base_data *alloc_base_data(void)
 {
 	struct base_data *base =3D xmalloc(sizeof(struct base_data));
@@ -237,15 +325,16 @@ static void free_base_data(struct base_data *c)
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
@@ -257,22 +346,23 @@ static void link_base_data(struct base_data *base=
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
@@ -461,19 +551,24 @@ static void sha1_object(const void *data, unsigne=
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
@@ -507,6 +602,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			}
 			obj->flags |=3D FLAG_CHECKED;
 		}
+		read_unlock();
 	}
 }
=20
@@ -552,7 +648,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -568,7 +664,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, "failed to apply delta");
-			base_cache_used +=3D c->size;
+			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -596,7 +692,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
-	nr_resolved_deltas++;
+	resolve_one_delta();
 }
=20
 static struct base_data *find_unresolved_deltas_1(struct base_data *ba=
se,
@@ -696,7 +792,32 @@ static void second_pass(struct object_entry *obj)
 	base_obj->obj =3D obj;
 	base_obj->data =3D NULL;
 	find_unresolved_deltas(base_obj);
-	display_progress(progress, nr_resolved_deltas);
+}
+
+static void *threaded_second_pass(void *arg)
+{
+	for (;;) {
+		int i, nr =3D 16;
+		work_lock();
+		display_progress(progress, nr_resolved_deltas);
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
@@ -755,13 +876,30 @@ static void parse_pack_objects(unsigned char *sha=
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
@@ -967,6 +1105,17 @@ static int git_index_pack_config(const char *k, c=
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
@@ -1125,6 +1274,16 @@ int cmd_index_pack(int argc, const char **argv, =
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
@@ -1196,6 +1355,23 @@ int cmd_index_pack(int argc, const char **argv, =
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
1.7.8.36.g69ee2
