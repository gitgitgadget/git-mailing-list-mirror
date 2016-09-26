Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57545209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032472AbcIZMAj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:48047 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbcIZMAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:38 -0400
Received: (qmail 18740 invoked by uid 109); 26 Sep 2016 12:00:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:38 +0000
Received: (qmail 4436 invoked by uid 111); 26 Sep 2016 12:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:36 -0400
Date:   Mon, 26 Sep 2016 08:00:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user gives us an ambiguous short sha1, we print an
error and refuse to resolve it. In some cases, the next step
is for them to feed us more characters (e.g., if they were
retyping or cut-and-pasting from a full sha1). But in other
cases, that might be all they have. For example, an old
commit message may have used a 7-character hex that was
unique at the time, but is now ambiguous.  Git doesn't
provide any information about the ambiguous objects it
found, so it's hard for the user to find out which one they
probably meant.

This patch teaches get_short_sha1() to list the sha1s of the
objects it found, along with a few bits of information that
may help the user decide which one they meant. Here's what
it looks like on git.git:

  $ git rev-parse b2e1
  error: short SHA1 b2e1 is ambiguous
  hint: The candidates are:
  hint:   b2e1196 tag v2.8.0-rc1
  hint:   b2e11d1 tree
  hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
  hint:   b2e1759 blob
  hint:   b2e18954 blob
  hint:   b2e1895c blob
  fatal: ambiguous argument 'b2e1': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

We show the tagname for tags, and the date and subject for
commits. For trees and blobs, in theory we could dig in the
history to find the paths at which they were present. But
that's very expensive (on the order of 30s for the kernel),
and it's not likely to be all that helpful. Most short
references are to commits, so the useful information is
typically going to be that the object in question _isn't_ a
commit. So it's silly to spend a lot of CPU preemptively
digging up the path; the user can do it themselves if they
really need to.

And of course it's somewhat ironic that we abbreviate the
sha1s in the disambiguation hint. But full sha1s would cause
annoying line wrapping for the commit lines, and presumably
the user is going to just re-issue their command immediately
with the corrected sha1.

We also restrict the list to those that match any
disambiguation hint. E.g.:

  $ git rev-parse b2e1:foo
  error: short SHA1 b2e1 is ambiguous
  hint: The candidates are:
  hint:   b2e1196 tag v2.8.0-rc1
  hint:   b2e11d1 tree
  hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
  fatal: Invalid object name 'b2e1'.

does not bother reporting the blobs, because they cannot
work as a treeish.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                         | 50 +++++++++++++++++++++++++++++++++++--
 t/t1512-rev-parse-disambiguation.sh | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f7403d7..35d943d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -318,6 +318,38 @@ static int init_object_disambiguation(const char *name, int len,
 	return 0;
 }
 
+static int show_ambiguous_object(const unsigned char *sha1, void *data)
+{
+	const struct disambiguate_state *ds = data;
+	struct strbuf desc = STRBUF_INIT;
+	int type;
+
+	if (ds->fn && !ds->fn(sha1, ds->cb_data))
+		return 0;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type == OBJ_COMMIT) {
+		struct commit *commit = lookup_commit(sha1);
+		if (commit) {
+			struct pretty_print_context pp = {0};
+			pp.date_mode.type = DATE_SHORT;
+			format_commit_message(commit, " %ad - %s", &desc, &pp);
+		}
+	} else if (type == OBJ_TAG) {
+		struct tag *tag = lookup_tag(sha1);
+		if (!parse_tag(tag) && tag->tag)
+			strbuf_addf(&desc, " %s", tag->tag);
+	}
+
+	advise("  %s %s%s",
+	       find_unique_abbrev(sha1, DEFAULT_ABBREV),
+	       typename(type) ? typename(type) : "unknown type",
+	       desc.buf);
+
+	strbuf_release(&desc);
+	return 0;
+}
+
 static int multiple_bits_set(unsigned flags)
 {
 	return !!(flags & (flags - 1));
@@ -351,8 +383,22 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, sha1);
 
-	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
+	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
+		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
+
+		/*
+		 * We may still have ambiguity if we simply saw a series of
+		 * candidates that did not satisfy our hint function. In
+		 * that case, we still want to show them, so disable the hint
+		 * function entirely.
+		 */
+		if (!ds.ambiguous)
+			ds.fn = NULL;
+
+		advise(_("The candidates are:"));
+		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
+	}
+
 	return status;
 }
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 1d8f550..c5447ef 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -323,4 +323,28 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (peel)' '
 	test_line_count = 1 errors
 '
 
+test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
+	test_must_fail git rev-parse 000000000 2>stderr &&
+	grep ^hint: stderr >hints &&
+	# 16 candidates, plus one intro line
+	test_line_count = 17 hints
+'
+
+test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
+	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
+	grep ^hint: stderr >hints &&
+	# 5 commits, 1 tag (which is a commitish), plus intro line
+	test_line_count = 7 hints
+'
+
+test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
+	# these two blobs share the same prefix "ee3d", but neither
+	# will pass for a commit
+	echo 851 | git hash-object --stdin -w &&
+	echo 872 | git hash-object --stdin -w &&
+	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
+	grep ^hint: stderr >hints &&
+	test_line_count = 3 hints
+'
+
 test_done
-- 
2.10.0.492.g14f803f
