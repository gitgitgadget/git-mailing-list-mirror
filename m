From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-config: Parse config files leniently
Date: Wed,  2 Sep 2009 22:17:10 +0200
Message-ID: <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 22:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiwGt-0001QF-GN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 22:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbZIBURZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZIBURY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 16:17:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49828 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751607AbZIBURY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 16:17:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D35D36042B;
	Wed,  2 Sep 2009 16:17:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 02 Sep 2009 16:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=uUl5BHdNOt8Yg45ax42dEkNXET8=; b=kwG+wnvLDyp+9MmgG2kaMKxPe53jwZJPrAsGEzx16GFq15dyyv2VvXSx7r5oDW4A1ETPP0g1mayrUkHbxxChyO2BsPNs+v1Rz3QbgYlM2E0VvWbkEQoQLNWbWGu40042V6VGIUyjqU2RQ/aIk1uRlXde6LFKWLkc5bfablMTwU4=
X-Sasl-enc: Mb9tiyCaATu2/Cq0DhLTqHdk/CmW202h6v9zFtZtxMhv 1251922643
Received: from localhost (p5DCC1043.dip0.t-ipconnect.de [93.204.16.67])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A0CD248E1F;
	Wed,  2 Sep 2009 16:17:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.395.ge3d52
In-Reply-To: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127629>

Currently, git config dies as soon as there is a parsing error. This is
especially unfortunate in case a user tries to correct config mistakes
using git config -e.

Instead, issue a warning only and treat the rest of the line as a
comment (ignore it). This benefits not only git config -e users but
also everyone else.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Reported-by: David Reitter <david.reitter@gmail.com>
---
 config.c                |   80 ++++++++++++++++++++++++----------------------
 t/t1303-wacky-config.sh |    3 +-
 2 files changed, 44 insertions(+), 39 deletions(-)

So, after a business trip, vacation, ... I'm finally returning to this patch.
I addressed the echo/printf issue as suggested and clarified the commit message.

Regarding the global int for switching on/off lenient parsing: I reinstated my
v0 of the patch only to find out (again) that setup_git_directory_gently is the
problem here. We would have to turn on lenient parsing before we even know that
"-e" is supplied. So, the only option would be to have "git config" use lenient
parsing in all modes (edit/get/set) and have other git commands die fatally on
erroneous config.

So, here's v2 which has lenient config parsing for everyone because I don't see
a way to have it for "git config -e" only. If you prefer to have it for all of
"git config" only, that version is in another branch head now...

Cheers,
Michael

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
index 080117c..0599d9f 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -44,7 +44,8 @@ LONG_VALUE=$(printf "x%01021dx a" 7)
 test_expect_success 'do not crash on special long config line' '
 	setup &&
 	git config section.key "$LONG_VALUE" &&
-	check section.key "fatal: bad config file line 2 in .git/config"
+	check section.key "warning: bad config file line 2 in .git/config
+warning: bad config file line 2 in .git/config"
 '
 
 test_done
-- 
1.6.4.2.395.ge3d52
