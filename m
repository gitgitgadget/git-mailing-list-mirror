From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Modularize commit-walker
Date: Tue, 3 Jul 2007 01:28:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707030127170.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 07:28:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5awE-0006uq-7L
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 07:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXGCF20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 01:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbXGCF20
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 01:28:26 -0400
Received: from iabervon.org ([66.92.72.58]:3426 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbXGCF2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 01:28:23 -0400
Received: (qmail 11883 invoked by uid 1000); 3 Jul 2007 05:28:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jul 2007 05:28:21 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51460>

This turns the extern functions to be provided by the backend into a
struct of pointers, renames the functions to be more
namespace-friendly, and updates http-fetch to this interface. It
removes the unused include from http-push.c. It makes git-http-fetch a
builtin (with the implementation a separate file, accessible
directly).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This is moderately tested. git-http-fetch actually supports file:/// URLs, 
so I tried fetching a bunch of stuff from a different local repository    
with it, and it worked with all of the features I was using. I don't have 
an "alternates" setup to test against, however. I also built it without 
curl to make sure that works.

 Makefile             |   15 +-
 builtin-http-fetch.c |   77 ++++
 builtin.h            |    1 +
 fetch.c              |  317 ---------------
 fetch.h              |   54 ---
 git.c                |    3 +
 http-fetch.c         | 1064 --------------------------------------------------
 http-push.c          |    1 -
 http-walker.c        | 1038 ++++++++++++++++++++++++++++++++++++++++++++++++
 walker.c             |  318 +++++++++++++++
 walker.h             |   37 ++
 11 files changed, 1482 insertions(+), 1443 deletions(-)
 create mode 100644 builtin-http-fetch.c
 delete mode 100644 fetch.c
 delete mode 100644 fetch.h
 delete mode 100644 http-fetch.c
 create mode 100644 http-walker.c
 create mode 100644 walker.c
 create mode 100644 walker.h

diff --git a/Makefile b/Makefile
index 705dde5..47f5fb8 100644
--- a/Makefile
+++ b/Makefile
@@ -508,7 +508,9 @@ else
 	CC_LD_DYNPATH = -R
 endif
 
-ifndef NO_CURL
+ifdef NO_CURL
+	BASIC_CFLAGS += -DNO_CURL
+else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/lib" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
@@ -516,7 +518,9 @@ ifndef NO_CURL
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	PROGRAMS += git-http-fetch$X
+	BUILTIN_OBJS += builtin-http-fetch.o
+	EXTLIBS += $(CURL_LIBCURL)
+	LIB_OBJS += http.o walker.o http-walker.o
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -883,16 +887,13 @@ git-%$X: %.o $(GITLIBS)
 
 git-imap-send$X: imap-send.o $(LIB_FILE)
 
-http.o http-fetch.o http-push.o: http.h
-git-http-fetch$X: fetch.o http.o http-fetch.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+http.o builtin-http-fetch.o http-push.o: http.h
 
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS) fetch.o: $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS) walker.o: $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
new file mode 100644
index 0000000..4a50dbd
--- /dev/null
+++ b/builtin-http-fetch.c
@@ -0,0 +1,77 @@
+#include "cache.h"
+#include "walker.h"
+
+int cmd_http_fetch(int argc, const char **argv, const char *prefix)
+{
+	struct walker *walker;
+	int commits_on_stdin = 0;
+	int commits;
+	const char **write_ref = NULL;
+	char **commit_id;
+	const char *url;
+	int arg = 1;
+	int rc = 0;
+	int get_tree = 0;
+	int get_history = 0;
+	int get_all = 0;
+	int get_verbosely = 0;
+	int get_recover = 0;
+
+	git_config(git_default_config);
+
+	while (arg < argc && argv[arg][0] == '-') {
+		if (argv[arg][1] == 't') {
+			get_tree = 1;
+		} else if (argv[arg][1] == 'c') {
+			get_history = 1;
+		} else if (argv[arg][1] == 'a') {
+			get_all = 1;
+			get_tree = 1;
+			get_history = 1;
+		} else if (argv[arg][1] == 'v') {
+			get_verbosely = 1;
+		} else if (argv[arg][1] == 'w') {
+			write_ref = &argv[arg + 1];
+			arg++;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_recover = 1;
+		} else if (!strcmp(argv[arg], "--stdin")) {
+			commits_on_stdin = 1;
+		}
+		arg++;
+	}
+	if (argc < arg + 2 - commits_on_stdin) {
+		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
+		return 1;
+	}
+	if (commits_on_stdin) {
+		commits = walker_targets_stdin(&commit_id, &write_ref);
+	} else {
+		commit_id = (char **) &argv[arg++];
+		commits = 1;
+	}
+	url = argv[arg];
+
+	walker = get_http_walker(url);
+	walker->get_tree = get_tree;
+	walker->get_history = get_history;
+	walker->get_all = get_all;
+	walker->get_verbosely = get_verbosely;
+	walker->get_recover = get_recover;
+
+	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
+
+	if (commits_on_stdin)
+		walker_targets_free(commits, commit_id, write_ref);
+
+	if (walker->corrupt_object_found) {
+		fprintf(stderr,
+"Some loose object were found to be corrupt, but they might be just\n"
+"a false '404 Not Found' error message sent with incorrect HTTP\n"
+"status code.  Suggest running git-fsck.\n");
+	}
+
+	walker_free(walker);
+
+	return rc;
+}
diff --git a/builtin.h b/builtin.h
index 661a92f..bd06af7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -40,6 +40,7 @@ extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
+extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
diff --git a/fetch.c b/fetch.c
deleted file mode 100644
index 811be87..0000000
--- a/fetch.c
+++ /dev/null
@@ -1,317 +0,0 @@
-#include "cache.h"
-#include "fetch.h"
-#include "commit.h"
-#include "tree.h"
-#include "tree-walk.h"
-#include "tag.h"
-#include "blob.h"
-#include "refs.h"
-#include "strbuf.h"
-
-int get_tree = 0;
-int get_history = 0;
-int get_all = 0;
-int get_verbosely = 0;
-int get_recover = 0;
-static unsigned char current_commit_sha1[20];
-
-void pull_say(const char *fmt, const char *hex)
-{
-	if (get_verbosely)
-		fprintf(stderr, fmt, hex);
-}
-
-static void report_missing(const struct object *obj)
-{
-	char missing_hex[41];
-	strcpy(missing_hex, sha1_to_hex(obj->sha1));;
-	fprintf(stderr, "Cannot obtain needed %s %s\n",
-		obj->type ? typename(obj->type): "object", missing_hex);
-	if (!is_null_sha1(current_commit_sha1))
-		fprintf(stderr, "while processing commit %s.\n",
-			sha1_to_hex(current_commit_sha1));
-}
-
-static int process(struct object *obj);
-
-static int process_tree(struct tree *tree)
-{
-	struct tree_desc desc;
-	struct name_entry entry;
-
-	if (parse_tree(tree))
-		return -1;
-
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	while (tree_entry(&desc, &entry)) {
-		struct object *obj = NULL;
-
-		/* submodule commits are not stored in the superproject */
-		if (S_ISGITLINK(entry.mode))
-			continue;
-		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.sha1);
-			if (tree)
-				obj = &tree->object;
-		}
-		else {
-			struct blob *blob = lookup_blob(entry.sha1);
-			if (blob)
-				obj = &blob->object;
-		}
-		if (!obj || process(obj))
-			return -1;
-	}
-	free(tree->buffer);
-	tree->buffer = NULL;
-	tree->size = 0;
-	return 0;
-}
-
-#define COMPLETE	(1U << 0)
-#define SEEN		(1U << 1)
-#define TO_SCAN		(1U << 2)
-
-static struct commit_list *complete = NULL;
-
-static int process_commit(struct commit *commit)
-{
-	if (parse_commit(commit))
-		return -1;
-
-	while (complete && complete->item->date >= commit->date) {
-		pop_most_recent_commit(&complete, COMPLETE);
-	}
-
-	if (commit->object.flags & COMPLETE)
-		return 0;
-
-	hashcpy(current_commit_sha1, commit->object.sha1);
-
-	pull_say("walk %s\n", sha1_to_hex(commit->object.sha1));
-
-	if (get_tree) {
-		if (process(&commit->tree->object))
-			return -1;
-		if (!get_all)
-			get_tree = 0;
-	}
-	if (get_history) {
-		struct commit_list *parents = commit->parents;
-		for (; parents; parents = parents->next) {
-			if (process(&parents->item->object))
-				return -1;
-		}
-	}
-	return 0;
-}
-
-static int process_tag(struct tag *tag)
-{
-	if (parse_tag(tag))
-		return -1;
-	return process(tag->tagged);
-}
-
-static struct object_list *process_queue = NULL;
-static struct object_list **process_queue_end = &process_queue;
-
-static int process_object(struct object *obj)
-{
-	if (obj->type == OBJ_COMMIT) {
-		if (process_commit((struct commit *)obj))
-			return -1;
-		return 0;
-	}
-	if (obj->type == OBJ_TREE) {
-		if (process_tree((struct tree *)obj))
-			return -1;
-		return 0;
-	}
-	if (obj->type == OBJ_BLOB) {
-		return 0;
-	}
-	if (obj->type == OBJ_TAG) {
-		if (process_tag((struct tag *)obj))
-			return -1;
-		return 0;
-	}
-	return error("Unable to determine requirements "
-		     "of type %s for %s",
-		     typename(obj->type), sha1_to_hex(obj->sha1));
-}
-
-static int process(struct object *obj)
-{
-	if (obj->flags & SEEN)
-		return 0;
-	obj->flags |= SEEN;
-
-	if (has_sha1_file(obj->sha1)) {
-		/* We already have it, so we should scan it now. */
-		obj->flags |= TO_SCAN;
-	}
-	else {
-		if (obj->flags & COMPLETE)
-			return 0;
-		prefetch(obj->sha1);
-	}
-
-	object_list_insert(obj, process_queue_end);
-	process_queue_end = &(*process_queue_end)->next;
-	return 0;
-}
-
-static int loop(void)
-{
-	struct object_list *elem;
-
-	while (process_queue) {
-		struct object *obj = process_queue->item;
-		elem = process_queue;
-		process_queue = elem->next;
-		free(elem);
-		if (!process_queue)
-			process_queue_end = &process_queue;
-
-		/* If we are not scanning this object, we placed it in
-		 * the queue because we needed to fetch it first.
-		 */
-		if (! (obj->flags & TO_SCAN)) {
-			if (fetch(obj->sha1)) {
-				report_missing(obj);
-				return -1;
-			}
-		}
-		if (!obj->type)
-			parse_object(obj->sha1);
-		if (process_object(obj))
-			return -1;
-	}
-	return 0;
-}
-
-static int interpret_target(char *target, unsigned char *sha1)
-{
-	if (!get_sha1_hex(target, sha1))
-		return 0;
-	if (!check_ref_format(target)) {
-		if (!fetch_ref(target, sha1)) {
-			return 0;
-		}
-	}
-	return -1;
-}
-
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
-	if (commit) {
-		commit->object.flags |= COMPLETE;
-		insert_by_date(commit, &complete);
-	}
-	return 0;
-}
-
-int pull_targets_stdin(char ***target, const char ***write_ref)
-{
-	int targets = 0, targets_alloc = 0;
-	struct strbuf buf;
-	*target = NULL; *write_ref = NULL;
-	strbuf_init(&buf);
-	while (1) {
-		char *rf_one = NULL;
-		char *tg_one;
-
-		read_line(&buf, stdin, '\n');
-		if (buf.eof)
-			break;
-		tg_one = buf.buf;
-		rf_one = strchr(tg_one, '\t');
-		if (rf_one)
-			*rf_one++ = 0;
-
-		if (targets >= targets_alloc) {
-			targets_alloc = targets_alloc ? targets_alloc * 2 : 64;
-			*target = xrealloc(*target, targets_alloc * sizeof(**target));
-			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
-		}
-		(*target)[targets] = xstrdup(tg_one);
-		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
-		targets++;
-	}
-	return targets;
-}
-
-void pull_targets_free(int targets, char **target, const char **write_ref)
-{
-	while (targets--) {
-		free(target[targets]);
-		if (write_ref && write_ref[targets])
-			free((char *) write_ref[targets]);
-	}
-}
-
-int pull(int targets, char **target, const char **write_ref,
-         const char *write_ref_log_details)
-{
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
-	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
-	int i;
-
-	save_commit_buffer = 0;
-	track_object_refs = 0;
-
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
-		}
-	}
-
-	if (!get_recover)
-		for_each_ref(mark_complete, NULL);
-
-	for (i = 0; i < targets; i++) {
-		if (interpret_target(target[i], &sha1[20 * i])) {
-			error("Could not interpret %s as something to pull", target[i]);
-			goto unlock_and_fail;
-		}
-		if (process(lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
-	}
-
-	if (loop())
-		goto unlock_and_fail;
-
-	if (write_ref_log_details) {
-		msg = xmalloc(strlen(write_ref_log_details) + 12);
-		sprintf(msg, "fetch from %s", write_ref_log_details);
-	} else {
-		msg = NULL;
-	}
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
-	}
-	free(msg);
-
-	return 0;
-
-
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
-	return -1;
-}
diff --git a/fetch.h b/fetch.h
deleted file mode 100644
index be48c6f..0000000
--- a/fetch.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifndef PULL_H
-#define PULL_H
-
-/*
- * Fetch object given SHA1 from the remote, and store it locally under
- * GIT_OBJECT_DIRECTORY.  Return 0 on success, -1 on failure.  To be
- * provided by the particular implementation.
- */
-extern int fetch(unsigned char *sha1);
-
-/*
- * Fetch the specified object and store it locally; fetch() will be
- * called later to determine success. To be provided by the particular
- * implementation.
- */
-extern void prefetch(unsigned char *sha1);
-
-/*
- * Fetch ref (relative to $GIT_DIR/refs) from the remote, and store
- * the 20-byte SHA1 in sha1.  Return 0 on success, -1 on failure.  To
- * be provided by the particular implementation.
- */
-extern int fetch_ref(char *ref, unsigned char *sha1);
-
-/* Set to fetch the target tree. */
-extern int get_tree;
-
-/* Set to fetch the commit history. */
-extern int get_history;
-
-/* Set to fetch the trees in the commit history. */
-extern int get_all;
-
-/* Set to be verbose */
-extern int get_verbosely;
-
-/* Set to check on all reachable objects. */
-extern int get_recover;
-
-/* Report what we got under get_verbosely */
-extern void pull_say(const char *, const char *);
-
-/* Load pull targets from stdin */
-extern int pull_targets_stdin(char ***target, const char ***write_ref);
-
-/* Free up loaded targets */
-extern void pull_targets_free(int targets, char **target, const char **write_ref);
-
-/* If write_ref is set, the ref filename to write the target value to. */
-/* If write_ref_log_details is set, additional text will appear in the ref log. */
-extern int pull(int targets, char **target, const char **write_ref,
-		const char *write_ref_log_details);
-
-#endif /* PULL_H */
diff --git a/git.c b/git.c
index b949cbb..4c2d6da 100644
--- a/git.c
+++ b/git.c
@@ -317,6 +317,9 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
+#ifndef NO_CURL
+		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
+#endif
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
diff --git a/http-fetch.c b/http-fetch.c
deleted file mode 100644
index 202fae0..0000000
--- a/http-fetch.c
+++ /dev/null
@@ -1,1064 +0,0 @@
-#include "cache.h"
-#include "commit.h"
-#include "pack.h"
-#include "fetch.h"
-#include "http.h"
-
-#define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
-
-static int commits_on_stdin;
-
-static int got_alternates = -1;
-static int corrupt_object_found;
-
-static struct curl_slist *no_pragma_header;
-
-struct alt_base
-{
-	char *base;
-	int got_indices;
-	struct packed_git *packs;
-	struct alt_base *next;
-};
-
-static struct alt_base *alt;
-
-enum object_request_state {
-	WAITING,
-	ABORTED,
-	ACTIVE,
-	COMPLETE,
-};
-
-struct object_request
-{
-	unsigned char sha1[20];
-	struct alt_base *repo;
-	char *url;
-	char filename[PATH_MAX];
-	char tmpfile[PATH_MAX];
-	int local;
-	enum object_request_state state;
-	CURLcode curl_result;
-	char errorstr[CURL_ERROR_SIZE];
-	long http_code;
-	unsigned char real_sha1[20];
-	SHA_CTX c;
-	z_stream stream;
-	int zret;
-	int rename;
-	struct active_request_slot *slot;
-	struct object_request *next;
-};
-
-struct alternates_request {
-	const char *base;
-	char *url;
-	struct buffer *buffer;
-	struct active_request_slot *slot;
-	int http_specific;
-};
-
-static struct object_request *object_queue_head;
-
-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
-			       void *data)
-{
-	unsigned char expn[4096];
-	size_t size = eltsize * nmemb;
-	int posn = 0;
-	struct object_request *obj_req = (struct object_request *)data;
-	do {
-		ssize_t retval = xwrite(obj_req->local,
-				       (char *) ptr + posn, size - posn);
-		if (retval < 0)
-			return posn;
-		posn += retval;
-	} while (posn < size);
-
-	obj_req->stream.avail_in = size;
-	obj_req->stream.next_in = ptr;
-	do {
-		obj_req->stream.next_out = expn;
-		obj_req->stream.avail_out = sizeof(expn);
-		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
-		SHA1_Update(&obj_req->c, expn,
-			    sizeof(expn) - obj_req->stream.avail_out);
-	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
-	data_received++;
-	return size;
-}
-
-static int missing__target(int code, int result)
-{
-	return	/* file:// URL -- do we ever use one??? */
-		(result == CURLE_FILE_COULDNT_READ_FILE) ||
-		/* http:// and https:// URL */
-		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
-		/* ftp:// URL */
-		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
-		;
-}
-
-#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
-
-static void fetch_alternates(const char *base);
-
-static void process_object_response(void *callback_data);
-
-static void start_object_request(struct object_request *obj_req)
-{
-	char *hex = sha1_to_hex(obj_req->sha1);
-	char prevfile[PATH_MAX];
-	char *url;
-	char *posn;
-	int prevlocal;
-	unsigned char prev_buf[PREV_BUF_SIZE];
-	ssize_t prev_read = 0;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-	struct active_request_slot *slot;
-
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
-	unlink(prevfile);
-	rename(obj_req->tmpfile, prevfile);
-	unlink(obj_req->tmpfile);
-
-	if (obj_req->local != -1)
-		error("fd leakage in start: %d", obj_req->local);
-	obj_req->local = open(obj_req->tmpfile,
-			      O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/* This could have failed due to the "lazy directory creation";
-	 * try to mkdir the last path component.
-	 */
-	if (obj_req->local < 0 && errno == ENOENT) {
-		char *dir = strrchr(obj_req->tmpfile, '/');
-		if (dir) {
-			*dir = 0;
-			mkdir(obj_req->tmpfile, 0777);
-			*dir = '/';
-		}
-		obj_req->local = open(obj_req->tmpfile,
-				      O_WRONLY | O_CREAT | O_EXCL, 0666);
-	}
-
-	if (obj_req->local < 0) {
-		obj_req->state = ABORTED;
-		error("Couldn't create temporary file %s for %s: %s",
-		      obj_req->tmpfile, obj_req->filename, strerror(errno));
-		return;
-	}
-
-	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-
-	inflateInit(&obj_req->stream);
-
-	SHA1_Init(&obj_req->c);
-
-	url = xmalloc(strlen(obj_req->repo->base) + 51);
-	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
-	strcpy(url, obj_req->repo->base);
-	posn = url + strlen(obj_req->repo->base);
-	strcpy(posn, "/objects/");
-	posn += 9;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
-	strcpy(obj_req->url, url);
-
-	/* If a previous temp file is present, process what was already
-	   fetched. */
-	prevlocal = open(prevfile, O_RDONLY);
-	if (prevlocal != -1) {
-		do {
-			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
-			if (prev_read>0) {
-				if (fwrite_sha1_file(prev_buf,
-						     1,
-						     prev_read,
-						     obj_req) == prev_read) {
-					prev_posn += prev_read;
-				} else {
-					prev_read = -1;
-				}
-			}
-		} while (prev_read > 0);
-		close(prevlocal);
-	}
-	unlink(prevfile);
-
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
-	   file; also rewind to the beginning of the local file. */
-	if (prev_read == -1) {
-		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-		inflateInit(&obj_req->stream);
-		SHA1_Init(&obj_req->c);
-		if (prev_posn>0) {
-			prev_posn = 0;
-			lseek(obj_req->local, 0, SEEK_SET);
-			ftruncate(obj_req->local, 0);
-		}
-	}
-
-	slot = get_active_slot();
-	slot->callback_func = process_object_response;
-	slot->callback_data = obj_req;
-	obj_req->slot = slot;
-
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, obj_req);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-
-	/* If we have successfully processed data from a previous fetch
-	   attempt, only fetch the data we don't already have. */
-	if (prev_posn>0) {
-		if (get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl,
-				 CURLOPT_HTTPHEADER, range_header);
-	}
-
-	/* Try to get the request started, abort the request on error */
-	obj_req->state = ACTIVE;
-	if (!start_active_slot(slot)) {
-		obj_req->state = ABORTED;
-		obj_req->slot = NULL;
-		close(obj_req->local); obj_req->local = -1;
-		free(obj_req->url);
-		return;
-	}
-}
-
-static void finish_object_request(struct object_request *obj_req)
-{
-	struct stat st;
-
-	fchmod(obj_req->local, 0444);
-	close(obj_req->local); obj_req->local = -1;
-
-	if (obj_req->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
-	} else if (obj_req->curl_result != CURLE_OK) {
-		if (stat(obj_req->tmpfile, &st) == 0)
-			if (st.st_size == 0)
-				unlink(obj_req->tmpfile);
-		return;
-	}
-
-	inflateEnd(&obj_req->stream);
-	SHA1_Final(obj_req->real_sha1, &obj_req->c);
-	if (obj_req->zret != Z_STREAM_END) {
-		unlink(obj_req->tmpfile);
-		return;
-	}
-	if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
-		unlink(obj_req->tmpfile);
-		return;
-	}
-	obj_req->rename =
-		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
-
-	if (obj_req->rename == 0)
-		pull_say("got %s\n", sha1_to_hex(obj_req->sha1));
-}
-
-static void process_object_response(void *callback_data)
-{
-	struct object_request *obj_req =
-		(struct object_request *)callback_data;
-
-	obj_req->curl_result = obj_req->slot->curl_result;
-	obj_req->http_code = obj_req->slot->http_code;
-	obj_req->slot = NULL;
-	obj_req->state = COMPLETE;
-
-	/* Use alternates if necessary */
-	if (missing_target(obj_req)) {
-		fetch_alternates(alt->base);
-		if (obj_req->repo->next != NULL) {
-			obj_req->repo =
-				obj_req->repo->next;
-			close(obj_req->local);
-			obj_req->local = -1;
-			start_object_request(obj_req);
-			return;
-		}
-	}
-
-	finish_object_request(obj_req);
-}
-
-static void release_object_request(struct object_request *obj_req)
-{
-	struct object_request *entry = object_queue_head;
-
-	if (obj_req->local != -1)
-		error("fd leakage in release: %d", obj_req->local);
-	if (obj_req == object_queue_head) {
-		object_queue_head = obj_req->next;
-	} else {
-		while (entry->next != NULL && entry->next != obj_req)
-			entry = entry->next;
-		if (entry->next == obj_req)
-			entry->next = entry->next->next;
-	}
-
-	free(obj_req->url);
-	free(obj_req);
-}
-
-#ifdef USE_CURL_MULTI
-void fill_active_slots(void)
-{
-	struct object_request *obj_req = object_queue_head;
-	struct active_request_slot *slot = active_queue_head;
-	int num_transfers;
-
-	while (active_requests < max_requests && obj_req != NULL) {
-		if (obj_req->state == WAITING) {
-			if (has_sha1_file(obj_req->sha1))
-				obj_req->state = COMPLETE;
-			else
-				start_object_request(obj_req);
-			curl_multi_perform(curlm, &num_transfers);
-		}
-		obj_req = obj_req->next;
-	}
-
-	while (slot != NULL) {
-		if (!slot->in_use && slot->curl != NULL) {
-			curl_easy_cleanup(slot->curl);
-			slot->curl = NULL;
-		}
-		slot = slot->next;
-	}
-}
-#endif
-
-void prefetch(unsigned char *sha1)
-{
-	struct object_request *newreq;
-	struct object_request *tail;
-	char *filename = sha1_file_name(sha1);
-
-	newreq = xmalloc(sizeof(*newreq));
-	hashcpy(newreq->sha1, sha1);
-	newreq->repo = alt;
-	newreq->url = NULL;
-	newreq->local = -1;
-	newreq->state = WAITING;
-	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
-	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
-		 "%s.temp", filename);
-	newreq->slot = NULL;
-	newreq->next = NULL;
-
-	if (object_queue_head == NULL) {
-		object_queue_head = newreq;
-	} else {
-		tail = object_queue_head;
-		while (tail->next != NULL) {
-			tail = tail->next;
-		}
-		tail->next = newreq;
-	}
-
-#ifdef USE_CURL_MULTI
-	fill_active_slots();
-	step_active_slots();
-#endif
-}
-
-static int fetch_index(struct alt_base *repo, unsigned char *sha1)
-{
-	char *hex = sha1_to_hex(sha1);
-	char *filename;
-	char *url;
-	char tmpfile[PATH_MAX];
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	FILE *indexfile;
-	struct active_request_slot *slot;
-	struct slot_results results;
-
-	if (has_pack_index(sha1))
-		return 0;
-
-	if (get_verbosely)
-		fprintf(stderr, "Getting index for pack %s\n", hex);
-
-	url = xmalloc(strlen(repo->base) + 64);
-	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
-
-	filename = sha1_pack_index_name(sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	indexfile = fopen(tmpfile, "a");
-	if (!indexfile)
-		return error("Unable to open local file %s for pack index",
-			     filename);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = indexfile;
-
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
-	prev_posn = ftell(indexfile);
-	if (prev_posn>0) {
-		if (get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of index for pack %s at byte %ld\n",
-				hex, prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
-		}
-	} else {
-		fclose(indexfile);
-		return error("Unable to start request");
-	}
-
-	fclose(indexfile);
-
-	return move_temp_to_file(tmpfile, filename);
-}
-
-static int setup_index(struct alt_base *repo, unsigned char *sha1)
-{
-	struct packed_git *new_pack;
-	if (has_pack_file(sha1))
-		return 0; /* don't list this as something we can get */
-
-	if (fetch_index(repo, sha1))
-		return -1;
-
-	new_pack = parse_pack_index(sha1);
-	new_pack->next = repo->packs;
-	repo->packs = new_pack;
-	return 0;
-}
-
-static void process_alternates_response(void *callback_data)
-{
-	struct alternates_request *alt_req =
-		(struct alternates_request *)callback_data;
-	struct active_request_slot *slot = alt_req->slot;
-	struct alt_base *tail = alt;
-	const char *base = alt_req->base;
-	static const char null_byte = '\0';
-	char *data;
-	int i = 0;
-
-	if (alt_req->http_specific) {
-		if (slot->curl_result != CURLE_OK ||
-		    !alt_req->buffer->posn) {
-
-			/* Try reusing the slot to get non-http alternates */
-			alt_req->http_specific = 0;
-			sprintf(alt_req->url, "%s/objects/info/alternates",
-				base);
-			curl_easy_setopt(slot->curl, CURLOPT_URL,
-					 alt_req->url);
-			active_requests++;
-			slot->in_use = 1;
-			if (slot->finished != NULL)
-				(*slot->finished) = 0;
-			if (!start_active_slot(slot)) {
-				got_alternates = -1;
-				slot->in_use = 0;
-				if (slot->finished != NULL)
-					(*slot->finished) = 1;
-			}
-			return;
-		}
-	} else if (slot->curl_result != CURLE_OK) {
-		if (!missing_target(slot)) {
-			got_alternates = -1;
-			return;
-		}
-	}
-
-	fwrite_buffer(&null_byte, 1, 1, alt_req->buffer);
-	alt_req->buffer->posn--;
-	data = alt_req->buffer->buffer;
-
-	while (i < alt_req->buffer->posn) {
-		int posn = i;
-		while (posn < alt_req->buffer->posn && data[posn] != '\n')
-			posn++;
-		if (data[posn] == '\n') {
-			int okay = 0;
-			int serverlen = 0;
-			struct alt_base *newalt;
-			char *target = NULL;
-			if (data[i] == '/') {
-				/* This counts
-				 * http://git.host/pub/scm/linux.git/
-				 * -----------here^
-				 * so memcpy(dst, base, serverlen) will
-				 * copy up to "...git.host".
-				 */
-				const char *colon_ss = strstr(base,"://");
-				if (colon_ss) {
-					serverlen = (strchr(colon_ss + 3, '/')
-						     - base);
-					okay = 1;
-				}
-			} else if (!memcmp(data + i, "../", 3)) {
-				/* Relative URL; chop the corresponding
-				 * number of subpath from base (and ../
-				 * from data), and concatenate the result.
-				 *
-				 * The code first drops ../ from data, and
-				 * then drops one ../ from data and one path
-				 * from base.  IOW, one extra ../ is dropped
-				 * from data than path is dropped from base.
-				 *
-				 * This is not wrong.  The alternate in
-				 *     http://git.host/pub/scm/linux.git/
-				 * to borrow from
-				 *     http://git.host/pub/scm/linus.git/
-				 * is ../../linus.git/objects/.  You need
-				 * two ../../ to borrow from your direct
-				 * neighbour.
-				 */
-				i += 3;
-				serverlen = strlen(base);
-				while (i + 2 < posn &&
-				       !memcmp(data + i, "../", 3)) {
-					do {
-						serverlen--;
-					} while (serverlen &&
-						 base[serverlen - 1] != '/');
-					i += 3;
-				}
-				/* If the server got removed, give up. */
-				okay = strchr(base, ':') - base + 3 <
-					serverlen;
-			} else if (alt_req->http_specific) {
-				char *colon = strchr(data + i, ':');
-				char *slash = strchr(data + i, '/');
-				if (colon && slash && colon < data + posn &&
-				    slash < data + posn && colon < slash) {
-					okay = 1;
-				}
-			}
-			/* skip "objects\n" at end */
-			if (okay) {
-				target = xmalloc(serverlen + posn - i - 6);
-				memcpy(target, base, serverlen);
-				memcpy(target + serverlen, data + i,
-				       posn - i - 7);
-				target[serverlen + posn - i - 7] = 0;
-				if (get_verbosely)
-					fprintf(stderr,
-						"Also look at %s\n", target);
-				newalt = xmalloc(sizeof(*newalt));
-				newalt->next = NULL;
-				newalt->base = target;
-				newalt->got_indices = 0;
-				newalt->packs = NULL;
-
-				while (tail->next != NULL)
-					tail = tail->next;
-				tail->next = newalt;
-			}
-		}
-		i = posn + 1;
-	}
-
-	got_alternates = 1;
-}
-
-static void fetch_alternates(const char *base)
-{
-	struct buffer buffer;
-	char *url;
-	char *data;
-	struct active_request_slot *slot;
-	struct alternates_request alt_req;
-
-	/* If another request has already started fetching alternates,
-	   wait for them to arrive and return to processing this request's
-	   curl message */
-#ifdef USE_CURL_MULTI
-	while (got_alternates == 0) {
-		step_active_slots();
-	}
-#endif
-
-	/* Nothing to do if they've already been fetched */
-	if (got_alternates == 1)
-		return;
-
-	/* Start the fetch */
-	got_alternates = 0;
-
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
-	if (get_verbosely)
-		fprintf(stderr, "Getting alternates list for %s\n", base);
-
-	url = xmalloc(strlen(base) + 31);
-	sprintf(url, "%s/objects/info/http-alternates", base);
-
-	/* Use a callback to process the result, since another request
-	   may fail and need to have alternates loaded before continuing */
-	slot = get_active_slot();
-	slot->callback_func = process_alternates_response;
-	slot->callback_data = &alt_req;
-
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-
-	alt_req.base = base;
-	alt_req.url = url;
-	alt_req.buffer = &buffer;
-	alt_req.http_specific = 1;
-	alt_req.slot = slot;
-
-	if (start_active_slot(slot))
-		run_active_slot(slot);
-	else
-		got_alternates = -1;
-
-	free(data);
-	free(url);
-}
-
-static int fetch_indices(struct alt_base *repo)
-{
-	unsigned char sha1[20];
-	char *url;
-	struct buffer buffer;
-	char *data;
-	int i = 0;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
-
-	if (repo->got_indices)
-		return 0;
-
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
-	if (get_verbosely)
-		fprintf(stderr, "Getting pack list for %s\n", repo->base);
-
-	url = xmalloc(strlen(repo->base) + 21);
-	sprintf(url, "%s/objects/info/packs", repo->base);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			if (missing_target(&results)) {
-				repo->got_indices = 1;
-				free(buffer.buffer);
-				return 0;
-			} else {
-				repo->got_indices = 0;
-				free(buffer.buffer);
-				return error("%s", curl_errorstr);
-			}
-		}
-	} else {
-		repo->got_indices = 0;
-		free(buffer.buffer);
-		return error("Unable to start request");
-	}
-
-	data = buffer.buffer;
-	while (i < buffer.posn) {
-		switch (data[i]) {
-		case 'P':
-			i++;
-			if (i + 52 <= buffer.posn &&
-			    !prefixcmp(data + i, " pack-") &&
-			    !prefixcmp(data + i + 46, ".pack\n")) {
-				get_sha1_hex(data + i + 6, sha1);
-				setup_index(repo, sha1);
-				i += 51;
-				break;
-			}
-		default:
-			while (i < buffer.posn && data[i] != '\n')
-				i++;
-		}
-		i++;
-	}
-
-	free(buffer.buffer);
-	repo->got_indices = 1;
-	return 0;
-}
-
-static int fetch_pack(struct alt_base *repo, unsigned char *sha1)
-{
-	char *url;
-	struct packed_git *target;
-	struct packed_git **lst;
-	FILE *packfile;
-	char *filename;
-	char tmpfile[PATH_MAX];
-	int ret;
-	long prev_posn = 0;
-	char range[RANGE_HEADER_SIZE];
-	struct curl_slist *range_header = NULL;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
-
-	if (fetch_indices(repo))
-		return -1;
-	target = find_sha1_pack(sha1, repo->packs);
-	if (!target)
-		return -1;
-
-	if (get_verbosely) {
-		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->sha1));
-		fprintf(stderr, " which contains %s\n",
-			sha1_to_hex(sha1));
-	}
-
-	url = xmalloc(strlen(repo->base) + 65);
-	sprintf(url, "%s/objects/pack/pack-%s.pack",
-		repo->base, sha1_to_hex(target->sha1));
-
-	filename = sha1_pack_name(target->sha1);
-	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
-	packfile = fopen(tmpfile, "a");
-	if (!packfile)
-		return error("Unable to open local file %s for pack",
-			     filename);
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	slot->local = packfile;
-
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
-	prev_posn = ftell(packfile);
-	if (prev_posn>0) {
-		if (get_verbosely)
-			fprintf(stderr,
-				"Resuming fetch of pack %s at byte %ld\n",
-				sha1_to_hex(target->sha1), prev_posn);
-		sprintf(range, "Range: bytes=%ld-", prev_posn);
-		range_header = curl_slist_append(range_header, range);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
-	}
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			fclose(packfile);
-			return error("Unable to get pack file %s\n%s", url,
-				     curl_errorstr);
-		}
-	} else {
-		fclose(packfile);
-		return error("Unable to start request");
-	}
-
-	target->pack_size = ftell(packfile);
-	fclose(packfile);
-
-	ret = move_temp_to_file(tmpfile, filename);
-	if (ret)
-		return ret;
-
-	lst = &repo->packs;
-	while (*lst != target)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
-
-	if (verify_pack(target, 0))
-		return -1;
-	install_packed_git(target);
-
-	return 0;
-}
-
-static void abort_object_request(struct object_request *obj_req)
-{
-	if (obj_req->local >= 0) {
-		close(obj_req->local);
-		obj_req->local = -1;
-	}
-	unlink(obj_req->tmpfile);
-	if (obj_req->slot) {
-		release_active_slot(obj_req->slot);
-		obj_req->slot = NULL;
-	}
-	release_object_request(obj_req);
-}
-
-static int fetch_object(struct alt_base *repo, unsigned char *sha1)
-{
-	char *hex = sha1_to_hex(sha1);
-	int ret = 0;
-	struct object_request *obj_req = object_queue_head;
-
-	while (obj_req != NULL && hashcmp(obj_req->sha1, sha1))
-		obj_req = obj_req->next;
-	if (obj_req == NULL)
-		return error("Couldn't find request for %s in the queue", hex);
-
-	if (has_sha1_file(obj_req->sha1)) {
-		abort_object_request(obj_req);
-		return 0;
-	}
-
-#ifdef USE_CURL_MULTI
-	while (obj_req->state == WAITING) {
-		step_active_slots();
-	}
-#else
-	start_object_request(obj_req);
-#endif
-
-	while (obj_req->state == ACTIVE) {
-		run_active_slot(obj_req->slot);
-	}
-	if (obj_req->local != -1) {
-		close(obj_req->local); obj_req->local = -1;
-	}
-
-	if (obj_req->state == ABORTED) {
-		ret = error("Request for %s aborted", hex);
-	} else if (obj_req->curl_result != CURLE_OK &&
-		   obj_req->http_code != 416) {
-		if (missing_target(obj_req))
-			ret = -1; /* Be silent, it is probably in a pack. */
-		else
-			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
-				    obj_req->errorstr, obj_req->curl_result,
-				    obj_req->http_code, hex);
-	} else if (obj_req->zret != Z_STREAM_END) {
-		corrupt_object_found++;
-		ret = error("File %s (%s) corrupt", hex, obj_req->url);
-	} else if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
-		ret = error("File %s has bad hash", hex);
-	} else if (obj_req->rename < 0) {
-		ret = error("unable to write sha1 filename %s",
-			    obj_req->filename);
-	}
-
-	release_object_request(obj_req);
-	return ret;
-}
-
-int fetch(unsigned char *sha1)
-{
-	struct alt_base *altbase = alt;
-
-	if (!fetch_object(altbase, sha1))
-		return 0;
-	while (altbase) {
-		if (!fetch_pack(altbase, sha1))
-			return 0;
-		fetch_alternates(alt->base);
-		altbase = altbase->next;
-	}
-	return error("Unable to find %s under %s", sha1_to_hex(sha1),
-		     alt->base);
-}
-
-static inline int needs_quote(int ch)
-{
-	if (((ch >= 'A') && (ch <= 'Z'))
-			|| ((ch >= 'a') && (ch <= 'z'))
-			|| ((ch >= '0') && (ch <= '9'))
-			|| (ch == '/')
-			|| (ch == '-')
-			|| (ch == '.'))
-		return 0;
-	return 1;
-}
-
-static inline int hex(int v)
-{
-	if (v < 10) return '0' + v;
-	else return 'A' + v - 10;
-}
-
-static char *quote_ref_url(const char *base, const char *ref)
-{
-	const char *cp;
-	char *dp, *qref;
-	int len, baselen, ch;
-
-	baselen = strlen(base);
-	len = baselen + 7; /* "/refs/" + NUL */
-	for (cp = ref; (ch = *cp) != 0; cp++, len++)
-		if (needs_quote(ch))
-			len += 2; /* extra two hex plus replacement % */
-	qref = xmalloc(len);
-	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "/refs/", 6);
-	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
-		if (needs_quote(ch)) {
-			*dp++ = '%';
-			*dp++ = hex((ch >> 4) & 0xF);
-			*dp++ = hex(ch & 0xF);
-		}
-		else
-			*dp++ = ch;
-	}
-	*dp = 0;
-
-	return qref;
-}
-
-int fetch_ref(char *ref, unsigned char *sha1)
-{
-        char *url;
-        char hex[42];
-        struct buffer buffer;
-	const char *base = alt->base;
-	struct active_request_slot *slot;
-	struct slot_results results;
-        buffer.size = 41;
-        buffer.posn = 0;
-        buffer.buffer = hex;
-        hex[41] = '\0';
-
-	url = quote_ref_url(base, ref);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK)
-			return error("Couldn't get %s for %s\n%s",
-				     url, ref, curl_errorstr);
-	} else {
-		return error("Unable to start request");
-	}
-
-        hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
-        return 0;
-}
-
-int main(int argc, const char **argv)
-{
-	int commits;
-	const char **write_ref = NULL;
-	char **commit_id;
-	const char *url;
-	char *s;
-	int arg = 1;
-	int rc = 0;
-
-	setup_git_directory();
-	git_config(git_default_config);
-
-	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't') {
-			get_tree = 1;
-		} else if (argv[arg][1] == 'c') {
-			get_history = 1;
-		} else if (argv[arg][1] == 'a') {
-			get_all = 1;
-			get_tree = 1;
-			get_history = 1;
-		} else if (argv[arg][1] == 'v') {
-			get_verbosely = 1;
-		} else if (argv[arg][1] == 'w') {
-			write_ref = &argv[arg + 1];
-			arg++;
-		} else if (!strcmp(argv[arg], "--recover")) {
-			get_recover = 1;
-		} else if (!strcmp(argv[arg], "--stdin")) {
-			commits_on_stdin = 1;
-		}
-		arg++;
-	}
-	if (argc < arg + 2 - commits_on_stdin) {
-		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
-		return 1;
-	}
-	if (commits_on_stdin) {
-		commits = pull_targets_stdin(&commit_id, &write_ref);
-	} else {
-		commit_id = (char **) &argv[arg++];
-		commits = 1;
-	}
-	url = argv[arg];
-
-	http_init();
-
-	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
-
-	alt = xmalloc(sizeof(*alt));
-	alt->base = xmalloc(strlen(url) + 1);
-	strcpy(alt->base, url);
-	for (s = alt->base + strlen(alt->base) - 1; *s == '/'; --s)
-		*s = 0;
-	alt->got_indices = 0;
-	alt->packs = NULL;
-	alt->next = NULL;
-
-	if (pull(commits, commit_id, write_ref, url))
-		rc = 1;
-
-	http_cleanup();
-
-	curl_slist_free_all(no_pragma_header);
-
-	if (commits_on_stdin)
-		pull_targets_free(commits, commit_id, write_ref);
-
-	if (corrupt_object_found) {
-		fprintf(stderr,
-"Some loose object were found to be corrupt, but they might be just\n"
-"a false '404 Not Found' error message sent with incorrect HTTP\n"
-"status code.  Suggest running git-fsck.\n");
-	}
-	return rc;
-}
diff --git a/http-push.c b/http-push.c
index 7c3720f..1e9cf89 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "commit.h"
 #include "pack.h"
