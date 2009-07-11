From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH/RFC v2] grep: Add --[no-]recurse options.
Date: Sat, 11 Jul 2009 23:20:08 +0200
Message-ID: <1247347208-2624-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 23:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPjzn-0006xC-84
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 23:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbZGKVUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbZGKVUU
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 17:20:20 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42202 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbZGKVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 17:20:18 -0400
Received: by ewy26 with SMTP id 26so1827020ewy.37
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=b0t+tUr/fMuePLG7GTTvfHahTW46tXmJQmsz6Zu9lz0=;
        b=OQ74PUVc5spw1DwhSUgad4Qr+hwsK1jsQVlNg5gAl/zdHw/RyxMxex202OANm/KAUg
         woG70RDI+6npy9q0qApZHmSN4Fg3ccEoXX4PwZmvD0SuFfy+UUuQQI/5/LErqAbAJf3/
         +HZa2/g4cUQpNWhUYOLxHo5Qirli9AGQiuRig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RIxBGYKMmkmTZpbZyoaNTu7QdvbUtcKeE0IYeHj91As/+V8lrjIpyyvz/wBbSQelB/
         5uHXqOqtqrcQLFFV+Bz//ZK8DWjR4kcijbD0xvB3kbqyvQruWH3R0vrfEhh15fwbUZSV
         KjrPZsPnigX0Ar9LPF5QUyimBVGFO+3nFZRpY=
Received: by 10.210.132.3 with SMTP id f3mr4161329ebd.41.1247347216782;
        Sat, 11 Jul 2009 14:20:16 -0700 (PDT)
Received: from localhost (87-205-62-248.adsl.inetia.pl [87.205.62.248])
        by mx.google.com with ESMTPS id 5sm5849672eyf.54.2009.07.11.14.20.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Jul 2009 14:20:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123131>

Sometimes it is useful to grep directories non-recursive. E.g. if I wan=
t
to look for all files in main directory, but not in any subdirectory.
Or in Documentation/, but not in Documentation/technical/ and so on.

This patch adds support for --no-recurse and (for symmetry) --recurse
options to git-grep. If --no-recurse is set, git-grep does not descend
to subdirectories. When --recurse option is set, directories are
searched recursively (this is the default behavior).

If path specified on command line contains wildcards, option --no-recur=
se
makes no sense, i.e.

$ git grep -l --no-recurse GNU -- 'contrib/*'

(note the quotes) will search all files in contrib/, even in
subdirectories, because '*' matches all files.

Documentation updates, bash-completion and simple test cases are also
provided.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

Changes from previous version:
 * Renamed '--directories=3Daction' to '--[no-]recurse', because my
   implementation is not compatible with GNU. Also parsing this option =
was
   simplified.
 * Moved 'int recurse' into 'struct grep_opt'.
 * Fixed merge conflict with 'master'.
 * Added bash-completion.

 Documentation/git-grep.txt             |    7 ++++++
 builtin-grep.c                         |   27 +++++++++++++++++-------
 contrib/completion/git-completion.bash |    1 +
 grep.h                                 |    1 +
 t/t7002-grep.sh                        |   34 ++++++++++++++++++++++++=
+++++++-
 5 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b753c9d..1766d33 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-z | --null]
 	   [-c | --count] [--all-match]
