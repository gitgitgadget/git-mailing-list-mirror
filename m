From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Remove preemptive allocations.
Date: Sun, 16 Sep 2007 10:19:01 +0200
Message-ID: <20070916172233.A60E42D43A4@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:23:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxpt-00082n-48
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbXIPRWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbXIPRWp
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:45 -0400
Received: from pan.madism.org ([88.191.52.104]:35181 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbXIPRWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:36 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6BEF2202B1;
	Sun, 16 Sep 2007 19:22:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A60E42D43A4; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58332>

Careful profiling shows that we spend more time guessing what pattern
allocation will have, whereas we can delay it only at the point where
add_rfc2047 will be used and don't allocate huge memory area for the many
cases where it's not.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 commit.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/commit.c b/commit.c
index 13af933..85889f9 100644
--- a/commit.c
+++ b/commit.c
@@ -501,6 +501,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 	return;
 
 needquote:
+	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=?%s?q?", encoding);
 	for (i = last = 0; i < len; i++) {
 		unsigned ch = line[i] & 0xFF;
@@ -520,14 +521,6 @@ needquote:
 	strbuf_addstr(sb, "?=");
 }
 
-static unsigned long bound_rfc2047(unsigned long len, const char *encoding)
-{
-	/* upper bound of q encoded string of length 'len' */
-	unsigned long elen = strlen(encoding);
-
-	return len * 3 + elen + 100;
-}
-
 static void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 			 const char *line, enum date_mode dmode,
 			 const char *encoding)
@@ -560,8 +553,7 @@ static void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb
 		add_rfc2047(sb, line, display_name_length, encoding);
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
-	}
-	else {
+	} else {
 		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
 			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
 			      filler, namelen, line);
@@ -955,19 +947,12 @@ static void pp_header(enum cmit_fmt fmt,
 		 * FULLER shows both authors and dates.
 		 */
 		if (!memcmp(line, "author ", 7)) {
-			unsigned long len = linelen;
-			if (fmt == CMIT_FMT_EMAIL)
-				len = bound_rfc2047(linelen, encoding);
-			strbuf_grow(sb, len + 80);
+			strbuf_grow(sb, linelen + 80);
 			add_user_info("Author", fmt, sb, line + 7, dmode, encoding);
 		}
-
 		if (!memcmp(line, "committer ", 10) &&
 		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
-			unsigned long len = linelen;
-			if (fmt == CMIT_FMT_EMAIL)
-				len = bound_rfc2047(linelen, encoding);
-			strbuf_grow(sb, len + 80);
+			strbuf_grow(sb, linelen + 80);
 			add_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
 		}
 	}
@@ -982,7 +967,6 @@ static void pp_title_line(enum cmit_fmt fmt,
 			  int plain_non_ascii)
 {
 	struct strbuf title;
-	unsigned long len;
 
 	strbuf_init(&title, 80);
 
@@ -1004,16 +988,7 @@ static void pp_title_line(enum cmit_fmt fmt,
 		strbuf_add(&title, line, linelen);
 	}
 
-	/* Enough slop for the MIME header and rfc2047 */
-	len = bound_rfc2047(title.len, encoding) + 1000;
-	if (subject)
-		len += strlen(subject);
-	if (after_subject)
-		len += strlen(after_subject);
-	if (encoding)
-		len += strlen(encoding);
-
-	strbuf_grow(sb, title.len + len);
+	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
 		strbuf_addstr(sb, subject);
 		add_rfc2047(sb, title.buf, title.len, encoding);
-- 
1.5.3.1
