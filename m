From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] commit: allow core.commentChar=auto for character auto selection
Date: Fri, 16 May 2014 20:51:23 +0700
Message-ID: <1400248283-303-2-git-send-email-pclouds@gmail.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 15:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlIY2-0004d2-Af
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757161AbaEPNvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 09:51:37 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64571 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130AbaEPNvd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:51:33 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so2596457pad.13
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FC3lQFUo/ja86mIGVVT/7721EtZF+1wlEhDRQ+oO3DE=;
        b=aZJZMdlTBHbYxdPS9zz4UmnMz01KDnqUQ9nTr7QgYedkEr+BcuFJMM2mp3Fr3WFhiC
         21GOSbCWbBcD2l6+OBAKm07HnCGrn4Hsa26GXvfPssektVVi6rmp75Hs/UCagcPlbYGm
         6Gi2O7iis/Vhck/OnmBlDAAlIy42GhRa2bO41RI7nR6jclReLJMAP1tz5IRfxdXdm1kH
         MDIaRsCv/ukk0DjdpKQ3XFU6uSi+9b7wnOnD0Inde9F0reISOIQwE1J218BbDGzmerAm
         CKOE9MU+YZDzHLjakQkRamGTk7jimtu8lZO99nrAob+51Ph1ILVQVJJkHHoO2/XWgTd0
         ru3w==
X-Received: by 10.66.66.225 with SMTP id i1mr21315287pat.0.1400248292702;
        Fri, 16 May 2014 06:51:32 -0700 (PDT)
Received: from lanh ([115.73.241.6])
        by mx.google.com with ESMTPSA id au4sm14741034pbc.10.2014.05.16.06.51.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:51:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 16 May 2014 20:51:40 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1400248283-303-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249307>

core.commentChar starts with '#' as in default but if it's already in
the prepared message, find another one among a small subset. This
should stop surprises because git strips some lines unexpectedly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  3 +++
 builtin/commit.c         | 36 ++++++++++++++++++++++++++++++++++++
 cache.h                  |  1 +
 config.c                 |  2 ++
 environment.c            |  1 +
 t/t7502-commit.sh        | 25 +++++++++++++++++++++++++
 6 files changed, 68 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..d5bf4d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -544,6 +544,9 @@ core.commentchar::
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
 	(default '#').
++
+If set to "auto", `git-commit` would select a character that is not
+the beginning character of any line of existing commit messages.
=20
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase instructio=
n file.
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..039b426 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -594,6 +594,40 @@ static char *cut_ident_timestamp_part(char *string=
)
 	return ket;
 }
=20
+static void adjust_comment_line_char(const struct strbuf *sb)
+{
+	char candidates[] =3D " @!#$%^&|:;~";
+	char *candidate;
+	const char *p;
+
+	if (!sb->len)
+		return;
+
+	if (!strchr(candidates, comment_line_char))
+		candidates[0] =3D comment_line_char;
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
+	if (candidates[0] =3D=3D comment_line_char)
+		return;
+	for (p =3D candidates; *p =3D=3D ' '; p++)
+		;
+	if (!*p)
+		die(_("the comment character '%c' exists in the commit message\n"
+		      "Please choose another character for core.commentChar"),
+		    comment_line_char);
+	comment_line_char =3D *p;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -748,6 +782,8 @@ static int prepare_to_commit(const char *index_file=
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
index 05d909b..5ec3520 100644
--- a/config.c
+++ b/config.c
@@ -829,6 +829,8 @@ static int git_default_core_config(const char *var,=
 const char *value)
 		if (!ret) {
 			if (comment[0] && !comment[1])
 				comment_line_char =3D comment[0];
+			else if (!strcasecmp(comment, "auto"))
+				auto_comment_line_char =3D 1;
 			else
 				return error("core.commentChar should only be one character");
 		}
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
index 9a3f3a1..5cff300 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -563,4 +563,29 @@ test_expect_success 'commit --status with custom c=
omment character' '
 	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
=20
+test_expect_success 'switch core.commentchar' '
+	test_commit "#foo" foo &&
+	GIT_EDITOR=3D.git/FAKE_EDITOR git -c core.commentChar=3Dauto commit -=
-amend &&
+	test_i18ngrep "^@ Changes to be committed:" .git/COMMIT_EDITMSG
+'
+
+test_expect_success 'switch core.commentchar but out of options' '
+	cat >text <<\EOF &&
+# 1
+@ 2
+! 3
+$ 4
+% 5
+^ 6
+& 7
+| 8
+: 9
+; 10
+~ 11
+EOF
+	git commit --amend -F text &&
+	GIT_EDITOR=3D.git/FAKE_EDITOR test_must_fail \
+		git -c core.commentChar=3Dauto commit --amend
+'
+
 test_done
--=20
1.9.1.346.ga2b5940
