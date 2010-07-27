From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4] Allow detached form for git diff --stat-name-width and --stat-width.
Date: Tue, 27 Jul 2010 23:21:57 +0200
Message-ID: <1280265719-30968-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 27 23:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odrbl-0002ZA-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0G0VWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:22:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42512 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab0G0VWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:22:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RLKJR1026592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 23:20:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb9-00025k-1z; Tue, 27 Jul 2010 23:22:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb9-00084p-0m; Tue, 27 Jul 2010 23:22:03 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 23:20:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RLKJR1026592
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280870419.48985@GP4ES0p3B7fV4dza7r/ZLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152000>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 41b39be..c8ee603 100644
--- a/diff.c
+++ b/diff.c
@@ -3044,6 +3044,7 @@ int diff_opt_parse(struct diff_options *options, const char **argv, int ac)
 	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat")) {
+		argcount = 1;
 		char *end;
 		int width = options->stat_width;
 		int name_width = options->stat_name_width;
@@ -3052,8 +3053,20 @@ int diff_opt_parse(struct diff_options *options, const char **argv, int ac)
 
 		switch (*arg) {
 		case '-':
+			if (!strcmp(arg, "-width")) {
+				if (!argv[1])
+					die("Option `--stat-width' requires a value");
+				width = strtoul(argv[1], &end, 10);
+				argcount = 2;
+			}
 			if (!prefixcmp(arg, "-width="))
 				width = strtoul(arg + 7, &end, 10);
+			else if (!strcmp(arg, "-name-width")) {
+				if (!argv[1])
+					die("Option `--stat-name-width' requires a value");
+				name_width = strtoul(argv[1], &end, 10);
+				argcount = 2;
+			}				
 			else if (!prefixcmp(arg, "-name-width="))
 				name_width = strtoul(arg + 12, &end, 10);
 			break;
@@ -3069,6 +3082,7 @@ int diff_opt_parse(struct diff_options *options, const char **argv, int ac)
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 		options->stat_name_width = name_width;
 		options->stat_width = width;
+		return argcount;
 	}
 
 	/* renames options */
-- 
1.7.2.25.g9ebe3
