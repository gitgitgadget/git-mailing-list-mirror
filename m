From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] diff: split off a function for --stat-* option parsing
Date: Wed, 28 Jul 2010 21:37:50 -0500
Message-ID: <20100729023750.GK29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-2-git-send-email-Matthieu.Moy@imag.fr> <20100729023627.GJ29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeJ0O-0001v1-OR
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab0G2Chv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:37:51 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:34248 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0G2Chv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:37:51 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 8C68FA0EE;
	Wed, 28 Jul 2010 21:37:50 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 6E0369A186; Wed, 28 Jul 2010 21:37:50 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100729023627.GJ29156@dert.cs.uchicago.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152151>

As an optimization, the diff_opt_parse() switchboard has
a single case for all the --stat-* options.  Split it
off into a separate function so we can enhance it
without bringing code dangerously close to the right
margin.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.c |   62 +++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index 1868b3e..641a326 100644
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
1.6.5
