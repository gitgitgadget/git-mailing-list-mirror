From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v7] Add git-grep threads param
Date: Sun, 13 Dec 2015 18:17:36 +0300
Message-ID: <1450019856-14609-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, gitster@pobox.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 16:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a88QJ-0002vv-0L
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 16:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbbLMPSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 10:18:50 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33260 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbbLMPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 10:18:48 -0500
Received: by lfcy184 with SMTP id y184so4005326lfc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2hS/0nta66/W+mloZOhdLe16M4jdV7H7RA+PCgeDE7k=;
        b=xdj2qH+oR3CFMG5Hlt7NGOCje9U0ubWhPTQRhXu6KSzzQOIakT6bEs/VqVmU7JfgIl
         rFKAoXL4RCCDKxOiWN900NM5bZRq7sTRZc20OO1clCObYnMZI0p3aQWoH6bOQDu+317n
         sEZezJ13e1fdS0NNmTcqVm/pqqWHnhbOSSbiyzTuVHOTiLEKlRe2skStW20QKZvrCobe
         xg7wjEtla2iJ+1IlFthqRduIaj0o5atLI1KtCBQl3rnz6rBIS2sc8Pu6nA3fXaEFkAlr
         zByeybzXrBfVrA+SuwFD+1uuPCy80g8BPrB1sgdawtycS0gESDSatOCraWlFNXuFcR6U
         YFlw==
X-Received: by 10.25.208.11 with SMTP id h11mr11844665lfg.109.1450019927124;
        Sun, 13 Dec 2015 07:18:47 -0800 (PST)
Received: from del-debian ([31.173.85.127])
        by smtp.gmail.com with ESMTPSA id us1sm4769733lbc.25.2015.12.13.07.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2015 07:18:46 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a88Q7-0003oL-85; Sun, 13 Dec 2015 18:18:43 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282332>

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Changes to default behavior: number of threads now doesn't depend
 on online_cpus(), e.g. if specific number is not configured
 GREP_NUM_THREADS_DEFAULT (8) threads will be used even on 1-core CPU.

 Reason: multithreading can improve performance even on single core machines
 as IO is also a major factor here. Using multiple threads can significantly
 boost grep performance when working on slow filesystems (or repo isn't cached)
 or through network (for example repo is located on NFS).

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
	* Fixed broken t7811: moved all threads_num setup to 1 place (for -O option it was in wrong place) ($gmane/281160)
	* Fixed 'invalid number of threads' message so that it could be translated ($gmane/281160)
	* Got rid of grep_threads_config() - its too trivial to be separate function ($gmane/281160)
	* Fixed xcalloc() args (sizeof(pthread_t) -> sizeof(*threads)) to correspond to general git style ($gmane/281160)
	* Improved commit message to explain why online_cpus() is now not used in threads_num setup ($gmane/281160)


 Documentation/config.txt               |  7 ++++++
 Documentation/git-grep.txt             | 15 ++++++++++++
 builtin/grep.c                         | 42 ++++++++++++++++++++++------------
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d06b11..687b9ad 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1450,6 +1450,13 @@ grep.extendedRegexp::
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
index 4229cae..756b6af 100644
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
+	threads = xcalloc(num_threads, sizeof(*threads));
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
@@ -267,6 +270,10 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	int st = grep_config(var, value, cb);
 	if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
+
+	if (!strcmp(var, "grep.threads"))
+		num_threads = git_config_int(var, value); /* Sanity check of value will be perfomed later */
+
 	return st;
 }
 
@@ -294,7 +301,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	}
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
@@ -323,7 +330,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
@@ -697,6 +704,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
+		OPT_INTEGER(0, "threads", &num_threads,
+			N_("use <n> worker threads")),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -786,7 +795,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.output_priv = &path_list;
 		opt.output = append_path;
 		string_list_append(&path_list, show_in_pager);
-		use_threads = 0;
 	}
 
 	if (!opt.pattern_list)
@@ -817,14 +825,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
-		use_threads = 0;
+	if (list.nr || cached || show_in_pager)
+		num_threads = 0; /* Can not multi-thread object lookup */
+	else if (num_threads == 0)
+		num_threads = GREP_NUM_THREADS_DEFAULT; /* User didn't specify value, or just wants default behavior */
+	else if (num_threads < 0)
+		die(_("invalid number of threads specified (%d)"), num_threads);
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
@@ -894,7 +906,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
-	if (use_threads)
+	if (num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 111b053..d5c3e3f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1311,6 +1311,7 @@ _git_grep ()
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
 			--perl-regexp
+			--threads
 			--files-with-matches --name-only
 			--files-without-match
 			--max-depth
-- 
2.6.3.369.g3e7f205.dirty
