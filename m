From: Michal Vitecek <fuf@mageo.cz>
Subject: Re: [PATCH] Use "" instead of "<unknown>" for placeholders
Date: Tue, 25 Sep 2007 12:52:02 +0200
Message-ID: <20070925105201.GO22869@mageo.cz>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site> <20070921110646.GA9072@mageo.cz> <Pine.LNX.4.64.0709211207070.28395@racer.site> <20070921140500.GB9072@mageo.cz> <7vk5qjixqy.fsf@gitster.siamese.dyndns.org> <46F4D815.5050602@mageo.cz> <20070925094320.GN22869@mageo.cz> <Pine.LNX.4.64.0709251120120.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia81Z-000714-5x
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbXIYKwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 06:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXIYKwH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:52:07 -0400
Received: from interactive-1.com ([193.85.232.82]:42149 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbXIYKwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:52:06 -0400
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 396BE23B3A3;
	Tue, 25 Sep 2007 12:52:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709251120120.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59113>

 Hi,

Johannes Schindelin wrote:
>> >>>>>>> I made it because I want to use my own pretty format which c=
urrently=20
>> >>>>>>> only allows '%s' for subject and '%b' for body. But '%b' is=20
>> >>>>>>> substituted with <undefined> if the body is "missing" which =
I=20
>> >>>>>>> obviously don't like :)
>> >>>>>> Then you should fix %b not to show "<undefined>".
>> >>>>>  I'll do it if it is okay. Shall I do the same for the other
>> >>>>>  placeholders as well?
>> >>>> Yeah.  Don't know why I did it that way.
>> >>>  Here comes the big patch :)
>> >> Now, this breaks t6006 which needs this patch.
>> >
>> > Oops - I'm sorry about that. I ran the test suite (1.5.3.1) but it=
 failed=20
>> > in 2 tests before the patch and in 2 tests after it so I considere=
d it=20
>> > okay.
>> >
>> >> Looking at this patch, I am not sure if your change is really a
>> >> desirable one --- shouldn't it be removing the line itself, not
>> >> just <unknown> token?
>> >
>> > This sounds as the best solution. I'll look into it. Thanks for yo=
ur time.
>>=20
>>  Here comes the patch. I hope it will be ok this time :) Thanks.
>>=20
>>  Don't use "<unknown>" for unknown values of placeholders and suppre=
ss
>>  printing of empty user formats.
>>=20
>> ---
>
>We use tabs for indentation, not spaces.
>
>Also, instead of the expensive "strlen(buf)", you rather want to check=
 "if=20
>(*buf)".

---

 Thanks for the notes - here comes the patch with the above fixes.


 builtin-rev-list.c         |    3 ++-
 commit.c                   |    3 ---
 interpolate.c              |    6 +++++-
 log-tree.c                 |   10 ++++++----
 t/t6006-rev-list-format.sh |    8 --------
 t/t7500-commit.sh          |    4 ++--
 6 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 3894633..0b74eb3 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -85,7 +85,8 @@ static void show_commit(struct commit *commit)
 		pretty_print_commit(revs.commit_format, commit, ~0,
 				    &buf, &buflen,
 				    revs.abbrev, NULL, NULL, revs.date_mode);
-		printf("%s%c", buf, hdr_termination);
+		if (*buf)
+			printf("%s%c", buf, hdr_termination);
 		free(buf);
 	}
 	maybe_flush_or_die(stdout, "stdout");
diff --git a/commit.c b/commit.c
index 99f65ce..c9a1818 100644
--- a/commit.c
+++ b/commit.c
@@ -917,9 +917,6 @@ long format_commit_message(const struct commit *com=
mit, const void *format,
 	}
 	if (msg[i])
 		table[IBODY].value =3D xstrdup(msg + i);
