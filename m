From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 2/2] Fix sparse warnings
Date: Tue, 22 Mar 2011 00:51:05 -0700
Message-ID: <1300780265-5698-1-git-send-email-bebarino@gmail.com>
References: <7vzkoop912.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wNA-00023X-OU
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 08:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab1CVHvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 03:51:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35959 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab1CVHvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 03:51:17 -0400
Received: by iyb26 with SMTP id 26so7177139iyb.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IN1Q9B62rm5gLwIzmuiXeL5MFXtMb9GZywGJKIwJRhs=;
        b=Oe6z8FM8vOvNmXRColENQU1/3un8YyNo+u8f/tacHvz1Sge5IwW92TJ54Dbx1FEQON
         f/F0GWijAHpVj70AiAsnwG4bFx4rz6SEwsa+UTrsd7ti/ltfiUuB7tZ/UJflmch8u6cH
         bqW27fNrYa4ABuLet3FWk7/A9xb+VVTt1wJdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x2xs4sreTTzRaBOG0E5axm85treoplnXIWzchKtmiXesjUb2LN9ZZSU0dN0Sqa0L06
         3Re+peEqPWp1O6giPu1Q0GX8wS0/H0iCvje+7PVUm2sftsm418klGUU4R6/MF33OKGVu
         K99XSMIVFag6KiTHKQGMjgbdIIROkQPuLE7Ik=
Received: by 10.231.32.75 with SMTP id b11mr5216153ibd.95.1300780276540;
        Tue, 22 Mar 2011 00:51:16 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id s1sm1505144iba.58.2011.03.22.00.51.08
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 00:51:13 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 22 Mar 2011 00:51:05 -0700
X-Mailer: git-send-email 1.7.4.1.343.ga91df
In-Reply-To: <7vzkoop912.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169704>

Fix warnings from 'make check'.

These files don't include 'builtin.h' causing sparse to complain that
cmd_* isn't declared:

builtin/clone.c:364, builtin/fetch-pack.c:797,
builtin/fmt-merge-msg.c:34, builtin/hash-object.c:78,
builtin/merge-index.c:69, builtin/merge-recursive.c:22
builtin/merge-tree.c:341, builtin/mktag.c:156, builtin/notes.c:426
builtin/notes.c:822, builtin/pack-redundant.c:596,
builtin/pack-refs.c:10, builtin/patch-id.c:60, builtin/patch-id.c:149,
builtin/remote.c:1512, builtin/remote-ext.c:240, builtin/remote-fd.c:53,
builtin/reset.c:236, builtin/send-pack.c:384, builtin/unpack-file.c:25,
builtin/var.c:75

These files have symbols which should be marked static since they're
only file scope:

submodule.c:12, diff.c:631, replace_object.c:92, submodule.c:13,
submodule.c:14, trace.c:78, transport.c:195, transport-helper.c:79,
unpack-trees.c:19, url.c:3, url.c:18, url.c:104, url.c:117, url.c:123,
url.c:129, url.c:136, thread-utils.c:21, thread-utils.c:48,

These files redeclare symbols to be different types:

builtin/index-pack.c:210, parse-options.c:564, parse-options.c:571,
usage.c:49, usage.c:58, usage.c:63, usage.c:72,

These files use a literal integer 0 when they really should use a NULL
pointer:

daemon.c:663, fast-import.c:2942, imap-send.c:1072, notes-merge.c:362

When we're in the area try to cleanup some unused #includes in builtin
files (mostly exec_cmdh.h).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Squashed in Junio's fixup and reworded commit message. Plus
removed some of the exec_cmd.h usages and a stray blob.h include.

 builtin/clone.c           |    2 +-
 builtin/fetch-pack.c      |    2 +-
 builtin/fmt-merge-msg.c   |    2 +-
 builtin/hash-object.c     |    2 +-
 builtin/index-pack.c      |    2 +-
 builtin/merge-index.c     |    3 +--
 builtin/merge-recursive.c |    2 +-
 builtin/merge-tree.c      |    2 +-
 builtin/mktag.c           |    3 +--
 builtin/notes.c           |    4 ++--
 builtin/pack-redundant.c  |    3 +--
 builtin/pack-refs.c       |    2 +-
 builtin/patch-id.c        |    5 ++---
 builtin/remote-ext.c      |    1 +
 builtin/remote-fd.c       |    1 +
 builtin/remote.c          |    2 +-
 builtin/reset.c           |    2 +-
 builtin/send-pack.c       |    2 +-
 builtin/unpack-file.c     |    4 +---
 builtin/var.c             |    3 +--
 daemon.c                  |    2 +-
 diff.c                    |    2 +-
 fast-import.c             |    2 +-
 imap-send.c               |    2 +-
 notes-merge.c             |    2 +-
 parse-options.c           |    4 ++--
 replace_object.c          |    1 +
 submodule.c               |    6 +++---
 thread-utils.c            |    2 +-
 trace.c                   |    2 +-
 transport-helper.c        |    2 +-
 transport.c               |    2 +-
 unpack-trees.c            |    2 +-
 url.c                     |    1 +
 usage.c                   |    8 ++++----
 35 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 02547ad..c6e10bb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 272bc38..ef39862 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "commit.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 5189b16..7581632 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -31,7 +31,7 @@ struct src_data {
 	int head_status;
 };
 
