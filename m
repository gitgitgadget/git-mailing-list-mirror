From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v4] Threaded grep
Date: Mon, 25 Jan 2010 23:51:39 +0100
Message-ID: <20100125225139.GA3048@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 23:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZXmi-0001og-9f
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 23:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab0AYWvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 17:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800Ab0AYWvr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 17:51:47 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33700 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab0AYWvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 17:51:45 -0500
Received: by ewy19 with SMTP id 19so315631ewy.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=IMxlkiunYu467y68geAxuGf+2Fmi6Pe6aT3GgMktB7c=;
        b=xWAtPqsxfFPb6f+w2W/DzrNUNw1DT3kIzSRqTM0tCDU2OdmoUKhDpn2oIPE1Lo76Yx
         H5p3V53ehbLyzMCNtL8jbyH5kfkpFBJkPZFFk+aZMPUkPrC8vRevViMUNYwygc1K+kMs
         ukMm0B08VRFtgGMNv2YmdNJYP2g0Rq7qwETeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=vRGvKl9829Y2nO1y1pENcZUCNlzWJEBaLEhrLDNw9wjbgHHG2yKBnQu2lzsTe7JvxB
         eNQjeTCMz/ZQN0WvViSYP8xcs1PyNqN+8+Fk4mBv1wWqj3pEtaXhnPf4miDjiXNVIJWD
         r2mea4yZ2+6C2RW6QUTwtczyo9LARbduNgNL0=
Received: by 10.213.109.136 with SMTP id j8mr1898419ebp.75.1264459903249;
        Mon, 25 Jan 2010 14:51:43 -0800 (PST)
Received: from fredrik-laptop (c83-250-149-66.bredband.comhem.se [83.250.149.66])
        by mx.google.com with ESMTPS id 28sm9241204eyg.20.2010.01.25.14.51.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 14:51:42 -0800 (PST)
Content-Disposition: inline
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138004>

Make git grep use threads when it is available.

The results below are best of five runs in the Linux repository (on a
box with two cores).

With the patch:

git grep qwerty
1.58user 0.55system 0:01.16elapsed 183%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+800outputs (0major+5774minor)pagefaults 0swaps

Without:

git grep qwerty
1.59user 0.43system 0:02.02elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+800outputs (0major+3716minor)pagefaults 0swaps


And with a pattern with quite a few matches:

With the patch:

$ /usr/bin/time git grep void
5.61user 0.56system 0:03.44elapsed 179%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+800outputs (0major+5587minor)pagefaults 0swaps

Without:

$ /usr/bin/time git grep void
5.36user 0.51system 0:05.87elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+800outputs (0major+3693minor)pagefaults 0swaps

In either case we gain about 40% by the threading.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

The patch has been rebased on top of next.

Additional changes since v3:

* Fix some issues with Git's native pthreads implementation on
  Windows (pthread_cond_broadcast is still used though).
* Fix style issues.
* When greping in a tree, allocate memory for the data buffer as
  late as possible.
* Return void from grep_sha1_async and grep_file_async instead of
  always returning 0.

 builtin-grep.c |  394 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 grep.c         |  106 +++++++++++++--
 grep.h         |    6 +
 3 files changed, 457 insertions(+), 49 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index da854fa..252cb0b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -16,11 +16,270 @@
 #include "quote.h"
 #include "dir.h"
 
+#ifndef NO_PTHREADS
+#include "thread-utils.h"
+#include <pthread.h>
+#endif
+
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
 	NULL
 };
 
