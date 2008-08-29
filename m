From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 20:54:59 -0400
Message-ID: <20080829005458.GA4248@coredump.intra.peff.net>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com> <20080828231547.GD29609@coredump.intra.peff.net> <7viqtkd84s.fsf@gitster.siamese.dyndns.org> <20080828235420.GB30195@coredump.intra.peff.net> <d77df1110808281710r6d58739fl2acb93e1940c7433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYsHZ-0007x1-O7
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbYH2AzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbYH2AzE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:55:04 -0400
Received: from peff.net ([208.65.91.99]:2620 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbYH2AzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:55:02 -0400
Received: (qmail 10269 invoked by uid 111); 29 Aug 2008 00:55:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 20:55:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 20:54:59 -0400
Content-Disposition: inline
In-Reply-To: <d77df1110808281710r6d58739fl2acb93e1940c7433@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94238>

On Thu, Aug 28, 2008 at 07:10:45PM -0500, Nathan W. Panike wrote:

> The genesis of this patch was the documentation says that %ad
> represents 'author date' without any more specific information.  I
> thought that I could do
> 
> git show --date=short --pretty=format:"%ad %h"
> 
> and get the date in short form---but alas, this did not work.  So I

Regardless of expansions to --pretty=format:, that is something we
should probably be doing _anyway_. The current behavior is just
confusing, and %ad is simply documented as "date", not in any particular
format (and I think anyone relying on it _ignoring_ --date= is insane,
since that --date is otherwise not doing anything).

So how about this?

-- >8 --
pretty=format: respect date format options

When running a command like:

  git log --pretty=format:%ad --date=short

the date option was ignored. This patch causes it to use
whatever format was specified by --date (or by
--relative-date, etc), just as the non-user formats would
do.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt |    2 +-
 archive.c                        |    2 +-
 builtin-commit.c                 |    2 +-
 commit.h                         |    3 ++-
 pretty.c                         |   17 +++++++++++------
 t/t6006-rev-list-format.sh       |    6 ++++++
 6 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index c11d495..388d492 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -103,7 +103,7 @@ The placeholders are:
 - '%an': author name
 - '%aN': author name (respecting .mailmap)
 - '%ae': author email
-- '%ad': author date
+- '%ad': author date (format respects --date= option)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
diff --git a/archive.c b/archive.c
index 5b40e26..e2280df 100644
--- a/archive.c
+++ b/archive.c
@@ -48,7 +48,7 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf);
+		format_commit_message(commit, fmt.buf, buf, DATE_NORMAL);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..c870037 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -882,7 +882,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
-		format_commit_message(commit, "%h: %s", &buf);
+		format_commit_message(commit, "%h: %s", &buf, DATE_NORMAL);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/commit.h b/commit.h
index d163c74..de15f4d 100644
--- a/commit.h
+++ b/commit.h
@@ -67,7 +67,8 @@ extern int non_ascii(int);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
-                                  const void *format, struct strbuf *sb);
+				  const void *format, struct strbuf *sb,
+				  enum date_mode dmode);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 struct strbuf *,
                                 int abbrev, const char *subject,
diff --git a/pretty.c b/pretty.c
index 33ef34a..a29c290 100644
--- a/pretty.c
+++ b/pretty.c
@@ -310,7 +310,7 @@ static int mailmap_name(struct strbuf *sb, const char *email)
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
-                               const char *msg, int len)
+				 const char *msg, int len, enum date_mode dmode)
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
@@ -377,7 +377,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 
 	switch (part) {
 	case 'd':	/* date */
-		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
+		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
 	case 'D':	/* date, RFC2822 style */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
@@ -409,6 +409,7 @@ struct chunk {
 
 struct format_commit_context {
 	const struct commit *commit;
+	enum date_mode dmode;
 
 	/* These offsets are relative to the start of the commit message. */
 	int commit_header_parsed;
@@ -584,10 +585,12 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		return 1;
 	case 'a':	/* author ... */
 		return format_person_part(sb, placeholder[1],
-		                   msg + c->author.off, c->author.len);
+				   msg + c->author.off, c->author.len,
+				   c->dmode);
 	case 'c':	/* committer ... */
 		return format_person_part(sb, placeholder[1],
-		                   msg + c->committer.off, c->committer.len);
+				   msg + c->committer.off, c->committer.len,
+				   c->dmode);
 	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
 		return 1;
@@ -599,12 +602,14 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 }
 
 void format_commit_message(const struct commit *commit,
-                           const void *format, struct strbuf *sb)
+			   const void *format, struct strbuf *sb,
+			   enum date_mode dmode)
 {
 	struct format_commit_context context;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
+	context.dmode = dmode;
 	strbuf_expand(sb, format, format_commit_item, &context);
 }
 
@@ -770,7 +775,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	const char *encoding;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb);
+		format_commit_message(commit, user_format, sb, dmode);
 		return;
 	}
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9176484..485ad4d 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -139,6 +139,12 @@ commit 131a310eb913d107dd3c09a65d1651175898735d
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
 
+test_expect_success '%ad respects --date=' '
+	echo 2005-04-07 >expect.ad-short &&
+	git log -1 --date=short --pretty=tformat:%ad >output.ad-short master &&
+	test_cmp expect.ad-short output.ad-short
+'
+
 test_expect_success 'empty email' '
 	test_tick &&
 	C=$(GIT_AUTHOR_EMAIL= git commit-tree HEAD^{tree} </dev/null) &&
-- 
1.6.0.1.173.g2bf39.dirty
