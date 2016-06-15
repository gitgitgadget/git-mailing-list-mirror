From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] rerere: Separate libgit and builtin functions
Date: Wed,  9 Jul 2008 12:18:03 +0200
Message-ID: <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGWlQ-00018O-85
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 12:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYGIKSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYGIKSK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 06:18:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbYGIKSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 06:18:08 -0400
Received: (qmail invoked by alias); 09 Jul 2008 10:18:04 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp012) with SMTP; 09 Jul 2008 12:18:04 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19d6FIM68hd+PngGvnaS/RtwxFHlqNA2vAwl53Vjg
	wQ9J0iCIuQVd1v
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGWkN-0002Wa-W0; Wed, 09 Jul 2008 12:18:03 +0200
X-Mailer: git-send-email 1.5.6.2.574.gd4568
In-Reply-To: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87864>

This patch moves rerere()-related functions into a newly created
rerere.c file.  Also setup_rerere() is moved into rerere.c to decrease
code duplications for rerere.c and builtin-rerere.c.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

> BTW I think it is a horrible thing that rerere() is declared in commit.h
> (a libgit header), but implemented in builtin-rerere.c, which is not part
> of libgit.a.

Ok, I give it a try.

 Makefile                     |    2 +
 builtin-rerere.c             |  324 +++---------------------------------------
 builtin-rerere.c => rerere.c |  133 +-----------------
 rerere.h                     |    9 ++
 4 files changed, 32 insertions(+), 436 deletions(-)
 copy builtin-rerere.c => rerere.c (66%)
 create mode 100644 rerere.h

diff --git a/Makefile b/Makefile
index bddd1a7..4e23c29 100644
--- a/Makefile
+++ b/Makefile
@@ -363,6 +363,7 @@ LIB_H += quote.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
+LIB_H += rerere.h
 LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += sha1-lookup.h
@@ -447,6 +448,7 @@ LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
+LIB_OBJS += rerere.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 85222d9..669a963 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
+#include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
@@ -13,183 +14,11 @@ static const char git_rerere_usage[] =
 static int cutoff_noresolve = 15;
 static int cutoff_resolve = 60;
 
-/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
-static int rerere_enabled = -1;
-
-static char *merge_rr_path;
-
 static const char *rr_path(const char *name, const char *file)
 {
 	return git_path("rr-cache/%s/%s", name, file);
 }
 
