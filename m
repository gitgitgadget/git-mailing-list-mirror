From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 1/6] format-patch: add cover{letter,onepatch} options
Date: Sat, 18 Apr 2009 18:16:16 +0200
Message-ID: <1240071381-25165-2-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDFY-0000ZQ-5x
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbZDRQRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbZDRQQ7
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:16:59 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:42891 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbZDRQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:16:56 -0400
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDq-0007gH-Er; Sat, 18 Apr 2009 18:16:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006YW-GJ; Sat, 18 Apr 2009 18:16:23 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116835>

When using --cover-letter, a cover letter is created even if the patch
series is only one patch long. By setting format.coveronepatch to 'false', this
is prevented. To temporarily force creating cover letter even for
one-patch "series", the --cover-one-patch option may be used.

To always create cover letters, the format.coverletter option may be set
to 'true'.

A possible setup to create cover letters for every created patch series,
that is longer than one patch, would be:

[format]
    coverletter = true
    coveronepatch = false

git-format-patch's default behaviour is not altered by this patch.

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 builtin-log.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..82d8724 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -436,6 +436,9 @@ static char **extra_cc;
 static int extra_cc_nr;
 static int extra_cc_alloc;
 
+static int cover_letter = 0;
+static int cover_one_patch = 1;
+
 static void add_header(const char *value)
 {
 	int len = strlen(value);
@@ -512,6 +515,14 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		do_signoff = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.coverletter")) {
+		cover_letter = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "format.coveronepatch")) {
+		cover_one_patch = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -752,7 +763,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int numbered_files = 0;		/* _just_ numbers */
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
-	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
@@ -868,6 +878,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fmt_patch_suffix = argv[i] + 9;
 		else if (!strcmp(argv[i], "--cover-letter"))
 			cover_letter = 1;
+		else if (!strcmp(argv[i], "--cover-one-patch"))
+			cover_one_patch = 1;
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
@@ -1010,6 +1022,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (!cover_one_patch && total == 1)
+		cover_letter = 0;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
-- 
1.6.2.2.446.gfbdc0
