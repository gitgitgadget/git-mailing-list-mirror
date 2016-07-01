Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A19F1FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 05:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcGAF7F (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 01:59:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:38727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbcGAF7C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 01:59:02 -0400
Received: (qmail 23846 invoked by uid 102); 1 Jul 2016 05:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 01:59:03 -0400
Received: (qmail 13562 invoked by uid 107); 1 Jul 2016 05:59:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 01:59:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 01:58:58 -0400
Date:	Fri, 1 Jul 2016 01:58:58 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 1/5] add an extra level of indirection to main()
Message-ID: <20160701055858.GA4593@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are certain startup tasks that we expect every git
process to do. In some cases this is just to improve the
quality of the program (e.g., setting up gettext()). In
others it is a requirement for using certain functions in
libgit.a (e.g., system_path() expects that you have called
git_extract_argv0_path()).

Most commands are builtins and are covered by the git.c
version of main(). However, there are still a few external
commands that use their own main(). Each of these has to
remember to include the correct startup sequence, and we are
not always consistent.

Rather than just fix the inconsistencies, let's make this
harder to get wrong by providing a common main() that can
run this standard startup.

We basically have two options to do this:

 - the compat/mingw.h file already does something like this by
   adding a #define that replaces the definition of main with a
   wrapper that calls mingw_startup().

   The upside is that the code in each program doesn't need
   to be changed at all; it's rewritten on the fly by the
   preprocessor.

   The downside is that it may make debugging of the startup
   sequence a bit more confusing, as the preprocessor is
   quietly inserting new code.

 - the builtin functions are all of the form cmd_foo(),
   and git.c's main() calls them.

   This is much more explicit, which may make things more
   obvious to somebody reading the code. It's also more
   flexible (because of course we have to figure out _which_
   cmd_foo() to call).

   The downside is that each of the builtins must define
   cmd_foo(), instead of just main().

This patch chooses the latter option, preferring the more
explicit approach, even though it is more invasive. We
introduce a new file common-main.c, with the "real" main. It
expects to call cmd_main() from whatever other objects it is
linked against.

We link common-main.o against anything that links against
libgit.a, since we know that such programs will need to do
this setup. Note that common-main.o can't actually go inside
libgit.a, as the linker would not pick up its main()
function automatically (it has no callers).

The rest of the patch is just adjusting all of the various
external programs (mostly in t/helper) to use cmd_main().
I've provided a global declaration for cmd_main(), which
means that all of the programs also need to match its
signature. In particular, many functions need to switch to
"const char **" instead of "char **" for argv. This effect
ripples out to a few other variables and functions, as well.

This makes the patch even more invasive, but the end result
is much better. We should be treating argv strings as const
anyway, and now all programs conform to the same signature
(which also matches the way builtins are defined).

