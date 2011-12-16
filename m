From: Jeff King <peff@peff.net>
Subject: [PATCH] pretty: give placeholders to reflog identity
Date: Fri, 16 Dec 2011 06:40:24 -0500
Message-ID: <20111216114024.GA16965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 12:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbW9h-0007qh-9O
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 12:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab1LPLkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 06:40:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44002
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758846Ab1LPLk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 06:40:27 -0500
Received: (qmail 3781 invoked by uid 107); 16 Dec 2011 11:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 06:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 06:40:24 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187272>

When doing a reflog walk, you can get some information about
the reflog (such as the subject line), but not the identity
information (i.e., name and email).

Let's make those available, mimicing the options for author
and committer identity.

Signed-off-by: Jeff King <peff@peff.net>
---
Initial posting and discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/185043

Response was positive, but we were in 1.7.8 release freeze, so you asked
me to hold and re-post.

 Documentation/pretty-formats.txt |    4 ++++
 pretty.c                         |   25 +++++++++++++++++++++++++
 reflog-walk.c                    |   12 ++++++++++++
 reflog-walk.h                    |    1 +
 t/t6006-rev-list-format.sh       |    6 ++++++
 5 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..880b6f2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -132,6 +132,10 @@ The placeholders are:
 - '%N': commit notes
 - '%gD': reflog selector, e.g., `refs/stash@\{1\}`
 - '%gd': shortened reflog selector, e.g., `stash@\{1\}`
+- '%gn': reflog identity name
+- '%gN': reflog identity name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
+- '%ge': reflog identity email
+- '%gE': reflog identity email (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%gs': reflog subject
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
diff --git a/pretty.c b/pretty.c
index 230fe1c..1580299 100644
--- a/pretty.c
+++ b/pretty.c
@@ -822,6 +822,23 @@ static void rewrap_message_tail(struct strbuf *sb,
 	c->indent2 = new_indent2;
 }
 
+static int format_reflog_person(struct strbuf *sb,
+				char part,
+				struct reflog_walk_info *log,
+				enum date_mode dmode)
+{
+	const char *ident;
+
+	if (!log)
+		return 2;
+
+	ident = get_reflog_ident(log);
+	if (!ident)
+		return 2;
+
+	return format_person_part(sb, part, ident, strlen(ident), dmode);
+}
+
 static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 				void *context)
 {
@@ -963,6 +980,14 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_message(sb, c->pretty_ctx->reflog_info);
 			return 2;
+		case 'n':
+		case 'N':
+		case 'e':
+		case 'E':
+			return format_reflog_person(sb,
+						    placeholder[1],
+						    c->pretty_ctx->reflog_info,
+						    c->pretty_ctx->date_mode);
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
diff --git a/reflog-walk.c b/reflog-walk.c
index da71a85..c7095b7 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -294,6 +294,18 @@ void get_reflog_message(struct strbuf *sb,
 	strbuf_add(sb, info->message, len);
 }
 
+const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+
+	if (!commit_reflog)
+		return NULL;
+
+	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+	return info->email;
+}
+
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 	enum date_mode dmode)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index 7bd2cd4..afb1ae3 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -14,6 +14,7 @@ extern void show_reflog_message(struct reflog_walk_info *info, int,
 		enum date_mode);
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
+extern const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
 		enum date_mode dmode,
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index d918cc0..4442790 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -267,6 +267,12 @@ test_expect_success '%gd shortens ref name' '
 	test_cmp expect.gd-short actual.gd-short
 '
 
+test_expect_success 'reflog identity' '
+	echo "C O Mitter:committer@example.com" >expect &&
+	git log -g -1 --format="%gn:%ge" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'oneline with empty message' '
 	git commit -m "dummy" --allow-empty &&
 	git commit -m "dummy" --allow-empty &&
-- 
1.7.7.4.13.g57bf4
