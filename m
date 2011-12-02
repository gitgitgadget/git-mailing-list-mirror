From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Fri, 2 Dec 2011 14:07:48 +0100
Message-ID: <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Dec 02 14:08:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWSqW-000567-PA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 14:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab1LBNHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 08:07:54 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:53773 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269Ab1LBNHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 08:07:52 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:47 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:49 +0100
X-Mailer: git-send-email 1.7.8.rc4.388.ge53ab
In-Reply-To: <cover.1322830368.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186218>

Measuring grep performance showed that in all but the worktree case
(as opposed to --cached, <committish> or <treeish>), threading
actually slows things down.  For example, on my dual-core
hyperthreaded i7 in a linux-2.6.git at v2.6.37-rc2, I got:

Threads       worktree case                 | --cached case
--------------------------------------------------------------------------
8 (default) | 2.17user 0.15sys 0:02.20real  | 0.11user 0.26sys 0:00.11real
4           | 2.06user 0.17sys 0:02.08real  | 0.11user 0.26sys 0:00.12real
2           | 2.02user 0.25sys 0:02.08real  | 0.15user 0.37sys 0:00.28real
NO_PTHREADS | 1.57user 0.05sys 0:01.64real  | 0.09user 0.12sys 0:00.22real

I conjecture that this is caused by contention on read_sha1_mutex.

So disable threading entirely when not scanning the worktree, to get
the NO_PTHREADS performance in that case.  This obsoletes all code
related to grep_sha1_async.  The thread startup must be delayed until
after all arguments have been parsed, but this does not have a
measurable effect.
---
 builtin/grep.c |  157 ++++++++++++++++----------------------------------------
 1 files changed, 44 insertions(+), 113 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 65b1ffe..edf6a31 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -34,21 +34,13 @@
 		       const char *name);
 static void *load_file(const char *filename, size_t *sz);
 
-enum work_type {WORK_SHA1, WORK_FILE};
-
 /* We use one producer thread and THREADS consumer
  * threads. The producer adds struct work_items to 'todo' and the
  * consumers pick work items from the same array.
  */
 struct work_item {
-	enum work_type type;
 	char *name;
-
-	/* if type == WORK_SHA1, then 'identifier' is a SHA1,
-	 * otherwise type == WORK_FILE, and 'identifier' is a NUL
-	 * terminated filename.
-	 */
-	void *identifier;
+	char *filename;
 	char done;
 	struct strbuf out;
 };
@@ -86,21 +78,6 @@ static inline void grep_unlock(void)
 		pthread_mutex_unlock(&grep_mutex);
 }
 
-/* Used to serialize calls to read_sha1_file. */
-static pthread_mutex_t read_sha1_mutex;
-
-static inline void read_sha1_lock(void)
-{
-	if (use_threads)
-		pthread_mutex_lock(&read_sha1_mutex);
-}
-
-static inline void read_sha1_unlock(void)
-{
-	if (use_threads)
-		pthread_mutex_unlock(&read_sha1_mutex);
-}
-
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
 
@@ -114,7 +91,7 @@ static inline void read_sha1_unlock(void)
 
 static int skip_first_line;
 
-static void add_work(enum work_type type, char *name, void *id)
+static void add_work(char *name, char *filename)
 {
 	grep_lock();
 
@@ -122,9 +99,8 @@ static void add_work(enum work_type type, char *name, void *id)
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	todo[todo_end].type = type;
 	todo[todo_end].name = name;
-	todo[todo_end].identifier = id;
+	todo[todo_end].filename = filename;
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
@@ -152,19 +128,10 @@ static void add_work(enum work_type type, char *name, void *id)
 	return ret;
 }
 
-static void grep_sha1_async(struct grep_opt *opt, char *name,
-			    const unsigned char *sha1)
-{
-	unsigned char *s;
-	s = xmalloc(20);
-	memcpy(s, sha1, 20);
-	add_work(WORK_SHA1, name, s);
-}
-
 static void grep_file_async(struct grep_opt *opt, char *name,
 			    const char *filename)
 {
-	add_work(WORK_FILE, name, xstrdup(filename));
+	add_work(name, xstrdup(filename));
 }
 
 static void work_done(struct work_item *w)
@@ -194,7 +161,7 @@ static void work_done(struct work_item *w)
 			write_or_die(1, p, len);
 		}
 		free(w->name);
-		free(w->identifier);
+		free(w->filename);
 	}
 
 	if (old_done != todo_done)
