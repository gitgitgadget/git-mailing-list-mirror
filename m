From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] diff: allow --stat-width n, --stat-name-width n
Date: Wed, 28 Jul 2010 21:38:35 -0500
Message-ID: <20100729023835.GL29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-2-git-send-email-Matthieu.Moy@imag.fr> <20100729023627.GJ29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeJ17-000257-RJ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0G2Cih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:38:37 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:34271 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab0G2Cig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:38:36 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 2543CA0EE;
	Wed, 28 Jul 2010 21:38:36 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 068149A186; Wed, 28 Jul 2010 21:38:36 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100729023627.GJ29156@dert.cs.uchicago.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152152>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Part of a campaign for unstuck forms of options.

[jn: with some refactoring]

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 641a326..55edc3e 100644
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
1.6.5