+static int use_threads = 1;
+
+#ifndef NO_PTHREADS
+#define THREADS 8
+static pthread_t threads[THREADS];
+
+static void *load_sha1(const unsigned char *sha1, unsigned long *size,
+		       const char *name);
+static void *load_file(const char *filename, size_t *sz);
+
+enum work_type {WORK_SHA1, WORK_FILE};
+
+/* We use one producer thread and THREADS consumer
+ * threads. The producer adds struct work_items to 'todo' and the
+ * consumers pick work items from the same array.
+ */
+struct work_item
+{
+	enum work_type type;
+	char *name;
+
+	/* if type == WORK_SHA1, then 'identifier' is a SHA1,
+	 * otherwise type == WORK_FILE, and 'identifier' is a NUL
+	 * terminated filename.
+	 */
+	void *identifier;
+	char done;
+	struct strbuf out;
+};
+
+/* In the range [todo_done, todo_start) in 'todo' we have work_items
+ * that have been or are processed by a consumer thread. We haven't
+ * written the result for these to stdout yet.
+ *
+ * The work_items in [todo_start, todo_end) are waiting to be picked
+ * up by a consumer thread.
+ *
+ * The ranges are modulo TODO_SIZE.
+ */
+#define TODO_SIZE 128
+static struct work_item todo[TODO_SIZE];
+static int todo_start;
+static int todo_end;
+static int todo_done;
+
+/* Has all work items been added? */
+static int all_work_added;
+
+/* This lock protects all the variables above. */
+static pthread_mutex_t grep_lock;
+
+/* Used to serialize calls to read_sha1_file. */
+static pthread_mutex_t read_sha1_lock;
+
+/* Signalled when a new work_item is added to todo. */
+static pthread_cond_t cond_add;
+
+/* Signalled when the result from one work_item is written to
+ * stdout.
+ */
+static pthread_cond_t cond_write;
+
+/* Signalled when we are finished with everything. */
+static pthread_cond_t cond_result;
+
+static void add_work(enum work_type type, char *name, void *id)
+{
+	pthread_mutex_lock(&grep_lock);
+
+	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
+		pthread_cond_wait(&cond_write, &grep_lock);
+	}
+
+	todo[todo_end].type = type;
+	todo[todo_end].name = name;
+	todo[todo_end].identifier = id;
+	todo[todo_end].done = 0;
+	strbuf_reset(&todo[todo_end].out);
+	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
+
+	pthread_cond_signal(&cond_add);
+	pthread_mutex_unlock(&grep_lock);
+}
+
+static struct work_item *get_work()
+{
+	struct work_item *ret;
+
+	pthread_mutex_lock(&grep_lock);
+	while (todo_start == todo_end && !all_work_added) {
+		pthread_cond_wait(&cond_add, &grep_lock);
+	}
+
+	if (todo_start == todo_end && all_work_added) {
+		ret = NULL;
+	} else {
+		ret = &todo[todo_start];
+		todo_start = (todo_start + 1) % ARRAY_SIZE(todo);
+	}
+	pthread_mutex_unlock(&grep_lock);
+	return ret;
+}
+
+static void grep_sha1_async(struct grep_opt *opt, char *name,
+			    const unsigned char *sha1)
+{
+	unsigned char *s;
+	s = xmalloc(20);
+	memcpy(s, sha1, 20);
+	add_work(WORK_SHA1, name, s);
+}
+
+static void grep_file_async(struct grep_opt *opt, char *name,
+			    const char *filename)
+{
+	add_work(WORK_FILE, name, xstrdup(filename));
+}
+
+static void work_done(struct work_item *w)
+{
+	int old_done;
+
+	pthread_mutex_lock(&grep_lock);
+	w->done = 1;
+	old_done = todo_done;
+	for(; todo[todo_done].done && todo_done != todo_start;
+	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
+		w = &todo[todo_done];
+		write_or_die(1, w->out.buf, w->out.len);
+		free(w->name);
+		free(w->identifier);
+	}
+
+	if (old_done != todo_done)
+		pthread_cond_signal(&cond_write);
+
+	if (all_work_added && todo_done == todo_end)
+		pthread_cond_signal(&cond_result);
+
+	pthread_mutex_unlock(&grep_lock);
+}
+
+static void *run(void *arg)
+{
+	int hit = 0;
+	struct grep_opt *opt = arg;
+
+	while (1) {
+		struct work_item *w = get_work();
+		if (!w)
+			break;
+
+		opt->output_priv = w;
+		if (w->type == WORK_SHA1) {
+			unsigned long sz;
+			void* data;
+
+			pthread_mutex_lock(&read_sha1_lock);
+			data = load_sha1(w->identifier, &sz, w->name);
+			pthread_mutex_unlock(&read_sha1_lock);
+
+			if (data) {
+				hit |= grep_buffer(opt, w->name, data, sz);
+				free(data);
+			}
+		} else if (w->type == WORK_FILE) {
+			size_t sz;
+			void* data = load_file(w->identifier, &sz);
+			if (data) {
+				hit |= grep_buffer(opt, w->name, data, sz);
+				free(data);
+			}
+		} else {
+			assert(0);
+		}
+
+		work_done(w);
+	}
+
+	return (void*) (intptr_t) hit;
+}
+
+static void strbuf_out(struct grep_opt *opt, const void *buf, size_t size)
+{
+	struct work_item *w = opt->output_priv;
+	strbuf_add(&w->out, buf, size);
+}
+
+static void start_threads(struct grep_opt *opt)
+{
+	int i;
+
+	pthread_mutex_init(&grep_lock, NULL);
+	pthread_mutex_init(&read_sha1_lock, NULL);
+	pthread_cond_init(&cond_add, NULL);
+	pthread_cond_init(&cond_write, NULL);
+	pthread_cond_init(&cond_result, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(todo); i++) {
+		strbuf_init(&todo[i].out, 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		int err;
+		struct grep_opt *o = grep_opt_dup(opt);
+		o->output = strbuf_out;
+		compile_grep_patterns(o);
+		err = pthread_create(&threads[i], NULL, run, o);
+
+		if (err)
+			die("grep: failed to create thread: %s",
+			    strerror(err));
+	}
+}
+
+static int wait_all()
+{
+	int hit = 0;
+	int i;
+
+	pthread_mutex_lock(&grep_lock);
+	all_work_added = 1;
+
+	/* Wait until all work is done. */
+	while (todo_done != todo_end)
+		pthread_cond_wait(&cond_result, &grep_lock);
+
+	/* Wake up all the consumer threads so they can see that there
+	 * is no more work to do.
+	 */
+	pthread_cond_broadcast(&cond_add);
+	pthread_mutex_unlock(&grep_lock);
+
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		void *h;
+		pthread_join(threads[i], &h);
+		hit |= (int) (intptr_t) h;
+	}
+
+	pthread_mutex_destroy(&grep_lock);
+	pthread_mutex_destroy(&read_sha1_lock);
+	pthread_cond_destroy(&cond_add);
+	pthread_cond_destroy(&cond_write);
+	pthread_cond_destroy(&cond_result);
+
+	return hit;
+}
+#else /* !NO_PTHREADS */
+static int wait_all()
+{
+	return 0;
+}
+#endif
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -144,37 +403,60 @@ static int pathspec_matches(const char **paths, const char *name, int max_depth)
 	return 0;
 }
 
