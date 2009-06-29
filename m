From: Roger Leigh <rleigh@debian.org>
Subject: [PATCH] builtin-mailinfo.c: Trim only first pair of square brackets in subject
Date: Mon, 29 Jun 2009 22:17:00 +0100
Message-ID: <1246310220-16909-1-git-send-email-rleigh@debian.org>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
Cc: Roger Leigh <rleigh@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 23:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOER-0005yi-GA
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbZF2VRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbZF2VRa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:17:30 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:54074 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbZF2VR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:17:29 -0400
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id 365C418223; Mon, 29 Jun 2009 22:17:30 +0100 (BST)
Received: from hardknott (unknown [78.148.79.113])
	by nagini.codelibre.net (Postfix) with ESMTPSA id 65CB9181C0;
	Mon, 29 Jun 2009 22:17:28 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id 9D534120C1; Mon, 29 Jun 2009 22:17:28 +0100 (BST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122458>

Use a regular expression to match text after "Re:" or any text in the
first pair of square brackets such as "[PATCH n/m]".  This replaces
the complex hairy string munging with a simple single  pattern match.

Signed-off-by: Roger Leigh <rleigh@debian.org>
---
 builtin-mailinfo.c |   61 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..6d19046 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -219,35 +219,42 @@ static int is_multipart_boundary(const struct strbuf *line)
 
 static void cleanup_subject(struct strbuf *subject)
 {
-	char *pos;
-	size_t remove;
-	while (subject->len) {
-		switch (*subject->buf) {
-		case 'r': case 'R':
-			if (subject->len <= 3)
-				break;
-			if (!memcmp(subject->buf + 1, "e:", 2)) {
-				strbuf_remove(subject, 0, 3);
-				continue;
-			}
-			break;
-		case ' ': case '\t': case ':':
-			strbuf_remove(subject, 0, 1);
-			continue;
-		case '[':
-			if ((pos = strchr(subject->buf, ']'))) {
-				remove = pos - subject->buf;
-				if (remove <= (subject->len - remove) * 2) {
-					strbuf_remove(subject, 0, remove + 1);
-					continue;
-				}
-			} else
-				strbuf_remove(subject, 0, 1);
-			break;
-		}
+	int status;
+	regex_t regex;
+	regmatch_t match[4];
+
+	/* Strip off 'Re:' and/or the first text in square brackets, such as
+	   '[PATCH]' at the start of the mail Subject. */
+	status = regcomp(&regex,
+			 "^([Rr]e:)?([^]]*\\[[^]]+\\])(.*)$",
+			 REG_EXTENDED);
+
+	if (status) {
+		/* Compiling the regex failed.  Find out why and tell
+		   the user.  This is always a bug in the code. */
+		int esize = regerror(status, &regex, NULL, 0);
+		struct strbuf etext = STRBUF_INIT;
+
+		strbuf_grow(&etext, esize);
+		regerror(status, &regex, etext.buf, esize);
+		fprintf (stderr,
+			 "Error compiling regular expression: %s\n",
+			 etext.buf);
+		strbuf_release(&etext);
+		exit(1);
+	}
+
+	/* Store any matches in match. */
+	status = regexec(&regex, subject->buf, 4, match, 0);
+
+	/* If there was a match for \3 in the regex, trim the subject
+	   to this match. */
+	if (!status && match[3].rm_so > 0) {
+		strbuf_remove(subject, 0, match[3].rm_so);
 		strbuf_trim(subject);
-		return;
 	}
+
+	return;
 }
 
 static void cleanup_space(struct strbuf *sb)
-- 
1.6.3.3
