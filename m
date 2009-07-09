From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH/RFC] grep: Add --directories option.
Date: Thu,  9 Jul 2009 21:20:28 +0200
Message-ID: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 21:21:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOzBT-00031J-7B
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZGITVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2009 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZGITVX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 15:21:23 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38285 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZGITVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 15:21:22 -0400
Received: by fxm18 with SMTP id 18so404267fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=3LaJyHkTsJnZ24kkr0eYEOy5mhg5Qn6lUDEAyJzAxEU=;
        b=wbaRPDCS93TNmchndCvRRg+E0I2TeKr+w00Vvvr+gblMmkT8BDibWM9A+jk1VSWNUq
         vHScaJKUapARgmRv7xoGqrjXiN7uxH1lKPDNgoevXwM6OSVCalF+1nQIPlTdF3IMLGeA
         a6ITt4S1TLkQB2v2iC7F/zeiFBHwwhUj6HTXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=kaof/QoMmbGERd2YYRDa/PxNXvTtUz7fuugENy/sWhE/Lot9sDFbhv6Fl9z2eszbL1
         UJVMS+iLJGuQgW/eLaU1RY/oliWjLFp2uE1mNruyWGOQPPPoNJPBLc7lLp5X1gJOaQ3m
         lbXGSxpCO4/DRryUmC6Plot0cctK+X5nLo8h4=
Received: by 10.204.119.70 with SMTP id y6mr1049237bkq.72.1247167279803;
        Thu, 09 Jul 2009 12:21:19 -0700 (PDT)
Received: from localhost (87-205-49-23.adsl.inetia.pl [87.205.49.23])
        by mx.google.com with ESMTPS id 2sm401767fks.33.2009.07.09.12.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 12:21:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123003>

Sometimes it is useful to grep directories non-recursive. E.g. if I wan=
t
to look for all files in main directory, but not in any subdirectory.
Or in Documentation/, but not in Documentation/technical/ and so on.

This patch adds support for GNU grep compatible option
"--directories=3Daction" to git-grep. Currently supported actions are:
recurse (default) and skip. Action 'read' is not implemented.

Documentation updates and simple test cases are also provided.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-grep.txt |    7 ++++
 builtin-grep.c             |   71 +++++++++++++++++++++++++++++++++---=
-------
 t/t7002-grep.sh            |   34 ++++++++++++++++++++-
 3 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fccb82d..1c4b1ff 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-z | --null]
 	   [-c | --count] [--all-match]
+	   [(-d|--directories) <action>]
 	   [--color | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
@@ -47,6 +48,12 @@ OPTIONS
 -I::
 	Don't match the pattern in binary files.
=20
+-d <action>::
+--directories=3D<action>::
+	If an input file is a directory, use `action` to process it. If
+	`action` is recurse (default), read all files under each directory,
+	recursively. If `action` is skip, directories are skipped.
+
 -w::
 --word-regexp::
 	Match the pattern only at word boundary (either begin at the
diff --git a/builtin-grep.c b/builtin-grep.c
index e558368..27330e8 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -45,27 +45,34 @@ static int grep_config(const char *var, const char =
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
@@ -307,7 +314,8 @@ static void grep_add_color(struct strbuf *sb, const=
 char *escape_seq)
 		strbuf_setlen(sb, sb->len - 1);
 }
=20
-static int external_grep(struct grep_opt *opt, const char **paths, int=
 cached)
+static int external_grep(struct grep_opt *opt, const char **paths, int=
 cached,
+		int recurse)
 {
 	int i, nr, argc, hit, len, status;
 	const char *argv[MAXARGS+1];
@@ -403,7 +411,7 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 		int kept;
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, recurse))
 			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
@@ -437,7 +445,7 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 #endif
=20
 static int grep_cache(struct grep_opt *opt, const char **paths, int ca=
ched,
-		      int external_grep_allowed)
+		      int external_grep_allowed, int recurse)
 {
 	int hit =3D 0;
 	int nr;
@@ -450,7 +458,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 	 * be a lot more optimized
 	 */
 	if (!cached && external_grep_allowed) {
-		hit =3D external_grep(opt, paths, cached);
+		hit =3D external_grep(opt, paths, cached, recurse);
 		if (hit >=3D 0)
 			return hit;
 	}
@@ -460,7 +468,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name))
+		if (!pathspec_matches(paths, ce->name, recurse))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -488,7 +496,8 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
=20
 static int grep_tree(struct grep_opt *opt, const char **paths,
 		     struct tree_desc *tree,
-		     const char *tree_name, const char *base)
+		     const char *tree_name, const char *base,
+		     int recurse)
 {
 	int len;
 	int hit =3D 0;
@@ -520,7 +529,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 			strbuf_addch(&pathbuf, '/');
=20
 		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(paths, down))
