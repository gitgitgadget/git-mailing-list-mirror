From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3.1 3/5] Introduce new pretty formats %g[sdD] for reflog information
Date: Sat, 17 Oct 2009 16:48:11 +0200
Message-ID: <e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
References: <8a5b3a586d437f02e2a75edd2786636b605522a7.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 16:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzAaQ-00083P-Hi
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 16:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZJQOsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZJQOsk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 10:48:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:25329 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbZJQOsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 10:48:40 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sat, 17 Oct
 2009 16:48:43 +0200
Received: from localhost.localdomain (217.162.250.189) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sat, 17 Oct
 2009 16:48:43 +0200
X-Mailer: git-send-email 1.6.5.116.g4aaa3
In-Reply-To: <8a5b3a586d437f02e2a75edd2786636b605522a7.1255701207.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130557>

Add three new --pretty=format escapes:

  %gD  long  reflog descriptor (e.g. refs/stash@{0})
  %gd  short reflog descriptor (e.g. stash@{0})
  %gs  reflog message

This is achieved by passing down the reflog info, if any, inside the
pretty_print_context struct.

We use the newly refactored get_reflog_selector(), and give it some
extra functionality to extract a shortened ref.  The shortening is
cached inside the commit_reflogs struct; the only allocation of it
happens in read_complete_reflog(), where it is initialised to 0.  Also
add another helper get_reflog_message() for the message extraction.

Note that the --format="%h %gD: %gs" tests may not work in real
repositories, as the --pretty formatter doesn't know to leave away the
": " on the last commit in an incomplete (because git-gc removed the
old part) reflog.  This equivalence is nevertheless the main goal of
this patch.

Thanks to Jeff King for reviews, the %gd testcase and documentation.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wrote:
> [Tacking this on the corresponding v3 patch, but the text below is
> from <20091017011801.GA31443@coredump.intra.peff.net>.]

This sadly backfired, as I forgot to snip out the in-reply-to in the
mail itself and git-send-email apparently trusted that more.  Sorry
for the confusion.

Jeff King wrote:
> I am tempted to do a note like the one below, but maybe the behavior is
> obvious enough to users that it isn't necessary.
[...]
> +NOTE: Some placeholders may depend on other options given to the
> +revision traversal engine. For example, the `%g*` reflog options will
> +insert an empty string unless we are traversing reflog entries (e.g., by
> +`git log -g`). The `%d` placeholder will use the "short" decoration
> +format if `--decorate` was not already provided on the command line.

Sure.  I figured it was obvious enough, but since you already went to
the lengths of documenting the exact behaviour of %d, I squashed it
and adjusted the acknowledgement in the commit message accordingly.

 Documentation/pretty-formats.txt |    9 +++++++++
 commit.h                         |    1 +
 log-tree.c                       |    1 +
 pretty.c                         |   17 +++++++++++++++++
 reflog-walk.c                    |   35 ++++++++++++++++++++++++++++++++---
 reflog-walk.h                    |    8 ++++++++
 t/t6006-rev-list-format.sh       |   18 ++++++++++++++++++
 7 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..38b9904 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,9 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%gD': reflog selector, e.g., `refs/stash@\{1\}`
+- '%gd': shortened reflog selector, e.g., `stash@\{1\}`
+- '%gs': reflog subject
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
@@ -132,6 +135,12 @@ The placeholders are:
 - '%n': newline
 - '%x00': print a byte from a hex code
 
+NOTE: Some placeholders may depend on other options given to the
+revision traversal engine. For example, the `%g*` reflog options will
+insert an empty string unless we are traversing reflog entries (e.g., by
+`git log -g`). The `%d` placeholder will use the "short" decoration
+format if `--decorate` was not already provided on the command line.
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
diff --git a/commit.h b/commit.h
index 011766d..15cb649 100644
--- a/commit.h
+++ b/commit.h
@@ -70,6 +70,7 @@ struct pretty_print_context
 	const char *after_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
+	struct reflog_walk_info *reflog_info;
 };
 
 extern int non_ascii(int);
diff --git a/log-tree.c b/log-tree.c
index f57487f..8e782fc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -409,6 +409,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
+	ctx.reflog_info = opt->reflog_info;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index d6d57eb..fc65fca 100644
--- a/pretty.c
+++ b/pretty.c
@@ -7,6 +7,7 @@
 #include "mailmap.h"
 #include "log-tree.h"
 #include "color.h"
