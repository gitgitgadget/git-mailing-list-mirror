From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] pretty: Initialize notes if %N is used
Date: Sun, 11 Apr 2010 16:54:22 +0200
Message-ID: <1270997662-25430-1-git-send-email-heipei@hackvalue.de>
References: <20100410220843.GA29987@coredump.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 16:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0yYD-0001jO-7h
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 16:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0DKOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 10:54:10 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:41498 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0DKOyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 10:54:09 -0400
Received: from u-6-233.vpn.rwth-aachen.de ([137.226.102.233]:44916 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O0yXz-0003vg-FI; Sun, 11 Apr 2010 16:54:03 +0200
X-Mailer: git-send-email 1.7.0.2.201.g80978
In-Reply-To: <20100410220843.GA29987@coredump.intra.peff.net>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.233
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144650>

When using git log --pretty='%N' without an explicit --show-notes, git
would segfault. This patches fixes this behaviour by loading the needed
notes datastructures if --pretty is used and the format contains %N.
When --pretty='%N' is used together with --no-notes, %N won't be
expanded.

This is an extension to a proposed patch by Jeff King.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hey Jeff,

something like this? I didn't see why userformat_fill_want had to have an extra
argument for the format, since the user_format variable is static in pretty.c.

Sorry for the many very different patches to the bug, as you can see I'm not
really familiar with best-practices in git.git.

Greetings,
Jojo

 builtin/log.c |    6 +++++-
 commit.h      |    5 +++++
 pretty.c      |   31 +++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b706a5f..f8f5d22 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -58,7 +58,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, opt);
 
-	if (!rev->show_notes_given && !rev->pretty_given)
+	struct userformat_want w;
+	if (rev->commit_format == CMIT_FMT_USERFORMAT)
+		userformat_fill_want(&w);
+
+	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
diff --git a/commit.h b/commit.h
index 3cf5166..fc1c504 100644
--- a/commit.h
+++ b/commit.h
@@ -74,11 +74,16 @@ struct pretty_print_context
 	struct reflog_walk_info *reflog_info;
 };
 
+struct userformat_want {
+	unsigned notes:1;
+};
+
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern void userformat_fill_want(struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index 6ba3da8..0e3ae98 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,10 +775,13 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		format_display_notes(commit->object.sha1, sb,
-			    git_log_output_encoding ? git_log_output_encoding
-						    : git_commit_encoding, 0);
-		return 1;
+		if (c->pretty_ctx->show_notes) {
+			format_display_notes(commit->object.sha1, sb,
+				    git_log_output_encoding ? git_log_output_encoding
+							    : git_commit_encoding, 0);
+			return 1;
+		}
+		return 0;
 	}
 
 	/* For the rest we have to parse the commit header. */
@@ -855,6 +858,26 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	return consumed + 1;
 }
 
+static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
+				 void *context)
+{
+	struct userformat_want *w = context;
+	switch (*placeholder) {
+		case 'N': w->notes = 1;
+	}
+	return 0;
+}
+
+void userformat_fill_want(struct userformat_want *w)
+{
+	if (!user_format)
+		return;
+	struct strbuf dummy = STRBUF_INIT;
+	memset(w, 0, sizeof(*w));
+	strbuf_expand(&dummy, user_format, userformat_want_item, w);
+	strbuf_release(&dummy);
+}
+
 void format_commit_message(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
 			   const struct pretty_print_context *pretty_ctx)
-- 
1.7.0.2.201.g80978
