From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH] builtin-blame: Reencode commit messages according to git-log rules.
Date: Tue, 21 Oct 2008 01:24:39 +0400
Message-ID: <1224537879-13000-1-git-send-email-angavrilov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 01:08:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks2I0-0003vq-GZ
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 23:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbYJTV0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbYJTV0g
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 17:26:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:25503 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbYJTV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 17:26:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1529508fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=q9JyDbPShf4vWDBQZssjlqinxEhQIVxL6Datf3KqZ7U=;
        b=VTbEGKUnH+lkoTUt7niTmnqqOS0Sbs1a7VofcNpJR/SYNZLAoK5ceOqiB1yQYpoUhv
         Vub4BUmJkIQPA9nT84XmOWVsGu5XFE7/xZZEGbvB9VCzAZ60ejpA3bVkaq9iHyHO1d7d
         JV/8a9rdYRAl1of+YAEsVXXP4UM2cT3hSoDzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jth545gCxAi+rrSHcTcNGHA3fBMzSRKHAiLSTruztyexT0jGghHFRRajYoFO/kEiBf
         bBdsirXEpvZ5MBkXl25i6lecHDLsE7wCN3CYJ10zk6SAHdPl0FAjyBh4E+MHdmY3t/gO
         5uQov7aC8iSwRZ9EMfP8oUsT6jCZv6spOiNjA=
Received: by 10.180.222.1 with SMTP id u1mr278546bkg.190.1224537991000;
        Mon, 20 Oct 2008 14:26:31 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm8399557fkh.11.2008.10.20.14.26.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 14:26:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98739>

Currently git-blame outputs text from the commit messages
(e.g. the author name and the summary string) as-is, without
even providing any information about the encoding used for
the data. It makes interpreting the data in multilingual
environment very difficult.

This commit changes the blame implementation to recode the
messages using the rules used by other commands like git-log.
Namely, the target encoding can be specified through the
i18n.commitEncoding or i18n.logOutputEncoding options, or
directly on the command line using the --encoding parameter.

Converting the encoding before output seems to be more
friendly to the porcelain tools than simply providing the
value of the encoding header, and does not require changing
the output format.

If anybody needs the old behavior, it is possible to
achieve it by specifying --encoding=none.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 Documentation/blame-options.txt |    7 +++++++
 Documentation/i18n.txt          |    6 +++---
 builtin-blame.c                 |   16 +++++++++++-----
 commit.h                        |    2 ++
 pretty.c                        |   21 +++++++++++++++------
 5 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 5428111..51e7f9f 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -49,6 +49,13 @@ of lines before or after the line given by <start>.
 	Show the result incrementally in a format designed for
 	machine consumption.
 
+--encoding=<encoding>::
+	Specifies the encoding used to output author names
+	and commit summaries. Setting it to `none` makes blame
+	output unconverted data. For more information see the
+	discussion about encoding in the linkgit:git-log[1]
+	manual page.
+
 --contents <file>::
 	When <rev> is not specified, the command annotates the
 	changes starting backwards from the working tree copy.
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index d2970f8..2cdacd9 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -37,9 +37,9 @@ of `i18n.commitencoding` in its `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
-. 'git-log', 'git-show' and friends looks at the `encoding`
-  header of a commit object, and tries to re-code the log
-  message into UTF-8 unless otherwise specified.  You can
+. 'git-log', 'git-show', 'git-blame' and friends look at the
+  `encoding` header of a commit object, and try to re-code the
+  log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
   `i18n.logoutputencoding` in `.git/config` file, like this:
 +
diff --git a/builtin-blame.c b/builtin-blame.c
index 48cc0c1..a806036 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1431,7 +1431,7 @@ static void get_commit_info(struct commit *commit,
 			    int detailed)
 {
 	int len;
-	char *tmp, *endp;
+	char *tmp, *endp, *reencoded, *message;
 	static char author_buf[1024];
 	static char committer_buf[1024];
 	static char summary_buf[1024];
@@ -1449,24 +1449,29 @@ static void get_commit_info(struct commit *commit,
 			die("Cannot read commit %s",
 			    sha1_to_hex(commit->object.sha1));
 	}
+	reencoded = reencode_commit_message(commit, NULL);
+	message   = reencoded ? reencoded : commit->buffer;
 	ret->author = author_buf;
-	get_ac_line(commit->buffer, "\nauthor ",
+	get_ac_line(message, "\nauthor ",
 		    sizeof(author_buf), author_buf, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
-	if (!detailed)
+	if (!detailed) {
+		free(reencoded);
 		return;
+	}
 
 	ret->committer = committer_buf;
-	get_ac_line(commit->buffer, "\ncommitter ",
+	get_ac_line(message, "\ncommitter ",
 		    sizeof(committer_buf), committer_buf, &ret->committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
 
 	ret->summary = summary_buf;
-	tmp = strstr(commit->buffer, "\n\n");
+	tmp = strstr(message, "\n\n");
 	if (!tmp) {
 	error_out:
 		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
+		free(reencoded);
 		return;
 	}
 	tmp += 2;
@@ -1478,6 +1483,7 @@ static void get_commit_info(struct commit *commit,
 		goto error_out;
 	memcpy(summary_buf, tmp, len);
 	summary_buf[len] = 0;
+	free(reencoded);
 }
 
 /*
diff --git a/commit.h b/commit.h
index 4c05864..c73fb2d 100644
--- a/commit.h
+++ b/commit.h
@@ -65,6 +65,8 @@ enum cmit_fmt {
 
 extern int non_ascii(int);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+extern char *reencode_commit_message(const struct commit *commit,
+				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
 				  const void *format, struct strbuf *sb,
diff --git a/pretty.c b/pretty.c
index 1e79943..58c8c11 100644
--- a/pretty.c
+++ b/pretty.c
@@ -783,6 +783,20 @@ void pp_remainder(enum cmit_fmt fmt,
 	}
 }
 
+char *reencode_commit_message(const struct commit *commit, const char **encoding_p)
+{
+	const char *encoding;
+
+	encoding = (git_log_output_encoding
+		    ? git_log_output_encoding
+		    : git_commit_encoding);
+	if (!encoding)
+		encoding = "utf-8";
+	if (encoding_p)
+		*encoding_p = encoding;
+	return logmsg_reencode(commit, encoding);
+}
+
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 			 struct strbuf *sb, int abbrev,
 			 const char *subject, const char *after_subject,
@@ -799,12 +813,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		return;
 	}
 
-	encoding = (git_log_output_encoding
-		    ? git_log_output_encoding
-		    : git_commit_encoding);
-	if (!encoding)
-		encoding = "utf-8";
-	reencoded = logmsg_reencode(commit, encoding);
+	reencoded = reencode_commit_message(commit, &encoding);
 	if (reencoded) {
 		msg = reencoded;
 	}
-- 
1.6.0.20.g6148bc
