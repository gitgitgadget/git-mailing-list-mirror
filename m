From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2] Threaded grep
Date: Wed, 13 Jan 2010 00:44:41 +0100
Message-ID: <20100112234441.GA19578@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 00:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUqPu-00026F-KK
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 00:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab0ALXot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 18:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403Ab0ALXot
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 18:44:49 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:43598 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab0ALXor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 18:44:47 -0500
Received: by ewy1 with SMTP id 1so5382724ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=dNztmZ0a6EqwstnZiV0e6Tdd/ZdeCEg24lXgYNrMURc=;
        b=ovKeMmdDrRJieXSxOrJTrMM7rn7Nd48Mcw+SyBUOV1fhKbQybBsfH/5B/GanTvEHRp
         l0O+hGlj+PR9YTxP4QrGoyj0o8x8EpTRE8eCEq6Ug4JWMyjbJPPf5ZBc9qRYFp34k2bB
         jQHnZlmhdusmjOgKcXAwtk9jUiXJcPj7KH2fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ZDWqSyIckZ6XDQ3RXiqkERNnCoTBPAUxuALcPOrk0pl0xzEauvK/XFTKlOuEU7eB5k
         bjnzjGF562QKgqFzXAJuQo6zuEBbX578fLvKQimi2Mh8gdOxOQN+1UwAUFm1m4Y16RUx
         +TTMmmCqn0AzhuBtxYiQKmX9+K3rLf6QWH6HY=
Received: by 10.216.91.82 with SMTP id g60mr2708620wef.98.1263339885347;
        Tue, 12 Jan 2010 15:44:45 -0800 (PST)
Received: from fredrik-laptop (c83-250-149-66.bredband.comhem.se [83.250.149.66])
        by mx.google.com with ESMTPS id 5sm8178169eyf.6.2010.01.12.15.44.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Jan 2010 15:44:44 -0800 (PST)
Content-Disposition: inline
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136761>

This the second version of the threaded grep patch. It applies cleanly
on top of pu.

Two environment variables can be used to control the threading. If
NO_THREADS is set, then the old non-threaded code will be used.
THREADS can be set to an integer to specify the number of threads that
should be used. If neither NO_THREADS nor THREADS is set, 8 threads
are used.

The results below are best of five runs in the Linux repository on a
box with two cores.

git grep --no-ext-grep qwerty

4.38user 0.57system 0:02.69elapsed 183%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+784outputs (0major+6206minor)pagefaults 0swaps

NO_THREADS=1 git grep --no-ext-grep qwerty
4.33user 0.48system 0:04.82elapsed 99%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+784outputs (0major+3523minor)pagefaults 0swaps


And with a pattern with quite a few matches:

git grep --no-ext-grep function
6.28user 0.63system 0:03.97elapsed 173%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+784outputs (0major+8101minor)pagefaults 0swaps

NO_THREADS=1 git grep --no-ext-grep function
6.21user 0.50system 0:06.71elapsed 100%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+784outputs (0major+3523minor)pagefaults 0swaps


In either case we gain about 40% by the threading. More testing is, as
always, greatly appreciated.

The patch needs some further clean-ups before it can be considered for
application.

---
Major changes since v1:

* Buffer the output from the threads instead of waiting until the
  result can be written to stdout.

* Limit the maximum number of pending work_items.


 builtin-grep.c |  340 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 grep.c         |   85 ++++++++++++--
 grep.h         |    6 +
 strbuf.c       |   19 ++-
 strbuf.h       |    1 
 5 files changed, 413 insertions(+), 38 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 59c4b12..ebeede9 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -15,6 +15,13 @@
 #include "grep.h"
 #include "quote.h"
 
+#ifdef THREADED_DELTA_SEARCH
+#include "thread-utils.h"
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+#endif
+
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
 #define NO_EXTERNAL_GREP 0
@@ -23,6 +30,262 @@
 #endif
 #endif
 
