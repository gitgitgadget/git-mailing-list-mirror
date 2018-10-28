Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D581F453
	for <e@80x24.org>; Sun, 28 Oct 2018 13:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJ1WPo (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 18:15:44 -0400
Received: from 0x63.nu ([109.74.10.199]:53172 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeJ1WPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 18:15:44 -0400
X-Greylist: delayed 2207 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Oct 2018 18:15:43 EDT
Received: from ip6-localhost ([::1] helo=changeme.sandvine.com)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gGka9-0003n0-5B; Sun, 28 Oct 2018 13:54:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH] pretty: Add %(trailer:X) to display single trailer
Date:   Sun, 28 Oct 2018 13:50:25 +0100
Message-Id: <20181028125025.30952-1-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new format placeholder allows displaying only a single
trailer. The formatting done is similar to what is done for
--decorate/%d using parentheses and comma separation.

It's intended use is for things like ticket references in trailers.

So with a commit with a message like:

 > Some good commit
 >
 > Ticket: XYZ-123

running:

 $ git log --pretty="%H %s% (trailer:Ticket)"

will give:

 > 123456789a Some good commit (Ticket: XYZ-123)

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt |  4 ++++
 pretty.c                         | 16 +++++++++++++
 t/t4205-log-pretty-formats.sh    | 40 ++++++++++++++++++++++++++++++++
 trailer.c                        | 18 ++++++++++++--
 trailer.h                        |  1 +
 5 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 6109ef09aa..a46d0c0717 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -211,6 +211,10 @@ endif::git-rev-list[]
   If the `unfold` option is given, behave as if interpret-trailer's
   `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
   both.
+- %(trailer:<t>): display the specified trailer in parentheses (like
+  %d does for refnames). If there are multiple entries of that trailer
+  they are shown comma separated. If there are no matching trailers
+  nothing is displayed.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 8ca29e9281..61ae34ced4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1324,6 +1324,22 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 	}
 
+	if (skip_prefix(placeholder, "(trailer:", &arg)) {
+		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		opts.no_divider = 1;
+		opts.only_trailers = 1;
+		opts.unfold = 1;
+
+		const char *end = strchr(arg, ')');
+		if (!end)
+			return 0;
+
+		opts.filter_trailer = xstrndup(arg, end - arg);
+		format_trailers_from_commit(sb, msg + c->subject_off, &opts);
+		free(opts.filter_trailer);
+		return end - placeholder + 1;
+	}
+
 	return 0;	/* unknown placeholder */
 }
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66ff..e929f820e7 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -598,6 +598,46 @@ test_expect_success ':only and :unfold work together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailer:foo) shows that trailer' '
+	git log --no-walk --pretty="%(trailer:Acked-By)" >actual &&
+	{
+		echo "(Acked-By: A U Thor <author@example.com>)"
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailer:nonexistant) becomes empty' '
+	git log --no-walk --pretty="x%(trailer:Nacked-By)x" >actual &&
+	{
+		echo "xx"
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '% (trailer:nonexistant) with space becomes empty' '
+	git log --no-walk --pretty="x% (trailer:Nacked-By)x" >actual &&
+	{
+		echo "xx"
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '% (trailer:foo) with space adds space before' '
+	git log --no-walk --pretty="x% (trailer:Acked-By)x" >actual &&
+	{
+		echo "x (Acked-By: A U Thor <author@example.com>)x"
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailer:foo) with multiple lines becomes comma separated and unwrapped' '
+	git log --no-walk --pretty="%(trailer:Signed-Off-By)" >actual &&
+	{
+		echo "(Signed-Off-By: A U Thor <author@example.com>, A U Thor <author@example.com>)"
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/trailer.c b/trailer.c
index 0796f326b3..d337bca8dd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1138,6 +1138,7 @@ static void format_trailer_info(struct strbuf *out,
 		return;
 	}
 
+	int printed_first = 0;
 	for (i = 0; i < info->trailer_nr; i++) {
 		char *trailer = info->trailers[i];
 		ssize_t separator_pos = find_separator(trailer, separators);
@@ -1150,7 +1151,19 @@ static void format_trailer_info(struct strbuf *out,
 			if (opts->unfold)
 				unfold_value(&val);
 
-			strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+			if (opts->filter_trailer) {
+				if (!strcasecmp (tok.buf, opts->filter_trailer)) {
+					if (!printed_first) {
+						strbuf_addf(out, "(%s: ", opts->filter_trailer);
+						printed_first = 1;
+					} else {
+						strbuf_addstr(out, ", ");
+					}
+					strbuf_addstr(out, val.buf);
+				}
+			} else {
+				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
+			}
 			strbuf_release(&tok);
 			strbuf_release(&val);
 
@@ -1158,7 +1171,8 @@ static void format_trailer_info(struct strbuf *out,
 			strbuf_addstr(out, trailer);
 		}
 	}
-
+	if (printed_first)
+		strbuf_addstr(out, ")");
 }
 
 void format_trailers_from_commit(struct strbuf *out, const char *msg,
diff --git a/trailer.h b/trailer.h
index b997739649..852c79d449 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	char *filter_trailer;
 };
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
-- 
2.17.1

