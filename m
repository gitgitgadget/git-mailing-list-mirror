From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v5] Add git-grep threads param
Date: Tue, 10 Nov 2015 16:28:38 +0300
Message-ID: <1447162118-17636-1-git-send-email-vleschuk@accesssoftek.com>
Cc: Victor Leschuk <vleschuk@accesssoftek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 14:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw8yw-0003Qc-FC
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 14:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbKJN27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 08:28:59 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36630 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbKJN25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 08:28:57 -0500
Received: by lfs39 with SMTP id 39so85362176lfs.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 05:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kvJ8MsXdS7Z8JmLkwDpVICzV0J0UZGZ0gtHP0/9O+sE=;
        b=AldGChav8CcfI8hs+La3ysSddJPyhb2SNgQl1lEMGsvjwWC5ZE68kcpO9csJyRWxF6
         WxTYEQqLYBJhHTJ93OOyPDqFqpaDFJgYbfUGIctpPG9DxnaO6XPBGmgulYSqhyGHsNzm
         z0My0zMKrc4UVHH0n4CwqZyH0fIyzs96YYyQ2ROFv1a7pCPpeTAdOeufKWykUJPzGXLF
         9x20YKBaQD/UO73P6rdBTVckOXyapi370So7N1Je9nKn+6v/tTnr3c+DlMg5Dlhf5QBM
         YAYtZd9yBBpx5Jf7od9E0U07iflWamjtV5y1M/38lgm6EUUUFP8CB+KZ9/b/lBIDprHp
         gqdQ==
X-Received: by 10.25.205.193 with SMTP id d184mr1646914lfg.72.1447162135261;
        Tue, 10 Nov 2015 05:28:55 -0800 (PST)
Received: from del-debian (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id 64sm518382lfu.35.2015.11.10.05.28.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2015 05:28:54 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1Zw8yh-0004b9-Qk; Tue, 10 Nov 2015 16:28:51 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281122>

"git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 Documentation/config.txt               |  7 +++++
 Documentation/git-grep.txt             | 15 ++++++++++
 builtin/grep.c                         | 50 +++++++++++++++++++++++-----------
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..467fa7b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1447,6 +1447,13 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.threads::
+	Number of grep worker threads, use it to tune up performance on
+	your machines. Leave it unset (or set to 0) for default behavior,
+	which for now is using 8 threads for all systems.
+	Default behavior can be changed in future versions
+	to better suite hardware and circumstances.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..91027b6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
@@ -53,6 +54,13 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.threads::
+	Number of grep worker threads, use it to tune up performance on
+	your machines. Leave it unset (or set to 0) for default behavior,
+	which for now is using 8 threads for all systems.
+	Default behavior can be changed in future versions
+	to better suite hardware and circumstances.
+
 grep.fullName::
 	If set to true, enable '--full-name' option by default.
 
@@ -227,6 +235,13 @@ OPTIONS
 	effectively showing the whole function in which the match was
 	found.
 
+--threads <num>::
+	Number of grep worker threads, use it to tune up performance on
+	your machines. Leave it unset (or set to 0) for default behavior,
+	which for now is using 8 threads for all systems.
+	Default behavior can be changed in future versions
+	to better suite hardware and circumstances.
+
 -f <file>::
 	Read patterns from <file>, one per line.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..f0e3dfb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,11 +24,11 @@ static char const * const grep_usage[] = {
 	NULL
 };
 
-static int use_threads = 1;
+#define GREP_NUM_THREADS_DEFAULT 8
+static int num_threads = 0;
 
 #ifndef NO_PTHREADS
-#define THREADS 8
-static pthread_t threads[THREADS];
+static pthread_t *threads;
 
 /* We use one producer thread and THREADS consumer
  * threads. The producer adds struct work_items to 'todo' and the
@@ -63,13 +63,13 @@ static pthread_mutex_t grep_mutex;
 
 static inline void grep_lock(void)
 {
-	if (use_threads)
+	if (num_threads)
 		pthread_mutex_lock(&grep_mutex);
 }
 
 static inline void grep_unlock(void)
 {
-	if (use_threads)
+	if (num_threads)
 		pthread_mutex_unlock(&grep_mutex);
 }
 
@@ -206,7 +206,8 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	threads = xcalloc(num_threads, sizeof(pthread_t));
+	for (i = 0; i < num_threads; i++) {
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
@@ -238,12 +239,14 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	for (i = 0; i < num_threads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |= (int) (intptr_t) h;
 	}
 
+	free(threads);
+
 	pthread_mutex_destroy(&grep_mutex);
 	pthread_mutex_destroy(&grep_read_mutex);
 	pthread_mutex_destroy(&grep_attr_mutex);
@@ -262,10 +265,19 @@ static int wait_all(void)
 }
 #endif
 
+static int grep_threads_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "grep.threads"))
+		num_threads = git_config_int(var, value); /* Sanity check of value will be perfomed later */
+	return 0;
+}
+
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	if (grep_threads_config(var, value, cb) < 0)
+		st = -1;
+	else if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
 	return st;
 }
@@ -294,7 +306,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	}
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
@@ -323,7 +335,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
@@ -702,6 +714,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
+		OPT_INTEGER(0, "threads", &num_threads,
+			N_("use <n> worker threads")),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -801,7 +815,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.output_priv = &path_list;
 		opt.output = append_path;
 		string_list_append(&path_list, show_in_pager);
-		use_threads = 0;
+		num_threads = 0;
 	}
 
 	if (!opt.pattern_list)
@@ -832,14 +846,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
-		use_threads = 0;
+	if (list.nr || cached)
+		num_threads = 0; /* Can not multi-thread object lookup */
+	else if (num_threads == 0)
+		num_threads = GREP_NUM_THREADS_DEFAULT; /* User didn't specify value, or just wants default behavior */
+	else if (num_threads < 0)
+		die("Invalid number of threads specified (%d)", num_threads);
 #else
-	use_threads = 0;
+	num_threads = 0;
 #endif
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
 		    && (opt.pre_context || opt.post_context ||
 			opt.file_break || opt.funcbody))
@@ -909,7 +927,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
-	if (use_threads)
+	if (num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..390d9c0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1310,6 +1310,7 @@ _git_grep ()
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
 			--perl-regexp
+			--threads
 			--files-with-matches --name-only
 			--files-without-match
 			--max-depth
-- 
2.6.3.369.g3e7f205.dirty