+		if (!pathspec_matches(paths, down, recurse))
 			;
 		else if (S_ISREG(entry.mode))
 			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
@@ -535,7 +544,8 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
-			hit |=3D grep_tree(opt, paths, &sub, tree_name, down);
+			hit |=3D grep_tree(opt, paths, &sub, tree_name, down,
+					recurse);
 			free(data);
 		}
 	}
@@ -544,7 +554,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 }
=20
 static int grep_object(struct grep_opt *opt, const char **paths,
-		       struct object *obj, const char *name)
+		       struct object *obj, const char *name, int recurse)
 {
 	if (obj->type =3D=3D OBJ_BLOB)
 		return grep_sha1(opt, obj->sha1, name, 0);
@@ -558,7 +568,7 @@ static int grep_object(struct grep_opt *opt, const =
char **paths,
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, paths, &tree, name, "");
+		hit =3D grep_tree(opt, paths, &tree, name, "", recurse);
 		free(data);
 		return hit;
 	}
@@ -648,10 +658,32 @@ static int help_callback(const struct option *opt=
, const char *arg, int unset)
 	return -1;
 }
=20
+static int directories_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	int *recurse =3D opt->value;
+
+	if (!arg)
+		return error("switch `d' requires a value");
+
+	if (!strcmp(arg, "recurse")) {
+		*recurse =3D 1;
+		return 0;
+	} else if (!strcmp(arg, "skip")) {
+		*recurse =3D 0;
+		return 0;
+	}
+
+	fprintf(stderr, "Invalid action `%s'.\n", arg);
+	fprintf(stderr, "Available actions are: recurse skip.\n");
+	return -1;
+}
+
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit =3D 0;
 	int cached =3D 0;
+	int recurse =3D 1;
 	int external_grep_allowed =3D 1;
 	int seen_dashdash =3D 0;
 	struct grep_opt opt;
@@ -674,6 +706,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			"don't match patterns in binary files",
 			GREP_BINARY_NOMATCH),
+		OPT_CALLBACK('d', "directories", &recurse, "action",
+			"action to perform when input file is a directory",
+			directories_callback),
 		OPT_GROUP(""),
 		OPT_BIT('E', "extended-regexp", &opt.regflags,
 			"use extended POSIX regular expressions", REG_EXTENDED),
@@ -830,7 +865,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
-		return !grep_cache(&opt, paths, cached, external_grep_allowed);
+		return !grep_cache(&opt, paths, cached, external_grep_allowed,
+				recurse);
 	}
=20
 	if (cached)
@@ -839,7 +875,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	for (i =3D 0; i < list.nr; i++) {
 		struct object *real_obj;
 		real_obj =3D deref_tag(list.objects[i].item, NULL, 0);
-		if (grep_object(&opt, paths, real_obj, list.objects[i].name))
+		if (grep_object(&opt, paths, real_obj, list.objects[i].name,
+					recurse))
 			hit =3D 1;
 	}
 	free_grep_patterns(&opt);
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 7868af8..6d1faf4 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -22,7 +22,9 @@ test_expect_success setup '
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file w x y z t/t &&
+	mkdir t/a &&
+	echo aa aa aa aa >t/a/a &&
+	git add file w x y z t/t t/a/a &&
 	test_tick &&
 	git commit -m initial
 '
@@ -123,6 +125,36 @@ do
 		! git grep -c test $H | grep /dev/null
         '
=20
+	test_expect_success "grep -d recurse $L" '
+		echo "${HC}t/t:1:test" >expected &&
+		git grep -d recurse -n -e test $H >actual &&
+		diff expected actual
+	'
+
+	test_expect_success "grep -d skip $L" '
+		: >expected &&
+		if git grep -d skip -e test $H >actual
+		then
+			echo should not have matched
+			cat actual
+			false
+		else
+			diff expected actual
+		fi
+	'
+
+	test_expect_success "grep -d skip $L -- t" '
+		: >expected &&
+		if git grep -d skip -e aa $H -- t >actual
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
