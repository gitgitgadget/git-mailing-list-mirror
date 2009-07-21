From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3] grep: Add --max-depth option.
Date: Tue, 21 Jul 2009 23:51:04 +0200
Message-ID: <1248213064-1541-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 23:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTNFO-0001iU-LB
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 23:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbZGUVvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 17:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756155AbZGUVvc
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 17:51:32 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:59781 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbZGUVvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 17:51:31 -0400
Received: by ewy26 with SMTP id 26so3425478ewy.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MbIuEladQhfGgn1NO/Bz+6AGy270LgPEBx87IJuIHq8=;
        b=ezHxN+qWHaXTlRFnsDcLEkAyZ3Xk62+Ilxx6TZxzjzgFQnB0kN6ZrjG/xifxnL3BTk
         u7x1a+8aanK0z6zvLwDcMa54HpCKMTgz2Pu3Tng2ZTFs7p02AQNbZ6N3sSTf31X5Ccfi
         YKKFhUwgZHIerwwCxc9ucfS+GawavvLZ1FZBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=nGnNcCl1XgWNpSzHN20pmhSXtYGq7c4ChnsC71HJluzizCa8DHsnXubkVGKCpcDcNE
         d/cDw0GX5WHwr5UsXkV1Mb+a6KHLqWF+ffQmJlMfcLNkSTI+Ng6wNDd+jtHjh/SdLqpT
         Feo+ApNzLK5TbzqpJFDkUVPkuoRqf1kJ4dfeY=
Received: by 10.210.30.10 with SMTP id d10mr148693ebd.88.1248213089191;
        Tue, 21 Jul 2009 14:51:29 -0700 (PDT)
Received: from localhost (87-205-60-143.adsl.inetia.pl [87.205.60.143])
        by mx.google.com with ESMTPS id 24sm172359eyx.43.2009.07.21.14.51.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 14:51:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123720>

Sometimes it is useful to grep directories non-recursive. E.g. if one
wants to look for all files in main directory, but not in any subdirect=
ory.
Or in Documentation/, but not in Documentation/technical/ and so on.

This patch adds support for --max-depth <depth> option to git-grep. If =
it is
set, git-grep descends at most <depth> levels of directories below path=
s
specified on command line.

Note that if path specified on command line contains wildcards, option
--max-depth makes no sense, i.e.

$ git grep -l --max-depth 0 GNU -- 'contrib/*'

(note the quotes) will search all files in contrib/, even in
subdirectories, because '*' matches all files.

Documentation updates, bash-completion and simple test cases are also
provided.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-grep.txt             |    5 +++
 builtin-grep.c                         |   55 ++++++++++++++++++++++++=
++------
 contrib/completion/git-completion.bash |    1 +
 grep.h                                 |    1 +
 t/t7002-grep.sh                        |   51 ++++++++++++++++++++++++=
+++++-
 5 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b753c9d..faa92d1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-z | --null]
 	   [-c | --count] [--all-match]
+	   [--max-depth <depth>]
 	   [--color | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
@@ -47,6 +48,10 @@ OPTIONS
 -I::
 	Don't match the pattern in binary files.
=20
+--max-depth <depth>::
+	Descend at most <depth> levels of directories below paths specified o=
n
+	command line. Negative value means no limit.
+
 -w::
 --word-regexp::
 	Match the pattern only at word boundary (either begin at the
diff --git a/builtin-grep.c b/builtin-grep.c
index f477659..2ed2507 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -52,26 +52,58 @@ static int grep_config(const char *var, const char =
*value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
=20
+static inline int count_chars(const char *str, char c)
+{
+	int num =3D 0;
+
+	if (!str)
+		return 0;
+
+	for (; *str; str++)
+		if (*str =3D=3D c)
+			num++;
+	return num;
+}
+
+static inline int accept_subdir(const char *path, int max_depth)
+{
+	return max_depth < 0 || count_chars(path, '/') <=3D max_depth;
+}
+
+/*
+ * Return non-zero if name is a subdirectory of match and is not too d=
eep.
+ */
+static inline int is_subdir(const char *name, int namelen,
+		const char *match, int matchlen, int max_depth)
+{
+	if (matchlen > namelen || strncmp(name, match, matchlen))
+		return 0;
+
+	if (name[matchlen] =3D=3D '\0') /* exact match */
+		return 1;
+
+	if (!matchlen || match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D=
 '/')
+		return accept_subdir(name + matchlen + 1, max_depth);
+
+	return 0;
+}
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
  */
-static int pathspec_matches(const char **paths, const char *name)
+static int pathspec_matches(const char **paths, const char *name, int =
max_depth)
 {
 	int namelen, i;
 	if (!paths || !*paths)
-		return 1;
+		return accept_subdir(name, max_depth);
 	namelen =3D strlen(name);
 	for (i =3D 0; paths[i]; i++) {
 		const char *match =3D paths[i];
 		int matchlen =3D strlen(match);
 		const char *cp, *meta;
=20
-		if (!matchlen ||
-		    ((matchlen <=3D namelen) &&
-		     !strncmp(name, match, matchlen) &&
-		     (match[matchlen-1] =3D=3D '/' ||
-		      name[matchlen] =3D=3D '\0' || name[matchlen] =3D=3D '/')))
+		if (is_subdir(name, namelen, match, matchlen, max_depth))
 			return 1;
 		if (!fnmatch(match, name, 0))
 			return 1;
@@ -421,7 +453,7 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 		int kept;
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, opt->max_depth))
 			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
@@ -478,7 +510,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, opt->max_depth))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -538,7 +570,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 			strbuf_addch(&pathbuf, '/');
=20
 		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(paths, down))
