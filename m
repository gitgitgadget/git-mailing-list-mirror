From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Tue, 06 Dec 2011 23:48:26 +0100
Message-ID: <4EDE9BBA.2010409@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 23:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3og-0006oX-EP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab1LFWso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 17:48:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:35225 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380Ab1LFWso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:48:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RY3oX-0006lP-Sd
	for git@vger.kernel.org; Tue, 06 Dec 2011 23:48:41 +0100
Received: from p4ffd9bf7.dip.t-dialin.net ([79.253.155.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 23:48:41 +0100
Received: from rene.scharfe by p4ffd9bf7.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 23:48:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ffd9bf7.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ED8F9AE.8030605@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186400>

Am 02.12.2011 17:15, schrieb Ren=E9 Scharfe:
> How about adding a parameter to control the number of threads=20
> (--threads?) instead that defaults to eight (or five) for the worktre=
e=20
> and one for the rest? That would also make benchmarking easier.

Like this:

-- >8 --
Subject: grep: add parameter --threads

Allow the number of threads to be specified by the user.  This makes
benchmarking the performance impact of different numbers of threads
much easier.

Move the code for thread handling after argument parsing.  This allows
to change the default number of threads based on the kind of search
(worktree etc.) later on.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Applies on top of your second patch.

 Documentation/git-grep.txt |    4 ++
 builtin/grep.c             |   75 +++++++++++++++++++++++-------------=
-------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 15d6711..47ac188 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -227,6 +227,10 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
=20
+--threads <n>::
+	Run <n> search threads in parallel.  Default is 8.  This option
+	is ignored if git was built without support for POSIX threads.
+
 <tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
diff --git a/builtin/grep.c b/builtin/grep.c
index 65b1ffe..0bda900 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,11 +24,10 @@ static char const * const grep_usage[] =3D {
 	NULL
 };
=20
-static int use_threads =3D 1;
-
 #ifndef NO_PTHREADS
 #define THREADS 8
-static pthread_t threads[THREADS];
+static pthread_t *threads;
+static int nr_threads =3D -1;
=20
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name);
@@ -76,13 +75,13 @@ static pthread_mutex_t grep_mutex;
=20
 static inline void grep_lock(void)
 {
-	if (use_threads)
+	if (nr_threads > 0)
 		pthread_mutex_lock(&grep_mutex);
 }
=20
 static inline void grep_unlock(void)
 {
-	if (use_threads)
+	if (nr_threads > 0)
 		pthread_mutex_unlock(&grep_mutex);
 }
=20
@@ -91,13 +90,13 @@ static pthread_mutex_t read_sha1_mutex;
=20
 static inline void read_sha1_lock(void)
 {
-	if (use_threads)
+	if (nr_threads > 0)
 		pthread_mutex_lock(&read_sha1_mutex);
 }
=20
 static inline void read_sha1_unlock(void)
 {
-	if (use_threads)
+	if (nr_threads > 0)
 		pthread_mutex_unlock(&read_sha1_mutex);
 }
=20
@@ -254,6 +253,8 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
=20
+	threads =3D xcalloc(nr_threads, sizeof(pthread_t));
+
 	pthread_mutex_init(&grep_mutex, NULL);
 	pthread_mutex_init(&read_sha1_mutex, NULL);
 	pthread_mutex_init(&grep_attr_mutex, NULL);
@@ -265,7 +266,7 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
+	for (i =3D 0; i < nr_threads; i++) {
 		int err;
 		struct grep_opt *o =3D grep_opt_dup(opt);
 		o->output =3D strbuf_out;
@@ -296,7 +297,7 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
=20
-	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
+	for (i =3D 0; i < nr_threads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |=3D (int) (intptr_t) h;
@@ -309,6 +310,8 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
=20
+	free(threads);
+
 	return hit;
 }
 #else /* !NO_PTHREADS */
@@ -410,7 +413,7 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
 	name =3D strbuf_detach(&pathbuf, NULL);
=20
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (nr_threads > 0) {
 		grep_sha1_async(opt, name, sha1);
 		return 0;
 	} else
@@ -472,7 +475,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
 	name =3D strbuf_detach(&buf, NULL);
=20
 #ifndef NO_PTHREADS
-	if (use_threads) {
+	if (nr_threads > 0) {
 		grep_file_async(opt, name, filename);
 		return 0;
 	} else
@@ -895,6 +898,13 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
+#ifdef NO_PTHREADS
+		OPT_INTEGER(0, "threads", &nr_threads,
+			"handle <n> files in parallel (ignored by this build)"),
+#else
+		OPT_INTEGER(0, "threads", &nr_threads,
+			"handle <n> files in parallel"),
+#endif
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
@@ -995,7 +1005,7 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		opt.output_priv =3D &path_list;
 		opt.output =3D append_path;
 		string_list_append(&path_list, show_in_pager);
-		use_threads =3D 0;
+		nr_threads =3D 0;
 	}
=20
 	if (!opt.pattern_list)
@@ -1003,28 +1013,6 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
=20
-#ifndef NO_PTHREADS
-	if (online_cpus() =3D=3D 1)
-		use_threads =3D 0;
-#else
-	use_threads =3D 0;
-#endif
-
-	opt.use_threads =3D use_threads;
-
-#ifndef NO_PTHREADS
-	if (use_threads) {
-		if (opt.pre_context || opt.post_context || opt.file_break ||
-		    opt.funcbody)
-			skip_first_line =3D 1;
-		start_threads(&opt);
-	}
-#else
-	use_threads =3D 0;
-#endif
-
-	compile_grep_patterns(&opt);
-
 	/* Check revs and then paths */
 	for (i =3D 0; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -1056,6 +1044,23 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
+#ifdef NO_PTHREADS
+	nr_threads =3D 0;
+#else
+	if (nr_threads =3D=3D -1)
+		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
+
+	if (nr_threads > 0) {
+		opt.use_threads =3D 1;
+		if (opt.pre_context || opt.post_context || opt.file_break ||
+		    opt.funcbody)
+			skip_first_line =3D 1;
+		start_threads(&opt);
+	}
+#endif
+
+	compile_grep_patterns(&opt);
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
=20
@@ -1100,7 +1105,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		hit =3D grep_objects(&opt, &pathspec, &list);
 	}
=20
-	if (use_threads)
+	if (nr_threads > 0)
 		hit |=3D wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
--=20
1.7.8