+static int use_threads = 1;
+
+#ifdef THREADED_DELTA_SEARCH
+
+static void* load_file(const char *filename, size_t *sz);
+
+enum work_type {WORK_BUF, WORK_FILE};
+
+/* We use one producer thread and number_of_threads consumer
+   threads. The producer adds struct work_items to 'todo' and the
+   consumers pick work items from the same array. */
+struct work_item
+{
+	enum work_type type;
+	char *name;
+
+	/* if type == WORK_BUF, then 'buf' points to a buffer of size
+	   'size' otherwise type == WORK_FILE and 'buf' is a nul
+	   terminated filename. */
+	char *buf;
+	size_t size;
+	char done;
+	struct strbuf out;
+};
+
+/* Number of consumer threads. */
+static int number_of_threads;
+static pthread_t *threads;
+
+/* In the range [todo_done, todo_start) in 'todo' we have work_items
+   that have been or are processed by a consumer thread. We haven't
+   written the result for these to stdout yet.
+
+   The work_items in [todo_start, todo_end) are waiting to be picked
+   up by a consumer thread.
+
+   The ranges are modulo todo_alloc.
+*/
+static struct work_item *todo = NULL;
+static int todo_alloc = 0;
+static int todo_start = 0;
+static int todo_end = 0;
+static int todo_done = 0;
+
+/* Has all work items been added? */
+static int all_work_added = 0;
+
+/* This lock protects all the variables above. */
+static pthread_mutex_t grep_lock = PTHREAD_MUTEX_INITIALIZER;
+
+/* Signalled when a new work_item is added to todo. */
+static pthread_cond_t cond_add = PTHREAD_COND_INITIALIZER;
+
+/* Signalled when the result from one work_item is written to
+   stdout. */
+static pthread_cond_t cond_write = PTHREAD_COND_INITIALIZER;
+
+/* Signalled when we are finished with everything. */
+static pthread_cond_t cond_result = PTHREAD_COND_INITIALIZER;
+
+static void add_work(enum work_type type, char *name, char *buf, size_t size)
+{
+	pthread_mutex_lock(&grep_lock);
+
+	while ((todo_end+1) % todo_alloc == todo_done) {
+		pthread_cond_wait(&cond_write, &grep_lock);
+	}
+
+	todo[todo_end].type = type;
+	todo[todo_end].name = name;
+	todo[todo_end].buf = buf;
+	todo[todo_end].size = size;
+	todo[todo_end].done = 0;
+	strbuf_reset(&todo[todo_end].out);
+	todo_end = (todo_end + 1) % todo_alloc;
+
+	pthread_mutex_unlock(&grep_lock);
+	pthread_cond_signal(&cond_add);
+}
+
+static struct work_item* get_work()
+{
+	struct work_item* ret;
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
+		todo_start = (todo_start + 1) % todo_alloc;
+	}
+	pthread_mutex_unlock(&grep_lock);
+	return ret;
+}
+
+/* This function takes ownership of 'name' and 'buf'. They will be
+   deallocated with free. */
+static int grep_buffer_async(struct grep_opt *opt, char *name, char *buf,
+			     size_t size)
+{
+	add_work(WORK_BUF, name, buf, size);
+	return 0;
+}
+
+static int grep_file_async(struct grep_opt *opt, char *name,
+			   const char *filename)
+{
+	add_work(WORK_FILE, name, (char*) filename, 0);
+	return 0;
+}
+
+static void work_done(struct work_item* w)
+{
+	int old_done;
+
+	pthread_mutex_lock(&grep_lock);
+	w->done = 1;
+	old_done = todo_done;
+	for(; todo[todo_done].done && todo_done != todo_start;
+	    todo_done = (todo_done+1) % todo_alloc) {
+		w = &todo[todo_done];
+		write_or_die(1, w->out.buf, w->out.len);
+		if (w->type == WORK_BUF)
+			free(w->buf);
+
+		free(w->name);
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
+static void* run(void *arg)
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
+		if (w->type == WORK_BUF) {
+			hit |= grep_buffer(opt, w->name, w->buf, w->size);
+		} else {
+			size_t sz;
+			void* data = load_file(w->buf, &sz);
+			if (data) {
+				hit |= grep_buffer(opt, w->name, data, sz);
+				free(data);
+			}
+		}
+
+		work_done(w);
+	}
+
+	return (void*) (intptr_t) hit;
+}
+
+static void strbuf_out(struct grep_opt *opt, const char *fmt, ...)
+{
+	struct work_item *w = opt->output_priv;
+	va_list ap;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&w->out, fmt, ap);
+	va_end(ap);
+}
+
+static void start_threads(struct grep_opt *opt)
+{
+	int i;
+
+	if (getenv("THREADS"))
+		number_of_threads = atoi(getenv("THREADS"));
+	else
+		number_of_threads = 8;
+
+	todo_alloc = 100;
+	todo = xmalloc(sizeof(struct work_item)*todo_alloc);
+	for (i = 0; i < todo_alloc; i++) {
+		strbuf_init(&todo[i].out, 0);
+	}
+
+	threads = xmalloc(sizeof(pthread_t)*number_of_threads);
+	for (i = 0; i < number_of_threads; i++) {
+		struct grep_opt *o = grep_opt_dup(opt);
+		o->show_hunk_mark = 1;
+		o->output = strbuf_out;
+		compile_grep_patterns(o);
+		int err = pthread_create(&threads[i], NULL, run, o);
+
+		if (err)
+			die("grep: failed to create thread: %s", strerror(err));
+	}
+}
+#endif /* THREADED_DELTA_SEARCH */
+
+#ifdef THREADED_DELTA_SEARCH
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
+	   is no more work to do. */
+	pthread_cond_broadcast(&cond_add);
+	pthread_mutex_unlock(&grep_lock);
+
+	for (i = 0; i < number_of_threads; i++) {
+		void *h;
+		pthread_join(threads[i], &h);
+		hit |= (int) (intptr_t) h;
+	}
+
+	return hit;
+}
+#else
+static int wait_all()
+{
+	return 0;
+}
+#endif
+
+static int grep_buffer_internal(struct grep_opt *opt, char *name, char *buf,
+				size_t size)
+{
+#ifdef THREADED_DELTA_SEARCH
+	if (use_threads)
+		return grep_buffer_async(opt, name, buf, size);
+#endif
+	{
+		int hit = grep_buffer(opt, name, buf, size);
+		free(name);
+		free(buf);
+		return hit;
+	}
+}
+
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
 	NULL
