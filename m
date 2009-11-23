From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] strbuf_add_wrapped_text(): skip over colour codes
Date: Mon, 23 Nov 2009 23:40:03 +0100
Message-ID: <4B0B0F43.6080509@lsrfire.ath.cx>
References: <4B0963A3.4060804@lsrfire.ath.cx> <7vzl6eiiyx.fsf@alter.siamese.dyndns.org> <4B09CD5A.4070401@lsrfire.ath.cx> <7vtywmayvk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 23:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCha2-0002Fv-TI
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 23:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbZKWWkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZKWWkJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 17:40:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:48728 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZKWWkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 17:40:09 -0500
Received: from [10.0.1.101] (p57B7BDDD.dip.t-dialin.net [87.183.189.221])
	by india601.server4you.de (Postfix) with ESMTPSA id 3FF5D2F8051;
	Mon, 23 Nov 2009 23:40:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vtywmayvk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133537>

Ignore display mode escape sequences (colour codes) for the purpose of
text wrapping because they don't have a visible width.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Renamed function to document its purpose and limitation, and remove
the note that is obsoleted by this patch.

 Documentation/pretty-formats.txt |    4 +---
 utf8.c                           |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 7ff6a6c..0683fb3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -136,9 +136,7 @@ The placeholders are:
 - '%n': newline
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
-  linkgit:git-shortlog[1].  NOTE: Color placeholders (`%C*`) are not
-  recognized as having no width, so they should not be put into wrapped
-  sections.
+  linkgit:git-shortlog[1].
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/utf8.c b/utf8.c
index 01d1869..7ddff23 100644
--- a/utf8.c
+++ b/utf8.c
@@ -314,6 +314,20 @@ static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 	}
 }
 
+static size_t display_mode_esc_sequence_len(const char *s)
+{
+	const char *p = s;
+	if (*p++ != '\033')
+		return 0;
+	if (*p++ != '[')
+		return 0;
+	while (isdigit(*p) || *p == ';')
+		p++;
+	if (*p++ != 'm')
+		return 0;
+	return p - s;
+}
+
 /*
  * Wrap the text, if necessary. The variable indent is the indent for the
  * first line, indent2 is the indent for all other lines.
@@ -337,7 +351,13 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 	}
 
 	for (;;) {
-		char c = *text;
+		char c;
+		size_t skip;
+
+		while ((skip = display_mode_esc_sequence_len(text)))
+			text += skip;
+
+		c = *text;
 		if (!c || isspace(c)) {
 			if (w < width || !space) {
 				const char *start = bol;
-- 
1.6.5