-static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name, int tree_name_len)
+static void *load_sha1(const unsigned char *sha1, unsigned long *size,
+		       const char *name)
 {
-	unsigned long size;
-	char *data;
 	enum object_type type;
-	int hit;
-	struct strbuf pathbuf = STRBUF_INIT;
+	char *data = read_sha1_file(sha1, &type, size);
 
-	data = read_sha1_file(sha1, &type, &size);
-	if (!data) {
+	if (!data)
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
-		return 0;
-	}
+
+	return data;
+}
+
+static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
+		     const char *filename, int tree_name_len)
+{
+	struct strbuf pathbuf = STRBUF_INIT;
+	char *name;
+
 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(name + tree_name_len, -1, &pathbuf, opt->prefix);
-		strbuf_insert(&pathbuf, 0, name, tree_name_len);
-		name = pathbuf.buf;
+		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
+				    opt->prefix);
+		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
+	} else {
+		strbuf_addstr(&pathbuf, filename);
+	}
+
+	name = strbuf_detach(&pathbuf, NULL);
+
+#ifndef NO_PTHREADS
+	if (use_threads) {
+		grep_sha1_async(opt, name, sha1);
+		return 0;
+	} else
+#endif
+	{
+		int hit;
+		unsigned long sz;
+		void *data = load_sha1(sha1, &sz, name);
+		if (!data)
+			hit = 0;
+		else
+			hit = grep_buffer(opt, name, data, sz);
+
+		free(data);
+		free(name);
+		return hit;
 	}
-	hit = grep_buffer(opt, name, data, size);
-	strbuf_release(&pathbuf);
-	free(data);
-	return hit;
 }
 
