From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Sat, 27 Apr 2013 20:19:47 +0100
Message-ID: <517C24D3.8080802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5h-0000k4-Ve
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab3D0TrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:22 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33161 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756460Ab3D0TrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:20 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id EF3A4384081;
	Sat, 27 Apr 2013 20:47:19 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 97BBB38407C;
	Sat, 27 Apr 2013 20:47:18 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:17 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222675>


Sparse issues 68 errors (two errors for each main() function) such
as the following:

      SP git.c
  git.c:510:5: error: too many arguments for function mingw_main
  git.c:510:5: error: symbol 'mingw_main' redeclared with different type \
    (originally declared at git.c:510) - different argument counts

The errors are caused by the 'main' macro used by the MinGW build
to provide a replacement main() function. The original main function
is effectively renamed to 'mingw_main' and is called from the new
main function. The replacement main is used to execute certain actions
common to all git programs on MinGW (e.g. ensure the standard I/O
streams are in binary mode).

In order to suppress the errors, we change the macro to include the
parameters in the declaration of the mingw_main function.

Unfortunately, this change provokes both sparse and gcc to complain
about 9 calls to mingw_main(), such as the following:

      CC git.o
  git.c: In function 'main':
  git.c:510: warning: passing argument 2 of 'mingw_main' from \
    incompatible pointer type
  git.c:510: note: expected 'const char **' but argument is of \
    type 'char **'

In order to suppress these warnings, since both of the main
functions need to be declared with the same prototype, we
change the declaration of the 9 main functions, thus:

    int main(int argc, char **argv)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mingw.h       | 4 ++--
 credential-store.c   | 4 ++--
 fast-import.c        | 4 ++--
 git.c                | 3 ++-
 remote-testsvn.c     | 2 +-
 test-chmtime.c       | 2 +-
 test-index-version.c | 2 +-
 test-mergesort.c     | 2 +-
 test-parse-options.c | 4 ++--
 test-subprocess.c    | 4 ++--
 10 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 3036980..bd0a88b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -346,8 +346,8 @@ extern CRITICAL_SECTION pinfo_cs;
  */
 
 #define main(c,v) dummy_decl_mingw_main(); \
-static int mingw_main(); \
-int main(int argc, const char **argv) \
+static int mingw_main(c,v); \
+int main(int argc, char **argv) \
 { \
 	extern CRITICAL_SECTION pinfo_cs; \
 	_fmode = _O_BINARY; \
diff --git a/credential-store.c b/credential-store.c
index 26f7589..f9146e5 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -114,7 +114,7 @@ static int lookup_credential(const char *fn, struct credential *c)
 	return c->username && c->password;
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	const char * const usage[] = {
 		"git credential-store [options] <action>",
@@ -131,7 +131,7 @@ int main(int argc, const char **argv)
 
 	umask(077);
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	argc = parse_options(argc, (const char **)argv, NULL, options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, options);
 	op = argv[0];
diff --git a/fast-import.c b/fast-import.c
index 5f539d7..6d94453 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -297,7 +297,7 @@ static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
 static int global_argc;
-static const char **global_argv;
+static char **global_argv;
 
 /* Memory pools */
 static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
@@ -3347,7 +3347,7 @@ static void parse_argv(void)
 		read_marks();
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	unsigned int i;
 
diff --git a/git.c b/git.c
index 1ada169..7dd07aa 100644
--- a/git.c
+++ b/git.c
@@ -507,8 +507,9 @@ static int run_argv(int *argcp, const char ***argv)
 }
 
 
-int main(int argc, const char **argv)
+int main(int argc, char **av)
 {
+	const char **argv = (const char **) av;
 	const char *cmd;
 
 	startup_info = &git_startup_info;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 5ddf11c..d7cd5d2 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -286,7 +286,7 @@ static int do_command(struct strbuf *line)
 	return 0;
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
 			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
diff --git a/test-chmtime.c b/test-chmtime.c
index 02b42ba..94903c4 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -56,7 +56,7 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 	return 1;
 }
 
-int main(int argc, const char *argv[])
+int main(int argc, char *argv[])
 {
 	static int verbose;
 
diff --git a/test-index-version.c b/test-index-version.c
index bfaad9e..05d4699 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/test-mergesort.c b/test-mergesort.c
index 3f388b4..ea3b959 100644
--- a/test-mergesort.c
+++ b/test-mergesort.c
@@ -22,7 +22,7 @@ static int compare_strings(const void *a, const void *b)
 	return strcmp(x->text, y->text);
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct line *line, *p = NULL, *lines = NULL;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/test-parse-options.c b/test-parse-options.c
index 3c9510a..434e8b8 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -29,7 +29,7 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	const char *prefix = "prefix/";
 	const char *usage[] = {
@@ -81,7 +81,7 @@ int main(int argc, const char **argv)
 	};
 	int i;
 
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
 	printf("integer: %u\n", integer);
diff --git a/test-subprocess.c b/test-subprocess.c
index f2d4c0d..93525eb 100644
--- a/test-subprocess.c
+++ b/test-subprocess.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct child_process cp;
 	int nogit = 0;
@@ -15,6 +15,6 @@ int main(int argc, const char **argv)
 	}
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = argv + 1;
+	cp.argv = (const char **)argv + 1;
 	return run_command(&cp);
 }
-- 
1.8.2
