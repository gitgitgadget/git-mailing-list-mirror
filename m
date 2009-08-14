From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-config: Parse config files leniently
Date: Fri, 14 Aug 2009 17:10:48 +0200
Message-ID: <a812f567b4541ce55e9c60037a047488a0893c36.1250262273.git.git@drmicha.warpmail.net>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
Cc: David Reitter <david.reitter@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 17:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbyR1-0008Cx-Hc
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 17:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbZHNPLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbZHNPLG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 11:11:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51538 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932415AbZHNPLF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 11:11:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B9FDF5294E;
	Fri, 14 Aug 2009 11:11:04 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 14 Aug 2009 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=AnfeMKZPBZEjp69NwI+LuSacoso=; b=mFfnCX1RW7XUx9Lwg2ilBlJ2Agl/WJDIAhhvHNGF1fwLFmfRkzOQ/Uss9VIMaPTguYiLO8OW74jt/OMw+2Oq26KmmvcdzluModRgYm8l3FAH0GR6S7uIMJeBXk7u5TnLSb5vOfZiDM23MNTYKaxS0rNAnHkbQA5uG8iaqOIxJXU=
X-Sasl-enc: /V9qmeXb/njTnc+KpfJF9kxrNF1kfOZau1QHAJ7muUmF 1250262663
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 936EB732E;
	Fri, 14 Aug 2009 11:11:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.225.gb589e
In-Reply-To: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125930>

Currently, git config dies as soon as there is a parsing error. This is
especially unfortunate in case a user tries to correct config mistakes
using git config -e.

Instead, issue a warning only and treat the rest of the line as a
comment (ignore it). This benefits not only git config -e users.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Reported-by: David Reitter <david.reitter@gmail.com>
---
The diff and stat are overstatements. I had to shift that whole for loop
by one tab stop but diff (with or without --color-words) does not recognize
this. Nothing inside the loop is changed.
The outer while makes sure that
* we switch to comment mode after a parsing error
* we return eventually no matter whether the file ends with \n or not.

Test had to be adjusted as well.

 config.c                |   80 ++++++++++++++++++++++++----------------------
 t/t1303-wacky-config.sh |    4 +-
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/config.c b/config.c
index e87edea..5e0af5d 100644
--- a/config.c
+++ b/config.c
@@ -207,50 +207,54 @@ static int git_parse_file(config_fn_t fn, void *data)
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
 	const unsigned char *bomptr = utf8_bom;
 
-	for (;;) {
-		int c = get_next_char();
-		if (bomptr && *bomptr) {
-			/* We are at the file beginning; skip UTF8-encoded BOM
-			 * if present. Sane editors won't put this in on their
-			 * own, but e.g. Windows Notepad will do it happily. */
-			if ((unsigned char) c == *bomptr) {
-				bomptr++;
+	while (!config_file_eof) {
+		for (;;) {
+			int c = get_next_char();
+			if (bomptr && *bomptr) {
+				/* We are at the file beginning; skip UTF8-encoded BOM
+				 * if present. Sane editors won't put this in on their
+				 * own, but e.g. Windows Notepad will do it happily. */
+				if ((unsigned char) c == *bomptr) {
+					bomptr++;
+					continue;
+				} else {
+					/* Do not tolerate partial BOM. */
+					if (bomptr != utf8_bom)
+						break;
+					/* No BOM at file beginning. Cool. */
+					bomptr = NULL;
+				}
+			}
+			if (c == '\n') {
+				if (config_file_eof)
+					return 0;
+				comment = 0;
 				continue;
-			} else {
-				/* Do not tolerate partial BOM. */
-				if (bomptr != utf8_bom)
+			}
+			if (comment || isspace(c))
+				continue;
+			if (c == '#' || c == ';') {
+				comment = 1;
+				continue;
+			}
+			if (c == '[') {
+				baselen = get_base_var(var);
+				if (baselen <= 0)
 					break;
-				/* No BOM at file beginning. Cool. */
-				bomptr = NULL;
+				var[baselen++] = '.';
+				var[baselen] = 0;
+				continue;
 			}
-		}
-		if (c == '\n') {
-			if (config_file_eof)
-				return 0;
-			comment = 0;
-			continue;
-		}
-		if (comment || isspace(c))
-			continue;
-		if (c == '#' || c == ';') {
-			comment = 1;
-			continue;
-		}
-		if (c == '[') {
-			baselen = get_base_var(var);
-			if (baselen <= 0)
+			if (!isalpha(c))
+				break;
+			var[baselen] = tolower(c);
+			if (get_value(fn, data, var, baselen+1) < 0)
 				break;
-			var[baselen++] = '.';
-			var[baselen] = 0;
-			continue;
 		}
-		if (!isalpha(c))
-			break;
-		var[baselen] = tolower(c);
-		if (get_value(fn, data, var, baselen+1) < 0)
-			break;
+		warning("bad config file line %d in %s", config_linenr, config_file_name);
+		comment = 1;
 	}
-	die("bad config file line %d in %s", config_linenr, config_file_name);
+	return -1;
 }
 
 static int parse_unit_factor(const char *end, unsigned long *val)
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 080117c..be850c5 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -9,7 +9,7 @@ setup() {
 }
 
 check() {
-	echo "$2" >expected
+	printf "$2\n" >expected
 	git config --get "$1" >actual 2>&1
 	test_cmp actual expected
 }
@@ -44,7 +44,7 @@ LONG_VALUE=$(printf "x%01021dx a" 7)
 test_expect_success 'do not crash on special long config line' '
 	setup &&
 	git config section.key "$LONG_VALUE" &&
-	check section.key "fatal: bad config file line 2 in .git/config"
+	check section.key "warning: bad config file line 2 in .git/config\nwarning: bad config file line 2 in .git/config"
 '
 
 test_done
-- 
1.6.4.225.gb589e