@@ -169,21 +432,21 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(name + tree_name_len, -1, &pathbuf, opt->prefix);
 		strbuf_insert(&pathbuf, 0, name, tree_name_len);
-		name = pathbuf.buf;
+	} else {
+		strbuf_addstr(&pathbuf, name);
 	}
-	hit = grep_buffer(opt, name, data, size);
-	strbuf_release(&pathbuf);
-	free(data);
+
+	hit = grep_buffer_internal(opt, strbuf_detach(&pathbuf, NULL),
+				   data, size);
+
 	return hit;
 }
 
-static int grep_file(struct grep_opt *opt, const char *filename)
+static void* load_file(const char *filename, size_t *sz)
 {
 	struct stat st;
+	char* data;
 	int i;
-	char *data;
-	size_t sz;
-	struct strbuf buf = STRBUF_INIT;
 
 	if (lstat(filename, &st) < 0) {
 	err_ret:
@@ -195,24 +458,47 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		return 0; /* empty file -- no grep hit */
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
+	data[*sz] = 0;
+	if (st.st_size != read_in_full(i, data, *sz)) {
 		error("'%s': short read %s", filename, strerror(errno));
 		close(i);
 		free(data);
 		return 0;
 	}
 	close(i);
+	return data;
+}
+
+static int grep_file(struct grep_opt *opt, const char *filename)
+{
+	char *data;
+	size_t sz;
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
+#ifdef THREADED_DELTA_SEARCH
+	if (use_threads) {
+		return grep_file_async(opt, name, filename);
+	} else
+#endif
+	{
+		data = load_file(filename, &sz);
+		if (!data)
+			return 0;
+
+		return grep_buffer_internal(opt, name, data, sz);
+	}
 }
 
 #if !NO_EXTERNAL_GREP
@@ -809,6 +1095,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	use_threads = getenv("NO_THREADS") == NULL;
+
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -862,6 +1150,17 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.regflags |= REG_ICASE;
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");
+
+#ifdef THREADED_DELTA_SEARCH
+	if (!grep_threads_ok(&opt))
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
@@ -899,9 +1198,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!list.nr) {
+		int hit;
 		if (!cached)
 			setup_work_tree();
-		return !grep_cache(&opt, paths, cached, external_grep_allowed);
+		hit = grep_cache(&opt, paths, cached, external_grep_allowed);
+		if (use_threads)
+			hit |= wait_all();
+		return !hit;
 	}
 
 	if (cached)
@@ -913,6 +1216,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
index 62723da..3dd3918 100644
--- a/grep.c
+++ b/grep.c
@@ -29,6 +29,28 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 	p->next = NULL;
 }
 
+struct grep_opt* grep_opt_dup(const struct grep_opt *opt)
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
 static int is_fixed(const char *s)
 {
 	while (*s && !is_regex_special(*s))
@@ -260,7 +282,7 @@ static int word_char(char ch)
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
+	opt->output(opt, "%s%c", name, opt->null_following_name ? '\0' : '\n');
 }
 
 
