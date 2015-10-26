From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v3] Add git-grep threads param
Date: Mon, 26 Oct 2015 15:32:13 +0300
Message-ID: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
Cc: Victor Leschuk <vleschuk@accesssoftek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 13:32:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqgwz-000597-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 13:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbbJZMc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 08:32:27 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33188 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbbJZMcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 08:32:25 -0400
Received: by lffv3 with SMTP id v3so146009825lff.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zFz4iOafiia0E0yFJTZ66C4lP9U0GjyI0NYwYyCwbCk=;
        b=clAKGd9SCLBaudAXuo5FIi6B4NH8mUtASdx+p4vpfsJHVq3BQyfPH3GATz3hnRckSZ
         ahnCk33lqOfYmnX7ezYeE1fCul8NbFtAjshrEcFe/SZY4xWl+QD3RVRuXEsv4VtEOx54
         lxtvIrOEvbXPBobxjsSfxiJmfjtfnxTgfxwIIdHTdauQmRaK3KSy52cV66bcX2hOpC20
         qOeiB85vCMPUblbIPCGGheRaGN9apHGU0FoXC12nzZTcloU1jAIRA+iPNAwnNyTHvVKe
         YFMUDUWQwmjnTCGoOjlC/3z/QY0Thxe5c0ffhs7RMTR/3ggv66luTyvRgtALgb75KLC2
         ZYLw==
X-Received: by 10.112.136.39 with SMTP id px7mr17021615lbb.77.1445862743769;
        Mon, 26 Oct 2015 05:32:23 -0700 (PDT)
Received: from del-debian (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id zk5sm5864109lbb.18.2015.10.26.05.32.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 05:32:22 -0700 (PDT)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1Zqgwn-0000ED-V2; Mon, 26 Oct 2015 15:32:22 +0300
X-Mailer: git-send-email 2.6.2.281.g222e106.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280188>

Make number of git-grep worker threads a configuration parameter.
According to several tests on systems with different number of CPU cores
the hard-coded number of 8 threads is not optimal for all systems:
tuning this parameter can significantly speed up grep performance.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 Documentation/config.txt               |  4 ++++
 Documentation/git-grep.txt             |  4 ++++
 builtin/grep.c                         | 34 ++++++++++++++++++++++++++--------
 contrib/completion/git-completion.bash |  1 +
 grep.c                                 | 10 ++++++++++
 grep.h                                 |  2 ++
 6 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..1c95587 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1447,6 +1447,10 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.threads::
+	Number of grep worker threads, use it to tune up performance on
+	multicore machines. Default value is 8.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..fbd4f83 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
+	   [--threads <num>]
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -220,6 +221,9 @@ OPTIONS
 	Show <num> leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
+--threads <num>::
+	Set number of worker threads to <num>. Default is 8.
+
 -W::
 --function-context::
 	Show the surrounding text from the previous line containing a
diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..5ef1b07 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -27,8 +27,7 @@ static char const * const grep_usage[] = {
 static int use_threads = 1;
 
 #ifndef NO_PTHREADS
-#define THREADS 8
-static pthread_t threads[THREADS];
+static pthread_t *threads;
 
 /* We use one producer thread and THREADS consumer
  * threads. The producer adds struct work_items to 'todo' and the
@@ -206,7 +205,8 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	threads = xcalloc(opt->num_threads, sizeof(pthread_t));
+	for (i = 0; i < opt->num_threads; i++) {
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
@@ -220,7 +220,7 @@ static void start_threads(struct grep_opt *opt)
 	}
 }
 
-static int wait_all(void)
+static int wait_all(struct grep_opt *opt)
 {
 	int hit = 0;
 	int i;
@@ -238,12 +238,14 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	for (i = 0; i < opt->num_threads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |= (int) (intptr_t) h;
 	}
 
+	free(threads);
+
 	pthread_mutex_destroy(&grep_mutex);
 	pthread_mutex_destroy(&grep_read_mutex);
 	pthread_mutex_destroy(&grep_attr_mutex);
@@ -256,7 +258,7 @@ static int wait_all(void)
 }
 #else /* !NO_PTHREADS */
 
-static int wait_all(void)
+static int wait_all(struct grep_opt *opt)
 {
 	return 0;
 }
@@ -702,6 +704,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
+		OPT_INTEGER(0, "threads", &opt.num_threads,
+			N_("use <n> worker threads")),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -832,8 +836,22 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
+	if (!opt.num_threads) {
+		use_threads = 0; /* User explicitely told not to use threads */
+	}
+	else if (list.nr || cached) {
+		use_threads = 0; /* Can not multi-thread object lookup */
+	}
+	else if (opt.num_threads >= 0) {
+		use_threads = 1; /* User explicitely set the number of threads */
+	}
+	else if (online_cpus() <= 1) {
 		use_threads = 0;
+	}
+	else {
+		use_threads = 1;
+		opt.num_threads = GREP_NUM_THREADS_DEFAULT;
+	}
 #else
 	use_threads = 0;
 #endif
@@ -910,7 +928,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_threads)
-		hit |= wait_all();
+		hit |= wait_all(&opt);
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
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
diff --git a/grep.c b/grep.c
index 7b2b96a..b53fb14 100644
--- a/grep.c
+++ b/grep.c
@@ -40,6 +40,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_selected, "");
 	color_set(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color = -1;
+	opt->num_threads = -1;
 }
 
 static int parse_pattern_type_arg(const char *opt, const char *arg)
@@ -124,6 +125,14 @@ int grep_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, color);
 	}
+
+	if (!strcmp(var, "grep.threads")) {
+		int threads = git_config_int(var, value);
+		if (threads < 0)
+			die("invalid number of threads specified (%d)", threads);
+		opt->num_threads = threads;
+		return 0;
+	}
 	return 0;
 }
 
@@ -150,6 +159,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pathname = def->pathname;
 	opt->regflags = def->regflags;
 	opt->relative = def->relative;
+	opt->num_threads = def->num_threads;
 
 	color_set(opt->color_context, def->color_context);
 	color_set(opt->color_filename, def->color_filename);
diff --git a/grep.h b/grep.h
index 95f197a..bb20456 100644
--- a/grep.h
+++ b/grep.h
@@ -132,6 +132,8 @@ struct grep_opt {
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
+#define GREP_NUM_THREADS_DEFAULT 8
+	int num_threads;
 	int show_hunk_mark;
 	int file_break;
 	int heading;
-- 
2.6.2.281.g222e106.dirty