-static void read_rr(struct path_list *rr)
-{
-	unsigned char sha1[20];
-	char buf[PATH_MAX];
-	FILE *in = fopen(merge_rr_path, "r");
-	if (!in)
-		return;
-	while (fread(buf, 40, 1, in) == 1) {
-		int i;
-		char *name;
-		if (get_sha1_hex(buf, sha1))
-			die("corrupt MERGE_RR");
-		buf[40] = '\0';
-		name = xstrdup(buf);
-		if (fgetc(in) != '\t')
-			die("corrupt MERGE_RR");
-		for (i = 0; i < sizeof(buf) && (buf[i] = fgetc(in)); i++)
-			; /* do nothing */
-		if (i == sizeof(buf))
-			die("filename too long");
-		path_list_insert(buf, rr)->util = name;
-	}
-	fclose(in);
-}
-
-static struct lock_file write_lock;
-
-static int write_rr(struct path_list *rr, int out_fd)
-{
-	int i;
-	for (i = 0; i < rr->nr; i++) {
-		const char *path = rr->items[i].path;
-		int length = strlen(path) + 1;
-		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
-		    write_in_full(out_fd, "\t", 1) != 1 ||
-		    write_in_full(out_fd, path, length) != length)
-			die("unable to write rerere record");
-	}
-	if (commit_lock_file(&write_lock) != 0)
-		die("unable to write rerere record");
-	return 0;
-}
-
-static int handle_file(const char *path,
-	 unsigned char *sha1, const char *output)
-{
-	SHA_CTX ctx;
-	char buf[1024];
-	int hunk = 0, hunk_no = 0;
-	struct strbuf one, two;
-	FILE *f = fopen(path, "r");
-	FILE *out = NULL;
-
-	if (!f)
-		return error("Could not open %s", path);
-
-	if (output) {
-		out = fopen(output, "w");
-		if (!out) {
-			fclose(f);
-			return error("Could not write %s", output);
-		}
-	}
-
-	if (sha1)
-		SHA1_Init(&ctx);
-
-	strbuf_init(&one, 0);
-	strbuf_init(&two,  0);
-	while (fgets(buf, sizeof(buf), f)) {
-		if (!prefixcmp(buf, "<<<<<<< "))
-			hunk = 1;
-		else if (!prefixcmp(buf, "======="))
-			hunk = 2;
-		else if (!prefixcmp(buf, ">>>>>>> ")) {
-			int cmp = strbuf_cmp(&one, &two);
-
-			hunk_no++;
-			hunk = 0;
-			if (cmp > 0) {
-				strbuf_swap(&one, &two);
-			}
-			if (out) {
-				fputs("<<<<<<<\n", out);
-				fwrite(one.buf, one.len, 1, out);
-				fputs("=======\n", out);
-				fwrite(two.buf, two.len, 1, out);
-				fputs(">>>>>>>\n", out);
-			}
-			if (sha1) {
-				SHA1_Update(&ctx, one.buf ? one.buf : "",
-					    one.len + 1);
-				SHA1_Update(&ctx, two.buf ? two.buf : "",
-					    two.len + 1);
-			}
-			strbuf_reset(&one);
-			strbuf_reset(&two);
-		} else if (hunk == 1)
-			strbuf_addstr(&one, buf);
-		else if (hunk == 2)
-			strbuf_addstr(&two, buf);
-		else if (out)
-			fputs(buf, out);
-	}
-	strbuf_release(&one);
-	strbuf_release(&two);
-
-	fclose(f);
-	if (out)
-		fclose(out);
-	if (sha1)
-		SHA1_Final(sha1, &ctx);
-	return hunk_no;
-}
-
-static int find_conflict(struct path_list *conflict)
-{
-	int i;
-	if (read_cache() < 0)
-		return error("Could not read index");
-	for (i = 0; i+1 < active_nr; i++) {
-		struct cache_entry *e2 = active_cache[i];
-		struct cache_entry *e3 = active_cache[i+1];
-		if (ce_stage(e2) == 2 &&
-		    ce_stage(e3) == 3 &&
-		    ce_same_name(e2, e3) &&
-		    S_ISREG(e2->ce_mode) &&
-		    S_ISREG(e3->ce_mode)) {
-			path_list_insert((const char *)e2->name, conflict);
-			i++; /* skip over both #2 and #3 */
-		}
-	}
-	return 0;
-}
-
-static int merge(const char *name, const char *path)
-{
-	int ret;
-	mmfile_t cur, base, other;
-	mmbuffer_t result = {NULL, 0};
-	xpparam_t xpp = {XDF_NEED_MINIMAL};
-
-	if (handle_file(path, NULL, rr_path(name, "thisimage")) < 0)
-		return 1;
-
-	if (read_mmfile(&cur, rr_path(name, "thisimage")) ||
-			read_mmfile(&base, rr_path(name, "preimage")) ||
-			read_mmfile(&other, rr_path(name, "postimage")))
-		return 1;
-	ret = xdl_merge(&base, &cur, "", &other, "",
-			&xpp, XDL_MERGE_ZEALOUS, &result);
-	if (!ret) {
-		FILE *f = fopen(path, "w");
-		if (!f)
-			return error("Could not write to %s", path);
-		fwrite(result.ptr, result.size, 1, f);
-		fclose(f);
-	}
-
-	free(cur.ptr);
-	free(base.ptr);
-	free(other.ptr);
-	free(result.ptr);
-
-	return ret;
-}
-
 static void unlink_rr_item(const char *name)
 {
 	unlink(rr_path(name, "thisimage"));
@@ -198,6 +27,17 @@ static void unlink_rr_item(const char *name)
 	rmdir(git_path("rr-cache/%s", name));
 }
 