@@ -213,29 +180,18 @@ static void work_done(struct work_item *w)
 
 	while (1) {
 		struct work_item *w = get_work();
+		size_t sz;
+		void* data;
+
 		if (!w)
 			break;
 
 		opt->output_priv = w;
-		if (w->type == WORK_SHA1) {
-			unsigned long sz;
-			void* data = load_sha1(w->identifier, &sz, w->name);
-
-			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
-				free(data);
-			}
-		} else if (w->type == WORK_FILE) {
-			size_t sz;
-			void* data = load_file(w->identifier, &sz);
-			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
-				free(data);
-			}
-		} else {
-			assert(0);
+		data = load_file(w->filename, &sz);
+		if (data) {
+			hit |= grep_buffer(opt, w->name, data, sz);
+			free(data);
 		}
-
 		work_done(w);
 	}
 	free_grep_patterns(arg);
@@ -255,7 +211,6 @@ static void start_threads(struct grep_opt *opt)
 	int i;
 
 	pthread_mutex_init(&grep_mutex, NULL);
-	pthread_mutex_init(&read_sha1_mutex, NULL);
 	pthread_mutex_init(&grep_attr_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
@@ -303,7 +258,6 @@ static int wait_all(void)
 	}
 
 	pthread_mutex_destroy(&grep_mutex);
-	pthread_mutex_destroy(&read_sha1_mutex);
 	pthread_mutex_destroy(&grep_attr_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
@@ -312,9 +266,6 @@ static int wait_all(void)
 	return hit;
 }
 #else /* !NO_PTHREADS */
-#define read_sha1_lock()
-#define read_sha1_unlock()
-
 static int wait_all(void)
 {
 	return 0;
@@ -371,21 +322,11 @@ static int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
-{
-	void *data;
-
-	read_sha1_lock();
-	data = read_sha1_file(sha1, type, size);
-	read_sha1_unlock();
-	return data;
-}
-
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name)
 {
 	enum object_type type;
-	void *data = lock_and_read_sha1_file(sha1, &type, size);
+	void *data = read_sha1_file(sha1, &type, size);
 
 	if (!data)
 		error(_("'%s': unable to read %s"), name, sha1_to_hex(sha1));
@@ -398,6 +339,9 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 {
 	struct strbuf pathbuf = STRBUF_INIT;
 	char *name;
+	int hit;
+	unsigned long sz;
+	void *data;
 
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
@@ -409,25 +353,15 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 
 	name = strbuf_detach(&pathbuf, NULL);
 
-#ifndef NO_PTHREADS
-	if (use_threads) {
-		grep_sha1_async(opt, name, sha1);
-		return 0;
-	} else
-#endif
-	{
-		int hit;
-		unsigned long sz;
-		void *data = load_sha1(sha1, &sz, name);
-		if (!data)
-			hit = 0;
-		else
-			hit = grep_buffer(opt, name, data, sz);
+	data = load_sha1(sha1, &sz, name);
+	if (!data)
+		hit = 0;
+	else
+		hit = grep_buffer(opt, name, data, sz);
 
-		free(data);
-		free(name);
-		return hit;
-	}
+	free(data);
+	free(name);
+	return hit;
 }
 
 static void *load_file(const char *filename, size_t *sz)
@@ -586,7 +520,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_sha1_file(entry.sha1, &type, &size);
+			data = read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    sha1_to_hex(entry.sha1));
@@ -616,10 +550,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		read_sha1_lock();
 		data = read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
-		read_sha1_unlock();
 
 		if (!data)
 			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
@@ -1003,26 +935,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
-#ifndef NO_PTHREADS
-	if (online_cpus() == 1)
-		use_threads = 0;
-#else
-	use_threads = 0;
-#endif
-
-	opt.use_threads = use_threads;
-
-#ifndef NO_PTHREADS
-	if (use_threads) {
-		if (opt.pre_context || opt.post_context || opt.file_break ||
-		    opt.funcbody)
-			skip_first_line = 1;
-		start_threads(&opt);
-	}
-#else
-	use_threads = 0;
-#endif
-
 	compile_grep_patterns(&opt);
 
 	/* Check revs and then paths */
@@ -1044,6 +956,25 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+#ifndef NO_PTHREADS
+	if (online_cpus() == 1 || cached || list.nr)
+		use_threads = 0;
+#else
+	use_threads = 0;
+#endif
+
+	opt.use_threads = use_threads;
+
+#ifndef NO_PTHREADS
+	if (use_threads) {
+		opt.use_threads = use_threads;
+		if (opt.pre_context || opt.post_context || opt.file_break ||
+		    opt.funcbody)
+			skip_first_line = 1;
+		start_threads(&opt);
+	}
+#endif
+
 	/* The rest are paths */
 	if (!seen_dashdash) {
 		int j;
-- 
1.7.8.rc4.388.ge53ab
