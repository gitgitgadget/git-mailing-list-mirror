From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] grep -O: allow optional argument specifying the pager
 (or editor)
Date: Fri, 4 Jun 2010 19:55:52 -0500
Message-ID: <20100605005552.GC8774@progeny.tock>
References: <20100605005116.GA8774@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 02:56:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKhg5-00058S-Sk
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 02:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab0FEAzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 20:55:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40625 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab0FEAzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 20:55:52 -0400
Received: by iwn37 with SMTP id 37so1626159iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uNnGGkxT9JgeQmrN9KITLfGF4HJJ68kWcenR+2Jk354=;
        b=NtdKiz0314CGISxzznMapCVeEYf+wOv1p8Q1H85npqUcYG+mL/gZvWSoa1Ris8IZas
         fOa+Iq+4je4TjpFuy6Q6LmiBfFXIErxyhs3lOARYGVWNStybAxAycSJteF0olDDA6QSy
         VPpXeMurEql/1TWfHu1S+6pGeGY6xiK+N4RRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WVX5GTpQxAsZD6G3PIev1l39QgnCzVVVAn2z42g0OgB1C8EN4v1plo65ArN0+4tJAE
         QLX1jpTBnGi9aJO5qJhnV17Bn4IQqjYUqbshpUYtRHxl/sYIjZSGwFpRGtMdOWHURu/1
         oH0yeLcmKBqN2xc3lNyj5rl7Z79ewI5G+HZ+w=
Received: by 10.231.194.194 with SMTP id dz2mr14379767ibb.74.1275699352017;
        Fri, 04 Jun 2010 17:55:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm7797040ibi.11.2010.06.04.17.55.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 17:55:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100605005116.GA8774@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148444>

=46rom: Johannes Schindelin <johannes.schindelin@gmx.de>

Suppose you want to edit all files that contain a specific search term.
Of course, you can do something totally trivial such as

	git grep -z -e <term> | xargs -0r vi +/<term>

but maybe you are happy that the same will be achieved by

	git grep -Ovi <term>

now.

[jn: rebased and added tests]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Things I didn=E2=80=99t think hard about:

 - the exit status
 - the special-casing of "less" and "vi"

Maybe the latter could be improved by also accepting "more" and
"vim", which both will accept the +/<term> option.

Thanks for reading.

 Documentation/git-grep.txt |    6 +++---
 builtin/grep.c             |   32 +++++++++++++++-----------------
 t/t7811-grep-open.sh       |   11 +++++++----
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8fdd8e1..d89ec32 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
-	   [-O | --open-files-in-pager]
+	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -105,8 +105,8 @@ OPTIONS
 	For better compatibility with 'git diff', `--name-only` is a
 	synonym for `--files-with-matches`.
=20
--O::
---open-files-in-pager::
+-O [<pager>]::
+--open-files-in-pager [<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
diff --git a/builtin/grep.c b/builtin/grep.c
index bc6c2ea..f9551a7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -584,8 +584,8 @@ static void run_pager(struct grep_opt *opt, const c=
har *prefix)
 		exit(status);
 }
=20
-static int grep_cache(struct grep_opt *opt, const char **paths,
-		      int cached, int show_in_pager, const char *prefix)
+static int grep_cache(struct grep_opt *opt, const char **paths, int ca=
ched,
+		      const char *show_in_pager, const char *prefix)
 {
 	int hit =3D 0;
 	int nr;
@@ -707,7 +707,7 @@ static int grep_object(struct grep_opt *opt, const =
char **paths,
 }
=20
 static int grep_directory(struct grep_opt *opt, const char **paths,
-			  int show_in_pager, const char *prefix)
+			  const char *show_in_pager, const char *prefix)
 {
 	struct dir_struct dir;
 	int i, hit =3D 0;
@@ -816,7 +816,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	int cached =3D 0;
 	int seen_dashdash =3D 0;
 	int external_grep_allowed__ignored;
-	int show_in_pager =3D 0;
+	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
 	struct grep_opt opt;
 	struct object_array list =3D { 0, 0, NULL };
 	const char **paths =3D NULL;
@@ -904,8 +904,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
-			"show matching files in the pager"),
+		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
+			"pager", "show matching files in the pager",
+			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -981,18 +982,15 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		argc--;
 	}
=20
+	if (show_in_pager =3D=3D default_pager)
+		show_in_pager =3D git_pager(1);
 	if (show_in_pager) {
-		const char *pager =3D git_pager(1);
-		if (!pager) {
-			show_in_pager =3D 0;
-		} else {
-			opt.name_only =3D 1;
-			opt.null_following_name =3D 1;
-			opt.output_priv =3D &path_list;
-			opt.output =3D append_path;
-			string_list_append(pager, &path_list);
-			use_threads =3D 0;
-		}
+		opt.name_only =3D 1;
+		opt.null_following_name =3D 1;
+		opt.output_priv =3D &path_list;
+		opt.output =3D append_path;
+		string_list_append(show_in_pager, &path_list);
+		use_threads =3D 0;
 	}
=20
 	if (!opt.pattern_list)
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 72e4023..fdf45b8 100644
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -97,9 +97,13 @@ test_expect_success 'git grep -O jumps to line in le=
ss' '
 	EOF
 	>empty &&
=20
-	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out
+	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out1
 	test_cmp expect actual &&
-	test_cmp empty out
+	test_cmp empty out1 &&
+
+	git grep -O./less GREP_PATTERN >out2 &&
+	test_cmp expect actual &&
+	test_cmp empty out2
 '
=20
 test_expect_success 'modified file' '
@@ -135,8 +139,7 @@ test_expect_success 'run from subdir' '
 		export GIT_PAGER &&
 		GIT_PAGER=3D'\''printf "%s\n" >../args'\'' &&
 		git grep -O "enum grep_pat_token" >../out
-		GIT_PAGER=3D"pwd >../dir; :" &&
-		git grep -O "enum grep_pat_token" >../out2
+		git grep -O"pwd >../dir; :" "enum grep_pat_token" >../out2
 	) &&
 	case $(cat dir) in
 	*subdir)
--=20
1.7.1
