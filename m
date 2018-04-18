Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14CC1F424
	for <e@80x24.org>; Wed, 18 Apr 2018 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDRKXB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 06:23:01 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:29772 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeDRKXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 06:23:00 -0400
Received: from lindisfarne.localdomain ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 8kEmfh02ZLjjA8kEsfWLlj; Wed, 18 Apr 2018 11:22:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524046979;
        bh=B6CYJpdJIQC/6uDqjjXYdhBf+6X2zZ8OJCp45tO+CKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=o5rIKksFVLN3SsGheT42O6LBUY374A+yITWNzbkmupjrNR1CMYBAz4vULohrNHNtv
         IdcD3zs5lfGD6+rPv9gG/QBPB9LG8OX0um+bRHQzAriAoTr3GKFnv61YYSDP3Cfvls
         hDv9Zodw3KbbEqKdqxRvutxnACY6+2vV+kO27G4k=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=evINK-nbAAAA:8 a=A9qS8gIqAAAA:8
 a=LzfmI6SqJrxuUzFKuroA:9 a=a4A-H4iTHQUEohuw:21 a=A_9u3xASPiTca09J:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=H28RkzuXznr5akrmL4QT:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH] ident: don't cache default date
Date:   Wed, 18 Apr 2018 11:22:36 +0100
Message-Id: <20180418102236.7183-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJ+BHaVFu1DO8TMDJq4Qftl6sEUMQIhKleOh3nZr/ITcOPwU4s0gKWxG8yPQV9p8COFxE8iyB8nLfOd1AFZhcWcFYvRm6xuQ24JGIr4YIAWQYfGB9ZdE
 cWoJqVvOrLAbxhfj7txNAgutt4uB7LVvk/cMDqaiExSgwS4hbrdadpXkmxcdaSKaZRiZvc6jM6h7zLCcHkHd6hiRHBZYle6Gb4TnvFF3OtwE4PSeHEpH05da
 qzRvssSHIMS9pjjizJamjnWxFsdFVMONPZjjUTTEbghDVNaUfi6aCusrtH9SUPIVe28edXaunMPww7IzFLkdqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the sequencer commits without forking when the commit message
isn't edited all the commits that are picked have the same committer
date. If a commit is reworded it's committer date will be a later time
as it is created by running an separate instance of 'git commit'.  If
the reworded commit is follow by further picks, those later commits
will have an earlier committer date than the reworded one. This is
caused by git caching the default date used when GIT_COMMITTER_DATE is
not set. Fix this by not caching the date.

Users expect commits to have the same author and committer dates when
the don't explicitly set them. As the date is now updated each time
git_author_info() or git_committer_info() is run it is possible to end
up with different author and committer dates. Fix this for
'commit-tree', 'notes' and 'merge' by using a single date in
commit_tree_extended() and passing it explicitly to the new functions
git_author_info_with_date() and git_committer_info_with_date() when
neither the author date nor the committer date are explicitly
set. 'commit' always passes the author date to commit_tree_extended()
and relied on the date caching to have the same committer and author
dates when neither was specified. Fix this by setting
GIT_COMMITTER_DATE to be the same as the author date passed to
commit_tree_extended().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reported-by: Johannes Sixt <j6t@kdbg.org>
---

I'm slightly nervous that setting GIT_COMMITTER_DATE in
builtin/commit.c will break someone's hook script. Maybe it would be
better to add a committer parameter to commit_tree() and
commit_tree_extended().

