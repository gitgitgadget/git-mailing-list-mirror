From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] git-log --format: Add %B tag with %B(x) option
Date: Fri, 18 Sep 2009 00:47:51 +0200
Message-ID: <1253227671-20493-1-git-send-email-heipei@hackvalue.de>
Cc: Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:47:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoPlE-0002tV-Im
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 00:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZIQWrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 18:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbZIQWrV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 18:47:21 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:48411 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZIQWrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 18:47:20 -0400
Received: from u-6-161.vpn.rwth-aachen.de ([137.226.102.161]:44586 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MoPl0-0006SJ-L5; Fri, 18 Sep 2009 00:47:18 +0200
X-Mailer: git-send-email 1.6.5.rc1.20.geb7d9
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.161
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128777>

Since one can simply use spaces to indent any other --pretty field we
should have an option to do that with the body too.

Also the %B flag strips the trailing newlines, to enable more compact
display.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hey list,

in my never-ending quest to beautify my personal log output I just whipped this 
up. Maybe you like it too or at least can tell me what's wrong with it ;)

Please CC me as I'm not on the list anymore (but keep up through Gmane though).

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |   13 +++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..c04f118 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,8 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%B': body without trailing newline
+- '%B(x)': body indented with x spaces
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f5983f8..6d530e1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -735,6 +735,19 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
+	case 'B':
+		if (placeholder[1] == '(') {
+			const char *body = msg + c->body_off;
+			const char *end = strchr(placeholder + 2, ')');
+			if(!end)
+				return 0;
+			pp_remainder(CMIT_FMT_MEDIUM, &body, sb, atoi(placeholder + 2));
+			strbuf_rtrim(sb);
+			return end - placeholder + 1;
+		}
+		strbuf_addstr(sb, msg + c->body_off);
+		strbuf_rtrim(sb);
+		return 1;
 	}
 	return 0;	/* unknown placeholder */
 }
-- 
1.6.5.rc1.20.geb7d9
