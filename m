From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Mon, 24 Oct 2011 13:47:38 -0700
Message-ID: <20111024204737.GA25574@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <20111020025149.GA31549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 22:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIRR3-0006KH-7B
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 22:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab1JXUrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 16:47:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55655
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485Ab1JXUrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 16:47:48 -0400
Received: (qmail 9194 invoked by uid 107); 24 Oct 2011 20:53:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Oct 2011 16:53:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2011 13:47:38 -0700
Content-Disposition: inline
In-Reply-To: <20111020025149.GA31549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184185>

On Wed, Oct 19, 2011 at 10:51:49PM -0400, Jeff King wrote:

> I couldn't resist:
> 
>   $ git commit -q -m foo --collide=deadbeef &&
>     git rev-list -1 HEAD
>   deadbeefdbd6e62a2185606a4fad653e22509b56

Here's a followup with a few cleanups:

  1. It will actually finish and report an error if we fail to find a
     commit after ULONG_MAX tries. On 64-bit machines this is unlikely,
     but it might be possible on a 32-bit machine if you have a lot of
     patience.

  2. It uses git_SHA* now, so it will build properly against BLK_SHA1 if
     NO_OPENSSL is defined.

  3. It will split the the collision-finding work across online_cpus()
     threads.

Somebody else suggested farming the work out to a GPU. I'll leave that
as an exercise to the reader.

-Peff

---
 builtin/commit.c |   56 ++++++++++++++++++-
 commit.c         |  165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h         |    4 +
 3 files changed, 223 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..734a7ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -105,6 +105,10 @@
 static const char *only_include_assumed;
 static struct strbuf message;
 
