From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5 v4] diff: parse detached options --stat-width n, --stat-name-width n
Date: Fri, 30 Jul 2010 10:31:07 +0200
Message-ID: <1280478669-22973-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 30 10:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oel5d-0002oK-93
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036Ab0G3IhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:37:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38559 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab0G3IhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:37:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6U8TVvv010057
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 10:29:31 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oekzy-0000Zk-Ey; Fri, 30 Jul 2010 10:31:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oekzy-0005zL-Dp; Fri, 30 Jul 2010 10:31:22 +0200
X-Mailer: git-send-email 1.7.2.252.gb848
In-Reply-To: <vpq7hkdml22.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 10:29:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6U8TVvv010057
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281083373.64045@3vtTSq6brPaUUgRMMV+ddQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152229>

Part of a campaign for unstuck forms of options.

[jn: with some refactoring]

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index d5f5d4b..90b07e1 100644
--- a/diff.c
+++ b/diff.c
@@ -3035,16 +3035,34 @@ static int stat_opt(struct diff_options *options, const char **av)
 	char *end;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
+	int argcount = 1;
 
 	arg += strlen("--stat");
 	end = (char *)arg;
 
 	switch (*arg) {
 	case '-':
-		if (!prefixcmp(arg, "-width="))
-			width = strtoul(arg + 7, &end, 10);
-		else if (!prefixcmp(arg, "-name-width="))
-			name_width = strtoul(arg + 12, &end, 10);
+		if (!prefixcmp(arg, "-width")) {
+			arg += strlen("-width");
+			if (*arg == '=')
+				width = strtoul(arg + 1, &end, 10);
+			else if (!*arg && !av[1])
+				die("Option '--stat-width' requires a value");
+			else if (!*arg) {
+				width = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}
+		} else if (!prefixcmp(arg, "-name-width")) {
+			arg += strlen("-name-width");
+			if (*arg == '=')
+				name_width = strtoul(arg + 1, &end, 10);
+			else if (!*arg && !av[1])
+				die("Option '--stat-name-width' requires a value");
+			else if (!*arg) {
+				name_width = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}
+		}
 		break;
 	case '=':
 		width = strtoul(arg+1, &end, 10);
@@ -3058,7 +3076,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_width = width;
-	return 1;
+	return argcount;
 }
 
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
-- 
1.7.2.252.gb848
