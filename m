From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH/RFC] grep: Add --directories option.
Date: Fri, 10 Jul 2009 09:33:43 +0200
Message-ID: <4A56EED7.9040008@lsrfire.ath.cx>
References: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 09:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPAcK-0007tk-DY
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 09:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZGJHdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 03:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZGJHdx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 03:33:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:45714 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZGJHdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 03:33:53 -0400
Received: from [10.0.1.101] (p57B7B9E1.dip.t-dialin.net [87.183.185.225])
	by india601.server4you.de (Postfix) with ESMTPSA id 91A832F8037;
	Fri, 10 Jul 2009 09:33:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123041>

Micha=C5=82 Kiedrowicz schrieb:
> Sometimes it is useful to grep directories non-recursive. E.g. if I w=
ant
> to look for all files in main directory, but not in any subdirectory.
> Or in Documentation/, but not in Documentation/technical/ and so on.
>=20
> This patch adds support for GNU grep compatible option
> "--directories=3Daction" to git-grep. Currently supported actions are=
:
> recurse (default) and skip. Action 'read' is not implemented.
>=20
> Documentation updates and simple test cases are also provided.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  Documentation/git-grep.txt |    7 ++++
>  builtin-grep.c             |   71 +++++++++++++++++++++++++++++++++-=
---------
>  t/t7002-grep.sh            |   34 ++++++++++++++++++++-
>  3 files changed, 94 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index fccb82d..1c4b1ff 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [-z | --null]
>  	   [-c | --count] [--all-match]
> +	   [(-d|--directories) <action>]
>  	   [--color | --no-color]
>  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
>  	   [-f <file>] [-e] <pattern>
> @@ -47,6 +48,12 @@ OPTIONS
>  -I::
>  	Don't match the pattern in binary files.
> =20
> +-d <action>::
> +--directories=3D<action>::
> +	If an input file is a directory, use `action` to process it. If
> +	`action` is recurse (default), read all files under each directory,
> +	recursively. If `action` is skip, directories are skipped.

Perhaps quote 'recurse' and 'skip'?