This needs some tests. I think we could test that the sequencer gives
each commit a new date with 'git rebase -i --exec="sleep 2"
--force-rebase @~2' and test the committer dates of the rebased
commits. I'm not sure if test -gt can cope with numbers that big
though, maybe we'll have to be content with test !=. For 'git commit'
I think doing GIT_EDITOR='sleep 2; echo message >"$1"' and checking
the committer date and author date will work as the author date is set
before the user edits the commit message. I'm not sure how to test
callers of commit_tree() though (that's commit-tree, notes and merge)
as I've not been able to come up with anything that will guarantee the
author and committer dates are different if the code in
commit_tree_extended() that ensures they are the same gets broken.

 builtin/commit.c |  8 ++++++++
 cache.h          |  2 ++
 commit.c         | 22 +++++++++++++++++++---
 ident.c          | 24 ++++++++++++++++++------
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 37fcb55ab0..4ad8317f88 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -584,6 +584,14 @@ static void determine_author_info(struct strbuf *author_ident)
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
 	export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
+	/*
+	 * Ensure the author and committer dates are identical if nither is
+	 * explicitly set
+	 */
+	if ((!date || !*date) && (!getenv("GIT_COMMITTER_DATE")
+				  || !*getenv("GIT_COMMITTER_DATE")))
+		export_one("GIT_COMMITTER_DATE", author.date_begin,
+			   author.tz_end, '@');
 	free(name);
 	free(email);
 	free(date);
diff --git a/cache.h b/cache.h
index a61b2d3f0d..9cde499507 100644
--- a/cache.h
+++ b/cache.h
@@ -1484,7 +1484,9 @@ int date_overflows(timestamp_t date);
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
 extern const char *git_author_info(int);
+extern const char *git_author_info_with_date(int, const char*);
 extern const char *git_committer_info(int);
+extern const char *git_committer_info_with_date(int, const char*);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
diff --git a/commit.c b/commit.c
index 00c99c7272..457cc8b71b 100644
--- a/commit.c
+++ b/commit.c
@@ -1513,6 +1513,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
 {
+	struct strbuf date_buf = STRBUF_INIT;
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
@@ -1540,10 +1541,25 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* Person/date information */
-	if (!author)
-		author = git_author_info(IDENT_STRICT);
+	if (!author) {
+		char *author_date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
+		char *committer_date =
+				xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
+		/*
+		 * If neither the author nor committer dates are explicitly set
+		 * ensure they are identical
+		 */
+		if (!author_date && !committer_date) {
+			datestamp(&date_buf);
+		}
+		author = git_author_info_with_date(IDENT_STRICT, date_buf.buf);
+		free(author_date);
+		free(committer_date);
+	}
 	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
+	strbuf_addf(&buffer, "committer %s\n",
+		    git_committer_info_with_date(IDENT_STRICT, date_buf.buf));
+	strbuf_release(&date_buf);
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
diff --git a/ident.c b/ident.c
index 327abe557f..f9eb933c2c 100644
--- a/ident.c
+++ b/ident.c
@@ -178,8 +178,8 @@ const char *ident_default_email(void)
 
 static const char *ident_default_date(void)
 {
-	if (!git_default_date.len)
-		datestamp(&git_default_date);
+	strbuf_reset(&git_default_date);
+	datestamp(&git_default_date);
 	return git_default_date.buf;
 }
 
@@ -427,30 +427,42 @@ const char *fmt_name(const char *name, const char *email)
 	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
 }
 
-const char *git_author_info(int flag)
+const char *git_author_info_with_date(int flag, const char *date_str)
 {
 	if (getenv("GIT_AUTHOR_NAME"))
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_AUTHOR_EMAIL"))
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
-			 getenv("GIT_AUTHOR_DATE"),
+			 date_str && *date_str ? date_str :
+					getenv("GIT_AUTHOR_DATE"),
 			 flag);
 }
 
-const char *git_committer_info(int flag)
+const char *git_author_info(int flag)
+{
+	return git_author_info_with_date(flag, NULL);
+}
+
+const char *git_committer_info_with_date(int flag, const char *date_str)
 {
 	if (getenv("GIT_COMMITTER_NAME"))
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_COMMITTER_EMAIL"))
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
-			 getenv("GIT_COMMITTER_DATE"),
+			 date_str && *date_str ? date_str :
+					getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
 
+const char *git_committer_info(int flag)
+{
+	return git_committer_info_with_date(flag, NULL);
+}
+
 static int ident_is_sufficient(int user_ident_explicitly_given)
 {
 #ifndef WINDOWS
-- 
2.17.0