+static int git_rerere_gc_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "gc.rerereresolved"))
+		cutoff_resolve = git_config_int(var, value);
+	else if (!strcmp(var, "gc.rerereunresolved"))
+		cutoff_noresolve = git_config_int(var, value);
+	else
+		return git_default_config(var, value, cb);
+	return 0;
+}
+
 static void garbage_collect(struct path_list *rr)
 {
 	struct path_list to_remove = { NULL, 0, 0, 1 };
@@ -207,6 +47,7 @@ static void garbage_collect(struct path_list *rr)
 	int len, i, cutoff;
 	time_t now = time(NULL), then;
 
+	git_config(git_rerere_gc_config, NULL);
 	strlcpy(buf, git_path("rr-cache"), sizeof(buf));
 	len = strlen(buf);
 	dir = opendir(buf);
@@ -267,148 +108,19 @@ static int diff_two(const char *file1, const char *label1,
 	return 0;
 }
 
-static int do_plain_rerere(struct path_list *rr, int fd)
-{
-	struct path_list conflict = { NULL, 0, 0, 1 };
-	int i;
-
-	find_conflict(&conflict);
-
-	/*
-	 * MERGE_RR records paths with conflicts immediately after merge
-	 * failed.  Some of the conflicted paths might have been hand resolved
-	 * in the working tree since then, but the initial run would catch all
-	 * and register their preimages.
-	 */
-
-	for (i = 0; i < conflict.nr; i++) {
-		const char *path = conflict.items[i].path;
-		if (!path_list_has_path(rr, path)) {
-			unsigned char sha1[20];
-			char *hex;
-			int ret;
-			ret = handle_file(path, sha1, NULL);
-			if (ret < 1)
-				continue;
-			hex = xstrdup(sha1_to_hex(sha1));
-			path_list_insert(path, rr)->util = hex;
-			if (mkdir(git_path("rr-cache/%s", hex), 0755))
-				continue;;
-			handle_file(path, NULL, rr_path(hex, "preimage"));
-			fprintf(stderr, "Recorded preimage for '%s'\n", path);
-		}
-	}
-
-	/*
-	 * Now some of the paths that had conflicts earlier might have been
-	 * hand resolved.  Others may be similar to a conflict already that
-	 * was resolved before.
-	 */
-
-	for (i = 0; i < rr->nr; i++) {
-		struct stat st;
-		int ret;
-		const char *path = rr->items[i].path;
-		const char *name = (const char *)rr->items[i].util;
-
-		if (!stat(rr_path(name, "preimage"), &st) &&
-				!stat(rr_path(name, "postimage"), &st)) {
-			if (!merge(name, path)) {
-				fprintf(stderr, "Resolved '%s' using "
-						"previous resolution.\n", path);
-				goto tail_optimization;
-			}
-		}
-
-		/* Let's see if we have resolved it. */
-		ret = handle_file(path, NULL, NULL);
-		if (ret)
-			continue;
-
-		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(rr_path(name, "postimage"), path, 0666);
-tail_optimization:
-		if (i < rr->nr - 1)
-			memmove(rr->items + i,
-				rr->items + i + 1,
-				sizeof(rr->items[0]) * (rr->nr - i - 1));
-		rr->nr--;
-		i--;
-	}
-
-	return write_rr(rr, fd);
-}
-
-static int git_rerere_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "gc.rerereresolved"))
-		cutoff_resolve = git_config_int(var, value);
-	else if (!strcmp(var, "gc.rerereunresolved"))
-		cutoff_noresolve = git_config_int(var, value);
-	else if (!strcmp(var, "rerere.enabled"))
-		rerere_enabled = git_config_bool(var, value);
-	else
-		return git_default_config(var, value, cb);
-	return 0;
-}
-
-static int is_rerere_enabled(void)
-{
-	struct stat st;
-	const char *rr_cache;
-	int rr_cache_exists;
-
-	if (!rerere_enabled)
-		return 0;
-
-	rr_cache = git_path("rr-cache");
-	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
-	if (rerere_enabled < 0)
-		return rr_cache_exists;
-
-	if (!rr_cache_exists &&
-	    (mkdir(rr_cache, 0777) || adjust_shared_perm(rr_cache)))
-		die("Could not create directory %s", rr_cache);
-	return 1;
-}
-
-static int setup_rerere(struct path_list *merge_rr)
-{
-	int fd;
-
-	git_config(git_rerere_config, NULL);
-	if (!is_rerere_enabled())
-		return -1;
-
-	merge_rr_path = xstrdup(git_path("rr-cache/MERGE_RR"));
-	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
-	read_rr(merge_rr);
-	return fd;
-}
-
-int rerere(void)
-{
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
-	int fd;
-
-	fd = setup_rerere(&merge_rr);
-	if (fd < 0)
-		return 0;
-	return do_plain_rerere(&merge_rr, fd);
-}
-
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct path_list merge_rr = { NULL, 0, 0, 1 };
 	int i, fd;
 