> +
>  -w::
>  --word-regexp::
>  	Match the pattern only at word boundary (either begin at the
> diff --git a/builtin-grep.c b/builtin-grep.c
> index e558368..27330e8 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -45,27 +45,34 @@ static int grep_config(const char *var, const cha=
r *value, void *cb)
>  	return git_color_default_config(var, value, cb);
>  }
> =20
> +static inline int accept_subdir(const char *path, int recurse)
> +{
> +	return recurse || !strchr(path, '/');
> +}
> +
>  /*
>   * git grep pathspecs are somewhat different from diff-tree pathspec=
s;
>   * pathname wildcards are allowed.
>   */
> -static int pathspec_matches(const char **paths, const char *name)
> +static int pathspec_matches(const char **paths, const char *name, in=
t recurse)
>  {
>  	int namelen, i;
>  	if (!paths || !*paths)
> -		return 1;
> +		return accept_subdir(name, recurse);
>  	namelen =3D strlen(name);
>  	for (i =3D 0; paths[i]; i++) {
>  		const char *match =3D paths[i];
>  		int matchlen =3D strlen(match);
>  		const char *cp, *meta;
> =20
> -		if (!matchlen ||
> +		if ((!matchlen && accept_subdir(name, recurse)) ||
>  		    ((matchlen <=3D namelen) &&
>  		     !strncmp(name, match, matchlen) &&
> -		     (match[matchlen-1] =3D=3D '/' ||
> -		      name[matchlen] =3D=3D '\0' || name[matchlen] =3D=3D '/')))
> +		     (name[matchlen] =3D=3D '\0' ||
> +		       ((match[matchlen-1] =3D=3D '/'|| name[matchlen] =3D=3D '/')=
 &&
> +			accept_subdir(name + matchlen + 1, recurse))))) {
>  			return 1;
> +		}
>  		if (!fnmatch(match, name, 0))
>  			return 1;
>  		if (name[namelen-1] !=3D '/')
> @@ -307,7 +314,8 @@ static void grep_add_color(struct strbuf *sb, con=
st char *escape_seq)
>  		strbuf_setlen(sb, sb->len - 1);
>  }
> =20
> -static int external_grep(struct grep_opt *opt, const char **paths, i=
nt cached)
> +static int external_grep(struct grep_opt *opt, const char **paths, i=
nt cached,
> +		int recurse)
>  {
>  	int i, nr, argc, hit, len, status;
>  	const char *argv[MAXARGS+1];
> @@ -403,7 +411,7 @@ static int external_grep(struct grep_opt *opt, co=
nst char **paths, int cached)
>  		int kept;
>  		if (!S_ISREG(ce->ce_mode))
>  			continue;
> -		if (!pathspec_matches(paths, ce->name))
> +		if (!pathspec_matches(paths, ce->name, recurse))
>  			continue;
>  		name =3D ce->name;
>  		if (name[0] =3D=3D '-') {
> @@ -437,7 +445,7 @@ static int external_grep(struct grep_opt *opt, co=
nst char **paths, int cached)
>  #endif
> =20
>  static int grep_cache(struct grep_opt *opt, const char **paths, int =
cached,
> -		      int external_grep_allowed)
> +		      int external_grep_allowed, int recurse)
>  {
>  	int hit =3D 0;
>  	int nr;
> @@ -450,7 +458,7 @@ static int grep_cache(struct grep_opt *opt, const=
 char **paths, int cached,
>  	 * be a lot more optimized
>  	 */
>  	if (!cached && external_grep_allowed) {
> -		hit =3D external_grep(opt, paths, cached);
> +		hit =3D external_grep(opt, paths, cached, recurse);
>  		if (hit >=3D 0)
>  			return hit;
>  	}
> @@ -460,7 +468,7 @@ static int grep_cache(struct grep_opt *opt, const=
 char **paths, int cached,
>  		struct cache_entry *ce =3D active_cache[nr];
>  		if (!S_ISREG(ce->ce_mode))
>  			continue;
> -		if (!pathspec_matches(paths, ce->name))
> +		if (!pathspec_matches(paths, ce->name, recurse))
>  			continue;
>  		/*
>  		 * If CE_VALID is on, we assume worktree file and its cache entry
> @@ -488,7 +496,8 @@ static int grep_cache(struct grep_opt *opt, const=
 char **paths, int cached,
> =20
>  static int grep_tree(struct grep_opt *opt, const char **paths,
>  		     struct tree_desc *tree,
> -		     const char *tree_name, const char *base)
> +		     const char *tree_name, const char *base,
> +		     int recurse)
>  {
>  	int len;
>  	int hit =3D 0;
> @@ -520,7 +529,7 @@ static int grep_tree(struct grep_opt *opt, const =
char **paths,
>  			strbuf_addch(&pathbuf, '/');
> =20
>  		down =3D pathbuf.buf + tn_len;
> -		if (!pathspec_matches(paths, down))
> +		if (!pathspec_matches(paths, down, recurse))
>  			;
>  		else if (S_ISREG(entry.mode))
>  			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
> @@ -535,7 +544,8 @@ static int grep_tree(struct grep_opt *opt, const =
char **paths,
>  				die("unable to read tree (%s)",
>  				    sha1_to_hex(entry.sha1));
>  			init_tree_desc(&sub, data, size);
> -			hit |=3D grep_tree(opt, paths, &sub, tree_name, down);
> +			hit |=3D grep_tree(opt, paths, &sub, tree_name, down,
> +					recurse);
>  			free(data);
>  		}
>  	}
> @@ -544,7 +554,7 @@ static int grep_tree(struct grep_opt *opt, const =
char **paths,
>  }
> =20
>  static int grep_object(struct grep_opt *opt, const char **paths,
> -		       struct object *obj, const char *name)
> +		       struct object *obj, const char *name, int recurse)
>  {
>  	if (obj->type =3D=3D OBJ_BLOB)
>  		return grep_sha1(opt, obj->sha1, name, 0);
> @@ -558,7 +568,7 @@ static int grep_object(struct grep_opt *opt, cons=
t char **paths,
>  		if (!data)
>  			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
>  		init_tree_desc(&tree, data, size);
> -		hit =3D grep_tree(opt, paths, &tree, name, "");
> +		hit =3D grep_tree(opt, paths, &tree, name, "", recurse);
>  		free(data);
>  		return hit;
>  	}
> @@ -648,10 +658,32 @@ static int help_callback(const struct option *o=
pt, const char *arg, int unset)
>  	return -1;
>  }
> =20
> +static int directories_callback(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	int *recurse =3D opt->value;
> +
> +	if (!arg)
> +		return error("switch `d' requires a value");
> +
> +	if (!strcmp(arg, "recurse")) {
> +		*recurse =3D 1;
> +		return 0;
> +	} else if (!strcmp(arg, "skip")) {
> +		*recurse =3D 0;
> +		return 0;
> +	}
> +
> +	fprintf(stderr, "Invalid action `%s'.\n", arg);
> +	fprintf(stderr, "Available actions are: recurse skip.\n");
> +	return -1;
> +}
> +
>  int cmd_grep(int argc, const char **argv, const char *prefix)
>  {
>  	int hit =3D 0;
>  	int cached =3D 0;
> +	int recurse =3D 1;

I suspect the patch would shrink significantly if you moved "int
recurse" into struct grep_opt, because then you wouln't need to add it
as a parameter to the grep_* functions.

> diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
> index 7868af8..6d1faf4 100755
> --- a/t/t7002-grep.sh
> +++ b/t/t7002-grep.sh
> @@ -22,7 +22,9 @@ test_expect_success setup '
>  	echo zzz > z &&
>  	mkdir t &&
>  	echo test >t/t &&
> -	git add file w x y z t/t &&
> +	mkdir t/a &&
> +	echo aa aa aa aa >t/a/a &&
> +	git add file w x y z t/t t/a/a &&

This conflicts with a recent change.

It seems your patch still allows recursion, one level deep.  In git's r=
epo:

	$ grep -l --directories=3Dskip GNU compat

	$ grep -l --directories=3Dskip GNU compat/*
	compat/qsort.c
	compat/snprintf.c

	$ git grep -l --directories=3Dskip GNU compat
	compat/qsort.c
	compat/snprintf.c

	$ git grep -l --directories=3Dskip GNU compat/*
	compat/fnmatch/fnmatch.c
	compat/fnmatch/fnmatch.h
	compat/nedmalloc/malloc.c.h
	compat/nedmalloc/nedmalloc.c
	compat/nedmalloc/nedmalloc.h
	compat/qsort.c
	compat/regex/regex.c
	compat/regex/regex.h
	compat/snprintf.c

Ren=C3=A9
