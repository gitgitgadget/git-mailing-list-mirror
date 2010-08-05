From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5] diff: parse separate options --stat-width n, --stat-name-width n
Date: Thu,  5 Aug 2010 10:22:54 +0200
Message-ID: <1280996576-1165-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqmxt14gjt.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 05 10:23:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogvjh-0006Af-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 10:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759961Ab0HEIXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 04:23:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49618 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759883Ab0HEIXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 04:23:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o758KpD6014317
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 10:20:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgvjB-0005XE-E9; Thu, 05 Aug 2010 10:23:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgvjB-0000JU-Cn; Thu, 05 Aug 2010 10:23:01 +0200
X-Mailer: git-send-email 1.7.2.1.30.g18195
In-Reply-To: <vpqmxt14gjt.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Aug 2010 10:20:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o758KpD6014317
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281601253.57433@kbnCFZ+DxYW5EenckZpZhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152624>

Part of a campaign for unstuck forms of options.

[jn: with some refactoring]

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index a08a56a..e98d59b 100644
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
1.7.2.1.30.g18195