+		if (!pathspec_matches(paths, down, opt->max_depth))
 			;
 		else if (S_ISREG(entry.mode))
 			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
@@ -692,6 +724,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			"don't match patterns in binary files",
 			GREP_BINARY_NOMATCH),
+		OPT_INTEGER(0, "max-depth", &opt.max_depth,
+				"descend at most <n> levels"),
 		OPT_GROUP(""),
 		OPT_BIT('E', "extended-regexp", &opt.regflags,
 			"use extended POSIX regular expressions", REG_EXTENDED),
@@ -768,6 +802,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	opt.pathname =3D 1;
 	opt.pattern_tail =3D &opt.pattern_list;
 	opt.regflags =3D REG_NEWLINE;
+	opt.max_depth =3D -1;
=20
 	strcpy(opt.color_match, GIT_COLOR_RED GIT_COLOR_BOLD);
 	opt.color =3D -1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 887731e..fb05c48 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1036,6 +1036,7 @@ _git_grep ()
 			--extended-regexp --basic-regexp --fixed-strings
 			--files-with-matches --name-only
 			--files-without-match
+			--max-depth
 			--count
 			--and --or --not --all-match
 			"
diff --git a/grep.h b/grep.h
index f00db0e..28e6b2a 100644
--- a/grep.h
+++ b/grep.h
@@ -79,6 +79,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int color;
+	int max_depth;
 	int funcname;
 	char color_match[COLOR_MAXLEN];
 	const char *color_external;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index b13aa7e..b4709e2 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -25,13 +25,17 @@ test_expect_success setup '
 		echo foo mmap bar_mmap
 		echo foo_mmap bar mmap baz
 	} >file &&
+	echo vvv >v &&
 	echo ww w >w &&
 	echo x x xx x >x &&
 	echo y yy >y &&
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file w x y z t/t hello.c &&
+	echo vvv >t/v &&
+	mkdir t/a &&
+	echo vvv >t/a/v &&
+	git add . &&
 	test_tick &&
 	git commit -m initial
 '
@@ -132,6 +136,51 @@ do
 		! git grep -c test $H | grep /dev/null
         '
=20
+	test_expect_success "grep --max-depth -1 $L" '
+		{
+			echo ${HC}t/a/v:1:vvv
+			echo ${HC}t/v:1:vvv
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth -1 -n -e vvv $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --max-depth 0 $L" '
+		{
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth 0 -n -e vvv $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --max-depth 0 -- '*' $L" '
+		{
+			echo ${HC}t/a/v:1:vvv
+			echo ${HC}t/v:1:vvv
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth 0 -n -e vvv $H -- "*" >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --max-depth 1 $L" '
+		{
+			echo ${HC}t/v:1:vvv
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth 1 -n -e vvv $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --max-depth 0 -- t $L" '
+		{
+			echo ${HC}t/v:1:vvv
+		} >expected &&
+		git grep --max-depth 0 -n -e vvv $H -- t >actual &&
+		test_cmp expected actual
+	'
+
 done
=20
 cat >expected <<EOF
--=20
1.6.3.3
