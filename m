From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/6] grep: add option -p/--show-function
Date: Thu, 02 Jul 2009 08:16:39 +0200
Message-ID: <4A4C50C7.1050303@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDDEA.3030005@lsrfire.ath.cx>	<7vbpo3errd.fsf@alter.siamese.dyndns.org>	<4A4C39D3.1020401@lsrfire.ath.cx> <7vy6r7d583.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 08:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMFbG-0007Nh-Pp
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 08:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbZGBGQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 02:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZGBGQj
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 02:16:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:36296 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZGBGQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 02:16:38 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id 85D802F8068;
	Thu,  2 Jul 2009 08:16:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <7vy6r7d583.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122623>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Hmm, even shorter would be to leave out these "=3D=3D" things entire=
ly:
>>
>> 	# mock-up
>> 	$ git grep -p -n markers grep.c
>> 	grep.c=3D746=3Dstatic void clr_hit_marker(struct grep_expr *x)
>> 	grep.c:748:     /* All-hit markers are meaningful only at...
>> 	grep.c=3D760=3Dstatic int chk_hit_marker(struct grep_expr *x)
>> 	grep.c:762:     /* Top level nodes have hit markers.  See...
>> 	grep.c=3D772=3Dint grep_buffer(struct grep_opt *opt, const ch...
>> 	grep.c:782:      * We first clear hit markers from them.
>>
>> Is that still readable?
>=20
> Actually the above matches what I expected to see when I read your [0=
/6].

OK. :)

> Is the use of '=3D' your invention, or does somebody's grep have this
> function header feature already and use '=3D' the same way?

I didn't find a prior implementation, only this announcement:

   http://thread.gmane.org/gmane.comp.gnu.grep.bugs/141

Initially, I used '@' (similar to diff), but that looked strange.  The
equal sign seemed to fit well ('-' means context, '=3D' means even more
context! ;-), but I haven't put a lot of thought or research into it.

Here's patch 5 again, with all traces of "=3D=3D" markers removed.  Pat=
ch 6
still applies, albeit with a slight offset.

--- snip! ---
The new option -p instructs git grep to print the previous function
definition as a context line, similar to diff -p.  Such context lines
are marked with an equal sign instead of a dash.  This option
complements the existing context options -A, -B, -C.

=46unction definitions are detected using the same heuristic that diff
uses.  User defined regular expressions are not supported, yet.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    5 ++++
 builtin-grep.c             |    4 ++-
 grep.c                     |   49 ++++++++++++++++++++++++++++++++++++=
++++---
 grep.h                     |    1 +
 t/t7002-grep.sh            |   36 ++++++++++++++++++++++++++++++-
 5 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fccb82d..b3bb283 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -122,6 +122,11 @@ OPTIONS
 -<num>::
 	A shortcut for specifying -C<num>.
=20
+-p::
+--show-function::
+	Show the preceding line that contains the function name of
+	the match, unless the matching line is a function name itself.
+
 -f <file>::
 	Read patterns from <file>, one per line.
=20
diff --git a/builtin-grep.c b/builtin-grep.c
index 48998af..44fd485 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -721,6 +721,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			"show <n> context lines after matches"),
 		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
 			context_callback),
+		OPT_BOOLEAN('p', "show-function", &opt.funcname,
+			"show a line with the function name before matches"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, "file",
 			"read patterns from file", file_callback),
@@ -789,7 +791,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		argc--;
 	}
=20
-	if (opt.color && !opt.color_external)
+	if ((opt.color && !opt.color_external) || opt.funcname)
 		external_grep_allowed =3D 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
diff --git a/grep.c b/grep.c
index 9b9d2e3..364c7c3 100644
--- a/grep.c
+++ b/grep.c
@@ -531,10 +531,40 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
 	printf("%.*s\n", rest, bol);
 }
=20
+static int match_funcname(char *bol, char *eol)
+{
+	if (bol =3D=3D eol)
+		return 0;
+	if (isalpha(*bol) || *bol =3D=3D '_' || *bol =3D=3D '$')
+		return 1;
+	return 0;
+}
+
+static void show_funcname_line(struct grep_opt *opt, const char *name,
+			       char *buf, char *bol, unsigned lno)
+{
+	while (bol > buf) {
+		char *eol =3D --bol;
+
+		while (bol > buf && bol[-1] !=3D '\n')
+			bol--;
+		lno--;
+
+		if (lno <=3D opt->last_shown)
+			break;
+
+		if (match_funcname(bol, eol)) {
+			show_line(opt, bol, eol, name, lno, '=3D');
+			break;
+		}
+	}
+}
+
 static void show_pre_context(struct grep_opt *opt, const char *name, c=
har *buf,
 			     char *bol, unsigned lno)
 {
-	unsigned cur =3D lno, from =3D 1;
+	unsigned cur =3D lno, from =3D 1, funcname_lno =3D 0;
+	int funcname_needed =3D opt->funcname;
=20
 	if (opt->pre_context < lno)
 		from =3D lno - opt->pre_context;
@@ -543,19 +573,28 @@ static void show_pre_context(struct grep_opt *opt=
, const char *name, char *buf,
=20
 	/* Rewind. */
 	while (bol > buf && cur > from) {
-		bol--;
+		char *eol =3D --bol;
+
 		while (bol > buf && bol[-1] !=3D '\n')
 			bol--;
 		cur--;
+		if (funcname_needed && match_funcname(bol, eol)) {
+			funcname_lno =3D cur;
+			funcname_needed =3D 0;
+		}
 	}
