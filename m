From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] commit: allow core.commentChar=auto for character auto selection
Date: Sat, 17 May 2014 08:52:23 +0700
Message-ID: <1400291543-1371-2-git-send-email-pclouds@gmail.com>
References: <1400248283-303-1-git-send-email-pclouds@gmail.com>
 <1400291543-1371-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 03:45:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlTh7-0004Bk-1a
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 03:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbaEQBpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 21:45:41 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62332 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbaEQBpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 21:45:40 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so3300439pbc.14
        for <git@vger.kernel.org>; Fri, 16 May 2014 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jTIkDnCGU/f7SKXcSvvqDfYKMY3+nSv50JcNjkYxcIg=;
        b=kgHs4sSIjGPasVahn7MgHSin0lPk7Ap42RJ+IrvYlIxs+H9+TiSSiueq8VwbEGKdDI
         8fWeF2iqFYHXfjW1ALk3PYQk9cNYkUB4zJD6vXf2raOrfcCPB+gmYbmdpGiPp/rcIbp1
         MaltlwmdZvRCv38E8hhGU6Mshfg3RecofYJIjlUY2Xnr0aUKLhaeBNKw+xb1xeLZf0X7
         oHGboCKo1N3h7shFOdAEQQm2kimeO1vYhP8WqxJUB/8j7TrAQcR+J3M7BJDKhRPEz2SS
         xJQVAo94M4bnu+7qfgiFWzeTW1ZOGwaU2rggmvmv9aNuqknVEuz8odrzLAiLjoXqUGu9
         aEAw==
X-Received: by 10.68.203.233 with SMTP id kt9mr10209989pbc.61.1400291139646;
        Fri, 16 May 2014 18:45:39 -0700 (PDT)
Received: from lanh ([115.73.230.255])
        by mx.google.com with ESMTPSA id bq4sm16901098pbb.60.2014.05.16.18.45.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 18:45:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 17 May 2014 08:53:11 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1400291543-1371-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249434>

When core.commentChar is "auto", the comment char starts with '#' as
in default but if it's already in the prepared message, find another
char in a small subset. This should stop surprises because git strips
some lines unexpectedly.

Note that git is not smart enough to recognize '#' as the comment char
in custom templates and convert it if the final comment char is
different. It thinks '#' lines in custom templates as part of the
commit message. So don't use this with custom templates.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  3 +++
 builtin/commit.c         | 32 ++++++++++++++++++++++++++++++++
 cache.h                  |  1 +
 config.c                 |  3 +++
 environment.c            |  1 +
 t/t7502-commit.sh        | 26 ++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..9f3ce06 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -544,6 +544,9 @@ core.commentchar::
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
 	(default '#').
++
+If set to "auto", `git-commit` would select a character that is not
+the beginning character of any line in existing commit messages.
=20
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase instructio=
n file.
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..515c4c4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -594,6 +594,36 @@ static char *cut_ident_timestamp_part(char *string=
)
 	return ket;
 }
=20
+static void adjust_comment_line_char(const struct strbuf *sb)
+{
+	char candidates[] =3D "#;@!$%^&|:";
+	char *candidate;
+	const char *p;
+
+	comment_line_char =3D candidates[0];
+	if (!memchr(sb->buf, comment_line_char, sb->len))
+		return;
+
+	p =3D sb->buf;
+	candidate =3D strchr(candidates, *p);
+	if (candidate)
+		*candidate =3D ' ';
+	for (p =3D sb->buf; *p; p++) {
+		if ((p[0] =3D=3D '\n' || p[0] =3D=3D '\r') && p[1]) {
+			candidate =3D strchr(candidates, p[1]);
+			if (candidate)
+				*candidate =3D ' ';
+		}
+	}
+
+	for (p =3D candidates; *p =3D=3D ' '; p++)
+		;
+	if (!*p)
+		die(_("unable to select a comment character that is not used\n"
+		      "in the current commit message"));
+	comment_line_char =3D *p;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -748,6 +778,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
=20
+	if (auto_comment_line_char)
+		adjust_comment_line_char(&sb);
 	strbuf_release(&sb);
=20
 	/* This checks if committer ident is explicitly given */
diff --git a/cache.h b/cache.h
index 107ac61..646fb81 100644
--- a/cache.h
+++ b/cache.h
@@ -602,6 +602,7 @@ extern int precomposed_unicode;
  * that is subject to stripspace.
  */
 extern char comment_line_char;
+extern int auto_comment_line_char;
=20
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED =3D -1,
diff --git a/config.c b/config.c
index 491a905..d29c733 100644
--- a/config.c
+++ b/config.c
@@ -828,8 +828,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		int ret =3D git_config_string(&comment, var, value);
 		if (ret)
 			return ret;
+		else if (!strcasecmp(comment, "auto"))
+			auto_comment_line_char =3D 1;
 		else if (comment[0] && !comment[1]) {
 			comment_line_char =3D comment[0];
+			auto_comment_line_char =3D 0;
 		} else
 			return error("core.commentChar should only be one character");
 		return 0;
diff --git a/environment.c b/environment.c
index 5c4815d..f2de1ee 100644
--- a/environment.c
+++ b/environment.c
@@ -69,6 +69,7 @@ unsigned long pack_size_limit_cfg;
  * that is subject to stripspace.
  */
 char comment_line_char =3D '#';
+int auto_comment_line_char;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 9a3f3a1..30e4688 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -563,4 +563,30 @@ test_expect_success 'commit --status with custom c=
omment character' '
 	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
=20
+test_expect_success 'switch core.commentchar' '
+	test_commit "#foo" foo &&
+	GIT_EDITOR=3D.git/FAKE_EDITOR git -c core.commentChar=3Dauto commit -=
-amend &&
+	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
+'
+
+test_expect_success 'switch core.commentchar but out of options' '
+	cat >text <<\EOF &&
+# 1
+; 2
+@ 3
+! 4
+$ 5
+% 6
+^ 7
+& 8
+| 9
+: 10
+EOF
+	git commit --amend -F text &&
+	(
+		test_set_editor .git/FAKE_EDITOR &&
+		test_must_fail git -c core.commentChar=3Dauto commit --amend
+	)
+'
+
 test_done
--=20
1.9.1.346.ga2b5940
