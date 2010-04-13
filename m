From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv2] pretty: Initialize notes if %N is used
Date: Tue, 13 Apr 2010 10:59:46 +0200
Message-ID: <1271149186-30156-1-git-send-email-heipei@hackvalue.de>
References: <20100412085647.GA26840@coredump.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:00:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1byc-0006Di-QV
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab0DMJAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:00:01 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:48358 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0DMJAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:00:00 -0400
Received: from u-7-037.vpn.rwth-aachen.de ([137.226.103.37]:45714 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O1byL-0000mA-KD; Tue, 13 Apr 2010 10:59:53 +0200
X-Mailer: git-send-email 1.7.1.rc1
In-Reply-To: <20100412085647.GA26840@coredump.intra.peff.net>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.103.37
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144797>

When using git log --pretty='%N' without an explicit --show-notes, git
would segfault. This patches fixes this behaviour by loading the needed
notes datastructures if --pretty is used and the format contains %N.
When --pretty='%N' is used together with --no-notes, %N won't be
expanded.

This is an extension to a proposed patch by Jeff King.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Thanks for the feedback Jeff. I've put your suggestions into my patch and tried
to come up with a sensible name for 'userformat_fill_want'. As you can see I
called it 'userformat_find_requirements', but am not really satisfied with it
since it's too long and not quite to the point.

Anything else missing?

Greetings, Jojo

 builtin/log.c |    5 ++++-
 commit.h      |    5 +++++
 pretty.c      |   36 ++++++++++++++++++++++++++++++++----
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b706a5f..dd8e996 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -36,6 +36,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 	int decoration_style = 0;
+	struct userformat_want w;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -58,7 +59,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, opt);
 
-	if (!rev->show_notes_given && !rev->pretty_given)
+	userformat_find_requirements(NULL,&w);
+
+	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
diff --git a/commit.h b/commit.h
index 3cf5166..26ec8c0 100644
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
+extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index 6ba3da8..871f4ae 100644
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
@@ -855,6 +858,31 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	return consumed + 1;
 }
 
+static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
+				   void *context)
+{
+	struct userformat_want *w = context;
+
+	switch (*placeholder) {
+		case 'N': w->notes = 1;
+	}
+	return 0;
+}
+
+void userformat_find_requirements(const char *fmt, struct userformat_want *w)
+{
+	struct strbuf dummy = STRBUF_INIT;
+
+	memset(w, 0, sizeof(*w));
+	if (!fmt) {
+		if (!user_format)
+			return;
+		fmt = user_format;
+	}
+	strbuf_expand(&dummy, user_format, userformat_want_item, w);
+	strbuf_release(&dummy);
+}
+
 void format_commit_message(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
 			   const struct pretty_print_context *pretty_ctx)
-- 
1.7.1.rc1
