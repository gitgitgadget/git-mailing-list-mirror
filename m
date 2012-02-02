From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] convert git-grep to use grep_source interface
Date: Thu, 2 Feb 2012 03:19:37 -0500
Message-ID: <20120202081937.GD6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrtR-0000Hs-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab2BBITl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:19:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52864
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab2BBITk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:19:40 -0500
Received: (qmail 17859 invoked by uid 107); 2 Feb 2012 08:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:26:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:19:37 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189596>

The grep_source interface (as opposed to grep_buffer) will
eventually gives us a richer interface for telling the
low-level grep code about our buffers. Eventually this will
lead to things like better binary-file handling. For now, it
lets us drop a lot of now-redundant code.

The conversion is mostly straight-forward. One thing to note
is that the memory ownership rules for "struct grep_source"
are different than the "struct work_item" found here (the
former will copy things like the filename, rather than
taking ownership). Therefore you will also see some slight
tweaking of when filename buffers are released.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c |  142 +++++++++-----------------------------------------------
 1 files changed, 23 insertions(+), 119 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f4402fa..bc85a20 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -29,25 +29,12 @@ static int use_threads = 1;
 #define THREADS 8
 static pthread_t threads[THREADS];
 
-static void *load_sha1(const unsigned char *sha1, unsigned long *size,
-		       const char *name);
-static void *load_file(const char *filename, size_t *sz);
-
-enum work_type {WORK_SHA1, WORK_FILE};
-
 /* We use one producer thread and THREADS consumer
  * threads. The producer adds struct work_items to 'todo' and the
  * consumers pick work items from the same array.
  */
 struct work_item {
-	enum work_type type;
-	char *name;
-
-	/* if type == WORK_SHA1, then 'identifier' is a SHA1,
-	 * otherwise type == WORK_FILE, and 'identifier' is a NUL
-	 * terminated filename.
-	 */
-	void *identifier;
+	struct grep_source source;
 	char done;
 	struct strbuf out;
 };
@@ -98,7 +85,8 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(enum work_type type, char *name, void *id)
+static void add_work(enum grep_source_type type, const char *name,
+		     const void *id)
 {
 	grep_lock();
 
@@ -106,9 +94,7 @@ static void add_work(enum work_type type, char *name, void *id)
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	todo[todo_end].type = type;
-	todo[todo_end].name = name;
-	todo[todo_end].identifier = id;
+	grep_source_init(&todo[todo_end].source, type, name, id);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
@@ -136,21 +122,6 @@ static struct work_item *get_work(void)
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
-static void grep_file_async(struct grep_opt *opt, char *name,
-			    const char *filename)
-{
-	add_work(WORK_FILE, name, xstrdup(filename));
-}
-
 static void work_done(struct work_item *w)
 {
 	int old_done;
@@ -177,8 +148,7 @@ static void work_done(struct work_item *w)
 
 			write_or_die(1, p, len);
 		}
-		free(w->name);
-		free(w->identifier);
+		grep_source_clear(&w->source);
 	}
 
 	if (old_done != todo_done)
@@ -201,25 +171,8 @@ static void *run(void *arg)
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
-		}
-
+		hit |= grep_source(opt, &w->source);
+		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
 	free_grep_patterns(arg);
@@ -365,23 +318,10 @@ static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type
 	return data;
 }
 
-static void *load_sha1(const unsigned char *sha1, unsigned long *size,
-		       const char *name)
-{
-	enum object_type type;
-	void *data = lock_and_read_sha1_file(sha1, &type, size);
-
-	if (!data)
-		error(_("'%s': unable to read %s"), name, sha1_to_hex(sha1));
-
-	return data;
-}
-
 static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		     const char *filename, int tree_name_len)
 {
 	struct strbuf pathbuf = STRBUF_INIT;
-	char *name;
 
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
@@ -391,87 +331,51 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		strbuf_addstr(&pathbuf, filename);
 	}
 
-	name = strbuf_detach(&pathbuf, NULL);
-
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		grep_sha1_async(opt, name, sha1);
+		add_work(GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		strbuf_release(&pathbuf);
 		return 0;
 	} else
 #endif
 	{
+		struct grep_source gs;
 		int hit;
-		unsigned long sz;
-		void *data = load_sha1(sha1, &sz, name);
-		if (!data)
-			hit = 0;
-		else
-			hit = grep_buffer(opt, name, data, sz);
 
-		free(data);
-		free(name);
-		return hit;
-	}
-}
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		strbuf_release(&pathbuf);
+		hit = grep_source(opt, &gs);
 
-static void *load_file(const char *filename, size_t *sz)
-{
-	struct stat st;
-	char *data;
-	int i;
-
-	if (lstat(filename, &st) < 0) {
-	err_ret:
-		if (errno != ENOENT)
-			error(_("'%s': %s"), filename, strerror(errno));
-		return NULL;
-	}
-	if (!S_ISREG(st.st_mode))
-		return NULL;
-	*sz = xsize_t(st.st_size);
-	i = open(filename, O_RDONLY);
-	if (i < 0)
-		goto err_ret;
-	data = xmalloc(*sz + 1);
-	if (st.st_size != read_in_full(i, data, *sz)) {
-		error(_("'%s': short read %s"), filename, strerror(errno));
-		close(i);
-		free(data);
-		return NULL;
+		grep_source_clear(&gs);
+		return hit;
 	}
-	close(i);
-	data[*sz] = 0;
-	return data;
 }
 
 static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	char *name;
 
 	if (opt->relative && opt->prefix_length)
 		quote_path_relative(filename, -1, &buf, opt->prefix);
 	else
 		strbuf_addstr(&buf, filename);
-	name = strbuf_detach(&buf, NULL);
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		grep_file_async(opt, name, filename);
+		add_work(GREP_SOURCE_FILE, buf.buf, filename);
+		strbuf_release(&buf);
 		return 0;
 	} else
 #endif
 	{
+		struct grep_source gs;
 		int hit;
-		size_t sz;
-		void *data = load_file(filename, &sz);
-		if (!data)
-			hit = 0;
-		else
-			hit = grep_buffer(opt, name, data, sz);
 
-		free(data);
-		free(name);
+		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename);
+		strbuf_release(&buf);
+		hit = grep_source(opt, &gs);
+
+		grep_source_clear(&gs);
 		return hit;
 	}
 }
-- 
1.7.9.3.gc3fce1.dirty
