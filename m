From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Sun, 28 Apr 2013 02:31:43 +0200
Message-ID: <517C6DEF.2050305@lsrfire.ath.cx>
References: <517C24D3.8080802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 02:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWFXA-0001sd-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 02:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3D1Abt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 20:31:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:49340 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3D1Abs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 20:31:48 -0400
Received: from [192.168.2.105] (p579BE62C.dip0.t-ipconnect.de [87.155.230.44])
	by india601.server4you.de (Postfix) with ESMTPSA id E3DD02B6;
	Sun, 28 Apr 2013 02:31:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517C24D3.8080802@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222719>

Am 27.04.2013 21:19, schrieb Ramsay Jones:
> In order to suppress these warnings, since both of the main
> functions need to be declared with the same prototype, we
> change the declaration of the 9 main functions, thus:
>=20
>      int main(int argc, char **argv)

Why not take the opposite direction with a patch like this?  It's quick
and dirty and based on v1.8.1.msysgit.1, as that was the version I had
lying around here, but you get the idea.

Ren=E9

---
 compat/mingw.h          |  4 ++--
 daemon.c                | 16 ++++++++--------
 http-backend.c          |  2 +-
 imap-send.c             |  2 +-
 sh-i18n--envsubst.c     |  2 +-
 shell.c                 |  2 +-
 show-index.c            |  2 +-
 test-ctype.c            |  2 +-
 test-date.c             |  8 ++++----
 test-delta.c            |  2 +-
 test-dump-cache-tree.c  |  2 +-
 test-genrandom.c        |  2 +-
 test-line-buffer.c      |  2 +-
 test-match-trees.c      |  2 +-
 test-mktemp.c           |  2 +-
 test-path-utils.c       |  4 ++--
 test-regex.c            |  2 +-
 test-revision-walking.c |  2 +-
 test-run-command.c      |  2 +-
 test-scrap-cache-tree.c |  2 +-
 test-sha1.c             |  2 +-
 test-sigchain.c         |  2 +-
 test-string-list.c      |  2 +-
 test-svn-fe.c           |  4 ++--
 upload-pack.c           |  6 +++---
 25 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 389ae01..74e7b87 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -452,11 +452,11 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size=
_t utflen);
=20
 void mingw_startup();
 #define main(c,v) dummy_decl_mingw_main(); \
-static int mingw_main(); \
+static int mingw_main(int, const char **); \
 int main(int argc, const char **argv) \
 { \
 	mingw_startup(); \
-	return mingw_main(__argc, __argv); \
+	return mingw_main(argc, argv); \
 } \
 static int mingw_main(c,v)
=20
diff --git a/daemon.c b/daemon.c
index 4602b46..f4186a7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -36,15 +36,15 @@ static const char daemon_usage[] =3D
 "           [<directory>...]";
=20
 /* List of acceptable pathname prefixes */
-static char **ok_paths;
+static const char **ok_paths;
 static int strict_paths;
=20
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees;
=20
 /* Take all paths relative to this one if non-NULL */
-static char *base_path;
-static char *interpolated_path;
+static const char *base_path;
+static const char *interpolated_path;
 static int base_path_relaxed;
=20
 /* Flag indicating client sent extra args. */
@@ -196,7 +196,7 @@ static const char *path_ok(char *directory)
 	}
