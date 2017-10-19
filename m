Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006BD202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbdJSU33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:29:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752345AbdJSU32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:29:28 -0400
Received: (qmail 2937 invoked by uid 109); 19 Oct 2017 20:29:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:29:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12004 invoked by uid 111); 19 Oct 2017 20:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:29:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:29:26 -0400
Date:   Thu, 19 Oct 2017 16:29:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 4/5] diff: fix whitespace-skipping with --color-moved
Message-ID: <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for handling whitespace with --color-moved
represents partial strings as a pair of pointers. There are
two possible conventions for the end pointer:

  1. It points to the byte right after the end of the
     string.

  2. It points to the final byte of the string.

But we seem to use both conventions in the code:

  a. we assign the initial pointers from the NUL-terminated
     string using (1)

  b. we eat trailing whitespace by checking the second
     pointer for isspace(), which needs (2)

  c. the next_byte() function checks for end-of-string with
     "if (cp > endp)", which is (2)

  d. in next_byte() we skip past internal whitespace with
     "while (cp < end)", which is (1)

This creates fewer bugs than you might think, because there
are some subtle interactions. Because of (a) and (c), we
always return the NUL-terminator from next_byte(). But all
of the callers of next_byte() happen to handle that
gracefully.

Because of the mismatch between (d) and (c), next_byte()
could accidentally return a whitespace character right at
endp. But because of the interaction of (a) and (b), we fail
to actually chomp trailing whitespace, meaning our endp
_always_ points to a NUL, canceling out the problem.

But that does leave (b) as a real bug: when ignoring
whitespace only at the end-of-line, we don't correctly trim
it, and fail to match up lines.

We can fix the whole thing by moving consistently to one
convention. Since convention (1) is idiomatic in our code
base, we'll pick that one.

The existing "-w" and "-b" tests continue to pass, and a new
"--ignore-space-at-eol" shows off the breakage we're fixing.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                     | 15 +++++++----
 t/t4015-diff-whitespace.sh | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 6fd288420b..09081a207c 100644
--- a/diff.c
+++ b/diff.c
@@ -712,7 +712,7 @@ static int next_byte(const char **cp, const char **endp,
 {
 	int retval;
 
-	if (*cp > *endp)
+	if (*cp >= *endp)
 		return -1;
 
 	if (isspace(**cp)) {
@@ -729,7 +729,12 @@ static int next_byte(const char **cp, const char **endp,
 		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
 			while (*cp < *endp && isspace(**cp))
 				(*cp)++;
-			/* return the first non-ws character via the usual below */
+			/*
+			 * return the first non-ws character via the usual
+			 * below, unless we ate all of the bytes
+			 */
+			if (*cp >= *endp)
+				return -1;
 		}
 	}
 
@@ -750,9 +755,9 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
-		while (ae > ap && isspace(*ae))
+		while (ae > ap && isspace(ae[-1]))
 			ae--;
-		while (be > bp && isspace(*be))
+		while (be > bp && isspace(be[-1]))
 			be--;
 	}
 
@@ -775,7 +780,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
 		int c;
 
 		strbuf_reset(&sb);
-		while (ae > ap && isspace(*ae))
+		while (ae > ap && isspace(ae[-1]))
 			ae--;
 		while ((c = next_byte(&ap, &ae, o)) > 0)
 			strbuf_addch(&sb, c);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 1f54816c6b..eb9431da7d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1463,6 +1463,73 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	test_cmp expected actual
 '
 
+test_expect_failure 'move detection ignoring whitespace at eol' '
+	git reset --hard &&
+	# Lines 6-9 have new eol whitespace, but 9 also has it in the middle
+	q_to_tab <<-\EOF >lines.txt &&
+	long line 6Q
+	long line 7Q
+	long line 8Q
+	longQline 9Q
+	line 1
+	line 2
+	line 3
+	line 4
+	line 5
+	EOF
+
+	# avoid cluttering the output with complaints about our eol whitespace
+	test_config core.whitespace -blank-at-eol &&
+
+	git diff HEAD --no-renames --color-moved --color |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
+	<GREEN>+<RESET><GREEN>long line 6	<RESET>
+	<GREEN>+<RESET><GREEN>long line 7	<RESET>
+	<GREEN>+<RESET><GREEN>long line 8	<RESET>
+	<GREEN>+<RESET><GREEN>long	line 9	<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	<RED>-long line 6<RESET>
+	<RED>-long line 7<RESET>
+	<RED>-long line 8<RESET>
+	<RED>-long line 9<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
+	<CYAN>+<RESET><CYAN>long line 6	<RESET>
+	<CYAN>+<RESET><CYAN>long line 7	<RESET>
+	<CYAN>+<RESET><CYAN>long line 8	<RESET>
+	<GREEN>+<RESET><GREEN>long	line 9	<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	<MAGENTA>-long line 6<RESET>
+	<MAGENTA>-long line 7<RESET>
+	<MAGENTA>-long line 8<RESET>
+	<RED>-long line 9<RESET>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'clean up whitespace-test colors' '
 	git config --unset color.diff.oldMoved &&
 	git config --unset color.diff.newMoved
-- 
2.15.0.rc1.560.g5f0609e481

