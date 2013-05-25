From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] commit: don't start editor if empty message is given with
 -m
Date: Sat, 25 May 2013 23:43:34 +0200
Message-ID: <51A13086.3060004@lsrfire.ath.cx>
References: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?TWlzbGF2IE1hcm9obmnEhw==?= <mislav.marohnic@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 23:43:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgMFb-0005tu-4h
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 23:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135Ab3EYVnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 17:43:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:56978 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106Ab3EYVni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 17:43:38 -0400
Received: from [192.168.2.105] (p579BE959.dip0.t-ipconnect.de [87.155.233.89])
	by india601.server4you.de (Postfix) with ESMTPSA id 919E719A;
	Sat, 25 May 2013 23:43:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <195A1F16-B587-4217-97BF-6A92DA8C0786@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225534>

If an empty message is specified with the option -m of git commit then
the editor is started.  That's unexpected and unnecessary.  Instead of
using the length of the message string for checking if the user
specified one, directly remember if the option -m was given.

Reported-by: Mislav Marohni=C4=87 <mislav.marohnic@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/commit.c  | 10 ++++++----
 t/t7502-commit.sh | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..1621dfc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,7 +107,7 @@ static const char *cleanup_arg;
=20
 static enum commit_whence whence;
 static int use_editor =3D 1, include_status =3D 1;
-static int show_ignored_in_status;
+static int show_ignored_in_status, have_option_m;
 static const char *only_include_assumed;
 static struct strbuf message =3D STRBUF_INIT;
=20
@@ -121,9 +121,11 @@ static enum {
 static int opt_parse_m(const struct option *opt, const char *arg, int =
unset)
 {
 	struct strbuf *buf =3D opt->value;
-	if (unset)
+	if (unset) {
+		have_option_m =3D 0;
 		strbuf_setlen(buf, 0);
-	else {
+	} else {
+		have_option_m =3D 1;
 		if (buf->len)
 			strbuf_addch(buf, '\n');
 		strbuf_addstr(buf, arg);
@@ -975,7 +977,7 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"))=
;
=20
-	if (logfile || message.len || use_message || fixup_message)
+	if (logfile || have_option_m || use_message || fixup_message)
 		use_editor =3D 0;
 	if (0 <=3D edit_flag)
 		use_editor =3D edit_flag;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index a4938b1..6313da2 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -361,6 +361,23 @@ test_expect_success !AUTOIDENT 'do not fire editor=
 when committer is bogus' '
 	test_cmp expect .git/result
 '
=20
+test_expect_success 'do not fire editor if -m <msg> was given' '
+	echo tick >file &&
+	git add file &&
+	echo "editor not started" >.git/result &&
+	(GIT_EDITOR=3D"\"$(pwd)/.git/FAKE_EDITOR\"" git commit -m tick) &&
+	test "$(cat .git/result)" =3D "editor not started"
+'
+
+test_expect_success 'do not fire editor if -m "" was given' '
+	echo tock >file &&
+	git add file &&
+	echo "editor not started" >.git/result &&
+	(GIT_EDITOR=3D"\"$(pwd)/.git/FAKE_EDITOR\"" \
+	 git commit -m "" --allow-empty-message) &&
+	test "$(cat .git/result)" =3D "editor not started"
+'
+
 test_expect_success 'do not fire editor in the presence of conflicts' =
'
=20
 	git clean -f &&
--=20
1.8.3