-	for (i =3D 0; i < ARRAY_SIZE(table); i++)
-		if (!table[i].value)
-			interp_set_entry(table, i, "<unknown>");
=20
 	do {
 		char *buf =3D *buf_p;
diff --git a/interpolate.c b/interpolate.c
index 0082677..2f727cd 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -76,8 +76,12 @@ unsigned long interpolate(char *result, unsigned lon=
g reslen,
 			/* Check for valid interpolation. */
 			if (i < ninterps) {
 				value =3D interps[i].value;
-				valuelen =3D strlen(value);
+				if (!value) {
+					src +=3D namelen;
+					continue;
+				}
=20
+				valuelen =3D strlen(value);
 				if (newlen + valuelen + 1 < reslen) {
 					/* Substitute. */
 					strncpy(dest, value, valuelen);
diff --git a/log-tree.c b/log-tree.c
index a642371..79502f4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -175,14 +175,15 @@ void show_log(struct rev_info *opt, const char *s=
ep)
 	 *  - The pretty-printed commit lacks a newline at the end
 	 *    of the buffer, but we do want to make sure that we
 	 *    have a newline there. If the separator isn't already
-	 *    a newline, add an extra one.
+         *    a newline, add an extra one and do the same for the
+         *    user format as well.
 	 *  - unlike other log messages, the one-line format does
 	 *    not have an empty line between entries.
 	 */
 	extra =3D "";
-	if (*sep !=3D '\n' && opt->commit_format =3D=3D CMIT_FMT_ONELINE)
+	if (*sep !=3D '\n' && (opt->commit_format =3D=3D CMIT_FMT_ONELINE || =
opt->commit_format =3D=3D CMIT_FMT_USERFORMAT))
 		extra =3D "\n";
-	if (opt->shown_one && opt->commit_format !=3D CMIT_FMT_ONELINE)
+	if (opt->shown_one && opt->commit_format !=3D CMIT_FMT_ONELINE && opt=
->commit_format !=3D CMIT_FMT_USERFORMAT)
 		putchar(opt->diffopt.line_termination);
 	opt->shown_one =3D 1;
=20
@@ -298,7 +299,8 @@ void show_log(struct rev_info *opt, const char *sep=
)
 	if (opt->show_log_size)
 		printf("log size %i\n", len);
=20
-	printf("%s%s%s", msgbuf, extra, sep);
+	if (*msgbuf)
+		printf("%s%s%s", msgbuf, extra, sep);
 	free(msgbuf);
 }
=20
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ad6d0b8..1e4541a 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -79,9 +79,7 @@ EOF
=20
 test_format encoding %e <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
 EOF
=20
 test_format subject %s <<'EOF'
@@ -93,9 +91,7 @@ EOF
=20
 test_format body %b <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
 EOF
=20
 test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
@@ -121,9 +117,7 @@ test_format complex-encoding %e <<'EOF'
 commit f58db70b055c5718631e5c61528b28b12090cdea
 iso8859-1
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
 EOF
=20
 test_format complex-subject %s <<'EOF'
@@ -142,9 +136,7 @@ and it will be encoded in iso8859-1. We should ther=
efore
 include an iso8859 character: =C3=82=C4=84bueno!
=20
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
 EOF
=20
 test_done
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index f11ada8..abbf54b 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -81,7 +81,7 @@ test_expect_success 'explicit commit message should o=
verride template' '
 	git add foo &&
 	GIT_EDITOR=3D../t7500/add-content git commit --template "$TEMPLATE" \
 		-m "command line msg" &&
-	commit_msg_is "command line msg<unknown>"
+	commit_msg_is "command line msg"
 '
=20
 test_expect_success 'commit message from file should override template=
' '
@@ -90,7 +90,7 @@ test_expect_success 'commit message from file should =
override template' '
 	echo "standard input msg" |
 		GIT_EDITOR=3D../t7500/add-content git commit \
 			--template "$TEMPLATE" --file - &&
-	commit_msg_is "standard input msg<unknown>"
+	commit_msg_is "standard input msg"
 '
=20
 test_done
--=20
1.5.3.2


--=20
		fuf		(fuf@mageo.cz)
