From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv2] git-log --format: Add %B tag with %B(x) option
Date: Fri, 18 Sep 2009 20:00:45 +0200
Message-ID: <1253296845-17219-1-git-send-email-heipei@hackvalue.de>
References: <7vk4zxgnim.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 20:00:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MohlA-0006FR-0E
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 20:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994AbZIRSA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757990AbZIRSA2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 14:00:28 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:49529 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978AbZIRSA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 14:00:27 -0400
Received: from u-7-100.vpn.rwth-aachen.de ([137.226.103.100]:41649 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1Mohkn-0004iz-Io; Fri, 18 Sep 2009 20:00:17 +0200
X-Mailer: git-send-email 1.6.5.rc1.20.geb7d9
In-Reply-To: <7vk4zxgnim.fsf@alter.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.103.100
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128802>

Since one can simply use spaces to indent any other --pretty field we
should have an option to do that with the body too.

Also the %B flag strips the trailing newlines, to enable more compact
display.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hi again,

I followed Junio's implementation-advice. Since we have two placeholders which 
take () arguments I put the scanning for those at the top, to avoid repetition. 
I used strtol in place of atoi and I also had to to add a check for ident > 0 
since the indent determines the growth-size of the buffer, and negative values 
produced nasty stuff (obviously).

As for general extendability: The current code deals with %B(42) as well as 
%B(42,23[,...]), so even old versions could be used with "new" pretty-formats.  
%B(c5) is simply no ident, while %B(5c) is 5 spaces indent. Don't know if this 
is unwanted behaviour, but that's what strtol gives us.

Dscho sent me a pointer to a patch [1], which not only adds indent but also 
rewrapping. But since this is my second patch and Dscho's patch depended on two 
other patches I didn't want to get in over my head by making his patches a 
prerequisite.

A last word on future formats: We can use (x,y,z) easily, another thing one 
might think of (or at least I do) is using an %an[20] syntax, returning only 
the first 20 chars of %an, so one can make onelined outputs nicely 
column-aligned for fields like the author.

Greetings,
Jojo

[1] - http://repo.or.cz/w/git/dscho.git?a=commit;h=ad48dfca58169c35e227e135638b4970fe4dc9a5

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |   25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

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
index f5983f8..7b88827 100644
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
@@ -733,7 +737,16 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		format_sanitized_subject(sb, msg + c->subject_off);
 		return 1;
 	case 'b':	/* body */
-		strbuf_addstr(sb, msg + c->body_off);
+		strbuf_addstr(sb, body);
+		return 1;
+	case 'B':	/* body without trailing newline */
+		if (end) {
+			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, strtol(placeholder + 2, NULL, 10));
+			strbuf_rtrim(sb);
+			return end - placeholder + 1;
+		}
+		strbuf_addstr(sb, body);
+		strbuf_rtrim(sb);
 		return 1;
 	}
 	return 0;	/* unknown placeholder */
@@ -875,6 +888,8 @@ void pp_remainder(enum cmit_fmt fmt,
 		}
 		first = 0;
 
+		if (indent < 0)
+			indent = 0;
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
 			memset(sb->buf + sb->len, ' ', indent);
-- 
1.6.5.rc1.20.geb7d9