Signed-off-by: Jeff King <peff@peff.net>
---
I waffled between the two mechanisms. Opinions welcome.

 Makefile                               | 17 +++++++++++++----
 common-main.c                          | 12 ++++++++++++
 credential-cache--daemon.c             |  2 +-
 credential-cache.c                     |  2 +-
 credential-store.c                     |  2 +-
 daemon.c                               |  8 ++++----
 fast-import.c                          |  4 ++--
 git-compat-util.h                      |  2 ++
 git.c                                  |  3 +--
 http-backend.c                         |  2 +-
 http-fetch.c                           |  2 +-
 http-push.c                            |  6 +++---
 imap-send.c                            |  2 +-
 remote-curl.c                          |  2 +-
 remote-testsvn.c                       |  2 +-
 sh-i18n--envsubst.c                    |  2 +-
 shell.c                                |  2 +-
 show-index.c                           |  2 +-
 t/helper/test-chmtime.c                |  2 +-
 t/helper/test-config.c                 |  2 +-
 t/helper/test-ctype.c                  |  2 +-
 t/helper/test-date.c                   |  8 ++++----
 t/helper/test-delta.c                  |  2 +-
 t/helper/test-dump-cache-tree.c        |  2 +-
 t/helper/test-dump-split-index.c       |  2 +-
 t/helper/test-dump-untracked-cache.c   |  2 +-
 t/helper/test-fake-ssh.c               |  2 +-
 t/helper/test-genrandom.c              |  2 +-
 t/helper/test-hashmap.c                |  2 +-
 t/helper/test-index-version.c          |  2 +-
 t/helper/test-line-buffer.c            |  2 +-
 t/helper/test-match-trees.c            |  2 +-
 t/helper/test-mergesort.c              |  2 +-
 t/helper/test-mktemp.c                 |  2 +-
 t/helper/test-parse-options.c          |  2 +-
 t/helper/test-path-utils.c             |  4 ++--
 t/helper/test-prio-queue.c             |  2 +-
 t/helper/test-read-cache.c             |  2 +-
 t/helper/test-regex.c                  |  2 +-
 t/helper/test-revision-walking.c       |  2 +-
 t/helper/test-run-command.c            |  2 +-
 t/helper/test-scrap-cache-tree.c       |  2 +-
 t/helper/test-sha1-array.c             |  2 +-
 t/helper/test-sha1.c                   |  2 +-
 t/helper/test-sigchain.c               |  2 +-
 t/helper/test-string-list.c            |  2 +-
 t/helper/test-submodule-config.c       |  6 +++---
 t/helper/test-subprocess.c             |  2 +-
 t/helper/test-svn-fe.c                 |  4 ++--
 t/helper/test-urlmatch-normalization.c |  2 +-
 t/helper/test-wildmatch.c              |  2 +-
 upload-pack.c                          |  2 +-
 52 files changed, 89 insertions(+), 67 deletions(-)
 create mode 100644 common-main.c

diff --git a/Makefile b/Makefile
index de5a030..717dc34 100644
--- a/Makefile
+++ b/Makefile
@@ -939,7 +939,7 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
-GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -1572,7 +1572,15 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
-LIBS = $(GITLIBS) $(EXTLIBS)
+# We must filter out any object files from $(GITLIBS),
+# as it is typically used like:
+#
+#   foo: foo.o $(GITLIBS)
+#	$(CC) $(filter %.o,$^) $(LIBS)
+#
+# where we use it as a dependency. Since we also pull object files
+# from the dependency list, that would make each entry appear twice.
+LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	$(COMPAT_CFLAGS)
@@ -1708,8 +1716,8 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) git.o \
-		$(BUILTIN_OBJS) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: common-cmds.h
 
@@ -1902,6 +1910,7 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
+	common-main.o \
 	git.o
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
diff --git a/common-main.c b/common-main.c
new file mode 100644
index 0000000..2b96bbf
--- /dev/null
+++ b/common-main.c
@@ -0,0 +1,12 @@
+#include "git-compat-util.h"
+
+int main(int argc, char **av)
+{
+	/*
+	 * This const trickery is explained in
+	 * 84d32bf7678259c08406571cd6ce4b7a6724dcba
+	 */
+	const char **argv = (const char **)av;
+
+	return cmd_main(argc, argv);
+}
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 1f14d56..1e5f16a 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -257,7 +257,7 @@ static void init_socket_directory(const char *path)
 	free(path_copy);
 }
 
