From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH v2] clean: add --null option
Date: Sun, 15 Apr 2012 11:09:22 +0200
Message-ID: <1334480962-18778-1-git-send-email-rosslagerwall@gmail.com>
Cc: Clemens Buchacher <drizzd@aon.at>,
	Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 11:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJLU8-0002FT-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 11:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab2DOJK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 05:10:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58194 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab2DOJK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 05:10:27 -0400
Received: by wibhq7 with SMTP id hq7so4252801wib.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wdh0TmKMRCS4J9hv1KPOZYknyWbzRngvTxkyAsN/2PI=;
        b=DJrtTc3FwMpI+dUJcEepyo/P311Oc0kX/r7fCkOZtR/yWoDoWfME8fg3uLF7Iy71c7
         4jCxVU+Q5hX4kz2dhT39mgaQDx93M1sIf3ZjwCk9EZc64GyhCE9Yj6WoWlcqxriE2lHo
         RlkjpdQLxpywH/Fo5GAIyCkzV73DdpuJB2cFMlqPA7kztnPBBQFXQy3unKFbuaZYpLsu
         4FAf/VRaC05Nvl1CUbgQtrFtGi/5xFdWOvTnS+MrVmm4qB91LzwIzn0//KRHApmW0auc
         H+BBvsKBWdu1RhqpFqIN0oESfhOQl2I3ZALnHG86SstrypElkwwLU2fnDWUm8Sreq72O
         rLIA==
Received: by 10.180.107.234 with SMTP id hf10mr2834766wib.0.1334481025608;
        Sun, 15 Apr 2012 02:10:25 -0700 (PDT)
Received: from localhost.localdomain (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id ea6sm10539104wib.5.2012.04.15.02.10.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 02:10:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195549>

Add a --null (-z) option to git-clean which prints out the files
and directories separated with a NUL character rather than '\n'.
This makes it useful in conjunction with xargs -0.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
This updated patch converts use_nul to a static variable and reformats
some lines.

 Documentation/git-clean.txt |    7 ++++++-
 builtin/clean.c             |   28 +++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 79fb984..0150484 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,8 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-z] [-q] [-e <pattern>] [-x | -X]
+	    [--] <path>...
 
 DESCRIPTION
 -----------
@@ -40,6 +41,10 @@ OPTIONS
 --dry-run::
 	Don't actually remove anything, just show what would be done.
 
+-z::
+--null::
+	Separate paths with the NUL character.
+
 -q::
 --quiet::
 	Be quiet, only report errors, but not the files that are
diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..9ce01d1 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,9 +14,10 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static int use_nul;
 
 static const char *const builtin_clean_usage[] = {
-	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-z] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
 	NULL
 };
 
@@ -34,6 +35,15 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static void print_path(const char *msg, const char *name)
+{
+	if (use_nul) {
+		fputs(name, stdout);
+		putchar('\0');
+	} else
+		printf(msg, name);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -50,6 +60,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, "do not print names of files removed"),
 		OPT__DRY_RUN(&show_only, "dry run"),
+		OPT_BOOLEAN('z', "null", &use_nul,
+			    "paths are separated with NUL character"),
 		OPT__FORCE(&force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
@@ -152,20 +164,22 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
 			if (show_only && (remove_directories ||
 			    (matches == MATCHED_EXACTLY))) {
-				printf(_("Would remove %s\n"), qname);
+				print_path(_("Would remove %s\n"), qname);
 			} else if (remove_directories ||
 				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
-					printf(_("Removing %s\n"), qname);
+					print_path(_("Removing %s\n"), qname);
 				if (remove_dir_recursively(&directory,
 							   rm_flags) != 0) {
 					warning(_("failed to remove %s"), qname);
 					errors++;
 				}
 			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
+				if (!use_nul)
+					printf(_("Would not remove %s\n"), qname);
 			} else {
-				printf(_("Not removing %s\n"), qname);
+				if (!use_nul)
+					printf(_("Not removing %s\n"), qname);
 			}
 			strbuf_reset(&directory);
 		} else {
@@ -173,10 +187,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue;
 			qname = quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
-				printf(_("Would remove %s\n"), qname);
+				print_path(_("Would remove %s\n"), qname);
 				continue;
 			} else if (!quiet) {
-				printf(_("Removing %s\n"), qname);
+				print_path(_("Removing %s\n"), qname);
 			}
 			if (unlink(ent->name) != 0) {
 				warning(_("failed to remove %s"), qname);
-- 
1.7.10