@@ -501,20 +523,20 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark)
-				fputs("--\n", stdout);
+				opt->output(opt, "--\n");
 			else
 				opt->show_hunk_mark = 1;
 		} else if (lno > opt->last_shown + 1)
-			fputs("--\n", stdout);
+			opt->output(opt, "--\n");
 	}
 	opt->last_shown = lno;
 
 	if (opt->null_following_name)
 		sign = '\0';
 	if (opt->pathname)
-		printf("%s%c", name, sign);
+		opt->output(opt, "%s%c", name, sign);
 	if (opt->linenum)
-		printf("%d%c", lno, sign);
+		opt->output(opt, "%d%c", lno, sign);
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -525,18 +547,19 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
-			printf("%.*s%s%.*s%s",
-			       (int)match.rm_so, bol,
-			       opt->color_match,
-			       (int)(match.rm_eo - match.rm_so), bol + match.rm_so,
-			       GIT_COLOR_RESET);
+			opt->output(opt, "%.*s%s%.*s%s",
+				    (int)match.rm_so, bol,
+				    opt->color_match,
+				    (int)(match.rm_eo - match.rm_so),
+				    bol + match.rm_so,
+				    GIT_COLOR_RESET);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
 		}
 		*eol = ch;
 	}
-	printf("%.*s\n", rest, bol);
+	opt->output(opt, "%.*s\n", rest, bol);
 }
 
 static int match_funcname(struct grep_opt *opt, char *bol, char *eol)
@@ -674,6 +697,33 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
 
+int grep_threads_ok(const struct grep_opt *opt)
+{
+	/* If this condition is true, then we may use the attribute
+	   machinery in grep_buffer_1. The attribute code is not
+	   thread safe, so we disable the use of threads. */
+	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	    !opt->name_only)
+		return 0;
+
+	/* If we are showing hunk marks, we should not do it for the
+	   first match. The synchronization problem we get for this
+	   constraint is not yet solved, so we disable threading in
+	   this case. */
+	if (opt->pre_context || opt->post_context)
+		return 0;
+	
+	return 1;
+}
+
+static void std_output(struct grep_opt *opt, const char* fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -689,6 +739,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	opt->last_shown = 0;
 
+	if (!opt->output)
+		opt->output = std_output;
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
@@ -761,7 +814,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			if (opt->status_only)
 				return 1;
 			if (binary_match_only) {
-				printf("Binary file %s matches\n", name);
+				opt->output(opt,
+					    "Binary file %s matches\n", name);
 				return 1;
 			}
 			if (opt->name_only) {
@@ -817,9 +871,10 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 * which feels mostly useless but sometimes useful.  Maybe
 	 * make it another option?  For now suppress them.
 	 */
-	if (opt->count && count)
-		printf("%s%c%u\n", name,
-		       opt->null_following_name ? '\0' : ':', count);
+	if (opt->count && count) {
+		opt->output(opt, "%s%c%u\n", name,
+			    opt->null_following_name ? '\0' : ':', count);
+	}
 	return !!last_hit;
 }
 
diff --git a/grep.h b/grep.h
index 75370f6..f5031c7 100644
--- a/grep.h
+++ b/grep.h
@@ -92,6 +92,9 @@ struct grep_opt {
 	unsigned last_shown;
 	int show_hunk_mark;
 	void *priv;
+
+	void (*output)(struct grep_opt*, const char*, ...);
+	void *output_priv;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
@@ -100,4 +103,7 @@ extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
 
+extern struct grep_opt* grep_opt_dup(const struct grep_opt *opt);
+extern int grep_threads_ok(const struct grep_opt *opt);
+
 #endif
diff --git a/strbuf.c b/strbuf.c
index 4017476..a41f0ea 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -194,21 +194,28 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
-	int len;
 	va_list ap;
 
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+}
+
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	int len;
+	va_list ap2;
+
+	va_copy(ap2, ap);
 	if (!strbuf_avail(sb))
 		strbuf_grow(sb, 64);
-	va_start(ap, fmt);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-	va_end(ap);
 	if (len < 0)
 		die("your vsnprintf is broken");
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
-		va_start(ap, fmt);
-		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-		va_end(ap);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap2);
+		va_end(ap2);
 		if (len > strbuf_avail(sb)) {
 			die("this should not happen, your snprintf is broken");
 		}
diff --git a/strbuf.h b/strbuf.h
index b37f06a..20129ad 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -118,6 +118,7 @@ extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
