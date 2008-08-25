From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix "git log -i --grep"
Date: Mon, 25 Aug 2008 02:15:05 -0400
Message-ID: <20080825061504.GA9313@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080825013837.GA17201@coredump.intra.peff.net> <7vmyj1isot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 08:16:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXVNC-0008Oz-5e
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 08:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbYHYGPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 02:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbYHYGPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 02:15:09 -0400
Received: from peff.net ([208.65.91.99]:1504 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbYHYGPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 02:15:08 -0400
Received: (qmail 17944 invoked by uid 111); 25 Aug 2008 06:15:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 25 Aug 2008 02:15:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2008 02:15:05 -0400
Content-Disposition: inline
In-Reply-To: <7vmyj1isot.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93601>

On Sun, Aug 24, 2008 at 10:12:34PM -0700, Junio C Hamano wrote:

> My sed is non POSIX in a good sense and does not have problem handing such
> an input, and my use case is to say "\C-u \M-! git who Jeff <ENTER>" while
> typing e-mail message, and I do _not_ want an extra newline after the
> input.  That is why I use format: (not tformat:) there.

Ah. I would have expected whatever you pulled the output into to eat the
newline. But there is no point in nitpicking, as this is a personal
alias. Mine uses tformat. :)

> > The fix is to allocate the grep_filter member whenever we
> > get _any_ grep information, be it actual filters or just
> > flags. Thus checking for non-NULL revs->grep_filter is no
> > longer sufficient to know that we have patterns; in
> > commit_match we must actually check that the pattern list is
> > not empty.
> 
> Well spotted, and thanks for the fix.

Actually, there is one spot missing from my previous patch. Rev-list
sets "save_commit_buffer" based on the value of grep_filter. So it must
also check grep_filter->pattern_list.

> As you suggested, making the grep option structure embedded in rev_info
> may not be a bad idea.  We used to keep track of the sub-options
> separately while we encounter, and updated grep_filter at the end of the
> loop, but the conversion to use parse-options broke it.

I worked up this patch, and it is below. However, I think it may not be
a good idea, because...

> The only issue I still have, which I suspect your fix has made it easier
> to address, is to complain if sub-options to grep like -i and -E are given
> without --grep.  That's not something v1.5.6 series did, though.

This is trivial with my first patch, but not with the second. With
grep_filter kept as a pointer, we know that if the pointer is non-NULL
but there are no patterns, then the user asked for grep options but
never --grep.

I guess this might be a helpful thing for some users, but I wonder if it
is being too unpredictable for script usage. I.e., a script like:

  git log -E `for i in "$@"; do echo --author=$i`

Anyway, the non-allocating patch is below. Aside from the test case, it
deletes more lines than it adds, which is always nice.

-- >8 --
fix "git log -i --grep"

This has been broken in v1.6.0 due to the reorganization of
the revision option parsing code. The "-i" is completely
ignored, but works fine in "git log --grep -i".

What happens is that the code for "-i" looks for
revs->grep_filter; if it is NULL, we do nothing, since there
are no grep filters. But that is obviously not correct,
since we want it to influence the later --grep option. Doing
it the other way around works, since "-i" just impacts the
existing grep_filter option.

Instead, we now always initialize the grep_filter member and
just fill in options and patterns as we get them. This means
that we can no longer check grep_filter for NULL, but
instead must check the pattern list to see if we have any
actual patterns.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-rev-list.c |    3 ++-
 revision.c         |   34 ++++++++++++----------------------
 revision.h         |    3 ++-
 t/t4202-log.sh     |   22 ++++++++++++++++++++++
 4 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 893762c..c023003 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -645,7 +645,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	    revs.diff)
 		usage(rev_list_usage);
 
-	save_commit_buffer = revs.verbose_header || revs.grep_filter;
+	save_commit_buffer = revs.verbose_header ||
+		revs.grep_filter.pattern_list;
 	if (bisect_list)
 		revs.limited = 1;
 
diff --git a/revision.c b/revision.c
index e75079a..36291b6 100644
--- a/revision.c
+++ b/revision.c
@@ -782,6 +782,10 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
+	revs->grep_filter.status_only = 1;
+	revs->grep_filter.pattern_tail = &(revs->grep_filter.pattern_list);
+	revs->grep_filter.regflags = REG_NEWLINE;
+
 	diff_setup(&revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
@@ -946,15 +950,7 @@ void read_revisions_from_stdin(struct rev_info *revs)
 
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
 {
-	if (!revs->grep_filter) {
-		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
-		opt->status_only = 1;
-		opt->pattern_tail = &(opt->pattern_list);
-		opt->regflags = REG_NEWLINE;
-		revs->grep_filter = opt;
-	}
-	append_grep_pattern(revs->grep_filter, ptn,
-			    "command line", 0, what);
+	append_grep_pattern(&revs->grep_filter, ptn, "command line", 0, what);
 }
 
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
@@ -1164,17 +1160,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--grep=")) {
 		add_message_grep(revs, arg+7);
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-		if (revs->grep_filter)
-			revs->grep_filter->regflags |= REG_EXTENDED;
+		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
-		if (revs->grep_filter)
-			revs->grep_filter->regflags |= REG_ICASE;
+		revs->grep_filter.regflags |= REG_ICASE;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
-		if (revs->grep_filter)
-			revs->grep_filter->fixed = 1;
+		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
-		if (revs->grep_filter)
-			revs->grep_filter->all_match = 1;
+		revs->grep_filter.all_match = 1;
 	} else if (!prefixcmp(arg, "--encoding=")) {
 		arg += 11;
 		if (strcmp(arg, "none"))
@@ -1349,9 +1341,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
-	if (revs->grep_filter) {
-		compile_grep_patterns(revs->grep_filter);
-	}
+	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
@@ -1492,9 +1482,9 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
-	if (!opt->grep_filter)
+	if (!opt->grep_filter.pattern_list)
 		return 1;
-	return grep_buffer(opt->grep_filter,
+	return grep_buffer(&opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
 }
diff --git a/revision.h b/revision.h
index 1b04566..91f1944 100644
--- a/revision.h
+++ b/revision.h
@@ -2,6 +2,7 @@
 #define REVISION_H
 
 #include "parse-options.h"
+#include "grep.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -92,7 +93,7 @@ struct rev_info {
 	int		show_log_size;
 
 	/* Filter by commit log message */
-	struct grep_opt	*grep_filter;
+	struct grep_opt	grep_filter;
 
 	/* Display history graph */
 	struct git_graph *graph;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4c8af45..0ab925c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -69,7 +69,29 @@ test_expect_success 'diff-filter=D' '
 
 '
 
+test_expect_success 'setup case sensitivity tests' '
+	echo case >one &&
+	test_tick &&
+	git commit -a -m Second
+'
+
+test_expect_success 'log --grep' '
+	echo second >expect &&
+	git log -1 --pretty="tformat:%s" --grep=sec >actual &&
+	test_cmp expect actual
+'
 
+test_expect_success 'log -i --grep' '
+	echo Second >expect &&
+	git log -1 --pretty="tformat:%s" -i --grep=sec >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep -i' '
+	echo Second >expect &&
+	git log -1 --pretty="tformat:%s" --grep=sec -i >actual &&
+	test_cmp expect actual
+'
 
 test_done
 
-- 
1.6.0.150.gc3242.dirty
