From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH] Add git-grep threads-num param
Date: Thu, 22 Oct 2015 16:23:56 +0300
Message-ID: <1445520236-10753-1-git-send-email-vleschuk@accesssoftek.com>
Cc: Victor Leschuk <vleschuk@accesssoftek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 15:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFqx-0005RG-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 15:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbbJVNYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 09:24:19 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35367 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943AbbJVNYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 09:24:17 -0400
Received: by lfbn126 with SMTP id n126so13391939lfb.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dm+/LpI7xn3YWB7qbVxl33NFe/GLUX4jf9PMeenrrd0=;
        b=bpJiLhuMAEYhxMmL+0uAHMqCZbt006wlh7zZs7nDxbadu89hGSFIoMON1qTXeCj945
         vlSLFM9HcTUx0OJ+KGMEsAkS35S3wmuAMKWw8PMoOG3DwIoOhB9bwWCiK1FkhTLaDBfj
         Su8gfOlZZfyK4b+CHog8FrhFWnQD0gIggc6iaVyhTn7wwyYKp6HL+SnzA+P36HUmBFPC
         aOio1OHp84aIFTXNs+ZLgGyTpwOggvOQfbb3Yy5y839dhBQE2O73uSx6K0i5WZnjd7V8
         KysMeNZxSl4/+mxUr1YhAsI4F/hEQD9X/bgtDN+k7YU7K7joG9bvrobS3cV25GrApTq1
         qjBw==
X-Received: by 10.112.16.67 with SMTP id e3mr8292159lbd.5.1445520255552;
        Thu, 22 Oct 2015 06:24:15 -0700 (PDT)
Received: from del-debian (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id v4sm2345610lbo.30.2015.10.22.06.24.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2015 06:24:14 -0700 (PDT)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1ZpFqo-0002oA-4z; Thu, 22 Oct 2015 16:24:14 +0300
X-Mailer: git-send-email 2.6.2.281.gd4b1c9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280053>

Hello all, I suggest we make number of git-grep worker threads a configuration
parameter. I have run several tests on systems with different number of CPU cores.
It appeared that the hard-coded number 8 lowers performance on both of my systems:
on my 4-core and 8-core systems the thread number of 4 worked about 20% faster than
default 8. So I think it is better to allow users tune this parameter.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 Documentation/config.txt               |  4 ++++
 Documentation/git-grep.txt             |  5 +++++
 builtin/grep.c                         | 20 +++++++++++++-------
 contrib/completion/git-completion.bash |  1 +
 grep.c                                 | 15 +++++++++++++++
 grep.h                                 |  4 ++++
 6 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..c3df20c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1447,6 +1447,10 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.threadsNum::
+	Number of grep worker threads, use it to tune up performance on
+	multicore machines. Default value is 8.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..e9ca265 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
+	   [-t <threads-num>]
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -220,6 +221,10 @@ OPTIONS
 	Show <num> leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
+-t <num>::
+--threads-num <num>::
+	Set number of worker threads to <num>. Default is 8.
+
 -W::
 --function-context::
 	Show the surrounding text from the previous line containing a
diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..9b4fc47 100644
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
+	threads = xmalloc(sizeof(pthread_t) * opt->num_threads);
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
@@ -702,6 +704,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
+#ifndef NO_PTHREADS
+		OPT_INTEGER('t', "threads-num", &opt.num_threads,
+			N_("use <n> worker threads")),
+#endif /* !NO_PTHREADS */
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -910,7 +916,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_threads)
-		hit |= wait_all();
+		hit |= wait_all(&opt);
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84..6231595 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1310,6 +1310,7 @@ _git_grep ()
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
 			--perl-regexp
+			--threads-num
 			--files-with-matches --name-only
 			--files-without-match
 			--max-depth
diff --git a/grep.c b/grep.c
index 7b2b96a..17e6a7c 100644
--- a/grep.c
+++ b/grep.c
@@ -40,6 +40,9 @@ void init_grep_defaults(void)
 	color_set(opt->color_selected, "");
 	color_set(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color = -1;
+#ifndef NO_PTHREADS
+	opt->num_threads = GREP_NUM_THREADS_DEFAULT;
+#endif /* !NO_PTHREADS */
 }
 
 static int parse_pattern_type_arg(const char *opt, const char *arg)
@@ -124,6 +127,14 @@ int grep_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, color);
 	}
+
+#ifndef NO_PTHREADS
+	if (!strcmp(var, "grep.threadsnum")) {
+		int threads = git_config_int(var, value);
+		opt->num_threads = (threads >= 0) ? threads : GREP_NUM_THREADS_DEFAULT;
+		return 0;
+	}
+#endif /* !NO_PTHREADS */
 	return 0;
 }
 
@@ -150,6 +161,10 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pathname = def->pathname;
 	opt->regflags = def->regflags;
 	opt->relative = def->relative;
+#ifndef NO_PTHREADS
+	if(!opt->num_threads)
+		opt->num_threads = def->num_threads;
+#endif /* !NO_PTHREADS */
 
 	color_set(opt->color_context, def->color_context);
 	color_set(opt->color_filename, def->color_filename);
diff --git a/grep.h b/grep.h
index 95f197a..e4a296b 100644
--- a/grep.h
+++ b/grep.h
@@ -132,6 +132,10 @@ struct grep_opt {
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
+#ifndef NO_PTHREADS
+#define GREP_NUM_THREADS_DEFAULT 8
+	unsigned num_threads;
+#endif /* !NO_PTHREADS */
 	int show_hunk_mark;
 	int file_break;
 	int heading;
-- 
2.6.2.281.gd4b1c9f
