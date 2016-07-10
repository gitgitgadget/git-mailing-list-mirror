Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5341FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 05:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbcGJFyK (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 01:54:10 -0400
Received: from imap.thunk.org ([74.207.234.97]:50672 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbcGJFyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 01:54:08 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=Message-Id:Date:Subject:Cc:To:From; bh=/RyGf520F2G6zYe7si3k9e6nsINj1+I8kYPmcaNfvBg=;
	b=XO3V6WW4bQ82GBZNg5gGNDRXHdpfqD9es4+YhD7B2lgYiHVQ1TznBF2hki9et1uNmnaPSSYUYZwFHISv7pA9SS9CMrnFfr+k9hKW+T1Xlywx3WHVW5EDxmmIP/4WmliCuE4C3LI/hBWERI2NWslMFFAnoEV9udzYlKvI2K9/bSI=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bM7gr-00083V-PM; Sun, 10 Jul 2016 05:54:05 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id EBD4A8219C2; Sun, 10 Jul 2016 01:54:04 -0400 (EDT)
From:	Theodore Ts'o <tytso@mit.edu>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Date:	Sun, 10 Jul 2016 01:54:02 -0400
Message-Id: <20160710055402.32684-1-tytso@mit.edu>
X-Mailer: git-send-email 2.9.0.243.g5c589a7.dirty
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add new format specifiers which allow the printing of reflog
timestamp.  This allows us to know when operations which change HEAD
take place (e.g., guilt pop -a, which does the equivalent of a "git
reset --hard commit"), since using %cr will display when the commit
was originally made, instead of when HEAD was moved to that commit.

This allows something like:

git log -g --pretty=format:'%Cred%h%Creset %gd %gs %Cgreen(%gr)%Creset %s' --abbrev-commit

to provide what (for me) is a much more useful "git reflog" type of
report.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/pretty-formats.txt |  4 ++++
 cache.h                          |  1 +
 date.c                           |  2 +-
 pretty.c                         | 18 ++++++++++++++++
 reflog-walk.c                    | 45 ++++++++++++++++++++++++++++++----------
 reflog-walk.h                    |  3 +++
 6 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 29b19b9..7927754 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -156,6 +156,10 @@ endif::git-rev-list[]
 - '%gE': reflog identity email (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%gs': reflog subject
+- '%gr': reflog date, relative
+- '%gt': reflog date, UNIX timestamp
+- '%gi': reflog date, ISO 8601-like format
+- '%gI': reflog date, strict ISO 8601 format
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/cache.h b/cache.h
index f1dc289..5dd2805 100644
--- a/cache.h
+++ b/cache.h
@@ -1237,6 +1237,7 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
+time_t gm_time_t(unsigned long time, int tz);
 const char *show_date(unsigned long time, int timezone, const struct date_mode *mode);
 void show_date_relative(unsigned long time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
diff --git a/date.c b/date.c
index 4c7aa9b..f98502e 100644
--- a/date.c
+++ b/date.c
@@ -39,7 +39,7 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
-static time_t gm_time_t(unsigned long time, int tz)
+time_t gm_time_t(unsigned long time, int tz)
 {
 	int minutes;
 
diff --git a/pretty.c b/pretty.c
index 330a5e0..eb1f44e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1212,6 +1212,24 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 						    placeholder[1],
 						    c->pretty_ctx->reflog_info,
 						    &c->pretty_ctx->date_mode);
+		case 'r':	/* date, relative */
+			strbuf_addstr(sb,
+				show_reflog_date(c->pretty_ctx->reflog_info,
+					DATE_MODE(RELATIVE)));
+			return 2;
+		case 'i':	/* date, ISO 8601-like */
+			strbuf_addstr(sb,
+				show_reflog_date(c->pretty_ctx->reflog_info,
+					DATE_MODE(ISO8601)));
+			return 2;
+		case 'I':	/* date, ISO 8601 strict */
+			strbuf_addstr(sb,
+				show_reflog_date(c->pretty_ctx->reflog_info,
+					DATE_MODE(ISO8601_STRICT)));
+			return 2;
+		case 't':
+			strbuf_addf(sb, "%lu", get_reflog_time_t(c->pretty_ctx->reflog_info));
+			return 2;
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
diff --git a/reflog-walk.c b/reflog-walk.c
index a246af2..d0aa2d0 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -292,17 +292,24 @@ void get_reflog_selector(struct strbuf *sb,
 	strbuf_addch(sb, '}');
 }
 
-void get_reflog_message(struct strbuf *sb,
-			struct reflog_walk_info *reflog_info)
+static struct reflog_info *get_reflog_info(struct reflog_walk_info *reflog_info)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
-	struct reflog_info *info;
-	size_t len;
 
 	if (!commit_reflog)
-		return;
+		return NULL;
+
+	return &commit_reflog->reflogs->items[commit_reflog->recno+1];
+}
 
-	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+void get_reflog_message(struct strbuf *sb,
+			struct reflog_walk_info *reflog_info)
+{
+	struct reflog_info *info = get_reflog_info(reflog_info);
+	size_t len;
+
+	if (!info)
+		return NULL;
 	len = strlen(info->message);
 	if (len > 0)
 		len--; /* strip away trailing newline */
@@ -311,16 +318,32 @@ void get_reflog_message(struct strbuf *sb,
 
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 {
-	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
-	struct reflog_info *info;
+	struct reflog_info *info = get_reflog_info(reflog_info);
 
-	if (!commit_reflog)
+	if (!info)
 		return NULL;
-
-	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 	return info->email;
 }
 
+unsigned long get_reflog_time_t(struct reflog_walk_info *reflog_info)
+{
+	struct reflog_info *info = get_reflog_info(reflog_info);
+
+	if (!info)
+		return NULL;
+	return gm_time_t(info->timestamp, info->tz);
+}
+
+const char *show_reflog_date(struct reflog_walk_info *reflog_info,
+			     const struct date_mode *mode)
+{
+	struct reflog_info *info = get_reflog_info(reflog_info);
+
+	if (!info)
+		return NULL;
+	return show_date(info->timestamp, info->tz, mode);
+}
+
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 			 const struct date_mode *dmode, int force_date)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index 27886f7..aaccc58 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -15,6 +15,9 @@ extern void show_reflog_message(struct reflog_walk_info *info, int,
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
 extern const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
+extern unsigned long get_reflog_time_t(struct reflog_walk_info *reflog_info);
+extern const char *show_reflog_date(struct reflog_walk_info *reflog_info,
+				    const struct date_mode *mode);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
 		const struct date_mode *dmode, int force_date,
-- 
2.9.0.243.g5c589a7.dirty