+	if (argc < 2)
+		return rerere();
+
 	fd = setup_rerere(&merge_rr);
 	if (fd < 0)
 		return 0;
 
-	if (argc < 2)
-		return do_plain_rerere(&merge_rr, fd);
-	else if (!strcmp(argv[1], "clear")) {
+	if (!strcmp(argv[1], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
 			struct stat st;
 			const char *name = (const char *)merge_rr.items[i].util;
@@ -417,7 +129,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 					stat(rr_path(name, "postimage"), &st))
 				unlink_rr_item(name);
 		}
-		unlink(merge_rr_path);
+		unlink(git_path("rr-cache/MERGE_RR"));
 	} else if (!strcmp(argv[1], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[1], "status"))
diff --git a/builtin-rerere.c b/rerere.c
similarity index 66%
copy from builtin-rerere.c
copy to rerere.c
index 85222d9..5c22bed 100644
--- a/builtin-rerere.c
+++ b/rerere.c
@@ -1,18 +1,11 @@
-#include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
+#include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
 #include <time.h>
 
-static const char git_rerere_usage[] =
-"git-rerere [clear | status | diff | gc]";
-
-/* these values are days */
-static int cutoff_noresolve = 15;
-static int cutoff_resolve = 60;
-
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
 
@@ -190,83 +183,6 @@ static int merge(const char *name, const char *path)
 	return ret;
 }
 
