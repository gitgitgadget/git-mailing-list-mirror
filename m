From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [RFC][PATCH] grep: enable threading for context line printing
Date: Sun, 14 Mar 2010 19:18:12 +0100
Message-ID: <4B9D2864.9090808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 14 19:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqsOP-00039S-DW
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 19:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696Ab0CNSST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 14:18:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:59516 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab0CNSSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 14:18:18 -0400
Received: from [10.0.1.100] (p57B7E290.dip.t-dialin.net [87.183.226.144])
	by india601.server4you.de (Postfix) with ESMTPSA id D80622F804E;
	Sun, 14 Mar 2010 19:18:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142147>

This patch makes work_done() in builtin/grep.c print hunk marks between
files if threading is used, while show_line() in grep.c still does the
same in the other case.  The latter is  controlled by the struct grep_o=
pt
member show_hunk_mark: 0 means show_line() prints no hunk marks between
files, 1 means it prints them before the next file with matches and 2
means it prints them before matches from the current file.

Having two places for this is a bit ugly but it enables parallel grep
for the common -ABC options.  Locking should be fine in add_work().

Comments?

Ren=E9

---
 builtin/grep.c |   17 ++++++++++++++++-
 grep.c         |   14 +++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 40b9a93..8d58bb9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -96,6 +96,9 @@ static pthread_cond_t cond_write;
 /* Signalled when we are finished with everything. */
 static pthread_cond_t cond_result;
=20
+static int print_hunk_marks_between_files;
+static int printed_something;
+
 static void add_work(enum work_type type, char *name, void *id)
 {
 	grep_lock();
@@ -159,7 +162,12 @@ static void work_done(struct work_item *w)
 	for(; todo[todo_done].done && todo_done !=3D todo_start;
 	    todo_done =3D (todo_done+1) % ARRAY_SIZE(todo)) {
 		w =3D &todo[todo_done];
-		write_or_die(1, w->out.buf, w->out.len);
+		if (w->out.len) {
+			if (print_hunk_marks_between_files && printed_something)
+				write_or_die(1, "--\n", 3);
+			write_or_die(1, w->out.buf, w->out.len);
+			printed_something =3D 1;
+		}
 		free(w->name);
 		free(w->identifier);
 	}
@@ -932,6 +940,13 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 	use_threads =3D 0;
 #endif
=20
+	if (opt.pre_context || opt.post_context) {
+		if (use_threads)
+			print_hunk_marks_between_files =3D 1;
+		else
+			opt.show_hunk_mark =3D 1;
+	}
+
 	compile_grep_patterns(&opt);
=20
 	/* Check revs and then paths */
diff --git a/grep.c b/grep.c
index 90a063a..251c70c 100644
--- a/grep.c
+++ b/grep.c
@@ -549,10 +549,10 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
 	sign_str[0] =3D sign;
 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown =3D=3D 0) {
-			if (opt->show_hunk_mark)
+			if (opt->show_hunk_mark =3D=3D 2)
 				opt->output(opt, "--\n", 3);
-			else
-				opt->show_hunk_mark =3D 1;
+			else if (opt->show_hunk_mark =3D=3D 1)
+				opt->show_hunk_mark =3D 2;
 		} else if (lno > opt->last_shown + 1)
 			opt->output(opt, "--\n", 3);
 	}
@@ -750,14 +750,6 @@ int grep_threads_ok(const struct grep_opt *opt)
 	    !opt->name_only)
 		return 0;
=20
-	/* If we are showing hunk marks, we should not do it for the
-	 * first match. The synchronization problem we get for this
-	 * constraint is not yet solved, so we disable threading in
-	 * this case.
-	 */
-	if (opt->pre_context || opt->post_context)
-		return 0;
-
 	return 1;
 }
=20
