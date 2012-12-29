From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 19/19] Add git-check-ignore sub-command
Date: Sat, 29 Dec 2012 01:23:52 +0000
Message-ID: <20121229012352.GA20379@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-20-git-send-email-git@adamspiers.org>
 <7vtxr5ho01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 02:39:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TolOi-0004Et-Jj
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 02:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab2L2BX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 20:23:56 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:56393 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab2L2BXz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 20:23:55 -0500
Received: from localhost (4.3.9.7.e.0.7.1.0.6.0.d.f.d.0.5.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:50df:d060:170e:7934])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D341B2E5D3
	for <git@vger.kernel.org>; Sat, 29 Dec 2012 01:23:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vtxr5ho01.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212281>

On Fri, Dec 28, 2012 at 01:21:02PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> > +static void output_exclude(const char *path, struct exclude *exclude)
> > +{
> > +	char *bang = exclude->flags & EXC_FLAG_NEGATIVE ? "!" : "";
> > +	char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
> 
> That's inconsistent.  Either s/bang/negated/ or s/dir/slash/ (but
> obviously not both).

OK.  I'll make the use of parentheses there consistent too.

> > +static int check_ignore(const char *prefix, const char **pathspec)
> > +{
> > +	struct dir_struct dir;
> > +...
> > +	if (pathspec) {
> > +...
> > +	} else {
> > +		printf("no pathspec\n");
> > +	}
> 
> Is this an error message, an informative warning, or what?  The
> command is presumably for script consumption downstream of a pipe.
> Does it make sense to emit this message to their standard input?
> Does it even have to be output?  Especially what should happen when
> the user says "--quiet"?
>
> Perhaps
> 
> 	if (!quiet)
> 		fprintf(stderr, "no pathspec given.\n");
> 
> or something?

Hmm.  I suspect this was an unfinished remnant of one of my early
prototypes, because this code path never gets hit.  There's even a
test which checks that a fatal error is generated when no pathspecs
are given via argv.  

However, the test for behaviour when no pathspecs are given via
--stdin *is* missing.  In this case, I think the code you suggest
above makes sense for generating a warning, and the existing behaviour
of returning an exit code of 1 also seems correct.  I have added your
code and a test to cover it.

> > +int cmd_check_ignore(int argc, const char **argv, const char *prefix)
> > +{
> > +	int num_ignored = 0;
> 
> I do not think you need to initialize this one.

Fixed.

> > +	if (stdin_paths) {
> > +		num_ignored = check_ignore_stdin_paths(prefix);
> > +	} else {
> > +		num_ignored = check_ignore(prefix, argv);
> > +		maybe_flush_or_die(stdout, "ignore to stdout");
> > +	}
> > +
> > +	return num_ignored > 0 ? 0 : 1;
> 
> Given that num_ignored will always be >=0, that is a funny way to
> say
> 
> 	return !num_ignored;

Personally I find that harder to read, but I'm not a regular C
programmer so I'll defer to your sense of style.

> or if you plan to report a non-fatal error as negative return from
> the two check_ignore* functions,

I don't think that's necessary here, but I'll bear it in mind.

> > +stderr_contains () {
> > +	regexp="$1"
> > +	if grep -q "$regexp" "$HOME/stderr"
> 
> Please do not use "grep -q"; the output from commands in test
> harness is normally hidden already.  This only makes script more
> cluttered and robs debuggers of potentially useful output when the
> test script is run with "-v".

Fixed.

> > +test_check_ignore () {
> > +	args="$1" expect_code="${2:-0}" global_args="$3"
> > +
> > +	init_vars &&
> > +	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
> > +	echo git $global_args check-ignore $quiet_opt $verbose_opt $args \
> > +		>"$HOME/cmd" &&
> 
> Does a debugger needs this "cmd" file when we already have "-v" option?

Yes, I think it's useful; for example:

    $ ./t0008-ignores.sh -i -v

    [... test fails ...]

    $ cd trash\ directory.t0008-ignores
    $ gdb --args ../../$(<cmd)

> > +test_expect_success_multi () {
> > +	prereq=
> > +	if test $# -eq 4
> > +	then
> > +		prereq=$1
> > +		shift
> > +	fi
> > +	testname="$1" expect_verbose="$2" code="$3"
> > +
> > +	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
> > +
> > +	test_expect_success $prereq "$testname" "
> > +		expect '$expect' &&
> > +		$code
> > +	"
> 
> This is brittle when $expect may have single quotes, isn't it?

Currently $expect will never have single quotes, but I grant this may
change in the future.

> Perhaps
> 
> 	test_expect_success $prereq "$testname" '
> 		expect "$expect" && eval "$code"
>         '
> 
> may fix it,

Yes that works, thanks.

> but in general I hate to see each test script trying to
> invent their own mini-harness like this (and getting them wrong).

test_expect_success_multi is specific to check-ignore and avoids a
huge amount of code duplication.  I can't think of a better approach
but if you can then I'm all ears.

I believe this only leaves two items from your review of v3 which are
yet to be resolved:

1. What should validate_path() should be renamed to in order to avoid
   ambiguity with other path validation functions?  Currently my
   preferred choice is die_if_path_beyond_symlink() but I don't really
   mind - I'll go with that unless I hear someone prefers another
   name.

2. The now-public functions fill_pathspec_matches() and
   find_used_pathspec(), need to be documented, and in particular need
   to mention that they traverse the index not a tree or the working
   directory.  I'll work on improving my understanding of these
   functions to the point where I can document them accurately (but
   hints are still welcome).

Once these are both resolved, I'll re-roll patches 16--19 only of the
v3 series, labelled as v4.

FYI, attached is the diff between check-ignore-v3 and my current
check-ignore, which is available at github:

    https://github.com/aspiers/git/commits/check-ignore

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index c825736..06e250e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -27,8 +27,8 @@ static const struct option check_ignore_options[] = {
 
 static void output_exclude(const char *path, struct exclude *exclude)
 {
-	char *bang = exclude->flags & EXC_FLAG_NEGATIVE ? "!" : "";
-	char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	char *bang  = exclude->flags & EXC_FLAG_NEGATIVE  ? "!" : "";
+	char *slash = exclude->flags & EXC_FLAG_MUSTBEDIR ? "/" : "";
 	if (!null_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
@@ -36,7 +36,7 @@ static void output_exclude(const char *path, struct exclude *exclude)
 			quote_c_style(exclude->el->src, NULL, stdout, 0);
 			printf(":%d:%s%s%s\t",
 			       exclude->srcpos,
-			       bang, exclude->pattern, dir);
+			       bang, exclude->pattern, slash);
 			quote_c_style(path, NULL, stdout, 0);
 			fputc('\n', stdout);
 		}
@@ -47,7 +47,7 @@ static void output_exclude(const char *path, struct exclude *exclude)
 			printf("%s%c%d%c%s%s%s%c%s%c",
 			       exclude->el->src, '\0',
 			       exclude->srcpos, '\0',
-			       bang, exclude->pattern, dir, '\0',
+			       bang, exclude->pattern, slash, '\0',
 			       path, '\0');
 		}
 	}
@@ -57,8 +57,10 @@ static int check_ignore(const char *prefix, const char **pathspec)
 {
 	struct dir_struct dir;
 	const char *path;
-	char *seen = NULL;
-	int num_ignored = 0;
+	char *seen;
+	int num_ignored = 0, i;
+	struct path_exclude_check check;
+	struct exclude *exclude;
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
 	if (read_cache() < 0)
@@ -68,38 +70,36 @@ static int check_ignore(const char *prefix, const char **pathspec)
 	dir.flags |= DIR_COLLECT_IGNORED;
 	setup_standard_excludes(&dir);
 
-	if (pathspec) {
-		int i;
-		struct path_exclude_check check;
-		struct exclude *exclude;
-
-		path_exclude_check_init(&check, &dir);
-		if (!seen)
-			seen = find_used_pathspec(pathspec);
-		for (i = 0; pathspec[i]; i++) {
-			const char *full_path;
-			path = pathspec[i];
-			full_path = prefix_path(prefix, prefix
-						? strlen(prefix) : 0, path);
-			full_path = treat_gitlink(full_path);
-			validate_path(full_path, prefix);
-			if (!seen[i] && path[0]) {
-				int dtype = DT_UNKNOWN;
-				exclude = last_exclude_matching_path(&check, full_path,
-								     -1, &dtype);
-				if (exclude) {
-					if (!quiet)
-						output_exclude(path, exclude);
-					num_ignored++;
-				}
+	if (!pathspec || !*pathspec) {
+		if (!quiet)
+			fprintf(stderr, "no pathspec given.\n");
+		return 0;
+	}
+
+	path_exclude_check_init(&check, &dir);
+	seen = find_used_pathspec(pathspec);
+	for (i = 0; pathspec[i]; i++) {
+		const char *full_path;
+		path = pathspec[i];
+		full_path = prefix_path(prefix, prefix
+					? strlen(prefix) : 0, path);
+		full_path = treat_gitlink(full_path);
+		die_if_path_beyond_symlink(full_path, prefix);
+		if (!seen[i] && path[0]) {
+			int dtype = DT_UNKNOWN;
+			exclude = last_exclude_matching_path(&check, full_path,
+							     -1, &dtype);
+			if (exclude) {
+				if (!quiet)
+					output_exclude(path, exclude);
+				num_ignored++;
 			}
 		}
-		free(seen);
-		clear_directory(&dir);
-		path_exclude_check_clear(&check);
-	} else {
-		printf("no pathspec\n");
 	}
+	free(seen);
+	clear_directory(&dir);
+	path_exclude_check_clear(&check);
+
 	return num_ignored;
 }
 
@@ -136,7 +136,7 @@ static int check_ignore_stdin_paths(const char *prefix)
 
 int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 {
-	int num_ignored = 0;
+	int num_ignored;
 
 	git_config(git_default_config, NULL);
 
@@ -144,7 +144,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 			     check_ignore_usage, 0);
 
 	if (stdin_paths) {
-		if (0 < argc)
+		if (argc > 0)
 			die(_("cannot specify pathnames with --stdin"));
 	} else {
 		if (null_term_line)
@@ -166,5 +166,5 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
-	return num_ignored > 0 ? 0 : 1;
+	return !num_ignored;
 }
diff --git a/pathspec.c b/pathspec.c
index 6724121..3789b14 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -36,9 +36,10 @@ char *find_used_pathspec(const char **pathspec)
 }
 
 /*
- * Check whether path refers to a submodule, or something inside a
- * submodule.  If the former, returns the path with any trailing slash
- * stripped.  If the latter, dies with an error message.
+ * Check the index to see whether path refers to a submodule, or
+ * something inside a submodule.  If the former, returns the path with
+ * any trailing slash stripped.  If the latter, dies with an error
+ * message.
  */
 const char *treat_gitlink(const char *path)
 {
@@ -78,9 +79,9 @@ void treat_gitlinks(const char **pathspec)
 
 /*
  * Dies if the given path refers to a file inside a symlinked
- * directory.
+ * directory in the index.
  */
-void validate_path(const char *path, const char *prefix)
+void die_if_path_beyond_symlink(const char *path, const char *prefix)
 {
 	if (has_symlink_leading_path(path, strlen(path))) {
 		int len = prefix ? strlen(prefix) : 0;
@@ -90,7 +91,8 @@ void validate_path(const char *path, const char *prefix)
 
 /*
  * Normalizes argv relative to prefix, via get_pathspec(), and then
- * runs validate_path() on each path in the normalized list.
+ * runs die_if_path_beyond_symlink() on each path in the normalized
+ * list.
  */
 const char **validate_pathspec(const char **argv, const char *prefix)
 {
@@ -99,7 +101,7 @@ const char **validate_pathspec(const char **argv, const char *prefix)
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			validate_path(*p, prefix);
+			die_if_path_beyond_symlink(*p, prefix);
 		}
 	}
 
diff --git a/pathspec.h b/pathspec.h
index c251441..1961b19 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,11 @@
+#ifndef PATHSPEC_H
+#define PATHSPEC_H
+
 extern char *find_used_pathspec(const char **pathspec);
 extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
 extern const char *treat_gitlink(const char *path);
 extern void treat_gitlinks(const char **pathspec);
 extern void validate_path(const char *path, const char *prefix);
 extern const char **validate_pathspec(const char **argv, const char *prefix);
+
+#endif /* PATHSPEC_H */
diff --git a/setup.c b/setup.c
index 03d6d5c..9570147 100644
--- a/setup.c
+++ b/setup.c
@@ -250,8 +250,12 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
 }
 
 /*
- * prefix - a path relative to the root of the working tree
- * pathspec - a list of paths underneath the prefix path
+ * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
+ * based interface - see pathspec_magic above.
+ *
+ * Arguments:
+ *  - prefix - a path relative to the root of the working tree
+ *  - pathspec - a list of paths underneath the prefix path
  *
  * Iterates over pathspec, prepending each path with prefix,
  * and return the resulting list.
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 3937ca4..8780b1e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -39,7 +39,7 @@ test_stderr () {
 
 stderr_contains () {
 	regexp="$1"
-	if grep -q "$regexp" "$HOME/stderr"
+	if grep "$regexp" "$HOME/stderr"
 	then
 		return 0
 	else
@@ -86,10 +86,10 @@ test_expect_success_multi () {
 
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
-	test_expect_success $prereq "$testname" "
-		expect '$expect' &&
-		$code
-	"
+	test_expect_success $prereq "$testname" '
+		expect "$expect" &&
+		eval "$code"
+	'
 
 	for quiet_opt in '-q' '--quiet'
 	do
@@ -164,6 +164,15 @@ test_expect_success_multi 'empty command line' '' '
 	stderr_contains "fatal: no path specified"
 '
 
+test_expect_success_multi '--stdin with empty STDIN' '' '
+	test_check_ignore "--stdin" 1 </dev/null &&
+	if test -n "$quiet_opt"; then
+		test_stderr ""
+	else
+		test_stderr "no pathspec given."
+	fi
+'
+
 test_expect_success '-q with multiple args' '
 	expect "" &&
 	test_check_ignore "-q one two" 128 &&
