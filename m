From: Carl Worth <cworth@cworth.org>
Subject: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Tue,  8 Jun 2010 18:01:45 -0700
Message-ID: <1276045305-20743-1-git-send-email-cworth@cworth.org>
Cc: Carl Worth <cworth@cworth.org>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 03:05:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM9jM-0005bz-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 03:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab0FIBB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 21:01:58 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:47532 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab0FIBB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 21:01:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 303E74196F2;
	Tue,  8 Jun 2010 18:01:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6nbwLvQTN21; Tue,  8 Jun 2010 18:01:46 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 04E42431FC1;
	Tue,  8 Jun 2010 18:01:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148738>

This uses the mboxrd style of quoting as documented here:
http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/mail-mbox-formats.html

This matches the mboxrd-style un-escaping recently added to "git am".

Test 4152 is now extended to verify that format-patch does the proper
escaping.  It also now relies directly on the escaped output from
format-patch to verify that "git am" does the proper unescaping,
(where previously, it faked the escaped output with sed).

Signed-off-by: Carl Worth <cworth@cworth.org>
---

This patch is on top of the three patches I sent earlier. With this patch,
the series to make git use mbox in a robust fashion (and to avoid using mbox
where possible) is complete.

The entire test suite passes, and new tests are added for all new
functionality.

All of the features and caveats I mentioned earlier are taken care of. The
only potentially missing piece is that git-send-email doesn't have code
to un-escape From_ lines in an mbox. But this is irrelevant since send-
email doesn't even know how to handle an mbox anyway, (it will treat it
as one large email message instead).

Without this patch series, there's no documented way that an external
tool can use to reliably construct an mbox that will be correctly handled
by "git am". The best one could do is to peek inside the git implementation
and notice that it wants unescaped "From " lines, that it will ignore any
"From " line that doesn't end with something very much like asctime format,
and then somehow ensure that no messages in the mbox have lines that begin
with "From " and end with something like asctime format, (which won't be
possible in all cases without corrupting the message).

With this patch series, one can instead document that "git am" accepts an
mbox in "mboxrd" format as documented at the URL above, but with the caveat
that no additional characters are allowed after the asctime portion of the
"From " line. This requirement allows git to continue to accept mbox files
created by old versions of git, (with a very minor chance of corruption).

Mbox files create and consumed by versions of git after this patch series
should have no corruption by design.

 builtin/log.c                                      |    2 +-
 commit.h                                           |    5 ++-
 log-tree.c                                         |    1 +
 pretty.c                                           |   14 +++++++++++-
 ....sh => t4152-format-patch-am-From_-escaping.sh} |   21 ++++++++++++-------
 5 files changed, 30 insertions(+), 13 deletions(-)
 rename t/{t4152-am-From_.sh => t4152-format-patch-am-From_-escaping.sh} (78%)
 mode change 100755 => 100644

diff --git a/builtin/log.c b/builtin/log.c
index adbec9f..36b2f5a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -763,7 +763,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
 		      encoding, need_8bit_cte);
-	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
+	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0, 0);
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
diff --git a/commit.h b/commit.h
index 6ef88dc..18e7197 100644
--- a/commit.h
+++ b/commit.h
@@ -70,6 +70,7 @@ struct pretty_print_context
 	const char *after_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
+	int need_from_escaping;
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
 };
@@ -103,8 +104,8 @@ void pp_title_line(enum cmit_fmt fmt,
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
-		  int indent);
-
+		  int indent,
+		  int need_from_escaping);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index 6aab273..1a179dc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -415,6 +415,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+	ctx.need_from_escaping = opt->format_mbox;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 74cda1b..62b376b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1011,7 +1011,8 @@ void pp_title_line(enum cmit_fmt fmt,
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
-		  int indent)
+		  int indent,
+		  int need_from_escaping)
 {
 	int first = 1;
 	for (;;) {
@@ -1030,6 +1031,15 @@ void pp_remainder(enum cmit_fmt fmt,
 		}
 		first = 0;
 
+		if (need_from_escaping && (*line == '>' || *line == 'F'))
+		{
+			const char *s = line;
+			while (*s == '>')
+				s++;
+			if (strncmp (s, "From ", 5) == 0)
+				strbuf_addch(sb, '>');
+		}
+
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
 			memset(sb->buf + sb->len, ' ', indent);
@@ -1117,7 +1127,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 
 	beginning_of_body = sb->len;
 	if (fmt != CMIT_FMT_ONELINE)
-		pp_remainder(fmt, &msg, sb, indent);
+		pp_remainder(fmt, &msg, sb, indent, context->need_from_escaping);
 	strbuf_rtrim(sb);
 
 	/* Make sure there is an EOLN for the non-oneline case */
diff --git a/t/t4152-am-From_.sh b/t/t4152-format-patch-am-From_-escaping.sh
old mode 100755
new mode 100644
similarity index 78%
rename from t/t4152-am-From_.sh
rename to t/t4152-format-patch-am-From_-escaping.sh
index 02821ee..dc013bb
--- a/t/t4152-am-From_.sh
+++ b/t/t4152-format-patch-am-From_-escaping.sh
@@ -34,13 +34,18 @@ test_expect_success setup '
 	test_tick &&
 	git commit -s -F msg &&
 	git tag second &&
-	git format-patch --stdout first | sed -e "1{p;d};s/^\(>*From \)/>\1/" > From_ &&
-	{
-		echo "X-Fake-Field: Line One" &&
-		echo "X-Fake-Field: Line Two" &&
-		echo "X-Fake-Field: Line Three" &&
-		git format-patch --stdout first | sed -e "1d"
-	} > From_.eml
+	git format-patch --stdout first > From_ &&
+	git format-patch first
+'
+
+test_expect_success 'format-patch escapes From_ lines in mbox' '
+	head -1 From_ | grep "^From " &&
+	test "$(grep "^From " From_ | wc -l)" = "1"
+'
+
+test_expect_success 'format-patch does not escapes From_ lines in email' '
+	head -1 0001-From_-lines.patch | grep -v "^From " >/dev/null &&
+	test "$(grep "^From " 0001-From_-lines.patch | wc -l)" = "1"
 '
 
 test_expect_success 'am unescapes From_ lines from mbox' '
@@ -54,7 +59,7 @@ test_expect_success 'am unescapes From_ lines from mbox' '
 
 test_expect_success 'am does not unescape From_ lines from email' '
 	git checkout first &&
-	git am From_.eml &&
+	git am 0001-From_-lines.patch &&
 	! test -d .git/rebase-apply &&
 	test -z "$(git diff second)" &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
-- 
1.7.0.4