+	   [--recurse | --no-recurse]
 	   [--color | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
@@ -47,6 +48,12 @@ OPTIONS
 -I::
 	Don't match the pattern in binary files.
=20
+--recurse::
+	Process directories recursively. This is the default.
+
+--no-recurse::
+	Do not descend to subdirectories.
+
 -w::
 --word-regexp::
 	Match the pattern only at word boundary (either begin at the
diff --git a/builtin-grep.c b/builtin-grep.c
index f477659..28e980a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -52,27 +52,34 @@ static int grep_config(const char *var, const char =
*value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
=20
+static inline int accept_subdir(const char *path, int recurse)
+{
+	return recurse || !strchr(path, '/');
+}
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
  */
-static int pathspec_matches(const char **paths, const char *name)
+static int pathspec_matches(const char **paths, const char *name, int =
recurse)
 {
 	int namelen, i;
 	if (!paths || !*paths)
-		return 1;
+		return accept_subdir(name, recurse);
 	namelen =3D strlen(name);
 	for (i =3D 0; paths[i]; i++) {
 		const char *match =3D paths[i];
 		int matchlen =3D strlen(match);
 		const char *cp, *meta;
=20
-		if (!matchlen ||
+		if ((!matchlen && accept_subdir(name, recurse)) ||
 		    ((matchlen <=3D namelen) &&
 		     !strncmp(name, match, matchlen) &&
-		     (match[matchlen-1] =3D=3D '/' ||
-		      name[matchlen] =3D=3D '\0' || name[matchlen] =3D=3D '/')))
+		     (name[matchlen] =3D=3D '\0' ||
+		       ((match[matchlen-1] =3D=3D '/'|| name[matchlen] =3D=3D '/') &=
&
+			accept_subdir(name + matchlen + 1, recurse))))) {
 			return 1;
+		}
 		if (!fnmatch(match, name, 0))
 			return 1;
 		if (name[namelen-1] !=3D '/')
@@ -421,7 +428,7 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 		int kept;
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, opt->recurse))
 			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
@@ -478,7 +485,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, opt->recurse))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -538,7 +545,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 			strbuf_addch(&pathbuf, '/');
=20
 		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(paths, down))
+		if (!pathspec_matches(paths, down, opt->recurse))
 			;
 		else if (S_ISREG(entry.mode))
 			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
@@ -692,6 +699,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			"don't match patterns in binary files",
 			GREP_BINARY_NOMATCH),
+		OPT_BOOLEAN(0, "recurse", &opt.recurse,
+				"search directories recursively"),
 		OPT_GROUP(""),
 		OPT_BIT('E', "extended-regexp", &opt.regflags,
 			"use extended POSIX regular expressions", REG_EXTENDED),
@@ -775,6 +784,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	if (opt.color =3D=3D -1)
 		opt.color =3D git_use_color_default;
=20
+	opt.recurse =3D 1;
+
 	/*
 	 * If there is no -- then the paths must exist in the working
 	 * tree.  If there is no explicit pattern specified with -e or
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 9c48864..5eec3cc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1036,6 +1036,7 @@ _git_grep ()
 			--extended-regexp --basic-regexp --fixed-strings
 			--files-with-matches --name-only
 			--files-without-match
+			--recurse --no-recurse
 			--count
 			--and --or --not --all-match
 			"
diff --git a/grep.h b/grep.h
index f00db0e..6badf51 100644
--- a/grep.h
+++ b/grep.h
@@ -79,6 +79,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int color;
+	int recurse;
 	int funcname;
 	char color_match[COLOR_MAXLEN];
 	const char *color_external;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index b13aa7e..0633673 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -31,7 +31,9 @@ test_expect_success setup '
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file w x y z t/t hello.c &&
+	mkdir t/a &&
+	echo aa aa aa aa >t/a/a &&
+	git add file w x y z t/t t/a/a hello.c &&
 	test_tick &&
 	git commit -m initial
 '
@@ -132,6 +134,36 @@ do
 		! git grep -c test $H | grep /dev/null
         '
=20
+	test_expect_success "grep --recurse $L" '
+		echo "${HC}t/t:1:test" >expected &&
+		git grep --recurse -n -e test $H >actual &&
+		diff expected actual
+	'
+
+	test_expect_success "grep --no-recurse $L" '
+		: >expected &&
+		if git grep --no-recurse -e test $H >actual
+		then
+			echo should not have matched
+			cat actual
+			false
+		else
+			diff expected actual
+		fi
+	'
+
+	test_expect_success "grep --no-recurse $L -- t" '
+		: >expected &&
+		if git grep --no-recurse -e aa $H -- t >actual
+		then
+			echo should not have matched
+			cat actual
+			false
+		else
+			diff expected actual
+		fi
+	'
+
 done
=20
 cat >expected <<EOF
--=20
1.6.3.3
