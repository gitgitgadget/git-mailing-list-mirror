From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv4] git-log --format: Add %B tag with %B(n) option
Date: Tue, 22 Sep 2009 23:30:38 +0200
Message-ID: <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 22 23:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqCwc-00063e-OD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZIVVad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 17:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbZIVVac
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 17:30:32 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:40177 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbZIVVac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 17:30:32 -0400
Received: from u-4-046.vpn.rwth-aachen.de ([137.226.100.46]:32967 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MqCwP-0005mT-C8; Tue, 22 Sep 2009 23:30:29 +0200
X-Mailer: git-send-email 1.6.5.rc1.38.g1fbd3
In-Reply-To: <7vfxaercma.fsf@alter.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.100.46
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128959>

Since one can simply use spaces to indent any other --pretty field we
should have an option to do that with the body too.

Also the %B flag strips the trailing newlines, to enable more compact
display.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hey,

I moved the indent >= 0 check to the caller. Also changed the documentation, n 
should indicate more strongly that n is supposed to be a natural number.

You mentioned small style issues but I'm not sure what you meant. One thing 
that could be made more compact is calling 
pp_remainder(CMIT_FMT_MEDIUM, &body, sb, indent < 0 ? 0 : indent);
and thereby saving two extra lines. I saw this at a lot of other spaces in 
git.git, but saw no specific guideline in CodingGuidelines.

Yet another option is aborting for negative indent values, issuing return 0;

Greetings,
Jojo

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |   29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..ca694c9 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,8 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%B': body without trailing newline
+- '%B(n)': %B indented by n spaces
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f5983f8..dafa8e0 100644
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
@@ -733,7 +737,22 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
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
+			if (placeholder + 2 == endp || *endp != ')')
+				return 0;
+			if (indent < 0)
+				indent = 0;
+			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, indent);
+			strbuf_rtrim(sb);
+			return end - placeholder + 1;
+		}
+		strbuf_addstr(sb, body);
+		strbuf_rtrim(sb);
 		return 1;
 	}
 	return 0;	/* unknown placeholder */
-- 
1.6.5.rc1.38.g1fbd3