=20
 	if ( ok_paths && *ok_paths ) {
-		char **pp;
+		const char **pp;
 		int pathlen =3D strlen(path);
=20
 		/* The validation is done on the paths after enter_repo
@@ -257,7 +257,7 @@ static int daemon_error(const char *dir, const char=
 *msg)
 	return -1;
 }
=20
-static char *access_hook;
+static const char *access_hook;
=20
 static int run_access_hook(struct daemon_service *service, const char =
*dir, const char *path)
 {
@@ -739,7 +739,7 @@ static void check_dead_children(void)
 			cradle =3D &blanket->next;
 }
=20
-static char **cld_argv;
+static const char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addr=
len)
 {
 	struct child_process cld =3D { NULL };
@@ -1164,7 +1164,7 @@ static int serve(struct string_list *listen_addr,=
 int listen_port,
 	return service_loop(&socklist);
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	int listen_port =3D 0;
 	struct string_list listen_addr =3D STRING_LIST_INIT_NODUP;
@@ -1179,7 +1179,7 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
=20
 	for (i =3D 1; i < argc; i++) {
-		char *arg =3D argv[i];
+		const char *arg =3D argv[i];
=20
 		if (!prefixcmp(arg, "--listen=3D")) {
 			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
diff --git a/http-backend.c b/http-backend.c
index f50e77f..ce164bb 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -533,7 +533,7 @@ static struct service_cmd {
 	{"POST", "/git-receive-pack$", service_rpc}
 };
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	char *method =3D getenv("REQUEST_METHOD");
 	char *dir;
diff --git a/imap-send.c b/imap-send.c
index d42e471..ec98934 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1502,7 +1502,7 @@ static int git_imap_config(const char *key, const=
 char *val, void *cb)
 	return 0;
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	struct msg_data all_msgs, msg;
 	struct store *ctx =3D NULL;
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 5ddd688..c3d0654 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -64,7 +64,7 @@ static void note_variables (const char *string);
 static void subst_from_stdin (void);
=20
 int
-main (int argc, char *argv[])
+main (int argc, const char *argv[])
 {
   /* Default values for command line options.  */
   /* unsigned short int show_variables =3D 0; */
diff --git a/shell.c b/shell.c
index 06a394c..9ec4491 100644
--- a/shell.c
+++ b/shell.c
@@ -129,7 +129,7 @@ static struct commands {
 	{ NULL },
 };
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	char *prog;
 	const char **user_argv;
diff --git a/show-index.c b/show-index.c
index 5a9eed7..651a115 100644
--- a/show-index.c
+++ b/show-index.c
@@ -4,7 +4,7 @@
 static const char show_index_usage[] =3D
 "git show-index < <packed archive index>";
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	int i;
 	unsigned nr;
diff --git a/test-ctype.c b/test-ctype.c
index 707a821..694dcfb 100644
--- a/test-ctype.c
+++ b/test-ctype.c
@@ -28,7 +28,7 @@ static int is_in(const char *s, int ch)
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	TEST_CLASS(isdigit, DIGIT);
 	TEST_CLASS(isspace, " \n\r\t");
diff --git a/test-date.c b/test-date.c
index 10afaab..00c9e93 100644
--- a/test-date.c
+++ b/test-date.c
@@ -5,7 +5,7 @@ static const char *usage_msg =3D "\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n";
=20
-static void show_dates(char **argv, struct timeval *now)
+static void show_dates(const char **argv, struct timeval *now)
 {
 	struct strbuf buf =3D STRBUF_INIT;
=20
@@ -17,7 +17,7 @@ static void show_dates(char **argv, struct timeval *n=
ow)
 	strbuf_release(&buf);
 }
=20
-static void parse_dates(char **argv, struct timeval *now)
+static void parse_dates(const char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
 		char result[100];
@@ -34,7 +34,7 @@ static void parse_dates(char **argv, struct timeval *=
now)
 	}
 }
=20
-static void parse_approxidate(char **argv, struct timeval *now)
+static void parse_approxidate(const char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
 		time_t t;
@@ -43,7 +43,7 @@ static void parse_approxidate(char **argv, struct tim=
eval *now)
 	}
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	struct timeval now;
 	const char *x;
diff --git a/test-delta.c b/test-delta.c
index af40a3c..b697e87 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -15,7 +15,7 @@
 static const char usage_str[] =3D
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
=20
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
 	int fd;
 	struct stat st;
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index a6ffdf3..ab75fe0 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -54,7 +54,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	return errs;
 }
=20
-int main(int ac, char **av)
+int main(int ac, const char **av)
 {
 	struct cache_tree *another =3D cache_tree();
 	if (read_cache() < 0)
diff --git a/test-genrandom.c b/test-genrandom.c
index b3c28d9..fa63cfd 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -6,7 +6,7 @@
=20
 #include "git-compat-util.h"
=20
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
 	unsigned long count, next =3D 0;
 	unsigned char *c;
diff --git a/test-line-buffer.c b/test-line-buffer.c
index ef1d7ba..a018fd7 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -50,7 +50,7 @@ static void handle_line(const char *line, struct line=
_buffer *stdin_buf)
 	handle_command(line, arg + 1, stdin_buf);
 }
=20
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
 	struct line_buffer stdin_buf =3D LINE_BUFFER_INIT;
 	struct line_buffer file_buf =3D LINE_BUFFER_INIT;