+static int collide;
+static unsigned char collide_sha1[20];
+static unsigned char collide_mask[20];
+
 static int null_termination;
 static enum {
 	STATUS_FORMAT_LONG,
@@ -125,6 +129,52 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_partial_sha1(const char *s, unsigned char sha1[20])
+{
+	unsigned int i;
+
+	hashclr(sha1);
+
+	for (i = 0; i < 40 && s[i]; i++) {
+		unsigned int v = hexval(s[i]);
+		if (v & ~0xf)
+			break;
+		if (!(i & 1))
+			v <<= 4;
+		sha1[i/2] |= v;
+	}
+	return i;
+}
+
+static void fill_sha1_mask(int n, unsigned char mask[20]) {
+	int i;
+
+	hashclr(mask);
+	for (i = 0; i < n/2; i++)
+		mask[i] = 0xff;
+	if (n & 1)
+		mask[i] = 0xf0;
+}
+
+static int opt_parse_collide(const struct option *opt, const char *arg,
+			     int unset)
+{
+	if (unset)
+		collide = 0;
+	else {
+		int n = parse_partial_sha1(arg, collide_sha1);
+		if (!arg[n])
+			fill_sha1_mask(n, collide_mask);
+		else if (arg[n] == '/')
+			parse_partial_sha1(arg + n + 1, collide_mask);
+		else
+			die("invalid --collide sha1: %s", arg);
+		collide = 1;
+	}
+	return 0;
+}
+
+
 static struct option builtin_commit_options[] = {
 	OPT__QUIET(&quiet, "suppress summary after successful commit"),
 	OPT__VERBOSE(&verbose, "show diff in commit message template"),
@@ -144,6 +194,7 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+	OPT_CALLBACK(0, "collide", NULL, "sha1[/mask]", "choose commit sha1 like <sha1>", opt_parse_collide),
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
@@ -1483,8 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
-			author_ident.buf)) {
+	if (commit_tree_collide(sb.buf, active_cache_tree->sha1, parents, sha1,
+				author_ident.buf,
+				collide ? collide_sha1 : NULL, collide_mask)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/commit.c b/commit.c
index 73b7e00..7beea9b 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "thread-utils.h"
 
 int save_commit_buffer = 1;
 
@@ -840,6 +841,158 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static inline int sha1_match_mask(const unsigned char *sha1,
+				  const unsigned char *want,
+				  const unsigned char *mask)
+{
+	int i;
+	for (i = 0; i < 20; i++)
+		if ((want[i] & mask[i]) != (sha1[i] & mask[i]))
+		    return 0;
+	return 1;
+}
+
+static unsigned long find_collision(const unsigned char *want,
+				    const unsigned char *mask,
+				    const git_SHA_CTX *base,
+				    unsigned long start,
+				    unsigned long end)
+{
+	unsigned long lulz;
+
+	for (lulz = start; lulz < end; lulz++) {
+		git_SHA_CTX guess;
+		unsigned char sha1[20];
+
+		memcpy(&guess, base, sizeof(guess));
+		git_SHA1_Update(&guess, &lulz, sizeof(lulz));
+		git_SHA1_Final(sha1, &guess);
+
+		if (sha1_match_mask(sha1, want, mask))
+			return lulz;
+	}
+	return end;
+}
+
+#ifndef NO_PTHREADS
+struct collision_thread_data {
+	const unsigned char *want;
+	const unsigned char *mask;
+	const git_SHA_CTX *base;
+	unsigned long start;
+	unsigned long end;
+
+	pthread_mutex_t *mutex;
+	pthread_cond_t *cond;
+	int *threads_alive;
+	unsigned long *answer;
+};
+
+static void *collision_thread(void *vdata)
+{
+	struct collision_thread_data *d = vdata;
+	unsigned long r;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+	r = find_collision(d->want, d->mask, d->base,
+			   d->start, d->end);
+
+	pthread_mutex_lock(d->mutex);
+
+	(*d->threads_alive)--;
+	if (r != d->end) {
+		*d->answer = r;
+		pthread_cond_signal(d->cond);
+	}
+	else {
+		/* If we failed to find it, and we're the last thread,
+		 * wake up the parent so it can report failure. */
+		if (!*d->threads_alive)
+			pthread_cond_signal(d->cond);
+	}
+
+	pthread_mutex_unlock(d->mutex);
+	return NULL;
+}
+
+static unsigned long find_collision_threaded(int nthreads,
+					     const unsigned char *want,
+					     const unsigned char *mask,
+					     const git_SHA_CTX *base)
+{
+	int i;
+	pthread_t *threads;
+	struct collision_thread_data *data;
+	pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+	pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+	int threads_alive = nthreads;
+	unsigned long ret = ULONG_MAX;
+
+	threads = xmalloc(nthreads * sizeof(*threads));
+	data = xmalloc(nthreads * sizeof(*data));
+
+	pthread_mutex_lock(&mutex);
+
+	for (i = 0; i < nthreads; i++) {
+		data[i].want = want;
+		data[i].mask = mask;
+		data[i].base = base;
+		data[i].start = i * (ULONG_MAX / nthreads);
+		data[i].end = (i+1) * (ULONG_MAX / nthreads);
+		data[i].mutex = &mutex;
+		data[i].cond = &cond;
+		data[i].answer = &ret;
+		data[i].threads_alive = &threads_alive;
+		pthread_create(&threads[i], NULL, collision_thread, &data[i]);
+	}
+
+	pthread_cond_wait(&cond, &mutex);
+
+	for (i = 0; i < nthreads; i++) {
+		pthread_cancel(threads[i]);
+		pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	free(data);
+	return ret;
+}
+#endif /* NO_PTHREADS */
+
+
+static void collide_commit(struct strbuf *data,
+			   const unsigned char *want,
+			   const unsigned char *mask)
+{
+	static const char terminator[] = { 0 };
+	char header[32];
+	int header_len;
+	unsigned long lulz;
+	git_SHA_CTX base;
+
+	header_len = snprintf(header, sizeof(header),
+			      "commit %lu",
+			      data->len + 1 + sizeof(lulz)) + 1;
+	git_SHA1_Init(&base);
+	git_SHA1_Update(&base, header, header_len);
+	git_SHA1_Update(&base, data->buf, data->len);
+	git_SHA1_Update(&base, terminator, sizeof(terminator));
+
+#ifdef NO_PTHREADS
+	lulz = find_collision(want, mask, &base, 0, ULONG_MAX);
+#else
+	lulz = find_collision_threaded(online_cpus(), want, mask, &base);
+#endif /* NO_PTHREADS */
+
+	if (lulz != ULONG_MAX) {
+		strbuf_add(data, terminator, sizeof(terminator));
+		strbuf_add(data, &lulz, sizeof(lulz));
+	}
+	else
+		warning("sorry, I couldn't find a collision!");
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -849,6 +1002,15 @@ int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
 {
+	return commit_tree_collide(msg, tree, parents, ret, author,
+				   NULL, NULL);
+}
+
+int commit_tree_collide(const char *msg, unsigned char *tree,
+			struct commit_list *parents, unsigned char *ret,
+			const char *author, const unsigned char *want,
+			const unsigned char *mask)
+{
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
@@ -890,6 +1052,9 @@ int commit_tree(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (want && mask)
+		collide_commit(&buffer, want, mask);
+
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
 	return result;
diff --git a/commit.h b/commit.h
index 009b113..337dcbd 100644
--- a/commit.h
+++ b/commit.h
@@ -184,5 +184,9 @@ static inline int single_parent(struct commit *commit)
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
+extern int commit_tree_collide(const char *msg, unsigned char *tree,
+			       struct commit_list *parents, unsigned char *ret,
+			       const char *author, const unsigned char *sha1,
+			       const unsigned char *mask);
 
 #endif /* COMMIT_H */
-- 
1.7.7.40.g1a72f