-int main(int argc, const char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char *socket_path;
 	int ignore_sighup = 0;
diff --git a/credential-cache.c b/credential-cache.c
index 86e21de..cc8a6ee 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,7 +83,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
-int main(int argc, const char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	char *socket_path = NULL;
 	int timeout = 900;
diff --git a/credential-store.c b/credential-store.c
index 5714167..55ca1b1 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -142,7 +142,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 			return; /* Found credential */
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char * const usage[] = {
 		"git credential-store [<options>] <action>",
diff --git a/daemon.c b/daemon.c
index 46dddac..4326cd0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -32,7 +32,7 @@ static const char daemon_usage[] =
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
-static char **ok_paths;
+static const char **ok_paths;
 static int strict_paths;
 
 /* If this is set, git-daemon-export-ok is not required */
@@ -240,7 +240,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	}
 
 	if ( ok_paths && *ok_paths ) {
-		char **pp;
+		const char **pp;
 		int pathlen = strlen(path);
 
 		/* The validation is done on the paths after enter_repo
@@ -1192,7 +1192,7 @@ static int serve(struct string_list *listen_addr, int listen_port,
 	return service_loop(&socklist);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
@@ -1207,7 +1207,7 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 		const char *v;
 
 		if (skip_prefix(arg, "--listen=", &v)) {
diff --git a/fast-import.c b/fast-import.c
index 59630ce..7cb7434 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -302,7 +302,7 @@ static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
 static int global_argc;
-static char **global_argv;
+static const char **global_argv;
 
 /* Memory pools */
 static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
@@ -3445,7 +3445,7 @@ static void parse_argv(void)
 		read_marks();
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	unsigned int i;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 49d4029..1930444 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1045,3 +1045,5 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #endif
 
 #endif
+
+extern int cmd_main(int, const char **);
diff --git a/git.c b/git.c
index 968a8a4..e244404 100644
--- a/git.c
+++ b/git.c
@@ -630,9 +630,8 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
-int main(int argc, char **av)
+int cmd_main(int argc, const char **argv)
 {
-	const char **argv = (const char **) av;
 	const char *cmd;
 	int done_help = 0;
 
diff --git a/http-backend.c b/http-backend.c
index 2148814..411c835 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -632,7 +632,7 @@ static struct service_cmd {
 	{"POST", "/git-receive-pack$", service_rpc}
 };
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	char *method = getenv("REQUEST_METHOD");
 	char *dir;
diff --git a/http-fetch.c b/http-fetch.c
index ba3ea10..eb559eb 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,7 +6,7 @@
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
 
-int main(int argc, const char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct walker *walker;
 	int commits_on_stdin = 0;
diff --git a/http-push.c b/http-push.c
index a092f02..df20e44 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1692,12 +1692,12 @@ static void run_request_queue(void)
 #endif
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct transfer_request *request;
 	struct transfer_request *next_request;
 	int nr_refspec = 0;
-	char **refspec = NULL;
+	const char **refspec = NULL;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
@@ -1717,7 +1717,7 @@ int main(int argc, char **argv)
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
-		char *arg = *argv;
+		const char *arg = *argv;
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--all")) {
diff --git a/imap-send.c b/imap-send.c
index 938c691..890e1cb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1494,7 +1494,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 }
 #endif
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
 	int total;
diff --git a/remote-curl.c b/remote-curl.c
index 672b382..a068340 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -984,7 +984,7 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
-int main(int argc, const char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f05ff45..32631eb 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -284,7 +284,7 @@ static int do_command(struct strbuf *line)
 	return 0;
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
 			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 2842a22..e06b2c1 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -64,7 +64,7 @@ static void note_variables (const char *string);
 static void subst_from_stdin (void);
 
 int
-main (int argc, char *argv[])
+cmd_main (int argc, const char *argv[])
 {
   /* Default values for command line options.  */
   /* unsigned short int show_variables = 0; */
diff --git a/shell.c b/shell.c
index c5439a6..3dd7fdc 100644
--- a/shell.c
+++ b/shell.c
@@ -138,7 +138,7 @@ static struct commands {
 	{ NULL },
 };
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	char *prog;
 	const char **user_argv;
diff --git a/show-index.c b/show-index.c
index acf8d54..575f9c5 100644
--- a/show-index.c
+++ b/show-index.c
@@ -4,7 +4,7 @@
 static const char show_index_usage[] =
 "git show-index";
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	int i;
 	unsigned nr;
diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index dfe8a83..e760256 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -56,7 +56,7 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 	return 1;
 }
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	static int verbose;
 
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 6a77552..d143cd7 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -33,7 +33,7 @@
  */
 
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	int i, val;
 	const char *v;
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 707a821..bb72c47 100644
--- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -28,7 +28,7 @@ static int is_in(const char *s, int ch)
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	TEST_CLASS(isdigit, DIGIT);
 	TEST_CLASS(isspace, " \n\r\t");
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 63f3735..0f3cfb1 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -5,7 +5,7 @@ static const char *usage_msg = "\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n";
 
-static void show_dates(char **argv, struct timeval *now)
+static void show_dates(const char **argv, struct timeval *now)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -17,7 +17,7 @@ static void show_dates(char **argv, struct timeval *now)
 	strbuf_release(&buf);
 }
 
-static void parse_dates(char **argv, struct timeval *now)
+static void parse_dates(const char **argv, struct timeval *now)
 {
 	struct strbuf result = STRBUF_INIT;
 
@@ -36,7 +36,7 @@ static void parse_dates(char **argv, struct timeval *now)
 	strbuf_release(&result);
 }
 
-static void parse_approxidate(char **argv, struct timeval *now)
+static void parse_approxidate(const char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
 		time_t t;
@@ -45,7 +45,7 @@ static void parse_approxidate(char **argv, struct timeval *now)
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct timeval now;
 	const char *x;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 4595cd6..59937dc 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -15,7 +15,7 @@
 static const char usage_str[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	int fd;
 	struct stat st;
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index bb53c0a..44f3290 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -54,7 +54,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	return errs;
 }
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 861d28c..d168924 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -7,7 +7,7 @@ static void show_bit(size_t pos, void *data)
 	printf(" %d", (int)pos);
 }
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	struct split_index *si;
 	int i;
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 0a1c285..50112cc 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -40,7 +40,7 @@ static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 	strbuf_setlen(base, len);
 }
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 980de21..12beee9 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -2,7 +2,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char *trash_directory = getenv("TRASH_DIRECTORY");
 	struct strbuf buf = STRBUF_INIT;
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 54824d0..8d11d22 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -6,7 +6,7 @@
 
 #include "git-compat-util.h"
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	unsigned long count, next = 0;
 	unsigned char *c;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index cc2891d..7aa9440 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -138,7 +138,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	char line[1024];
 	struct hashmap map;
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index 05d4699..f569f6b 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/t/helper/test-line-buffer.c b/t/helper/test-line-buffer.c
index 1e58f04..81575fe 100644
--- a/t/helper/test-line-buffer.c
+++ b/t/helper/test-line-buffer.c
@@ -50,7 +50,7 @@ static void handle_line(const char *line, struct line_buffer *stdin_buf)
 	handle_command(line, arg + 1, stdin_buf);
 }
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	struct line_buffer stdin_buf = LINE_BUFFER_INIT;
 	struct line_buffer file_buf = LINE_BUFFER_INIT;
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index d446b8e..e939502 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "tree.h"
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index ea3b959..335cf6b 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -22,7 +22,7 @@ static int compare_strings(const void *a, const void *b)
 	return strcmp(x->text, y->text);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct line *line, *p = NULL, *lines = NULL;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index c8c5421..89d9b2f 100644
--- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -3,7 +3,7 @@
  */
 #include "git-compat-util.h"
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	if (argc != 2)
 		usage("Expected 1 parameter defining the temporary file template");
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 8a1235d..d51d292 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -94,7 +94,7 @@ static void show(struct string_list *expect, int *status, const char *fmt, ...)
 	strbuf_release(&buf);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char *prefix = "prefix/";
 	const char *usage[] = {
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index ba805b3..1ebe0f7 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -156,7 +156,7 @@ static struct test_data dirname_data[] = {
 	{ NULL,              NULL     }
 };
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmallocz(strlen(argv[2]));
@@ -213,7 +213,7 @@ int main(int argc, char **argv)
 	}
 
 	if (argc >= 4 && !strcmp(argv[1], "prefix_path")) {
-		char *prefix = argv[2];
+		const char *prefix = argv[2];
 		int prefix_len = strlen(prefix);
 		int nongit_ok;
 		setup_git_directory_gently(&nongit_ok);
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 7be72f0..ae58fff 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -16,7 +16,7 @@ static void show(int *v)
 	free(v);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct prio_queue pq = { intcmp };
 
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b25bcf1..2a7990e 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main (int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	int i, cnt = 1;
 	if (argc == 2)
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 0dc598e..37b7f06 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	char *pat = "[^={} \t]+";
 	char *str = "={}\nfred";
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 3d03133..b8e6fe1 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -45,7 +45,7 @@ static int run_revision_walk(void)
 	return got_revision;
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	if (argc < 2)
 		return 1;
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 30a64a9..c71ea4f 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -49,7 +49,7 @@ static int task_finished(int result,
 	return 1;
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 6efee31..5b2fd09 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -5,7 +5,7 @@
 
 static struct lock_file index_lock;
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	hold_locked_index(&index_lock, 1);
 	if (read_cache() < 0)
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index 60ea1d5..09f7790 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -6,7 +6,7 @@ static void print_sha1(const unsigned char sha1[20], void *data)
 	puts(sha1_to_hex(sha1));
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index e57eae1..a1c13f5 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main(int ac, char **av)
+int cmd_main(int ac, const char **av)
 {
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index e499fce..b71edbd 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -13,7 +13,7 @@ X(two)
 X(three)
 #undef X
 
-int main(int argc, char **argv) {
+int cmd_main(int argc, const char **argv) {
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
 	sigchain_push(SIGTERM, three);
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 14bdf9d..4a68967 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -41,7 +41,7 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 	return starts_with(item->string, prefix);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	if (argc == 5 && !strcmp(argv[1], "split")) {
 		struct string_list list = STRING_LIST_INIT_DUP;
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index dab8c27..2cffded 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -2,7 +2,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 
-static void die_usage(int argc, char **argv, const char *msg)
+static void die_usage(int argc, const char **argv, const char *msg)
 {
 	fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "Usage: %s [<commit> <submodulepath>] ...\n", argv[0]);
@@ -14,9 +14,9 @@ static int git_test_config(const char *var, const char *value, void *cb)
 	return parse_submodule_config_option(var, value);
 }
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
-	char **arg = argv;
+	const char **arg = argv;
 	int my_argc = argc;
 	int output_url = 0;
 	int lookup_name = 0;
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 56881a0..30c5765 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int nogit = 0;
diff --git a/t/helper/test-svn-fe.c b/t/helper/test-svn-fe.c
index 120ec96..7667c08 100644
--- a/t/helper/test-svn-fe.c
+++ b/t/helper/test-svn-fe.c
@@ -11,7 +11,7 @@
 static const char test_svnfe_usage[] =
 	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
 
-static int apply_delta(int argc, char *argv[])
+static int apply_delta(int argc, const char **argv)
 {
 	struct line_buffer preimage = LINE_BUFFER_INIT;
 	struct line_buffer delta = LINE_BUFFER_INIT;
@@ -35,7 +35,7 @@ static int apply_delta(int argc, char *argv[])
 	return 0;
 }
 
-int main(int argc, char *argv[])
+int cmd_main(int argc, const char **argv)
 {
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
diff --git a/t/helper/test-urlmatch-normalization.c b/t/helper/test-urlmatch-normalization.c
index 090bf21..49b6e83 100644
--- a/t/helper/test-urlmatch-normalization.c
+++ b/t/helper/test-urlmatch-normalization.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "urlmatch.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char usage[] = "test-urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
 	char *url1, *url2;
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 578b164..52be876 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main(int argc, char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	int i;
 	for (i = 2; i < argc; i++) {
diff --git a/upload-pack.c b/upload-pack.c
index 9e03c27..80dda75 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -820,7 +820,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int main(int argc, const char **argv)
+int cmd_main(int argc, const char **argv)
 {
 	const char *dir;
 	int strict = 0;
-- 
2.9.0.317.g65b4e7c