=20
+	/* We need to look even further back to find a function signature. */
+	if (opt->funcname && funcname_needed)
+		show_funcname_line(opt, name, buf, bol, cur);
+
 	/* Back forward. */
 	while (cur < lno) {
-		char *eol =3D bol;
+		char *eol =3D bol, sign =3D (cur =3D=3D funcname_lno) ? '=3D' : '-';
=20
 		while (*eol !=3D '\n')
 			eol++;
-		show_line(opt, bol, eol, name, cur, '-');
+		show_line(opt, bol, eol, name, cur, sign);
 		bol =3D eol + 1;
 		cur++;
 	}
@@ -635,6 +674,8 @@ static int grep_buffer_1(struct grep_opt *opt, cons=
t char *name,
 			 */
 			if (opt->pre_context)
 				show_pre_context(opt, name, buf, bol, lno);
+			else if (opt->funcname)
+				show_funcname_line(opt, name, buf, bol, lno);
 			if (!opt->count)
 				show_line(opt, bol, eol, name, lno, ':');
 			last_hit =3D lno;
diff --git a/grep.h b/grep.h
index 730ffd6..3f75e3a 100644
--- a/grep.h
+++ b/grep.h
@@ -79,6 +79,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int color;
+	int funcname;
 	char color_match[COLOR_MAXLEN];
 	const char *color_external;
 	int regflags;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 155bfdb..ef59ab9 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,6 +8,15 @@ test_description=3D'git grep various.
=20
 . ./test-lib.sh
=20
+cat >hello.c <<EOF
+#include <stdio.h>
+int main(int argc, const char **argv)
+{
+	printf("Hello world.\n");
+	return 0;
+}
+EOF
+
 test_expect_success setup '
 	{
 		echo foo mmap bar
@@ -22,7 +31,7 @@ test_expect_success setup '
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file w x y z t/t &&
+	git add file w x y z t/t hello.c &&
 	test_tick &&
 	git commit -m initial
 '
@@ -229,9 +238,32 @@ test_expect_success 'log grep (6)' '
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-	test "$(git grep --no-ext-grep t)" =3D "t/t:test" &&
+	test "$(git grep --no-ext-grep test)" =3D "t/t:test" &&
 	git update-index --no-assume-unchanged t/t &&
 	git checkout t/t
 '
=20
+cat >expected <<EOF
+hello.c=3Dint main(int argc, const char **argv)
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -p' '
+	git grep -p return >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c-#include <stdio.h>
+hello.c=3Dint main(int argc, const char **argv)
+hello.c-{
+hello.c-	printf("Hello world.\n");
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -p -B5' '
+	git grep -p -B5 return >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.6.3.3