-static void unlink_rr_item(const char *name)
-{
-	unlink(rr_path(name, "thisimage"));
-	unlink(rr_path(name, "preimage"));
-	unlink(rr_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
-}
-
-static void garbage_collect(struct path_list *rr)
-{
-	struct path_list to_remove = { NULL, 0, 0, 1 };
-	char buf[1024];
-	DIR *dir;
-	struct dirent *e;
-	int len, i, cutoff;
-	time_t now = time(NULL), then;
-
-	strlcpy(buf, git_path("rr-cache"), sizeof(buf));
-	len = strlen(buf);
-	dir = opendir(buf);
-	strcpy(buf + len++, "/");
-	while ((e = readdir(dir))) {
-		const char *name = e->d_name;
-		struct stat st;
-		if (name[0] == '.' && (name[1] == '\0' ||
-					(name[1] == '.' && name[2] == '\0')))
-			continue;
-		i = snprintf(buf + len, sizeof(buf) - len, "%s", name);
-		strlcpy(buf + len + i, "/preimage", sizeof(buf) - len - i);
-		if (stat(buf, &st))
-			continue;
-		then = st.st_mtime;
-		strlcpy(buf + len + i, "/postimage", sizeof(buf) - len - i);
-		cutoff = stat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
-		if (then < now - cutoff * 86400) {
-			buf[len + i] = '\0';
-			path_list_insert(xstrdup(name), &to_remove);
-		}
-	}
-	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].path);
-	path_list_clear(&to_remove, 0);
-}
-
-static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
-{
-	int i;
-	for (i = 0; i < nbuf; i++)
-		if (write_in_full(1, ptr[i].ptr, ptr[i].size) != ptr[i].size)
-			return -1;
-	return 0;
-}
-
-static int diff_two(const char *file1, const char *label1,
-		const char *file2, const char *label2)
-{
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
-	mmfile_t minus, plus;
-
-	if (read_mmfile(&minus, file1) || read_mmfile(&plus, file2))
-		return 1;
-
-	printf("--- a/%s\n+++ b/%s\n", label1, label2);
-	fflush(stdout);
-	xpp.flags = XDF_NEED_MINIMAL;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 3;
-	ecb.outf = outf;
-	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
-
-	free(minus.ptr);
-	free(plus.ptr);
-	return 0;
-}
-
 static int do_plain_rerere(struct path_list *rr, int fd)
 {
 	struct path_list conflict = { NULL, 0, 0, 1 };
@@ -341,11 +257,7 @@ tail_optimization:
 
 static int git_rerere_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "gc.rerereresolved"))
-		cutoff_resolve = git_config_int(var, value);
-	else if (!strcmp(var, "gc.rerereunresolved"))
-		cutoff_noresolve = git_config_int(var, value);
-	else if (!strcmp(var, "rerere.enabled"))
+	if (!strcmp(var, "rerere.enabled"))
 		rerere_enabled = git_config_bool(var, value);
 	else
 		return git_default_config(var, value, cb);
@@ -372,7 +284,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-static int setup_rerere(struct path_list *merge_rr)
+int setup_rerere(struct path_list *merge_rr)
 {
 	int fd;
 
@@ -396,42 +308,3 @@ int rerere(void)
 		return 0;
 	return do_plain_rerere(&merge_rr, fd);
 }
-
-int cmd_rerere(int argc, const char **argv, const char *prefix)
-{
-	struct path_list merge_rr = { NULL, 0, 0, 1 };
-	int i, fd;
-
-	fd = setup_rerere(&merge_rr);
-	if (fd < 0)
-		return 0;
-
-	if (argc < 2)
-		return do_plain_rerere(&merge_rr, fd);
-	else if (!strcmp(argv[1], "clear")) {
-		for (i = 0; i < merge_rr.nr; i++) {
-			struct stat st;
-			const char *name = (const char *)merge_rr.items[i].util;
-			if (!stat(git_path("rr-cache/%s", name), &st) &&
-					S_ISDIR(st.st_mode) &&
-					stat(rr_path(name, "postimage"), &st))
-				unlink_rr_item(name);
-		}
-		unlink(merge_rr_path);
-	} else if (!strcmp(argv[1], "gc"))
-		garbage_collect(&merge_rr);
-	else if (!strcmp(argv[1], "status"))
-		for (i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].path);
-	else if (!strcmp(argv[1], "diff"))
-		for (i = 0; i < merge_rr.nr; i++) {
-			const char *path = merge_rr.items[i].path;
-			const char *name = (const char *)merge_rr.items[i].util;
-			diff_two(rr_path(name, "preimage"), path, path, path);
-		}
-	else
-		usage(git_rerere_usage);
-
-	path_list_clear(&merge_rr, 1);
-	return 0;
-}
diff --git a/rerere.h b/rerere.h
new file mode 100644
index 0000000..35b0fa8
--- /dev/null
+++ b/rerere.h
@@ -0,0 +1,9 @@
+#ifndef RERERE_H
+#define RERERE_H
+
+#include "path-list.h"
+
+extern int setup_rerere(struct path_list *);
+extern int rerere(void);
+
+#endif
-- 
1.5.6.2.574.gd4568
