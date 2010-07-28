From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4 v2] Allow detached form for git diff --stat-name-width and --stat-width.
Date: Wed, 28 Jul 2010 11:41:00 +0200
Message-ID: <1280310062-16793-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe39d-00062Y-JB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab0G1JmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:42:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60811 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0G1JmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:42:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9dJl0009878
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:39:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38L-0000KS-DO; Wed, 28 Jul 2010 11:41:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38L-0004NU-CG; Wed, 28 Jul 2010 11:41:05 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <vpqr5ioukca.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 11:39:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6S9dJl0009878
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280914764.01802@6V8x51AKIg/j5dtQ3jaOFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152062>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 1868b3e..04e97ef 100644
--- a/diff.c
+++ b/diff.c
@@ -3071,6 +3071,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat")) {
+		argcount = 1;
 		char *end;
 		int width = options->stat_width;
 		int name_width = options->stat_name_width;
@@ -3079,8 +3080,20 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
 		switch (*arg) {
 		case '-':
+			if (!strcmp(arg, "-width")) {
+				if (!av[1])
+					die("Option `--stat-width' requires a value");
+				width = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}
 			if (!prefixcmp(arg, "-width="))
 				width = strtoul(arg + 7, &end, 10);
+			else if (!strcmp(arg, "-name-width")) {
+				if (!av[1])
+					die("Option `--stat-name-width' requires a value");
+				name_width = strtoul(av[1], &end, 10);
+				argcount = 2;
+			}				
 			else if (!prefixcmp(arg, "-name-width="))
 				name_width = strtoul(arg + 12, &end, 10);
 			break;
@@ -3096,6 +3109,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 		options->stat_name_width = name_width;
 		options->stat_width = width;
+		return argcount;
 	}
 
 	/* renames options */
-- 
1.7.2.25.g9ebe3
