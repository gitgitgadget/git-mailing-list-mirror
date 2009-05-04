From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH v2 1/4] Add format.coverletter option
Date: Mon,  4 May 2009 11:58:59 +0200
Message-ID: <1241431142-8444-2-git-send-email-ft@bewatermyfriend.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 12:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0uyD-0007yi-R9
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 12:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZEDJ7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 05:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZEDJ7b
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 05:59:31 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:48764 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZEDJ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 05:59:30 -0400
Received: from [212.117.84.176] (helo=fsst.voodoo.lan)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uxK-00025i-R7; Mon, 04 May 2009 11:59:27 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uwx-0002Cn-WD; Mon, 04 May 2009 11:59:04 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118225>

When using --cover-letter, a cover letter is created even if the patch
series is only one patch long.

This patch cures that by making the behaviour configurable.
'format.coverletter' is an integer option, that tells git how long a
patch series needs to be for it to generate a cover letter.
If set to 0, git never creates a cover letter.

The default minimum patch series length is 2.

The --cover-letter option now accepts integer arguments (such as
--cover-letter=5), which have the same effect as setting the
'format.coverletter' option. 'never' instead of an integer has the
same effect as 0 has; it surpresses cover letter generation.
'always' has the same effect as setting the minimum length to 1.

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 builtin-log.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..157c8cf 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -436,6 +436,9 @@ static char **extra_cc;
 static int extra_cc_nr;
 static int extra_cc_alloc;
 
+static int cover_letter = 0;
+static int cover_letter_len = 2;
+
 static void add_header(const char *value)
 {
 	int len = strlen(value);
@@ -480,6 +483,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
+	if (!strcmp(var, "format.coverletter")) {
+		cover_letter_len = git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.numbered")) {
 		if (value && !strcasecmp(value, "auto")) {
 			auto_number = 1;
@@ -752,7 +759,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int numbered_files = 0;		/* _just_ numbers */
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
-	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
@@ -868,7 +874,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fmt_patch_suffix = argv[i] + 9;
 		else if (!strcmp(argv[i], "--cover-letter"))
 			cover_letter = 1;
-		else if (!strcmp(argv[i], "--no-binary"))
+		else if (!prefixcmp(argv[i], "--cover-letter=always")) {
+			cover_letter = 1;
+			cover_letter_len = 1;
+		} else if (!prefixcmp(argv[i], "--cover-letter=never"))
+			cover_letter = 0;
+		else if (!prefixcmp(argv[i], "--cover-letter=")) {
+			cover_letter = 1;
+			cover_letter_len = strtol(argv[i] + 15, NULL, 10);
+		} else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
 			add_header(argv[i] + 13);
@@ -877,6 +891,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	argc = j;
 
+	if (cover_letter_len <= 0)
+		cover_letter = 0;
+
 	if (do_signoff) {
 		const char *committer;
 		const char *endpos;
@@ -1010,6 +1027,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (total < cover_letter_len)
+		cover_letter = 0;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
-- 
1.6.2.2.446.gfbdc0
