From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 7/8] Make it possible to call cmd_apply multiple times
Date: Tue, 13 Jun 2006 22:22:03 +0200
Organization: Chalmers
Message-ID: <448F1E6B.6050507@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOu-0006Y1-Bi
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWFMUWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWFMUWH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:22:07 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:17342 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932220AbWFMUWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:22:06 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout1-sn2.hy.skanova.net (7.2.072.1)
        id 448977B3000E7424; Tue, 13 Jun 2006 22:22:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21809>

* xmalloc a new struct lock_file each invocation.
* Don't die() if the patch doesn't apply.
* Initialize the global variables each invocation.
* Roll back the lock_file.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 builtin-apply.c |   94 +++++++++++++++++++++++++++++++++++------------=
--------
 1 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e113c74..a76c553 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -22,24 +22,13 @@ #include "builtin.h"
 //  --index updates the cache as well.
 //  --cached updates only the cache without ever touching the working =
tree.
 //
-static const char *prefix;
-static int prefix_length =3D -1;
-static int newfd =3D -1;
-
-static int p_value =3D 1;
-static int allow_binary_replacement =3D 0;
-static int check_index =3D 0;
-static int write_index =3D 0;
-static int cached =3D 0;
-static int diffstat =3D 0;
-static int numstat =3D 0;
-static int summary =3D 0;
-static int check =3D 0;
-static int apply =3D 1;
-static int no_add =3D 0;
-static int show_index_info =3D 0;
-static int line_termination =3D '\n';
+static const char *prefix, *patch_input_file;
+static int prefix_length, newfd, p_value, allow_binary_replacement, ch=
eck_index,
+	write_index, cached, diffstat, numstat, summary, check, apply, no_add=
,
+	show_index_info, line_termination, whitespace_error, squelch_whitespa=
ce_errors,
+	applied_after_stripping;
 static unsigned long p_context =3D -1;
+
 static const char apply_usage[] =3D
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cac=
hed] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [=
-z] [-pNUM] [-CNUM] [--whitespace=3D<nowarn|warn|error|error-all|strip>=
] <patch>...";
=20
@@ -49,10 +38,31 @@ static enum whitespace_eol {
 	error_on_whitespace,
 	strip_whitespace,
 } new_whitespace =3D warn_on_whitespace;
-static int whitespace_error =3D 0;
-static int squelch_whitespace_errors =3D 5;
-static int applied_after_stripping =3D 0;
-static const char *patch_input_file =3D NULL;
+
+static void setup_state()
+{
+	prefix =3D NULL;
+	prefix_length =3D -1;
+	newfd =3D -1;
+	p_value =3D 1;
+	allow_binary_replacement =3D 0;
+	check_index =3D 0;
+	write_index =3D 0;
+	cached =3D 0;
+	diffstat =3D 0;
+	numstat =3D 0;
+	summary =3D 0;
+	check =3D 0;
+	apply =3D 1;
+	no_add =3D 0;
+	show_index_info =3D 0;
+	line_termination =3D '\n';
+	p_context =3D -1;
+	whitespace_error =3D 0;
+	squelch_whitespace_errors =3D 5;
+	applied_after_stripping =3D 0;
+	patch_input_file =3D NULL;
+}
=20
 static void parse_whitespace_option(const char *option)
 {
@@ -2072,7 +2082,7 @@ static void write_out_results(struct pat
 	}
 }
=20
-static struct lock_file lock_file;
+static struct lock_file *lock_file;
=20
 static struct excludes {
 	struct excludes *next;
@@ -2106,7 +2116,7 @@ static int apply_patch(int fd, const cha
=20
 	patch_input_file =3D filename;
 	if (!buffer)
-		return -1;
+		return -2;
 	offset =3D 0;
 	while (size > 0) {
 		struct patch *patch;
@@ -2134,7 +2144,7 @@ static int apply_patch(int fd, const cha
=20
 	write_index =3D check_index && apply;
 	if (write_index && newfd < 0) {
-		newfd =3D hold_lock_file_for_update(&lock_file,
+		newfd =3D hold_lock_file_for_update(lock_file,
 						  get_index_file());
 		if (newfd < 0)
 			die("unable to create new index file");
@@ -2145,7 +2155,7 @@ static int apply_patch(int fd, const cha
 	}
=20
 	if ((check || apply) && check_patch_list(list) < 0)
-		exit(1);
+		return -1;
=20
 	if (apply)
 		write_out_results(list, skipped_patch);
@@ -2175,20 +2185,27 @@ static int git_apply_config(const char *
 	return git_default_config(var, value);
 }
=20
-
 int cmd_apply(int argc, const char **argv, char **envp)
 {
-	int i;
+	int i, ret =3D 0;
 	int read_stdin =3D 1;
 	const char *whitespace_option =3D NULL;
=20
+	setup_state();
+
+	/* This memory can't be free()'d since it's needed atexit() */
+	lock_file =3D xmalloc(sizeof(struct lock_file));
+
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
 		char *end;
-		int fd;
+		int fd, apply_status;
=20
 		if (!strcmp(arg, "-")) {
-			apply_patch(0, "<stdin>");
+			if (apply_patch(0, "<stdin>")) {
+				ret =3D 1;
+				goto err;
+			}
 			read_stdin =3D 0;
 			continue;
 		}
@@ -2281,12 +2298,18 @@ int cmd_apply(int argc, const char **arg
 			usage(apply_usage);
 		read_stdin =3D 0;
 		set_default_whitespace_mode(whitespace_option);
-		apply_patch(fd, arg);
+		apply_status =3D apply_patch(fd, arg);
 		close(fd);
+		if (apply_status) {
+			ret =3D 1;
+			goto err;
+		}
 	}
 	set_default_whitespace_mode(whitespace_option);
-	if (read_stdin)
-		apply_patch(0, "<stdin>");
+	if (read_stdin && apply_patch(0, "<stdin>")) {
+		ret =3D 1;
+		goto err;
+	}
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
@@ -2316,9 +2339,12 @@ int cmd_apply(int argc, const char **arg
=20
 	if (write_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(&lock_file))
+		    commit_lock_file(lock_file))
 			die("Unable to write new index file");
 	}
=20
-	return 0;
+err:
+	rollback_lock_file(lock_file);
+
+	return ret;
 }
--=20
1.4.0
