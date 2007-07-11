From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] revision: allow selection of commits that do not
	match a pattern
Date: Wed, 11 Jul 2007 13:42:39 -0400
Message-ID: <20070711174238.GA23748@coredump.intra.peff.net>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0707071724410.4093@racer.site> <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0707071831300.4093@racer.site> <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0707071957370.4093@racer.site> <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 11 19:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8gD9-0001Pe-VI
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 19:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXGKRmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXGKRmo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 13:42:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1255 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbXGKRmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 13:42:43 -0400
Received: (qmail 11848 invoked from network); 11 Jul 2007 17:43:06 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jul 2007 17:43:06 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2007 13:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52179>

On Sun, Jul 08, 2007 at 12:57:20PM +0200, Sven Verdoolaege wrote:

> We do this by maintaining two lists of patterns, one for
> those that should match and one for those that should not match.
> 
> A negative pattern is specified by putting a '!' in front.
> For example, to show the commits of Jakub Narebski that
> are not about gitweb, you'd do a
> 
> 	git log --author='Narebski' --grep='!gitweb' --all-match

I wondered if the usage might be more natural if we could grep in
separate processes, and then build filtering pipelines (like we would
with regular grep).  For example, something like:

git-rev-list HEAD |
  git-revgrep --author=Narebski |
  git-revgrep -v gitweb |
  git-log -

However, my concern was that things might get a lot slower. And they do:

$ time git-rev-list --grep=Jeff.King HEAD >/dev/null
real    0m0.553s
user    0m0.532s
sys     0m0.020s

$ time git-rev-list HEAD | git-revgrep Jeff.King >/dev/null
real    0m0.662s
user    0m1.072s
sys     0m0.036s

(note the user time -- it's a dual-CPU box, so the wall clock time is
deceptive).

So it really does double your time (or triple, if you have a second
revgrep, and so forth (although as you filter out commits the cost of
each successive revgrep goes down)).  So it's probably not worth
pursuing this approach, but I thought I would throw it out there to
document my dead-end.

Quick and dirty git-revgrep code is below.

-Peff

---
diff --git a/Makefile b/Makefile
index d7541b4..baaf4f1 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,8 @@ BUILTIN_OBJS = \
 	builtin-verify-pack.o \
 	builtin-write-tree.o \
 	builtin-show-ref.o \
-	builtin-pack-refs.o
+	builtin-pack-refs.o \
+	builtin-revgrep.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/builtin-revgrep.c b/builtin-revgrep.c
new file mode 100644
index 0000000..35993c8
--- /dev/null
+++ b/builtin-revgrep.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+#include "commit.h"
+#include "grep.h"
+
+static int revgrep_one(const struct commit *commit, struct grep_opt *opt)
+{
+	return grep_buffer(opt, NULL, commit->buffer, strlen(commit->buffer));
+}
+
+static void revgrep_filter(struct grep_opt *opt)
+{
+	char line[1000];
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (line[len - 1] == '\n')
+			line[--len] = 0;
+		if (!len)
+			break;
+		get_sha1_hex(line, sha1);
+		commit = lookup_commit_reference(sha1);
+		if (!commit)
+			continue;
+		if (revgrep_one(commit, opt))
+			printf("%s\n", line);
+	}
+}
+
+int cmd_revgrep(int argc, const char **argv, const char *prefix)
+{
+	struct grep_opt opt;
+
+	memset(&opt, 0, sizeof(opt));
+	opt.pattern_tail = &opt.pattern_list;
+	opt.status_only = 1;
+
+	while (1 < argc) {
+		const char *arg = argv[1];
+		argc--; argv++;
+
+		if (!strcmp(arg, "-i")) {
+			opt.regflags |= REG_ICASE;
+			continue;
+		}
+		if (!strcmp(arg, "-v")) {
+			opt.invert = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-E")) {
+			opt.regflags |= REG_EXTENDED;
+			continue;
+		}
+
+		append_grep_pattern(&opt, arg, "command line", 0,
+				GREP_PATTERN);
+	}
+
+	if (!opt.pattern_list)
+		die("no pattern given");
+
+	compile_grep_patterns(&opt);
+	revgrep_filter(&opt);
+	free_grep_patterns(&opt);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 661a92f..d185528 100644
--- a/builtin.h
+++ b/builtin.h
@@ -82,5 +82,6 @@ extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
+extern int cmd_revgrep(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index a647f9c..d9ec129 100644
--- a/git.c
+++ b/git.c
@@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "revgrep", cmd_revgrep, RUN_SETUP },
 	};
 	int i;
 