diff --git a/test-match-trees.c b/test-match-trees.c
index a3c4688..2af5d80 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "tree.h"
=20
-int main(int ac, char **av)
+int main(int ac, const char **av)
 {
 	unsigned char hash1[20], hash2[20], shifted[20];
 	struct tree *one, *two;
diff --git a/test-mktemp.c b/test-mktemp.c
index c8c5421..6f3542c 100644
--- a/test-mktemp.c
+++ b/test-mktemp.c
@@ -3,7 +3,7 @@
  */
 #include "git-compat-util.h"
=20
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
 	if (argc !=3D 2)
 		usage("Expected 1 parameter defining the temporary file template");
diff --git a/test-path-utils.c b/test-path-utils.c
index 0092cbf..e02154c 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -28,7 +28,7 @@ static int normalize_ceiling_entry(struct string_list=
_item *item, void *unused)
 	return 1;
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	if (argc =3D=3D 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf =3D xmalloc(PATH_MAX + 1);
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
 	}
=20
 	if (argc >=3D 4 && !strcmp(argv[1], "prefix_path")) {
-		char *prefix =3D argv[2];
+		const char *prefix =3D argv[2];
 		int prefix_len =3D strlen(prefix);
 		int nongit_ok;
 		setup_git_directory_gently(&nongit_ok);
diff --git a/test-regex.c b/test-regex.c
index b5bfd54..22536aa 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,6 +1,6 @@
 #include <git-compat-util.h>
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	char *pat =3D "[^=3D{} \t]+";
 	char *str =3D "=3D{}\nfred";
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 3ade02c..d305962 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -45,7 +45,7 @@ static int run_revision_walk(void)
 	return got_revision;
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	if (argc < 2)
 		return 1;
diff --git a/test-run-command.c b/test-run-command.c
index 37918e1..00f040b 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -13,7 +13,7 @@
 #include <string.h>
 #include <errno.h>
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	struct child_process proc;
=20
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 4728013..cae5bcb 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -4,7 +4,7 @@
=20
 static struct lock_file index_lock;
=20
-int main(int ac, char **av)
+int main(int ac, const char **av)
 {
 	int fd =3D hold_locked_index(&index_lock, 1);
 	if (read_cache() < 0)
diff --git a/test-sha1.c b/test-sha1.c
index 80daba9..aed67af 100644
--- a/test-sha1.c
+++ b/test-sha1.c
@@ -1,6 +1,6 @@
 #include "cache.h"
=20
-int main(int ac, char **av)
+int main(int ac, const char **av)
 {
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
diff --git a/test-sigchain.c b/test-sigchain.c
index 42db234..b00e17f 100644
--- a/test-sigchain.c
+++ b/test-sigchain.c
@@ -13,7 +13,7 @@ X(two)
 X(three)
 #undef X
=20
-int main(int argc, char **argv) {
+int main(int argc, const char **argv) {
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
 	sigchain_push(SIGTERM, three);
diff --git a/test-string-list.c b/test-string-list.c
index 00ce6c9..f59cf05 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -41,7 +41,7 @@ static int prefix_cb(struct string_list_item *item, v=
oid *cb_data)
 	return !prefixcmp(item->string, prefix);
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	if (argc =3D=3D 5 && !strcmp(argv[1], "split")) {
 		struct string_list list =3D STRING_LIST_INIT_DUP;
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 0f2d9a4..8ac4954 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -11,7 +11,7 @@
 static const char test_svnfe_usage[] =3D
 	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
=20
-static int apply_delta(int argc, char *argv[])
+static int apply_delta(int argc, const char *argv[])
 {
 	struct line_buffer preimage =3D LINE_BUFFER_INIT;
 	struct line_buffer delta =3D LINE_BUFFER_INIT;
@@ -35,7 +35,7 @@ static int apply_delta(int argc, char *argv[])
 	return 0;
 }
=20
-int main(int argc, char *argv[])
+int main(int argc, const char *argv[])
 {
 	if (argc =3D=3D 2) {
 		if (svndump_init(argv[1]))
diff --git a/upload-pack.c b/upload-pack.c
index 6142421..71c72cc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -780,9 +780,9 @@ static void upload_pack(void)
 	}
 }
=20
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	char *dir;
+	const char *dir;
 	int i;
 	int strict =3D 0;
=20
@@ -793,7 +793,7 @@ int main(int argc, char **argv)
 	read_replace_refs =3D 0;
=20
 	for (i =3D 1; i < argc; i++) {
-		char *arg =3D argv[i];
+		const char *arg =3D argv[i];
=20
 		if (arg[0] !=3D '-')
 			break;