+#include "reflog-walk.h"
 
 static char *user_format;
 
@@ -701,6 +702,22 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'g':		/* reflog info */
+		switch(placeholder[1]) {
+		case 'd':	/* reflog selector */
+		case 'D':
+			if (c->pretty_ctx->reflog_info)
+				get_reflog_selector(sb,
+						    c->pretty_ctx->reflog_info,
+						    c->pretty_ctx->date_mode,
+						    (placeholder[1] == 'd'));
+			return 2;
+		case 's':	/* reflog message */
+			if (c->pretty_ctx->reflog_info)
+				get_reflog_message(sb, c->pretty_ctx->reflog_info);
+			return 2;
+		}
+		return 0;	/* unknown %g placeholder */
 	}
 
 	/* For the rest we have to parse the commit header. */
diff --git a/reflog-walk.c b/reflog-walk.c
index 596bafe..caba4f7 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -8,6 +8,7 @@
 
 struct complete_reflogs {
 	char *ref;
+	const char *short_ref;
 	struct reflog_info {
 		unsigned char osha1[20], nsha1[20];
 		char *email;
@@ -243,15 +244,26 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 enum date_mode dmode)
+			 enum date_mode dmode,
+			 int shorten)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
 	struct reflog_info *info;
+	const char *printed_ref;
 
 	if (!commit_reflog)
 		return;
 
-	strbuf_addf(sb, "%s@{", commit_reflog->reflogs->ref);
+	if (shorten) {
+		if (!commit_reflog->reflogs->short_ref)
+			commit_reflog->reflogs->short_ref
+				= shorten_unambiguous_ref(commit_reflog->reflogs->ref, 0);
+		printed_ref = commit_reflog->reflogs->short_ref;
+	} else {
+		printed_ref = commit_reflog->reflogs->ref;
+	}
+
+	strbuf_addf(sb, "%s@{", printed_ref);
 	if (commit_reflog->flag || dmode) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
@@ -263,6 +275,23 @@ void get_reflog_selector(struct strbuf *sb,
 	strbuf_addch(sb, '}');
 }
 
+void get_reflog_message(struct strbuf *sb,
+			struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+	size_t len;
+
+	if (!commit_reflog)
+		return;
+
+	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+	len = strlen(info->message);
+	if (len > 0)
+		len--; /* strip away trailing newline */
+	strbuf_add(sb, info->message, len);
+}
+
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 	enum date_mode dmode)
 {
@@ -272,7 +301,7 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		struct strbuf selector = STRBUF_INIT;
 
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
-		get_reflog_selector(&selector, reflog_info, dmode);
+		get_reflog_selector(&selector, reflog_info, dmode, 0);
 		if (oneline) {
 			printf("%s: %s", selector.buf, info->message);
 		}
diff --git a/reflog-walk.h b/reflog-walk.h
index 74c9096..7bd2cd4 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -3,6 +3,8 @@
 
 #include "cache.h"
 
+struct reflog_walk_info;
+
 extern void init_reflog_walk(struct reflog_walk_info** info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
@@ -10,5 +12,11 @@ extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
 		enum date_mode);
+extern void get_reflog_message(struct strbuf *sb,
+		struct reflog_walk_info *reflog_info);
+extern void get_reflog_selector(struct strbuf *sb,
+		struct reflog_walk_info *reflog_info,
+		enum date_mode dmode,
+		int shorten);
 
 #endif
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 59d1f62..7f61ab0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -162,4 +162,22 @@ test_expect_success 'empty email' '
 	}
 '
 
+test_expect_success '"%h %gD: %gs" is same as git-reflog' '
+	git reflog >expect &&
+	git log -g --format="%h %gD: %gs" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"%h %gD: %gs" is same as git-reflog (with date)' '
+	git reflog --date=raw >expect &&
+	git log -g --format="%h %gD: %gs" --date=raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%gd shortens ref name' '
+	echo "master@{0}" >expect.gd-short &&
+	git log -g -1 --format=%gd refs/heads/master >actual.gd-short &&
+	test_cmp expect.gd-short actual.gd-short
+'
+
 test_done
-- 
1.6.5.116.g4aaa3