> 
> As an added bonus, this patch also documents --all-match.
> 
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
>  Documentation/git-rev-list.txt |   17 ++++++++++
>  revision.c                     |   64 +++++++++++++++++++++++++++++++++------
>  revision.h                     |    1 +
>  3 files changed, 72 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 20dcac6..c462f5d 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -214,11 +214,19 @@ limiting may be applied.
>  
>  	Limit the commits output to ones with author/committer
>  	header lines that match the specified pattern (regular expression).
> +	A pattern starting with a '!' will show only commits that do
> +	not match the remainder of the pattern.
> +	To match lines starting with '!', escape the initial '!'
> +	with a backslash.
>  
>  --grep='pattern'::
>  
>  	Limit the commits output to ones with log message that
>  	matches the specified pattern (regular expression).
> +	A pattern starting with a '!' will show only commits that do
> +	not match the remainder of the pattern.
> +	To match lines starting with '!', escape the initial '!'
> +	with a backslash.
>  
>  --regexp-ignore-case::
>  
> @@ -229,6 +237,15 @@ limiting may be applied.
>  	Consider the limiting patterns to be extended regular expressions
>  	instead of the default basic regular expressions.
>  
> +--all-match::
> +
> +	Without this option, a commit is shown if any of the
> +	(positive or negative) patterns matches, i.e., there
> +	is at least one positive match or not all of the negative
> +	patterns match.  With this options, a commit is only
> +	shown if all of the patterns match, i.e., all positive
> +	patterns match and no negative pattern matches.
> +
>  --remove-empty::
>  
>  	Stop when a given path disappears from the tree.
> diff --git a/revision.c b/revision.c
> index 5184716..0035d40 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -821,34 +821,50 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
>  	return 0;
>  }
>  
> -static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
> +static void add_grep(struct rev_info *revs, const char *ptn,
> +		    enum grep_pat_token what)
>  {
> -	if (!revs->grep_filter) {
> +	int negated = 0;
> +	struct grep_opt **filter;
> +
> +	if (ptn[0] == '\\' && ptn[1] == '!')
> +		ptn++;
> +	if (*ptn == '!') {
> +		negated = 1;
> +		ptn++;
> +	}
> +	filter = negated ? &revs->grep_neg_filter : &revs->grep_filter;
> +	if (!*filter) {
>  		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
>  		opt->status_only = 1;
>  		opt->pattern_tail = &(opt->pattern_list);
>  		opt->regflags = REG_NEWLINE;
> -		revs->grep_filter = opt;
> +		*filter = opt;
>  	}
> -	append_grep_pattern(revs->grep_filter, ptn,
> -			    "command line", 0, what);
> +	append_grep_pattern(*filter, ptn, "command line", 0, what);
>  }
>  
> -static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
> +static void add_header_grep(struct rev_info *revs, const char *field,
> +			    const char *pattern)
>  {
>  	char *pat;
> -	const char *prefix;
> +	const char *prefix, *negated;
>  	int patlen, fldlen;
>  
>  	fldlen = strlen(field);
>  	patlen = strlen(pattern);
>  	pat = xmalloc(patlen + fldlen + 10);
> +	negated = "";
> +	if (*pattern == '!') {
> +		negated = "!";
> +		pattern++;
> +	}
>  	prefix = ".*";
>  	if (*pattern == '^') {
>  		prefix = "";
>  		pattern++;
>  	}
> -	sprintf(pat, "^%s %s%s", field, prefix, pattern);
> +	sprintf(pat, "%s^%s %s%s", negated, field, prefix, pattern);
>  	add_grep(revs, pat, GREP_PATTERN_HEAD);
>  }
>  
> @@ -1212,6 +1228,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  	if (revs->grep_filter)
>  		revs->grep_filter->regflags |= regflags;
>  
> +	if (revs->grep_neg_filter)
> +		revs->grep_neg_filter->regflags |= regflags;
> +
>  	if (show_merge)
>  		prepare_show_merge(revs);
>  	if (def && !revs->pending.nr) {
> @@ -1249,6 +1268,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  		compile_grep_patterns(revs->grep_filter);
>  	}
>  
> +	if (revs->grep_neg_filter) {
> +		revs->grep_neg_filter->all_match = !all_match;
> +		compile_grep_patterns(revs->grep_neg_filter);
> +	}
> +
>  	return left;
>  }
>  
> @@ -1327,11 +1351,31 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
>  	return 0;
>  }
>  
> +/*
> + * If all_match is set, then a commit matches if all the positive
> + * patterns match and not one of the negative patterns matches.
> + * If all_match is not set, then a commit matches if at least one
> + * of the positive patterns matches or not all of the negative
> + * patterns match.
> + */
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
> -	if (!opt->grep_filter)
> +	int pos_match, all_match;
> +
> +	pos_match = !opt->grep_filter ||
> +		    grep_buffer(opt->grep_filter,
> +			   NULL, /* we say nothing, not even filename */
> +			   commit->buffer, strlen(commit->buffer));
> +	if (!opt->grep_neg_filter)
> +		return pos_match;
> +
> +	all_match = !opt->grep_neg_filter->all_match;
> +	if (!all_match && opt->grep_filter && pos_match)
>  		return 1;
> -	return grep_buffer(opt->grep_filter,
> +	if (all_match && !pos_match)
> +		return 0;
> +
> +	return !grep_buffer(opt->grep_neg_filter,
>  			   NULL, /* we say nothing, not even filename */
>  			   commit->buffer, strlen(commit->buffer));
>  }
> diff --git a/revision.h b/revision.h
> index f46b4d5..9728d4c 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -84,6 +84,7 @@ struct rev_info {
>  
>  	/* Filter by commit log message */
>  	struct grep_opt	*grep_filter;
> +	struct grep_opt	*grep_neg_filter;
>  
>  	/* special limits */
>  	int skip_count;
> -- 
> 1.5.3.rc0.65.ge75d-dirty
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
