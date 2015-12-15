From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH 1/2] Introduce grep threads param
Date: Tue, 15 Dec 2015 18:31:39 +0300
Message-ID: <1450193500-22468-2-git-send-email-vleschuk@accesssoftek.com>
References: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, gitster@pobox.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 16:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ra2-00017n-PV
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 16:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbbLOPbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 10:31:48 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34793 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829AbbLOPbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 10:31:47 -0500
Received: by mail-lb0-f177.google.com with SMTP id cs9so8002721lbb.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CjSfyhq4SBsFrbLApGVX2LfbrjfMI9MBsqLPD4u35FY=;
        b=tOARGb3F4thQdOPPHEULeOaNUCdR2IWSUldhiNa/fbGP8zFnCKeAjkNc0mcJUTyJL6
         smRo34n0fC635bVIi8MPQ0GfVkPZLiGHgO8pkE0c7r3b98LaehVHIV120HWk2jTnE160
         SNxRA+3ArqJWEdUPEVNjP7nCSR6+1ybFqAZ+lL/EGQQ3it6LfA+YShmH7h8klXlJLcUl
         185F6jswpMCSEuBqvJeOwgANXOcjEJi6+Qna/pd+Vd3bMitVaO3Jr8Z/s3uMoWz8nWuP
         zOFBje/nYLGGNI8/qV0e1P7hRb1rHim8qEF7wgTtsbrdoNMvwRl3W6zBCfEM+AJDuRd7
         Gk3Q==
X-Received: by 10.112.36.130 with SMTP id q2mr15596683lbj.116.1450193505546;
        Tue, 15 Dec 2015 07:31:45 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id qp7sm287910lbc.24.2015.12.15.07.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2015 07:31:44 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a8rZn-0005r9-Ed; Tue, 15 Dec 2015 18:31:43 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
In-Reply-To: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282479>

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 Documentation/config.txt               |  4 +++
 Documentation/git-grep.txt             | 12 +++++++++
 builtin/grep.c                         | 49 +++++++++++++++++++++++-----------
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d06b11..cbf4071 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1450,6 +1450,10 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.threads::
+	Number of grep worker threads.
+	See `grep.threads` in linkgit:git-grep[1] for more information.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..25e6dc5 100644
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
+	which is using 8 threads for all systems.
+	Default behavior may change in future versions
+	to better suit hardware and circumstances.
+
 grep.fullName::
 	If set to true, enable '--full-name' option by default.
 
@@ -227,6 +235,10 @@ OPTIONS
 	effectively showing the whole function in which the match was
 	found.
 
+--threads <num>::
+	Number of grep worker threads.
+	See `grep.threads` in 'CONFIGURATION' for more information.
+
 -f <file>::
 	Read patterns from <file>, one per line.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 4229cae..e9aebab 100644
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
@@ -267,6 +270,12 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	int st = grep_config(var, value, cb);
 	if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
+
+	if (!strcmp(var, "grep.threads")) {
+		/* Sanity check of value will be perfomed later */
+		num_threads = git_config_int(var, value);
+	}
+
 	return st;
 }
 
@@ -294,7 +303,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	}
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
@@ -323,7 +332,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (num_threads) {
 		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
@@ -697,6 +706,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
+		OPT_INTEGER(0, "threads", &num_threads,
+			N_("use <n> worker threads")),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -786,7 +797,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.output_priv = &path_list;
 		opt.output = append_path;
 		string_list_append(&path_list, show_in_pager);
-		use_threads = 0;
 	}
 
 	if (!opt.pattern_list)
@@ -817,14 +827,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
-		use_threads = 0;
+	if (list.nr || cached || online_cpus() == 1 || show_in_pager) {
+		/* Can not multi-thread object lookup */
+		num_threads = 0;
+	}
+	else if (num_threads == 0) {
+		/* User didn't specify value, or just wants default behavior */
+		num_threads = GREP_NUM_THREADS_DEFAULT;
+	}
+	else if (num_threads < 0) {
+		die(_("invalid number of threads specified (%d)"), num_threads);
+	}
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
@@ -894,7 +913,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
