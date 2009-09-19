From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv3] git-log --format: Add %B tag with %B(x) option
Date: Sat, 19 Sep 2009 11:58:24 +0200
Message-ID: <1253354304-13117-1-git-send-email-heipei@hackvalue.de>
References: <7vtyz083tk.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 19 11:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mowi6-0006W7-C6
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 11:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZISJ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 05:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZISJ6V
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 05:58:21 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:35310 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZISJ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 05:58:20 -0400
Received: from u-7-100.vpn.rwth-aachen.de ([137.226.103.100]:48037 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1Mowht-0004UX-8s; Sat, 19 Sep 2009 11:58:17 +0200
X-Mailer: git-send-email 1.6.5.rc1.20.geb7d9
In-Reply-To: <7vtyz083tk.fsf@alter.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.103.100
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128824>

Since one can simply use spaces to indent any other --pretty field we
should have an option to do that with the body too.

Also the %B flag strips the trailing newlines, to enable more compact
display.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Changes to PATCHv2:
- Make %B() strict: Only nonnegative integers are allowed between the brackets, 
  everything else yields the placemark itself as output to indicate a wrong 
  argument. This also goes for an empty argument.

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |   29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..533bc5e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,8 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%B': body without trailing newline
+- '%B(x)': body indented by x spaces
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f5983f8..8970378 100644
--- a/pretty.c
+++ b/pretty.c
@@ -605,13 +605,17 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	int h1, h2;
 
 	/* these are independent of the commit */
+
+	const char *body = msg + c->body_off;
+	const char *end = NULL;
+	/* check if we have arguments to the placeholder */
+	if (placeholder[1] == '(')
+		end = strchr(placeholder + 2, ')');
+
 	switch (placeholder[0]) {
 	case 'C':
-		if (placeholder[1] == '(') {
-			const char *end = strchr(placeholder + 2, ')');
+		if (end) {
 			char color[COLOR_MAXLEN];
-			if (!end)
-				return 0;
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
 					"--pretty format", color);
@@ -733,7 +737,20 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		format_sanitized_subject(sb, msg + c->subject_off);
 		return 1;
 	case 'b':	/* body */
-		strbuf_addstr(sb, msg + c->body_off);
+		strbuf_addstr(sb, body);
+		return 1;
+	case 'B':	/* body without trailing newline */
+		if (end) {
+			char *endp = NULL;
+			int indent = strtol(placeholder + 2, &endp, 10);
+			if (placeholder + 2 == endp || *endp != ')' || indent < 0)
+				return 0;
+			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, indent);
+			strbuf_rtrim(sb);
+			return end - placeholder + 1;
+		}
+		strbuf_addstr(sb, body);
+		strbuf_rtrim(sb);
 		return 1;
 	}
 	return 0;	/* unknown placeholder */
@@ -875,6 +892,8 @@ void pp_remainder(enum cmit_fmt fmt,
 		}
 		first = 0;
 
+		if (indent < 0)
+			indent = 0;
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
 			memset(sb->buf + sb->len, ' ', indent);
-- 
1.6.5.rc1.20.geb7d9
