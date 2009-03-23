From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 1/6] pretty.c: add %f format specifier to format_commit_message()
Date: Sun, 22 Mar 2009 19:14:01 -0700
Message-ID: <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhv-0000lE-2j
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZCWCOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZCWCOP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:7533 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbZCWCOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:14 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2572989wff.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=p00U9+tF49jj6KeKLDBAsiCT00r3pCSqgqZgsMDAXyQ=;
        b=dFhUFtcYWokkTbOK0ioZky3WcmDfu7KH5JwOpHi9YIE9o0d0F/d2zoUjilBJ8HniqP
         LufqSfcoeon6C2hc8h91wd2wX9LlE9s0JKtr1NDrLS+mStyu62yQztX4LP+fSvLeluCV
         pITecma6RglWuhUuMHJeVq0DEV8RjHF1bLXGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GrAMBPrtqxVF5JPTAlT8kFn8ErqarqJprGO96CBBYqzcv7rbz6RrPTU5iqHyY9Lsqk
         m+SWQtUyQF3Wgbj7+xIIhoFaKaHN4VH4fkaB6u3iBLLQhuDr8XwjTdt9KPz/mju5QbG4
         fmodtOHbVZrxCQpNdBZtSBER+Q1+mgK5M7CoM=
Received: by 10.143.167.15 with SMTP id u15mr2611376wfo.147.1237774452253;
        Sun, 22 Mar 2009 19:14:12 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 29sm10257979wfg.53.2009.03.22.19.14.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:11 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:09 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <cover.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114231>

This specifier represents the sanitized and filename friendly subject
line of a commit. No checks are made against the length of the string,
so users may need to trim the result to the desired length if using as a
filename. This is commonly used by format-patch to massage commit
subjects into filenames and output patches to files.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 5c6e678..2a845b1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -121,6 +121,7 @@ The placeholders are:
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
+- '%f': sanitized subject line, suitable for a filename
 - '%b': body
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
diff --git a/pretty.c b/pretty.c
index efa7024..97de415 100644
--- a/pretty.c
+++ b/pretty.c
@@ -493,6 +493,41 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
+static int istitlechar(char c)
+{
+	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
+		(c >= '0' && c <= '9') || c == '.' || c == '_';
+}
+
+static void format_sanitized_subject(struct strbuf *sb, const char *msg)
+{
+	size_t trimlen;
+	int space = 0;
+
+	for (; *msg && *msg != '\n'; msg++) {
+		if (istitlechar(*msg))
+		{
+		    if (space) {
+			strbuf_addch(sb, '-');
+			space = 0;
+		    }
+		    strbuf_addch(sb, *msg);
+		    if (*msg == '.')
+			while (*(msg+1) == '.')
+				msg++;
+		}
+		else
+			space = 1;
+	}
+
+	// trim any trailing '.' or '-' characters
+	trimlen = 0;
+	while (sb->buf[sb->len - 1 - trimlen] == '.'
+		|| sb->buf[sb->len - 1 - trimlen] == '-')
+		trimlen++;
+	strbuf_remove(sb, sb->len - trimlen, trimlen);
+}
+
 const char *format_subject(struct strbuf *sb, const char *msg,
 			   const char *line_separator)
 {
@@ -683,6 +718,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 's':	/* subject */
 		format_subject(sb, msg + c->subject_off, " ");
 		return 1;
+	case 'f':	/* sanitized subject */
+		format_sanitized_subject(sb, msg + c->subject_off);
+		return 1;
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
-- 
1.6.2