-void init_src_data(struct src_data *data)
+static void init_src_data(struct src_data *data)
 {
 	data->branch.strdup_strings = 1;
 	data->tag.strdup_strings = 1;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c90acdd..b96f46a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c7e600d..5a67c81 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -207,7 +207,7 @@ static void parse_pack_header(void)
 static NORETURN void bad_object(unsigned long offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
-static void bad_object(unsigned long offset, const char *format, ...)
+static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 {
 	va_list params;
 	char buf[1024];
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..2338832 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,6 +1,5 @@
-#include "cache.h"
+#include "builtin.h"
 #include "run-command.h"
-#include "exec_cmd.h"
 
 static const char *pgm;
 static int one_shot, quiet;
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c33091b..3a64f5d 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9b25ddc..1991742 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..d0ccbb2 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,6 +1,5 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
-#include "exec_cmd.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/builtin/notes.c b/builtin/notes.c
index 0aab150..a0f310b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -423,7 +423,7 @@ void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
 	free(c);
 }
 
-int notes_copy_from_stdin(int force, const char *rewrite_cmd)
+static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct notes_rewrite_cfg *c = NULL;
@@ -819,7 +819,7 @@ static int merge_commit(struct notes_merge_options *o)
 	t = xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
-	o->local_ref = resolve_ref("NOTES_MERGE_REF", sha1, 0, 0);
+	o->local_ref = resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..f5c6afc 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,8 +6,7 @@
 *
 */
 
-#include "cache.h"
-#include "exec_cmd.h"
+#include "builtin.h"
 
 #define BLKSIZE 512
 
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 091860b..39a9d89 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "pack-refs.h"
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 49a0472..f821eb3 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,5 +1,4 @@
-#include "cache.h"
-#include "exec_cmd.h"
+#include "builtin.h"
 
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
 {
@@ -57,7 +56,7 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
+static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
 	static char line[1000];
 	int patchlen = 0, found_next = 0;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index ea71977..23e84e7 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "git-compat-util.h"
 #include "transport.h"
 #include "run-command.h"
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 1f2467b..b11b211 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "git-compat-util.h"
 #include "transport.h"
 
diff --git a/builtin/remote.c b/builtin/remote.c
index cb26080..b71ecd2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 5de2bce..eb5f98c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2cd1c40..8b0911c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 608590a..1920029 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,6 +1,4 @@
-#include "cache.h"
-#include "blob.h"
-#include "exec_cmd.h"
+#include "builtin.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
diff --git a/builtin/var.c b/builtin/var.c
index 0744bb8..99d068a 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,8 +3,7 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-#include "cache.h"
-#include "exec_cmd.h"
+#include "builtin.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
diff --git a/daemon.c b/daemon.c
index 347fd0c..4c8346d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -660,7 +660,7 @@ static void check_dead_children(void)
 static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
-	struct child_process cld = { 0 };
+	struct child_process cld = { NULL };
 	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
 	char *env[] = { addrbuf, portbuf, NULL };
 
diff --git a/diff.c b/diff.c
index 42a107c..9b3eb99 100644
--- a/diff.c
+++ b/diff.c
@@ -628,7 +628,7 @@ struct diff_words_style {
 	const char *newline;
 };
 
-struct diff_words_style diff_words_styles[] = {
+static struct diff_words_style diff_words_styles[] = {
 	{ DIFF_WORDS_PORCELAIN, {"+", "\n"}, {"-", "\n"}, {" ", "\n"}, "~\n" },
 	{ DIFF_WORDS_PLAIN, {"{+", "+}"}, {"[-", "-]"}, {"", ""}, "\n" },
 	{ DIFF_WORDS_COLOR, {"", ""}, {"", ""}, {"", ""}, "\n" }
diff --git a/fast-import.c b/fast-import.c
index d9f9a3f..65d65bf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2939,7 +2939,7 @@ static void parse_ls(struct branch *b)
 {
 	const char *p;
 	struct tree_entry *root = NULL;
-	struct tree_entry leaf = {0};
+	struct tree_entry leaf = {NULL};
 
 	/* ls SP (<treeish> SP)? <path> */
 	p = command_buf.buf + strlen("ls ");
diff --git a/imap-send.c b/imap-send.c
index 71506a8..9adf4b9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1069,7 +1069,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 	if (srvc->tunnel) {
 		const char *argv[] = { srvc->tunnel, NULL };
-		struct child_process tunnel = {0};
+		struct child_process tunnel = {NULL};
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
diff --git a/notes-merge.c b/notes-merge.c
index 1467ad3..28046a9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -359,7 +359,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	read_mmblob(&remote, p->remote);
 
 	status = ll_merge(&result_buf, sha1_to_hex(p->obj), &base, NULL,
-			  &local, o->local_ref, &remote, o->remote_ref, 0);
+			  &local, o->local_ref, &remote, o->remote_ref, NULL);
 
 	free(base.ptr);
 	free(local.ptr);
diff --git a/parse-options.c b/parse-options.c
index 42b51ef..73bd28a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -561,14 +561,14 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_HELP;
 }
 
-void usage_with_options(const char * const *usagestr,
+void NORETURN usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
 	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
 	exit(129);
 }
 
-void usage_msg_opt(const char *msg,
+void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
diff --git a/replace_object.c b/replace_object.c
index eb59604..7c6c754 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "sha1-lookup.h"
 #include "refs.h"
+#include "commit.h"
 
 static struct replace_object {
 	unsigned char sha1[2][20];
diff --git a/submodule.c b/submodule.c
index e9f2b19..0cb6d18 100644
--- a/submodule.c
+++ b/submodule.c
@@ -9,9 +9,9 @@
 #include "refs.h"
 #include "string-list.h"
 
-struct string_list config_name_for_path;
-struct string_list config_fetch_recurse_submodules_for_name;
-struct string_list config_ignore_for_name;
+static struct string_list config_name_for_path;
+static struct string_list config_fetch_recurse_submodules_for_name;
+static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules;
 
 static int add_submodule_odb(const char *path)
diff --git a/thread-utils.c b/thread-utils.c
index 589f838..7f4b76a 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include <pthread.h>
+#include "thread-utils.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
diff --git a/trace.c b/trace.c
index 8390bf7..d953416 100644
--- a/trace.c
+++ b/trace.c
@@ -75,7 +75,7 @@ void trace_vprintf(const char *key, const char *fmt, va_list ap)
 	strbuf_release(&buf);
 }
 
-void trace_printf_key(const char *key, const char *fmt, ...)
+static void trace_printf_key(const char *key, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
diff --git a/transport-helper.c b/transport-helper.c
index 0c5b1bd..5846b55 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -76,7 +76,7 @@ static void write_constant(int fd, const char *str)
 		die_errno("Full write to remote helper failed");
 }
 
-const char *remove_ext_force(const char *url)
+static const char *remove_ext_force(const char *url)
 {
 	if (url) {
 		const char *colon = strchr(url, ':');
diff --git a/transport.c b/transport.c
index 0078660..f1c0781 100644
--- a/transport.c
+++ b/transport.c
@@ -192,7 +192,7 @@ static const char *rsync_url(const char *url)
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
-	struct ref dummy = {0}, *tail = &dummy;
+	struct ref dummy = {NULL}, *tail = &dummy;
 	struct child_process rsync;
 	const char *args[5];
 	int temp_dir_len;
diff --git a/unpack-trees.c b/unpack-trees.c
index b68ec82..500ebcf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,7 +16,7 @@
  * situation better.  See how "git checkout" and "git merge" replaces
  * them using setup_unpack_trees_porcelain(), for example.
  */
-const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
+static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
diff --git a/url.c b/url.c
index 6a54959..3e06fd3 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "url.h"
 
 int is_urlschemechar(int first_flag, int ch)
 {
diff --git a/usage.c b/usage.c
index ec4cf53..b5e67e3 100644
--- a/usage.c
+++ b/usage.c
@@ -46,7 +46,7 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 	die_routine = routine;
 }
 
-void usagef(const char *err, ...)
+void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
 
@@ -55,12 +55,12 @@ void usagef(const char *err, ...)
 	va_end(params);
 }
 
-void usage(const char *err)
+void NORETURN usage(const char *err)
 {
 	usagef("%s", err);
 }
 
-void die(const char *err, ...)
+void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
@@ -69,7 +69,7 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
-void die_errno(const char *fmt, ...)
+void NORETURN die_errno(const char *fmt, ...)
 {
 	va_list params;
 	char fmt_with_err[1024];
-- 
1.7.4.1.343.ga91df
