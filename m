From: Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 2/2] commit: fix ending newline for template files
Date: Tue, 26 May 2015 08:15:08 +0200
Message-ID: <1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 08:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx8AB-0006NG-4V
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 08:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbbEZGQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 02:16:00 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37559 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbEZGP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 02:15:57 -0400
Received: by wifw1 with SMTP id w1so17390897wif.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxgQvEBLkr6AcypuM/n8WrkYCjdwcP8rcSaZPAbohI0=;
        b=CghD5ILTmKk7OXAQe5gH4UtwqGy6plc0x630v7+KnNDsY0vjU/1yl75JyM2iekqlnd
         3+DNqRaLiDglvE0MvhOoDmtriWNwFpzbGBi+jS1/eM1SjcmNEL2sWVepNjdU2i4QYCI+
         VphyUaYkKdCrb5kaG7AMAxoIdNNJwMnb/xEjSkXbrZdHcIk+obl7dcKLwCWkadRsfd07
         rLYt/d+hbqE43fxBuvKc7Bq9tWYlWe3VrKkylFU51Bskwn5T2KgG2gkv1R4QO9zB2wnZ
         Vg1/8PpKhO/xPrIT5XZzvtbTmtrwW/SjpoNPr25YqX1V1TB8VUKFKFCCaVZMk8sfGlQ0
         1CgQ==
X-Received: by 10.180.89.211 with SMTP id bq19mr36084499wib.17.1432620916723;
        Mon, 25 May 2015 23:15:16 -0700 (PDT)
Received: from tars.localdomain ([188.121.16.104])
        by mx.google.com with ESMTPSA id js3sm20027090wjc.5.2015.05.25.23.15.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 23:15:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269931>

git-commit with -t or -F -e uses content of user-supplied file as
initial value for commit msg in editor. There is no guarantee, that this
file ends with newline - it depends on file content and editor used to
create file (some editors append and hide last newline from user while
others do not).

When --status (default) is supplied, additional comment is placed after
template content. If template file ended with newline this results in
additional line being appended (which may be unexpected e.g. when last
line of template is a comment). On the other hand, first line of status
should never be concatenated to last line of template file.

Append newline before status _only_ if template/logfile didn't end with
one already. This way content of template is exactly the way user intended
and there's no chance, that line of status will merge with last line of
template.

Remove unnecessary premature cleanup of commit message, which was
implemented for -F, but not for -t.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/commit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da79ac4..eb41e05 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -666,8 +666,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
-	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int sb_ends_with_newline = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -737,7 +737,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno(_("could not read '%s'"), template_file);
 		hook_arg1 = "template";
-		clean_message_contents = 0;
 	}
 
 	/*
@@ -775,9 +774,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	s->hints = 0;
 
-	if (clean_message_contents)
-		stripspace(&sb, 0);
-
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(&sb), 0);
 
@@ -786,6 +782,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	if (auto_comment_line_char)
 		adjust_comment_line_char(&sb);
+
+	sb_ends_with_newline = ends_with(sb.buf, "\n");
+
 	strbuf_release(&sb);
 
 	/* This checks if committer ident is explicitly given */
@@ -794,6 +793,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		int ident_shown = 0;
 		int saved_color_setting;
 		struct ident_split ci, ai;
+		int append_newline = (template_file || logfile) ? !sb_ends_with_newline : 1;
+
+		if (append_newline)
+			fprintf(s->fp, "\n");
 
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == CLEANUP_SCISSORS)
@@ -815,7 +818,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					 : "CHERRY_PICK_HEAD"));
 		}
 
-		fprintf(s->fp, "\n");
 		if (cleanup_mode == CLEANUP_ALL)
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
-- 
2.4.1
