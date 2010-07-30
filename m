From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5 v4] diff: split off a function for --stat-* option parsing
Date: Fri, 30 Jul 2010 10:31:06 +0200
Message-ID: <1280478669-22973-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 30 10:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oel4o-0002JZ-D4
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab0G3IgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:36:17 -0400
Received: from imag.imag.fr ([129.88.30.1]:46554 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab0G3IgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:36:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6U8VJ1Z017072
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 10:31:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oekzv-0000Zh-FO; Fri, 30 Jul 2010 10:31:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oekzv-0005zI-EC; Fri, 30 Jul 2010 10:31:19 +0200
X-Mailer: git-send-email 1.7.2.252.gb848
In-Reply-To: <vpq7hkdml22.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 30 Jul 2010 10:31:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152228>

From: Jonathan Nieder <jrnieder@gmail.com>

As an optimization, the diff_opt_parse() switchboard has
a single case for all the --stat-* options.  Split it
off into a separate function so we can enhance it
without bringing code dangerously close to the right
margin.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c |   62 +++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index d89ea20..d5f5d4b 100644
--- a/diff.c
+++ b/diff.c
@@ -3029,6 +3029,38 @@ int diff_long_opt(const char *opt, const char **argv,
 	return 2;
 }
 
+static int stat_opt(struct diff_options *options, const char **av)
+{
+	const char *arg = av[0];
+	char *end;
+	int width = options->stat_width;
+	int name_width = options->stat_name_width;
+
+	arg += strlen("--stat");
+	end = (char *)arg;
+
+	switch (*arg) {
+	case '-':
+		if (!prefixcmp(arg, "-width="))
+			width = strtoul(arg + 7, &end, 10);
+		else if (!prefixcmp(arg, "-name-width="))
+			name_width = strtoul(arg + 12, &end, 10);
+		break;
+	case '=':
+		width = strtoul(arg+1, &end, 10);
+		if (*end == ',')
+			name_width = strtoul(end+1, &end, 10);
+	}
+
+	/* Important! This checks all the error cases! */
+	if (*end)
+		return 0;
+	options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	options->stat_name_width = name_width;
+	options->stat_width = width;
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3070,33 +3102,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (!prefixcmp(arg, "--stat")) {
-		char *end;
-		int width = options->stat_width;
-		int name_width = options->stat_name_width;
-		arg += 6;
-		end = (char *)arg;
-
-		switch (*arg) {
-		case '-':
-			if (!prefixcmp(arg, "-width="))
-				width = strtoul(arg + 7, &end, 10);
-			else if (!prefixcmp(arg, "-name-width="))
-				name_width = strtoul(arg + 12, &end, 10);
-			break;
-		case '=':
-			width = strtoul(arg+1, &end, 10);
-			if (*end == ',')
-				name_width = strtoul(end+1, &end, 10);
-		}
-
-		/* Important! This checks all the error cases! */
-		if (*end)
-			return 0;
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-		options->stat_name_width = name_width;
-		options->stat_width = width;
-	}
+	else if (!prefixcmp(arg, "--stat"))
+		/* --stat, --stat-width, or --stat-name-width */
+		return stat_opt(options, av);
 
 	/* renames options */
 	else if (!prefixcmp(arg, "-B")) {
-- 
1.7.2.252.gb848
