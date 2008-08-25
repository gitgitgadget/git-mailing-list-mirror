From: Jeff King <peff@peff.net>
Subject: [PATCH] fix "git log -i --grep"
Date: Sun, 24 Aug 2008 21:38:37 -0400
Message-ID: <20080825013837.GA17201@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 03:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXR3c-0001uL-9b
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 03:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYHYBil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 21:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbYHYBil
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 21:38:41 -0400
Received: from peff.net ([208.65.91.99]:2122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbYHYBik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 21:38:40 -0400
Received: (qmail 15553 invoked by uid 111); 25 Aug 2008 01:38:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 21:38:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 21:38:37 -0400
Content-Disposition: inline
In-Reply-To: <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93582>

On Fri, Aug 22, 2008 at 02:09:35PM -0700, Junio C Hamano wrote:

>     [alias]
>         who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"

I have two improvements for this, and one of them caused me to find a
git bug, for which the fix is below. :)

  1. I tried this with --no-pager, which made it obvious that this
     should be using --pretty=tformat to append a newline.

  2. I use it with "-i" so I don't have to hit the shift key. And that's
     what revealed the bug.

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

The fix is to allocate the grep_filter member whenever we
get _any_ grep information, be it actual filters or just
flags. Thus checking for non-NULL revs->grep_filter is no
longer sufficient to know that we have patterns; in
commit_match we must actually check that the pattern list is
not empty.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't bother bisecting, but I'm pretty sure this was a fallout from
Pierre's revision option parsing rewrite.

This was generated with -U5 to make the first hunk easier to read.

We could potentially make revs->grep_filter a part of the struct, rather
than malloc'ing it (since we have to look inside grep_filter anyway to
see if there are any patterns). But that still doesn't save us from a
setup_grep call, since we have to initialize some values inside it.
Potentially this setup (which is not very costly) could just be done
when initializing the rev_info struct, and then we could just assume
that grep_filter was always valid.

I went with the less intrusive change in this case, but I am happy to
work it up the other way.

 revision.c     |   25 +++++++++++++++----------
 t/t4202-log.sh |   22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 8cd39da..a73612f 100644
--- a/revision.c
+++ b/revision.c
@@ -942,19 +942,24 @@ void read_revisions_from_stdin(struct rev_info *revs)
 		if (handle_revision_arg(line, revs, 0, 1))
 			die("bad revision '%s'", line);
 	}
 }
 
-static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+static void setup_grep(struct rev_info *revs)
 {
 	if (!revs->grep_filter) {
 		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
 		opt->status_only = 1;
 		opt->pattern_tail = &(opt->pattern_list);
 		opt->regflags = REG_NEWLINE;
 		revs->grep_filter = opt;
 	}
+}
+
+static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+{
+	setup_grep(revs);
 	append_grep_pattern(revs->grep_filter, ptn,
 			    "command line", 0, what);
 }
 
 static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
@@ -1167,21 +1172,21 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--committer=")) {
 		add_header_grep(revs, "committer", arg+12);
 	} else if (!prefixcmp(arg, "--grep=")) {
 		add_message_grep(revs, arg+7);
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-		if (revs->grep_filter)
-			revs->grep_filter->regflags |= REG_EXTENDED;
+		setup_grep(revs);
+		revs->grep_filter->regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
-		if (revs->grep_filter)
-			revs->grep_filter->regflags |= REG_ICASE;
+		setup_grep(revs);
+		revs->grep_filter->regflags |= REG_ICASE;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
-		if (revs->grep_filter)
-			revs->grep_filter->fixed = 1;
+		setup_grep(revs);
+		revs->grep_filter->fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
-		if (revs->grep_filter)
-			revs->grep_filter->all_match = 1;
+		setup_grep(revs);
+		revs->grep_filter->all_match = 1;
 	} else if (!prefixcmp(arg, "--encoding=")) {
 		arg += 11;
 		if (strcmp(arg, "none"))
 			git_log_output_encoding = xstrdup(arg);
 		else
@@ -1647,11 +1652,11 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	return 0;
 }
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
-	if (!opt->grep_filter)
+	if (!opt->grep_filter || !opt->grep_filter->pattern_list)
 		return 1;
 	return grep_buffer(opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4c8af45..0ab925c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -67,9 +67,31 @@ test_expect_success 'diff-filter=D' '
 		false
 	}
 
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