-static int grep_file(struct grep_opt *opt, const char *filename)
+static void *load_file(const char *filename, size_t *sz)
 {
 	struct stat st;
-	int i;
 	char *data;
-	size_t sz;
-	struct strbuf buf = STRBUF_INIT;
+	int i;
 
 	if (lstat(filename, &st) < 0) {
 	err_ret:
@@ -184,25 +466,52 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	}
 	if (!S_ISREG(st.st_mode))
 		return 0;
-	sz = xsize_t(st.st_size);
+	*sz = xsize_t(st.st_size);
 	i = open(filename, O_RDONLY);
 	if (i < 0)
 		goto err_ret;
-	data = xmalloc(sz + 1);
-	if (st.st_size != read_in_full(i, data, sz)) {
+	data = xmalloc(*sz + 1);
+	if (st.st_size != read_in_full(i, data, *sz)) {
 		error("'%s': short read %s", filename, strerror(errno));
 		close(i);
 		free(data);
 		return 0;
 	}
 	close(i);
-	data[sz] = 0;
+	data[*sz] = 0;
+	return data;
+}
+
+static int grep_file(struct grep_opt *opt, const char *filename)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *name;
+
 	if (opt->relative && opt->prefix_length)
-		filename = quote_path_relative(filename, -1, &buf, opt->prefix);
-	i = grep_buffer(opt, filename, data, sz);
-	strbuf_release(&buf);
-	free(data);
-	return i;
+		quote_path_relative(filename, -1, &buf, opt->prefix);
+	else
+		strbuf_addstr(&buf, filename);
+	name = strbuf_detach(&buf, NULL);
+
+#ifndef NO_PTHREADS
+	if (use_threads) {
+		grep_file_async(opt, name, filename);
+		return 0;
+	} else
+#endif
+	{
+		int hit;
+		size_t sz;
+		void *data = load_file(filename, &sz);
+		if (!data)
+			hit = 0;
+		else
+			hit = grep_buffer(opt, name, data, sz);
+
+		free(data);
+		free(name);
+		return hit;
+	}
 }
 
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
@@ -572,6 +881,17 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.regflags |= REG_ICASE;
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");
+
+#ifndef NO_PTHREADS
+	if (online_cpus() == 1 || !grep_threads_ok(&opt))
+		use_threads = 0;
+
+	if (use_threads)
+		start_threads(&opt);
+#else
+	use_threads = 0;
+#endif
+
 	compile_grep_patterns(&opt);
 
 	/* Check revs and then paths */
@@ -609,17 +929,26 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!use_index) {
+		int hit;
 		if (cached)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
 			die("--no-index cannot be used with revs.");
-		return !grep_directory(&opt, paths);
+		hit = grep_directory(&opt, paths);
+		if (use_threads)
+			hit |= wait_all();
+		return !hit;
 	}
 
 	if (!list.nr) {
+		int hit;
 		if (!cached)
 			setup_work_tree();
-		return !grep_cache(&opt, paths, cached);
+
+		hit = grep_cache(&opt, paths, cached);
+		if (use_threads)
+			hit |= wait_all();
+		return !hit;
 	}
 
 	if (cached)
@@ -631,6 +960,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (grep_object(&opt, paths, real_obj, list.objects[i].name))
 			hit = 1;
 	}
+
+	if (use_threads)
+		hit |= wait_all();
 	free_grep_patterns(&opt);
 	return !hit;
 }
diff --git a/grep.c b/grep.c
index 8e1f7de..d281a02 100644
--- a/grep.c
+++ b/grep.c
@@ -29,6 +29,28 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 	p->next = NULL;
 }
 
+struct grep_opt *grep_opt_dup(const struct grep_opt *opt)
+{
+	struct grep_pat *pat;
+	struct grep_opt *ret = xmalloc(sizeof(struct grep_opt));
+	*ret = *opt;
+
+	ret->pattern_list = NULL;
+	ret->pattern_tail = &ret->pattern_list;
+
+	for(pat = opt->pattern_list; pat != NULL; pat = pat->next)
+	{
+		if(pat->token == GREP_PATTERN_HEAD)
+			append_header_grep_pattern(ret, pat->field,
+						   pat->pattern);
+		else
+			append_grep_pattern(ret, pat->pattern, pat->origin,
+					    pat->no, pat->token);
+	}
+
+	return ret;
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
@@ -253,7 +275,8 @@ static int word_char(char ch)
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
+	opt->output(opt, name, strlen(name));
+	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
 
@@ -490,24 +513,32 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, char sign)
 {
 	int rest = eol - bol;
+	char sign_str[1];
 
+	sign_str[0] = sign;
 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark)
