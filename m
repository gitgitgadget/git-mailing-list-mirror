From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
Date: Thu, 24 May 2012 19:28:40 -0400
Message-ID: <20120524232840.GE11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhSa-0003pg-2u
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab2EXX2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:28:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54595
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2EXX2n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:28:43 -0400
Received: (qmail 2220 invoked by uid 107); 24 May 2012 23:29:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:29:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:28:40 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198448>

Callers who ask for ERROR_ON_NO_NAME are not so much
concerned that the name will be blank (because, after all,
we will fall back to using the username), but rather it is a
check to make sure that low-quality identities do not end up
in things like commit messages or emails (whereas it is OK
for them to end up in things like reflogs).

When future commits add more quality checks on the identity,
each of these callers would want to use those checks, too.
Rather than modify each of them later to add a new flag,
let's refactor the flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 3 +--
 builtin/log.c    | 2 +-
 builtin/merge.c  | 4 ++--
 builtin/tag.c    | 2 +-
 builtin/var.c    | 4 ++--
 cache.h          | 2 +-
 commit.c         | 4 ++--
 gpg-interface.c  | 2 +-
 ident.c          | 6 +++---
 9 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a2ec73d..f43eaaf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -526,8 +526,7 @@ static void determine_author_info(struct strbuf *author_ident)
 
 	if (force_date)
 		date = force_date;
-	strbuf_addstr(author_ident, fmt_ident(name, email, date,
-					      IDENT_ERROR_ON_NO_NAME));
+	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
 	if (!split_ident_line(&author, author_ident->buf, author_ident->len)) {
 		export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 		export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/builtin/log.c b/builtin/log.c
index 4538309..d86bca3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1147,7 +1147,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (do_signoff) {
 		const char *committer;
 		const char *endpos;
-		committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
+		committer = git_committer_info(IDENT_STRICT);
 		endpos = strchr(committer, '>');
 		if (!endpos)
 			die(_("bogus committer info %s"), committer);
diff --git a/builtin/merge.c b/builtin/merge.c
index 470fc57..dd50a0c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1447,7 +1447,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		refresh_cache(REFRESH_QUIET);
 		if (allow_trivial && !fast_forward_only) {
 			/* See if it is really trivial. */
-			git_committer_info(IDENT_ERROR_ON_NO_NAME);
+			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
 			if (!read_tree_trivial(common->item->object.sha1,
 					       head_commit->object.sha1,
@@ -1490,7 +1490,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		die(_("Not possible to fast-forward, aborting."));
 
 	/* We are going to make a new commit. */
-	git_committer_info(IDENT_ERROR_ON_NO_NAME);
+	git_committer_info(IDENT_STRICT);
 
 	/*
 	 * At this point, we need a real merge.  No matter what strategy
diff --git a/builtin/tag.c b/builtin/tag.c
index 4fb6bd7..7b1be85 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -332,7 +332,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 			  sha1_to_hex(object),
 			  typename(type),
 			  tag,
-			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
+			  git_committer_info(IDENT_STRICT));
 
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
diff --git a/builtin/var.c b/builtin/var.c
index 99d068a..aedbb53 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -11,7 +11,7 @@ static const char *editor(int flag)
 {
 	const char *pgm = git_editor();
 
-	if (!pgm && flag & IDENT_ERROR_ON_NO_NAME)
+	if (!pgm && flag & IDENT_STRICT)
 		die("Terminal is dumb, but EDITOR unset");
 
 	return pgm;
@@ -55,7 +55,7 @@ static const char *read_var(const char *var)
 	val = NULL;
 	for (ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
-			val = ptr->read(IDENT_ERROR_ON_NO_NAME);
+			val = ptr->read(IDENT_STRICT);
 			break;
 		}
 	}
diff --git a/cache.h b/cache.h
index 4a76c23..06413e1 100644
--- a/cache.h
+++ b/cache.h
@@ -887,7 +887,7 @@ unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
-#define IDENT_ERROR_ON_NO_NAME 1
+#define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
 extern const char *git_author_info(int);
diff --git a/commit.c b/commit.c
index 9ed36c7..8248a99 100644
--- a/commit.c
+++ b/commit.c
@@ -1154,9 +1154,9 @@ int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
 
 	/* Person/date information */
 	if (!author)
-		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
+		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
+	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 09ab64a..0863c61 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -30,7 +30,7 @@ const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_ERROR_ON_NO_NAME|IDENT_NO_DATE);
+	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
 /*
diff --git a/ident.c b/ident.c
index 8b5080d..c42258f 100644
--- a/ident.c
+++ b/ident.c
@@ -267,7 +267,7 @@ const char *fmt_ident(const char *name, const char *email,
 {
 	static struct strbuf ident = STRBUF_INIT;
 	char date[50];
-	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
+	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
@@ -279,7 +279,7 @@ const char *fmt_ident(const char *name, const char *email,
 	if (want_name && !*name) {
 		struct passwd *pw;
 
-		if (error_on_no_name) {
+		if (strict) {
 			if (name == git_default_name.buf)
 				fputs(env_hint, stderr);
 			die("empty ident name (for <%s>) not allowed", email);
@@ -314,7 +314,7 @@ const char *fmt_ident(const char *name, const char *email,
 
 const char *fmt_name(const char *name, const char *email)
 {
-	return fmt_ident(name, email, NULL, IDENT_ERROR_ON_NO_NAME | IDENT_NO_DATE);
+	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
 }
 
 const char *git_author_info(int flag)
-- 
1.7.10.1.25.g7031a0f