-#include "fetch.h"
 #include "tag.h"
 #include "blob.h"
 #include "http.h"
diff --git a/http-walker.c b/http-walker.c
new file mode 100644
index 0000000..4bd42f2
--- /dev/null
+++ b/http-walker.c
@@ -0,0 +1,1038 @@
+#include "cache.h"
+#include "commit.h"
+#include "pack.h"
+#include "walker.h"
+#include "http.h"
+
+#define PREV_BUF_SIZE 4096
+#define RANGE_HEADER_SIZE 30
+
+struct alt_base
+{
+	char *base;
+	int got_indices;
+	struct packed_git *packs;
+	struct alt_base *next;
+};
+
+enum object_request_state {
+	WAITING,
+	ABORTED,
+	ACTIVE,
+	COMPLETE,
+};
+
+struct object_request
+{
+	struct walker *walker;
+	unsigned char sha1[20];
+	struct alt_base *repo;
+	char *url;
+	char filename[PATH_MAX];
+	char tmpfile[PATH_MAX];
+	int local;
+	enum object_request_state state;
+	CURLcode curl_result;
+	char errorstr[CURL_ERROR_SIZE];
+	long http_code;
+	unsigned char real_sha1[20];
+	SHA_CTX c;
+	z_stream stream;
+	int zret;
+	int rename;
+	struct active_request_slot *slot;
+	struct object_request *next;
+};
+
+struct alternates_request {
+	struct walker *walker;
+	const char *base;
+	char *url;
+	struct buffer *buffer;
+	struct active_request_slot *slot;
+	int http_specific;
+};
+
+struct walker_data {
+	const char *url;
+	int got_alternates;
+	struct alt_base *alt;
+	struct curl_slist *no_pragma_header;
+};
+
+static struct object_request *object_queue_head;
+
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
+	unsigned char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	struct object_request *obj_req = (struct object_request *)data;
+	do {
+		ssize_t retval = xwrite(obj_req->local,
+				       (char *) ptr + posn, size - posn);
+		if (retval < 0)
+			return posn;
+		posn += retval;
+	} while (posn < size);
+
+	obj_req->stream.avail_in = size;
+	obj_req->stream.next_in = ptr;
+	do {
+		obj_req->stream.next_out = expn;
+		obj_req->stream.avail_out = sizeof(expn);
+		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
+		SHA1_Update(&obj_req->c, expn,
+			    sizeof(expn) - obj_req->stream.avail_out);
+	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
+	data_received++;
+	return size;
+}
+
+static int missing__target(int code, int result)
+{
+	return	/* file:// URL -- do we ever use one??? */
+		(result == CURLE_FILE_COULDNT_READ_FILE) ||
+		/* http:// and https:// URL */
+		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
+		/* ftp:// URL */
+		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
+		;
+}
+
+#define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
+
+static void fetch_alternates(struct walker *walker, const char *base);
+
+static void process_object_response(void *callback_data);
+
+static void start_object_request(struct walker *walker,
+				 struct object_request *obj_req)
+{
+	char *hex = sha1_to_hex(obj_req->sha1);
+	char prevfile[PATH_MAX];
+	char *url;
+	char *posn;
+	int prevlocal;
+	unsigned char prev_buf[PREV_BUF_SIZE];
+	ssize_t prev_read = 0;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	struct active_request_slot *slot;
+	struct walker_data *data = walker->data;
+
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
+	unlink(prevfile);
+	rename(obj_req->tmpfile, prevfile);
+	unlink(obj_req->tmpfile);
+
+	if (obj_req->local != -1)
+		error("fd leakage in start: %d", obj_req->local);
+	obj_req->local = open(obj_req->tmpfile,
+			      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/* This could have failed due to the "lazy directory creation";
+	 * try to mkdir the last path component.
+	 */
+	if (obj_req->local < 0 && errno == ENOENT) {
+		char *dir = strrchr(obj_req->tmpfile, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(obj_req->tmpfile, 0777);
+			*dir = '/';
+		}
+		obj_req->local = open(obj_req->tmpfile,
+				      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+
+	if (obj_req->local < 0) {
+		obj_req->state = ABORTED;
+		error("Couldn't create temporary file %s for %s: %s",
+		      obj_req->tmpfile, obj_req->filename, strerror(errno));
+		return;
+	}
+
+	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
+
+	inflateInit(&obj_req->stream);
+
+	SHA1_Init(&obj_req->c);
+
+	url = xmalloc(strlen(obj_req->repo->base) + 51);
+	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
+	strcpy(url, obj_req->repo->base);
+	posn = url + strlen(obj_req->repo->base);
+	strcpy(posn, "/objects/");
+	posn += 9;
+	memcpy(posn, hex, 2);
+	posn += 2;
+	*(posn++) = '/';
+	strcpy(posn, hex + 2);
+	strcpy(obj_req->url, url);
+
+	/* If a previous temp file is present, process what was already
+	   fetched. */
+	prevlocal = open(prevfile, O_RDONLY);
+	if (prevlocal != -1) {
+		do {
+			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
+			if (prev_read>0) {
+				if (fwrite_sha1_file(prev_buf,
+						     1,
+						     prev_read,
+						     obj_req) == prev_read) {
+					prev_posn += prev_read;
+				} else {
+					prev_read = -1;
+				}
+			}
+		} while (prev_read > 0);
+		close(prevlocal);
+	}
+	unlink(prevfile);
+
+	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	   file; also rewind to the beginning of the local file. */
+	if (prev_read == -1) {
+		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
+		inflateInit(&obj_req->stream);
+		SHA1_Init(&obj_req->c);
+		if (prev_posn>0) {
+			prev_posn = 0;
+			lseek(obj_req->local, 0, SEEK_SET);
+			ftruncate(obj_req->local, 0);
+		}
+	}
+
+	slot = get_active_slot();
+	slot->callback_func = process_object_response;
+	slot->callback_data = obj_req;
+	obj_req->slot = slot;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, obj_req);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+
+	/* If we have successfully processed data from a previous fetch
+	   attempt, only fetch the data we don't already have. */
+	if (prev_posn>0) {
+		if (walker->get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of object %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl,
+				 CURLOPT_HTTPHEADER, range_header);
+	}
+
+	/* Try to get the request started, abort the request on error */
+	obj_req->state = ACTIVE;
+	if (!start_active_slot(slot)) {
+		obj_req->state = ABORTED;
+		obj_req->slot = NULL;
+		close(obj_req->local); obj_req->local = -1;
+		free(obj_req->url);
+		return;
+	}
+}
+
+static void finish_object_request(struct object_request *obj_req)
+{
+	struct stat st;
+
+	fchmod(obj_req->local, 0444);
+	close(obj_req->local); obj_req->local = -1;
+
+	if (obj_req->http_code == 416) {
+		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+	} else if (obj_req->curl_result != CURLE_OK) {
+		if (stat(obj_req->tmpfile, &st) == 0)
+			if (st.st_size == 0)
+				unlink(obj_req->tmpfile);
+		return;
+	}
+
+	inflateEnd(&obj_req->stream);
+	SHA1_Final(obj_req->real_sha1, &obj_req->c);
+	if (obj_req->zret != Z_STREAM_END) {
+		unlink(obj_req->tmpfile);
+		return;
+	}
+	if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
+		unlink(obj_req->tmpfile);
+		return;
+	}
+	obj_req->rename =
+		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
+
+	if (obj_req->rename == 0)
+		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
+}
+
+static void process_object_response(void *callback_data)
+{
+	struct object_request *obj_req =
+		(struct object_request *)callback_data;
+	struct walker *walker = obj_req->walker;
+	struct walker_data *data = walker->data;
+	struct alt_base *alt = data->alt;
+
+	obj_req->curl_result = obj_req->slot->curl_result;
+	obj_req->http_code = obj_req->slot->http_code;
+	obj_req->slot = NULL;
+	obj_req->state = COMPLETE;
+
+	/* Use alternates if necessary */
+	if (missing_target(obj_req)) {
+		fetch_alternates(walker, alt->base);
+		if (obj_req->repo->next != NULL) {
+			obj_req->repo =
+				obj_req->repo->next;
+			close(obj_req->local);
+			obj_req->local = -1;
+			start_object_request(walker, obj_req);
+			return;
+		}
+	}
+
+	finish_object_request(obj_req);
+}
+
+static void release_object_request(struct object_request *obj_req)
+{
+	struct object_request *entry = object_queue_head;
+
+	if (obj_req->local != -1)
+		error("fd leakage in release: %d", obj_req->local);
+	if (obj_req == object_queue_head) {
+		object_queue_head = obj_req->next;
+	} else {
+		while (entry->next != NULL && entry->next != obj_req)
+			entry = entry->next;
+		if (entry->next == obj_req)
+			entry->next = entry->next->next;
+	}
+
+	free(obj_req->url);
+	free(obj_req);
+}
+
+#ifdef USE_CURL_MULTI
+void fill_active_slots(struct walker *walker)
+{
+	struct object_request *obj_req = object_queue_head;
+	struct active_request_slot *slot = active_queue_head;
+	int num_transfers;
+
+	while (active_requests < max_requests && obj_req != NULL) {
+		if (obj_req->state == WAITING) {
+			if (has_sha1_file(obj_req->sha1))
+				obj_req->state = COMPLETE;
+			else
+				start_object_request(walker, obj_req);
+			curl_multi_perform(curlm, &num_transfers);
+		}
+		obj_req = obj_req->next;
+	}
+
+	while (slot != NULL) {
+		if (!slot->in_use && slot->curl != NULL) {
+			curl_easy_cleanup(slot->curl);
+			slot->curl = NULL;
+		}
+		slot = slot->next;
+	}
+}
+#endif
+
+static void prefetch(struct walker *impl, unsigned char *sha1)
+{
+	struct object_request *newreq;
+	struct object_request *tail;
+	struct walker_data *data = impl->data;
+	char *filename = sha1_file_name(sha1);
+
+	newreq = xmalloc(sizeof(*newreq));
+	newreq->walker = impl;
+	hashcpy(newreq->sha1, sha1);
+	newreq->repo = data->alt;
+	newreq->url = NULL;
+	newreq->local = -1;
+	newreq->state = WAITING;
+	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
+	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
+		 "%s.temp", filename);
+	newreq->slot = NULL;
+	newreq->next = NULL;
+
+	if (object_queue_head == NULL) {
+		object_queue_head = newreq;
+	} else {
+		tail = object_queue_head;
+		while (tail->next != NULL) {
+			tail = tail->next;
+		}
+		tail->next = newreq;
+	}
+
+#ifdef USE_CURL_MULTI
+	fill_active_slots();
+	step_active_slots();
+#endif
+}
+
+static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	char *filename;
+	char *url;
+	char tmpfile[PATH_MAX];
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	struct walker_data *data = walker->data;
+
+	FILE *indexfile;
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	if (has_pack_index(sha1))
+		return 0;
+
+	if (walker->get_verbosely)
+		fprintf(stderr, "Getting index for pack %s\n", hex);
+
+	url = xmalloc(strlen(repo->base) + 64);
+	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
+
+	filename = sha1_pack_index_name(sha1);
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	indexfile = fopen(tmpfile, "a");
+	if (!indexfile)
+		return error("Unable to open local file %s for pack index",
+			     filename);
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+	slot->local = indexfile;
+
+	/* If there is data present from a previous transfer attempt,
+	   resume where it left off */
+	prev_posn = ftell(indexfile);
+	if (prev_posn>0) {
+		if (walker->get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of index for pack %s at byte %ld\n",
+				hex, prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
+	}
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			fclose(indexfile);
+			return error("Unable to get pack index %s\n%s", url,
+				     curl_errorstr);
+		}
+	} else {
+		fclose(indexfile);
+		return error("Unable to start request");
+	}
+
+	fclose(indexfile);
+
+	return move_temp_to_file(tmpfile, filename);
+}
+
+static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+{
+	struct packed_git *new_pack;
+	if (has_pack_file(sha1))
+		return 0; /* don't list this as something we can get */
+
+	if (fetch_index(walker, repo, sha1))
+		return -1;
+
+	new_pack = parse_pack_index(sha1);
+	new_pack->next = repo->packs;
+	repo->packs = new_pack;
+	return 0;
+}
+
+static void process_alternates_response(void *callback_data)
+{
+	struct alternates_request *alt_req =
+		(struct alternates_request *)callback_data;
+	struct walker *walker = alt_req->walker;
+	struct walker_data *cdata = walker->data;
+	struct active_request_slot *slot = alt_req->slot;
+	struct alt_base *tail = cdata->alt;
+	const char *base = alt_req->base;
+	static const char null_byte = '\0';
+	char *data;
+	int i = 0;
+
+	if (alt_req->http_specific) {
+		if (slot->curl_result != CURLE_OK ||
+		    !alt_req->buffer->posn) {
+
+			/* Try reusing the slot to get non-http alternates */
+			alt_req->http_specific = 0;
+			sprintf(alt_req->url, "%s/objects/info/alternates",
+				base);
+			curl_easy_setopt(slot->curl, CURLOPT_URL,
+					 alt_req->url);
+			active_requests++;
+			slot->in_use = 1;
+			if (slot->finished != NULL)
+				(*slot->finished) = 0;
+			if (!start_active_slot(slot)) {
+				cdata->got_alternates = -1;
+				slot->in_use = 0;
+				if (slot->finished != NULL)
+					(*slot->finished) = 1;
+			}
+			return;
+		}
+	} else if (slot->curl_result != CURLE_OK) {
+		if (!missing_target(slot)) {
+			cdata->got_alternates = -1;
+			return;
+		}
+	}
+
+	fwrite_buffer(&null_byte, 1, 1, alt_req->buffer);
+	alt_req->buffer->posn--;
+	data = alt_req->buffer->buffer;
+
+	while (i < alt_req->buffer->posn) {
+		int posn = i;
+		while (posn < alt_req->buffer->posn && data[posn] != '\n')
+			posn++;
+		if (data[posn] == '\n') {
+			int okay = 0;
+			int serverlen = 0;
+			struct alt_base *newalt;
+			char *target = NULL;
+			if (data[i] == '/') {
+				/* This counts
+				 * http://git.host/pub/scm/linux.git/
+				 * -----------here^
+				 * so memcpy(dst, base, serverlen) will
+				 * copy up to "...git.host".
+				 */
+				const char *colon_ss = strstr(base,"://");
+				if (colon_ss) {
+					serverlen = (strchr(colon_ss + 3, '/')
+						     - base);
+					okay = 1;
+				}
+			} else if (!memcmp(data + i, "../", 3)) {
+				/* Relative URL; chop the corresponding
+				 * number of subpath from base (and ../
+				 * from data), and concatenate the result.
+				 *
+				 * The code first drops ../ from data, and
+				 * then drops one ../ from data and one path
+				 * from base.  IOW, one extra ../ is dropped
+				 * from data than path is dropped from base.
+				 *
+				 * This is not wrong.  The alternate in
+				 *     http://git.host/pub/scm/linux.git/
+				 * to borrow from
+				 *     http://git.host/pub/scm/linus.git/
+				 * is ../../linus.git/objects/.  You need
+				 * two ../../ to borrow from your direct
+				 * neighbour.
+				 */
+				i += 3;
+				serverlen = strlen(base);
+				while (i + 2 < posn &&
+				       !memcmp(data + i, "../", 3)) {
+					do {
+						serverlen--;
+					} while (serverlen &&
+						 base[serverlen - 1] != '/');
+					i += 3;
+				}
+				/* If the server got removed, give up. */
+				okay = strchr(base, ':') - base + 3 <
+					serverlen;
+			} else if (alt_req->http_specific) {
+				char *colon = strchr(data + i, ':');
+				char *slash = strchr(data + i, '/');
+				if (colon && slash && colon < data + posn &&
+				    slash < data + posn && colon < slash) {
+					okay = 1;
+				}
+			}
+			/* skip "objects\n" at end */
+			if (okay) {
+				target = xmalloc(serverlen + posn - i - 6);
+				memcpy(target, base, serverlen);
+				memcpy(target + serverlen, data + i,
+				       posn - i - 7);
+				target[serverlen + posn - i - 7] = 0;
+				if (walker->get_verbosely)
+					fprintf(stderr,
+						"Also look at %s\n", target);
+				newalt = xmalloc(sizeof(*newalt));
+				newalt->next = NULL;
+				newalt->base = target;
+				newalt->got_indices = 0;
+				newalt->packs = NULL;
+
+				while (tail->next != NULL)
+					tail = tail->next;
+				tail->next = newalt;
+			}
+		}
+		i = posn + 1;
+	}
+
+	cdata->got_alternates = 1;
+}
+
+static void fetch_alternates(struct walker *walker, const char *base)
+{
+	struct buffer buffer;
+	char *url;
+	char *data;
+	struct active_request_slot *slot;
+	struct alternates_request alt_req;
+	struct walker_data *cdata = walker->data;
+
+	/* If another request has already started fetching alternates,
+	   wait for them to arrive and return to processing this request's
+	   curl message */
+#ifdef USE_CURL_MULTI
+	while (cdata->got_alternates == 0) {
+		step_active_slots();
+	}
+#endif
+
+	/* Nothing to do if they've already been fetched */
+	if (cdata->got_alternates == 1)
+		return;
+
+	/* Start the fetch */
+	cdata->got_alternates = 0;
+
+	data = xmalloc(4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	if (walker->get_verbosely)
+		fprintf(stderr, "Getting alternates list for %s\n", base);
+
+	url = xmalloc(strlen(base) + 31);
+	sprintf(url, "%s/objects/info/http-alternates", base);
+
+	/* Use a callback to process the result, since another request
+	   may fail and need to have alternates loaded before continuing */
+	slot = get_active_slot();
+	slot->callback_func = process_alternates_response;
+	alt_req.walker = walker;
+	slot->callback_data = &alt_req;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+
+	alt_req.base = base;
+	alt_req.url = url;
+	alt_req.buffer = &buffer;
+	alt_req.http_specific = 1;
+	alt_req.slot = slot;
+
+	if (start_active_slot(slot))
+		run_active_slot(slot);
+	else
+		cdata->got_alternates = -1;
+
+	free(data);
+	free(url);
+}
+
+static int fetch_indices(struct walker *walker, struct alt_base *repo)
+{
+	unsigned char sha1[20];
+	char *url;
+	struct buffer buffer;
+	char *data;
+	int i = 0;
+
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	if (repo->got_indices)
+		return 0;
+
+	data = xmalloc(4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	if (walker->get_verbosely)
+		fprintf(stderr, "Getting pack list for %s\n", repo->base);
+
+	url = xmalloc(strlen(repo->base) + 21);
+	sprintf(url, "%s/objects/info/packs", repo->base);
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			if (missing_target(&results)) {
+				repo->got_indices = 1;
+				free(buffer.buffer);
+				return 0;
+			} else {
+				repo->got_indices = 0;
+				free(buffer.buffer);
+				return error("%s", curl_errorstr);
+			}
+		}
+	} else {
+		repo->got_indices = 0;
+		free(buffer.buffer);
+		return error("Unable to start request");
+	}
+
+	data = buffer.buffer;
+	while (i < buffer.posn) {
+		switch (data[i]) {
+		case 'P':
+			i++;
+			if (i + 52 <= buffer.posn &&
+			    !prefixcmp(data + i, " pack-") &&
+			    !prefixcmp(data + i + 46, ".pack\n")) {
+				get_sha1_hex(data + i + 6, sha1);
+				setup_index(walker, repo, sha1);
+				i += 51;
+				break;
+			}
+		default:
+			while (i < buffer.posn && data[i] != '\n')
+				i++;
+		}
+		i++;
+	}
+
+	free(buffer.buffer);
+	repo->got_indices = 1;
+	return 0;
+}
+
+static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+{
+	char *url;
+	struct packed_git *target;
+	struct packed_git **lst;
+	FILE *packfile;
+	char *filename;
+	char tmpfile[PATH_MAX];
+	int ret;
+	long prev_posn = 0;
+	char range[RANGE_HEADER_SIZE];
+	struct curl_slist *range_header = NULL;
+	struct walker_data *data = walker->data;
+
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	if (fetch_indices(walker, repo))
+		return -1;
+	target = find_sha1_pack(sha1, repo->packs);
+	if (!target)
+		return -1;
+
+	if (walker->get_verbosely) {
+		fprintf(stderr, "Getting pack %s\n",
+			sha1_to_hex(target->sha1));
+		fprintf(stderr, " which contains %s\n",
+			sha1_to_hex(sha1));
+	}
+
+	url = xmalloc(strlen(repo->base) + 65);
+	sprintf(url, "%s/objects/pack/pack-%s.pack",
+		repo->base, sha1_to_hex(target->sha1));
+
+	filename = sha1_pack_name(target->sha1);
+	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
+	packfile = fopen(tmpfile, "a");
+	if (!packfile)
+		return error("Unable to open local file %s for pack",
+			     filename);
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+	slot->local = packfile;
+
+	/* If there is data present from a previous transfer attempt,
+	   resume where it left off */
+	prev_posn = ftell(packfile);
+	if (prev_posn>0) {
+		if (walker->get_verbosely)
+			fprintf(stderr,
+				"Resuming fetch of pack %s at byte %ld\n",
+				sha1_to_hex(target->sha1), prev_posn);
+		sprintf(range, "Range: bytes=%ld-", prev_posn);
+		range_header = curl_slist_append(range_header, range);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, range_header);
+	}
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			fclose(packfile);
+			return error("Unable to get pack file %s\n%s", url,
+				     curl_errorstr);
+		}
+	} else {
+		fclose(packfile);
+		return error("Unable to start request");
+	}
+
+	target->pack_size = ftell(packfile);
+	fclose(packfile);
+
+	ret = move_temp_to_file(tmpfile, filename);
+	if (ret)
+		return ret;
+
+	lst = &repo->packs;
+	while (*lst != target)
+		lst = &((*lst)->next);
+	*lst = (*lst)->next;
+
+	if (verify_pack(target, 0))
+		return -1;
+	install_packed_git(target);
+
+	return 0;
+}
+
+static void abort_object_request(struct object_request *obj_req)
+{
+	if (obj_req->local >= 0) {
+		close(obj_req->local);
+		obj_req->local = -1;
+	}
+	unlink(obj_req->tmpfile);
+	if (obj_req->slot) {
+		release_active_slot(obj_req->slot);
+		obj_req->slot = NULL;
+	}
+	release_object_request(obj_req);
+}
+
+static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	int ret = 0;
+	struct object_request *obj_req = object_queue_head;
+
+	while (obj_req != NULL && hashcmp(obj_req->sha1, sha1))
+		obj_req = obj_req->next;
+	if (obj_req == NULL)
+		return error("Couldn't find request for %s in the queue", hex);
+
+	if (has_sha1_file(obj_req->sha1)) {
+		abort_object_request(obj_req);
+		return 0;
+	}
+
+#ifdef USE_CURL_MULTI
+	while (obj_req->state == WAITING) {
+		step_active_slots();
+	}
+#else
+	start_object_request(walker, obj_req);
+#endif
+
+	while (obj_req->state == ACTIVE) {
+		run_active_slot(obj_req->slot);
+	}
+	if (obj_req->local != -1) {
+		close(obj_req->local); obj_req->local = -1;
+	}
+
+	if (obj_req->state == ABORTED) {
+		ret = error("Request for %s aborted", hex);
+	} else if (obj_req->curl_result != CURLE_OK &&
+		   obj_req->http_code != 416) {
+		if (missing_target(obj_req))
+			ret = -1; /* Be silent, it is probably in a pack. */
+		else
+			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
+				    obj_req->errorstr, obj_req->curl_result,
+				    obj_req->http_code, hex);
+	} else if (obj_req->zret != Z_STREAM_END) {
+		walker->corrupt_object_found++;
+		ret = error("File %s (%s) corrupt", hex, obj_req->url);
+	} else if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
+		ret = error("File %s has bad hash", hex);
+	} else if (obj_req->rename < 0) {
+		ret = error("unable to write sha1 filename %s",
+			    obj_req->filename);
+	}
+
+	release_object_request(obj_req);
+	return ret;
+}
+
+static int fetch(struct walker *impl, unsigned char *sha1)
+{
+	struct walker_data *data = impl->data;
+	struct alt_base *altbase = data->alt;
+
+	if (!fetch_object(impl, altbase, sha1))
+		return 0;
+	while (altbase) {
+		if (!fetch_pack(impl, altbase, sha1))
+			return 0;
+		fetch_alternates(impl, data->alt->base);
+		altbase = altbase->next;
+	}
+	return error("Unable to find %s under %s", sha1_to_hex(sha1),
+		     data->alt->base);
+}
+
+static inline int needs_quote(int ch)
+{
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
+		return 0;
+	return 1;
+}
+
+static inline int hex(int v)
+{
+	if (v < 10) return '0' + v;
+	else return 'A' + v - 10;
+}
+
+static char *quote_ref_url(const char *base, const char *ref)
+{
+	const char *cp;
+	char *dp, *qref;
+	int len, baselen, ch;
+
+	baselen = strlen(base);
+	len = baselen + 7; /* "/refs/" + NUL */
+	for (cp = ref; (ch = *cp) != 0; cp++, len++)
+		if (needs_quote(ch))
+			len += 2; /* extra two hex plus replacement % */
+	qref = xmalloc(len);
+	memcpy(qref, base, baselen);
+	memcpy(qref + baselen, "/refs/", 6);
+	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
+		if (needs_quote(ch)) {
+			*dp++ = '%';
+			*dp++ = hex((ch >> 4) & 0xF);
+			*dp++ = hex(ch & 0xF);
+		}
+		else
+			*dp++ = ch;
+	}
+	*dp = 0;
+
+	return qref;
+}
+
+static int fetch_ref(struct walker *impl, char *ref, unsigned char *sha1)
+{
+        char *url;
+        char hex[42];
+        struct buffer buffer;
+	struct walker_data *data = impl->data;
+	const char *base = data->alt->base;
+	struct active_request_slot *slot;
+	struct slot_results results;
+        buffer.size = 41;
+        buffer.posn = 0;
+        buffer.buffer = hex;
+        hex[41] = '\0';
+
+	url = quote_ref_url(base, ref);
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK)
+			return error("Couldn't get %s for %s\n%s",
+				     url, ref, curl_errorstr);
+	} else {
+		return error("Unable to start request");
+	}
+
+        hex[40] = '\0';
+        get_sha1_hex(hex, sha1);
+        return 0;
+}
+
+static void cleanup(struct walker *walker)
+{
+	struct walker_data *data = walker->data;
+	http_cleanup();
+
+	curl_slist_free_all(data->no_pragma_header);
+}
+
+struct walker *get_http_walker(const char *url)
+{
+	char *s;
+	struct walker_data *data = xmalloc(sizeof(struct walker_data));
+	struct walker *walker = xmalloc(sizeof(struct walker));
+
+	http_init();
+
+	data->no_pragma_header = curl_slist_append(NULL, "Pragma:");
+
+	data->alt = xmalloc(sizeof(*data->alt));
+	data->alt->base = xmalloc(strlen(url) + 1);
+	strcpy(data->alt->base, url);
+	for (s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
+		*s = 0;
+	data->alt->got_indices = 0;
+	data->alt->packs = NULL;
+	data->alt->next = NULL;
+	data->got_alternates = -1;
+
+	walker->corrupt_object_found = 0;
+	walker->fetch = fetch;
+	walker->fetch_ref = fetch_ref;
+	walker->prefetch = prefetch;
+	walker->cleanup = cleanup;
+	walker->data = data;
+	return walker;
+}
diff --git a/walker.c b/walker.c
new file mode 100644
index 0000000..5c65ea4
--- /dev/null
+++ b/walker.c
@@ -0,0 +1,318 @@
+#include "cache.h"
+#include "walker.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "tag.h"
+#include "blob.h"
+#include "refs.h"
+#include "strbuf.h"
+
+static unsigned char current_commit_sha1[20];
+
+void walker_say(struct walker *walker, const char *fmt, const char *hex)
+{
+	if (walker->get_verbosely)
+		fprintf(stderr, fmt, hex);
+}
+
+static void report_missing(const struct object *obj)
+{
+	char missing_hex[41];
+	strcpy(missing_hex, sha1_to_hex(obj->sha1));;
+	fprintf(stderr, "Cannot obtain needed %s %s\n",
+		obj->type ? typename(obj->type): "object", missing_hex);
+	if (!is_null_sha1(current_commit_sha1))
+		fprintf(stderr, "while processing commit %s.\n",
+			sha1_to_hex(current_commit_sha1));
+}
+
+static int process(struct walker *walker, struct object *obj);
+
+static int process_tree(struct walker *walker, struct tree *tree)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		struct object *obj = NULL;
+
+		/* submodule commits are not stored in the superproject */
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode)) {
+			struct tree *tree = lookup_tree(entry.sha1);
+			if (tree)
+				obj = &tree->object;
+		}
+		else {
+			struct blob *blob = lookup_blob(entry.sha1);
+			if (blob)
+				obj = &blob->object;
+		}
+		if (!obj || process(walker, obj))
+			return -1;
+	}
+	free(tree->buffer);
+	tree->buffer = NULL;
+	tree->size = 0;
+	return 0;
+}
+
+#define COMPLETE	(1U << 0)
+#define SEEN		(1U << 1)
+#define TO_SCAN		(1U << 2)
+
+static struct commit_list *complete = NULL;
+
+static int process_commit(struct walker *walker, struct commit *commit)
+{
+	if (parse_commit(commit))
+		return -1;
+
+	while (complete && complete->item->date >= commit->date) {
+		pop_most_recent_commit(&complete, COMPLETE);
+	}
+
+	if (commit->object.flags & COMPLETE)
+		return 0;
+
+	hashcpy(current_commit_sha1, commit->object.sha1);
+
+	walker_say(walker, "walk %s\n", sha1_to_hex(commit->object.sha1));
+
+	if (walker->get_tree) {
+		if (process(walker, &commit->tree->object))
+			return -1;
+		if (!walker->get_all)
+			walker->get_tree = 0;
+	}
+	if (walker->get_history) {
+		struct commit_list *parents = commit->parents;
+		for (; parents; parents = parents->next) {
+			if (process(walker, &parents->item->object))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static int process_tag(struct walker *walker, struct tag *tag)
+{
+	if (parse_tag(tag))
+		return -1;
+	return process(walker, tag->tagged);
+}
+
+static struct object_list *process_queue = NULL;
+static struct object_list **process_queue_end = &process_queue;
+
+static int process_object(struct walker *walker, struct object *obj)
+{
+	if (obj->type == OBJ_COMMIT) {
+		if (process_commit(walker, (struct commit *)obj))
+			return -1;
+		return 0;
+	}
+	if (obj->type == OBJ_TREE) {
+		if (process_tree(walker, (struct tree *)obj))
+			return -1;
+		return 0;
+	}
+	if (obj->type == OBJ_BLOB) {
+		return 0;
+	}
+	if (obj->type == OBJ_TAG) {
+		if (process_tag(walker, (struct tag *)obj))
+			return -1;
+		return 0;
+	}
+	return error("Unable to determine requirements "
+		     "of type %s for %s",
+		     typename(obj->type), sha1_to_hex(obj->sha1));
+}
+
+static int process(struct walker *walker, struct object *obj)
+{
+	if (obj->flags & SEEN)
+		return 0;
+	obj->flags |= SEEN;
+
+	if (has_sha1_file(obj->sha1)) {
+		/* We already have it, so we should scan it now. */
+		obj->flags |= TO_SCAN;
+	}
+	else {
+		if (obj->flags & COMPLETE)
+			return 0;
+		walker->prefetch(walker, obj->sha1);
+	}
+
+	object_list_insert(obj, process_queue_end);
+	process_queue_end = &(*process_queue_end)->next;
+	return 0;
+}
+
+static int loop(struct walker *walker)
+{
+	struct object_list *elem;
+
+	while (process_queue) {
+		struct object *obj = process_queue->item;
+		elem = process_queue;
+		process_queue = elem->next;
+		free(elem);
+		if (!process_queue)
+			process_queue_end = &process_queue;
+
+		/* If we are not scanning this object, we placed it in
+		 * the queue because we needed to fetch it first.
+		 */
+		if (! (obj->flags & TO_SCAN)) {
+			if (walker->fetch(walker, obj->sha1)) {
+				report_missing(obj);
+				return -1;
+			}
+		}
+		if (!obj->type)
+			parse_object(obj->sha1);
+		if (process_object(walker, obj))
+			return -1;
+	}
+	return 0;
+}
+
+static int interpret_target(struct walker *walker, char *target, unsigned char *sha1)
+{
+	if (!get_sha1_hex(target, sha1))
+		return 0;
+	if (!check_ref_format(target)) {
+		if (!walker->fetch_ref(walker, target, sha1)) {
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit) {
+		commit->object.flags |= COMPLETE;
+		insert_by_date(commit, &complete);
+	}
+	return 0;
+}
+
+int walker_targets_stdin(char ***target, const char ***write_ref)
+{
+	int targets = 0, targets_alloc = 0;
+	struct strbuf buf;
+	*target = NULL; *write_ref = NULL;
+	strbuf_init(&buf);
+	while (1) {
+		char *rf_one = NULL;
+		char *tg_one;
+
+		read_line(&buf, stdin, '\n');
+		if (buf.eof)
+			break;
+		tg_one = buf.buf;
+		rf_one = strchr(tg_one, '\t');
+		if (rf_one)
+			*rf_one++ = 0;
+
+		if (targets >= targets_alloc) {
+			targets_alloc = targets_alloc ? targets_alloc * 2 : 64;
+			*target = xrealloc(*target, targets_alloc * sizeof(**target));
+			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
+		}
+		(*target)[targets] = xstrdup(tg_one);
+		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
+		targets++;
+	}
+	return targets;
+}
+
+void walker_targets_free(int targets, char **target, const char **write_ref)
+{
+	while (targets--) {
+		free(target[targets]);
+		if (write_ref && write_ref[targets])
+			free((char *) write_ref[targets]);
+	}
+}
+
+int walker_fetch(struct walker *walker, int targets, char **target,
+		 const char **write_ref, const char *write_ref_log_details)
+{
+	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	unsigned char *sha1 = xmalloc(targets * 20);
+	char *msg;
+	int ret;
+	int i;
+
+	save_commit_buffer = 0;
+	track_object_refs = 0;
+
+	for (i = 0; i < targets; i++) {
+		if (!write_ref || !write_ref[i])
+			continue;
+
+		lock[i] = lock_ref_sha1(write_ref[i], NULL);
+		if (!lock[i]) {
+			error("Can't lock ref %s", write_ref[i]);
+			goto unlock_and_fail;
+		}
+	}
+
+	if (!walker->get_recover)
+		for_each_ref(mark_complete, NULL);
+
+	for (i = 0; i < targets; i++) {
+		if (interpret_target(walker, target[i], &sha1[20 * i])) {
+			error("Could not interpret %s as something to pull", target[i]);
+			goto unlock_and_fail;
+		}
+		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
+			goto unlock_and_fail;
+	}
+
+	if (loop(walker))
+		goto unlock_and_fail;
+
+	if (write_ref_log_details) {
+		msg = xmalloc(strlen(write_ref_log_details) + 12);
+		sprintf(msg, "fetch from %s", write_ref_log_details);
+	} else {
+		msg = NULL;
+	}
+	for (i = 0; i < targets; i++) {
+		if (!write_ref || !write_ref[i])
+			continue;
+		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
+		lock[i] = NULL;
+		if (ret)
+			goto unlock_and_fail;
+	}
+	free(msg);
+
+	return 0;
+
+unlock_and_fail:
+	for (i = 0; i < targets; i++)
+		if (lock[i])
+			unlock_ref(lock[i]);
+
+	return -1;
+}
+
+void walker_free(struct walker *walker)
+{
+	walker->cleanup(walker);
+	free(walker);
+}
diff --git a/walker.h b/walker.h
new file mode 100644
index 0000000..ea2c363
--- /dev/null
+++ b/walker.h
@@ -0,0 +1,37 @@
+#ifndef WALKER_H
+#define WALKER_H
+
+struct walker {
+	void *data;
+	int (*fetch_ref)(struct walker *, char *ref, unsigned char *sha1);
+	void (*prefetch)(struct walker *, unsigned char *sha1);
+	int (*fetch)(struct walker *, unsigned char *sha1);
+	void (*cleanup)(struct walker *);
+	int get_tree;
+	int get_history;
+	int get_all;
+	int get_verbosely;
+	int get_recover;
+
+	int corrupt_object_found;
+};
+
+/* Report what we got under get_verbosely */
+void walker_say(struct walker *walker, const char *, const char *);
+
+/* Load pull targets from stdin */
+int walker_targets_stdin(char ***target, const char ***write_ref);
+
+/* Free up loaded targets */
+void walker_targets_free(int targets, char **target, const char **write_ref);
+
+/* If write_ref is set, the ref filename to write the target value to. */
+/* If write_ref_log_details is set, additional text will appear in the ref log. */
+int walker_fetch(struct walker *impl, int targets, char **target,
+		 const char **write_ref, const char *write_ref_log_details);
+
+void walker_free(struct walker *walker);
+
+struct walker *get_http_walker(const char *url);
+
+#endif /* WALKER_H */
-- 
1.5.2.2.1391.gcad2-dirty