-				fputs("--\n", stdout);
+				opt->output(opt, "--\n", 3);
 			else
 				opt->show_hunk_mark = 1;
 		} else if (lno > opt->last_shown + 1)
-			fputs("--\n", stdout);
+			opt->output(opt, "--\n", 3);
 	}
 	opt->last_shown = lno;
 
 	if (opt->null_following_name)
-		sign = '\0';
-	if (opt->pathname)
-		printf("%s%c", name, sign);
-	if (opt->linenum)
-		printf("%d%c", lno, sign);
+		sign_str[0] = '\0';
+	if (opt->pathname) {
+		opt->output(opt, name, strlen(name));
+		opt->output(opt, sign_str, 1);
+	}
+	if (opt->linenum) {
+		char buf[32];
+		snprintf(buf, sizeof(buf), "%d", lno);
+		opt->output(opt, buf, strlen(buf));
+		opt->output(opt, sign_str, 1);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -518,18 +549,22 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
-			printf("%.*s%s%.*s%s",
-			       (int)match.rm_so, bol,
-			       opt->color_match,
-			       (int)(match.rm_eo - match.rm_so), bol + match.rm_so,
-			       GIT_COLOR_RESET);
+
+			opt->output(opt, bol, match.rm_so);
+			opt->output(opt, opt->color_match,
+				    strlen(opt->color_match));
+			opt->output(opt, bol + match.rm_so,
+				    (int)(match.rm_eo - match.rm_so));
+			opt->output(opt, GIT_COLOR_RESET,
+				    strlen(GIT_COLOR_RESET));
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
 		}
 		*eol = ch;
 	}
-	printf("%.*s\n", rest, bol);
+	opt->output(opt, bol, rest);
+	opt->output(opt, "\n", 1);
 }
 
 static int match_funcname(struct grep_opt *opt, char *bol, char *eol)
@@ -667,6 +702,32 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
 
+int grep_threads_ok(const struct grep_opt *opt)
+{
+	/* If this condition is true, then we may use the attribute
+	 * machinery in grep_buffer_1. The attribute code is not
+	 * thread safe, so we disable the use of threads.
+	 */
+	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	    !opt->name_only)
+		return 0;
+
+	/* If we are showing hunk marks, we should not do it for the
+	 * first match. The synchronization problem we get for this
+	 * constraint is not yet solved, so we disable threading in
+	 * this case.
+	 */
+	if (opt->pre_context || opt->post_context)
+		return 0;
+
+	return 1;
+}
+
+static void std_output(struct grep_opt *opt, const void *buf, size_t size)
+{
+	fwrite(buf, size, 1, stdout);
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -682,6 +743,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	opt->last_shown = 0;
 
+	if (!opt->output)
+		opt->output = std_output;
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
@@ -754,7 +818,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			if (opt->status_only)
 				return 1;
 			if (binary_match_only) {
-				printf("Binary file %s matches\n", name);
+				opt->output(opt, "Binary file ", 12);
+				opt->output(opt, name, strlen(name));
+				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
 			if (opt->name_only) {
@@ -810,9 +876,13 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 * which feels mostly useless but sometimes useful.  Maybe
 	 * make it another option?  For now suppress them.
 	 */
-	if (opt->count && count)
-		printf("%s%c%u\n", name,
-		       opt->null_following_name ? '\0' : ':', count);
+	if (opt->count && count) {
+		char buf[32];
+		opt->output(opt, name, strlen(name));
+		snprintf(buf, sizeof(buf), "%c%u\n",
+			 opt->null_following_name ? '\0' : ':', count);
+		opt->output(opt, buf, strlen(buf));
+	}
 	return !!last_hit;
 }
 
diff --git a/grep.h b/grep.h
index 0c61b00..9703087 100644
--- a/grep.h
+++ b/grep.h
@@ -91,6 +91,9 @@ struct grep_opt {
 	unsigned last_shown;
 	int show_hunk_mark;
 	void *priv;
+
+	void (*output)(struct grep_opt *opt, const void *data, size_t size);
+	void *output_priv;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
@@ -99,4 +102,7 @@ extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
 
+extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
+extern int grep_threads_ok(const struct grep_opt *opt);
+
 #endif
