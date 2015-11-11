From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v6] Add git-grep threads param
Date: Wed, 11 Nov 2015 14:52:50 +0300
Message-ID: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Cc: Victor Leschuk <vleschuk@accesssoftek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 12:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwTxm-0008WK-39
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 12:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbbKKLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 06:53:08 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32829 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbKKLxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 06:53:03 -0500
Received: by lbbkw15 with SMTP id kw15so15440192lbb.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 03:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Hevr72mn3sMi1U8eT9Po4vNfqilnoGpRtWYwSBPxpD4=;
        b=o7DLrLg81kJtu5JaJByEMiw2PdHaKJYhnUlhk+lGyS0t/t3bcsjpyQ7TwxEhbG1Sqv
         sjK8HBfoGUjOyfX+jqohqme28j/hssnOBWKlM0b5iIIb/OovDCdxc5jkjpmF3eNlKBF5
         mwEvmcPbeIxB2Gw8jvRYgyjjw8Nm0o/NwF7LQkxiIKF3dZ+e0+o7P1c13UXZHgenfv74
         AdoBQs5Is8nutXTrA6mYKre3le8u1ooNQZRNnaKGAjo+fhTbAmHYAotWWSe8U9I6qCfv
         gAuT1YeKsluyz1zjlh0I/8801EeIqK6cRWINwajaVyAJ4uCXMM1F7S9lFiA58m3sXcKF
         Zv8Q==
X-Received: by 10.112.145.226 with SMTP id sx2mr2657303lbb.105.1447242781290;
        Wed, 11 Nov 2015 03:53:01 -0800 (PST)
Received: from del-debian (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id d187sm1413504lfd.26.2015.11.11.03.53.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2015 03:53:00 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1ZwTxT-0005PQ-88; Wed, 11 Nov 2015 14:52:59 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281160>

"git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Changes to default behavior: number of threads now doesn't depend
 on online_cpus(), e.g. if specific number is not configured
 GREP_NUM_THREADS_DEFAULT (8) threads will be used even on 1-core CPU. 

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
History of changes from the first version ($gmane/280053/:
	* Param renamed from threads-num to threads
	* Short version of '--threads' cmd key was removed
	* Made num_threads 'decision-tree' more obvious 
	  and easy to edit for future use ($gmane/280089)
	* Moved option description to more suitable place in documentation ($gmane/280188)
	* Hid threads param from 'external' grep.c, made it private for builtin/grep.c ($gmane/280188)
	* Improved num_threads 'decision-tree', got rid of dependency on online_cpus ($gmane/280299)
	* Improved param documentation ($gmane/280299)


 Documentation/config.txt               |  7 +++++
 Documentation/git-grep.txt             | 15 ++++++++++
 builtin/grep.c                         | 50 +++++++++++++++++++++++-----------
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..5084e36 100644
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
+	to better suit hardware and circumstances.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..8222a83 100644
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
+	to better suit hardware and circumstances.
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
+	to better suit hardware and circumstances.
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
