From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 19:52:15 +0200
Message-ID: <1248285135-9033-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 19:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTfzY-0000VV-6e
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbZGVRwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 13:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbZGVRwY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:52:24 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:40790 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZGVRwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 13:52:23 -0400
Received: by ey-out-2122.google.com with SMTP id 9so156384eyd.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=70VhUJa9nabwILWk4VVIuLnOxOxspQb3YYppHRTwDgY=;
        b=lSzxI4Bqkh6AM+aeZLB7vsVJEqbwJazkO4i/qBzvmUgXkVhxh39zvnoPVvQgYndkUo
         i8DTKgEE+grUcKMliQptCd64JIvxgoYlXNuT1ezShb7bm0gnCBHmwh6vZSk7FDgVTX1R
         GRSq359i11WZPHLcQvym3FNlTH01Bf/teP+R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RqBuSWn+9TY9mx9RxR/ukZt7WLnGB6rGnWe4AGBaCncw7aRU6Wka4oaK2ma5QZR/VX
         5adGbmh8g+j4NMSQMB92lmseVuIrcLmDx08WDfmoOq1wcRz6rFE5XoCwsFpcToxbcuMw
         BkcCKG51kjhsfL8dwOtRQF3Kp4b1ve0ArlhwY=
Received: by 10.210.58.13 with SMTP id g13mr1358932eba.99.1248285141714;
        Wed, 22 Jul 2009 10:52:21 -0700 (PDT)
Received: from localhost (87-205-60-143.adsl.inetia.pl [87.205.60.143])
        by mx.google.com with ESMTPS id 10sm245586eyd.7.2009.07.22.10.52.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 10:52:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123760>

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
I've merged count_chars() into accept_subdir(), changed OPT_INTEGER to
OPTION_INTEGER, which allowed me to set argh to "<depth>", to be more
consistent with git-grep.txt, and revised documentation.

 Documentation/git-grep.txt             |    5 +++
 builtin-grep.c                         |   56 ++++++++++++++++++++++++=
++------
 contrib/completion/git-completion.bash |    1 +
 grep.h                                 |    1 +
 t/t7002-grep.sh                        |   51 ++++++++++++++++++++++++=
++++-
 5 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b753c9d..d0e3638 100644
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
+	For each pathspec given on command line, descend at most <depth>
+	levels of directories. Negative value means no limit.
+
 -w::
 --word-regexp::
 	Match the pattern only at word boundary (either begin at the
diff --git a/builtin-grep.c b/builtin-grep.c
index f477659..1a9d6a4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -53,25 +53,57 @@ static int grep_config(const char *var, const char =
*value, void *cb)
 }
=20
 /*
+ * Return non-zero if max_depth is negative or path has no more then m=
ax_depth
+ * slashes.
+ */
+static inline int accept_subdir(const char *path, int max_depth)
+{
+	if (max_depth < 0)
+		return 1;
+
+	while ((path =3D strchr(path, '/')) !=3D NULL) {
+		max_depth--;
+		if (max_depth < 0)
+			return 0;
+		path++;
+	}
+	return 1;
+}
+
+/*
+ * Return non-zero if name is a subdirectory of match and is not too d=
eep.
+ */
+static int is_subdir(const char *name, int namelen,
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
+/*
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
@@ -692,6 +724,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			"don't match patterns in binary files",
 			GREP_BINARY_NOMATCH),
+		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, "depth",
+			"descend at most <depth> levels", PARSE_OPT_NONEG,
+			NULL, 1 },
 		OPT_GROUP(""),
 		OPT_BIT('E', "extended-regexp", &opt.regflags,
 			"use extended POSIX regular expressions", REG_EXTENDED),
@@ -768,6 +803,7 @@ int cmd_grep(int argc, const char **argv, const cha=
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
