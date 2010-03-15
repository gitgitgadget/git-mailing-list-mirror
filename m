From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC][PATCH] grep: enable threading for context line printing
Date: Mon, 15 Mar 2010 17:21:10 +0100
Message-ID: <4B9E5E76.9000702@lsrfire.ath.cx>
References: <4B9D2864.9090808@lsrfire.ath.cx> <4c8ef71003141303h474429aegc0a2eb2f97e7ff69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 17:21:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrD2l-0003NN-77
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 17:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346Ab0COQVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 12:21:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:34447 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965330Ab0COQVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 12:21:18 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 027AA2F804E;
	Mon, 15 Mar 2010 17:21:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <4c8ef71003141303h474429aegc0a2eb2f97e7ff69@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142219>

Am 14.03.2010 21:03, schrieb Fredrik Kuivinen:
> On Sun, Mar 14, 2010 at 19:18, Ren=E9 Scharfe <rene.scharfe@lsrfire.a=
th.cx> wrote:
>> This patch makes work_done() in builtin/grep.c print hunk marks betw=
een
>> files if threading is used, while show_line() in grep.c still does t=
he
>> same in the other case.  The latter is  controlled by the struct gre=
p_opt
>> member show_hunk_mark: 0 means show_line() prints no hunk marks betw=
een
>> files, 1 means it prints them before the next file with matches and =
2
>> means it prints them before matches from the current file.
>>
>> Having two places for this is a bit ugly but it enables parallel gre=
p
>> for the common -ABC options.  Locking should be fine in add_work().
>>
>> Comments?
>=20
> The implementation looks correct. As you say it is a bit ugly, but I
> think it is worth it anyway. (The solutions I managed to come up with
> when I wrote the original threaded grep patch were even uglier, that
> is why I simply disabled the threading in that case.)
>=20
> Symbolic constants for the magic values 0, 1, and 2 would make the
> code more readable.

Yes, that was a bit too complicated.  I shuffled the code around a bit,
so the patch is now a bit smaller and avoids introducing value 2 for
show_hunk_mark.  Better?

-- >8 --
If context lines are to be printed, grep separates them with hunk marks
("--\n").  These marks are printed between matches from different files=
,
too.  They are not printed before the first file, though.

Threading was disabled when context line printing was enabled because
avoiding to print the mark before the first line was an unsolved
synchronisation problem.  This patch separates the code for printing
hunk marks for the threaded and the unthreaded case, allowing threading
to be turned on together with the common -ABC options.

->show_hunk_mark, which controls printing of hunk marks between files i=
n
show_line(), is now set in grep_buffer_1(), but only if some results
have already been printed and threading is disabled.  The threaded case
is handled in work_done().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/grep.c |   15 +++++++++++++--
 grep.c         |   17 +++++------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 40b9a93..f427d55 100644
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
@@ -926,8 +934,11 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
 		use_threads =3D 0;
=20
-	if (use_threads)
+	if (use_threads) {
+		if (opt.pre_context || opt.post_context)
+			print_hunk_marks_between_files =3D 1;
 		start_threads(&opt);
+	}
 #else
 	use_threads =3D 0;
 #endif
diff --git a/grep.c b/grep.c
index 90a063a..e5f06e4 100644
--- a/grep.c
+++ b/grep.c
@@ -551,8 +551,6 @@ static void show_line(struct grep_opt *opt, char *b=
ol, char *eol,
 		if (opt->last_shown =3D=3D 0) {
 			if (opt->show_hunk_mark)
 				opt->output(opt, "--\n", 3);
-			else
-				opt->show_hunk_mark =3D 1;
 		} else if (lno > opt->last_shown + 1)
 			opt->output(opt, "--\n", 3);
 	}
@@ -750,14 +748,6 @@ int grep_threads_ok(const struct grep_opt *opt)
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
@@ -779,11 +769,14 @@ static int grep_buffer_1(struct grep_opt *opt, co=
nst char *name,
 	enum grep_context ctx =3D GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
=20
-	opt->last_shown =3D 0;
-
 	if (!opt->output)
 		opt->output =3D std_output;
=20
+	if (opt->last_shown && (opt->pre_context || opt->post_context) &&
+	    opt->output =3D=3D std_output)
+		opt->show_hunk_mark =3D 1;
+	opt->last_shown =3D 0;
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
