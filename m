From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] clean: add --null option
Date: Sat, 14 Apr 2012 19:55:58 +0200
Message-ID: <1334426158-13607-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 19:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7Dz-0001QP-1V
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 19:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab2DNR44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 13:56:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43026 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2DNR4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 13:56:42 -0400
Received: by wibhj6 with SMTP id hj6so7431717wib.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ozc0REgZdXmMby3GIo50RQwjgFj1MPcTZhPgUogsaQA=;
        b=W/Y86BV1rEoYvsX92BAhXNQ4xcBrg/RzreqpnOfKdtywgosF96uEtElGxnNK9F0O/R
         OMjBi0HXKSVaUVQakl/TPIS+ziGBa1OXt+cmMvg3ngXCvRpDYvV+xCoJCPPoHsIcCFzE
         oSZ+csd2Rh9Xtqn0M7NYLu2eLOeQy7aMdAeGrWop+UjBCPDXh7FPpqSr8Njo+PC4NRQz
         /aDQbA1+i2OOTmNQMsGcQVnZIn1qvUEvD7tZ2P0jx3mb+6hbH9UEL6Sywc9QnLHhPCSV
         hFjLm288Lexa05J+ngWW+dDttaqzbDRXbjXGN/9m/bN+qqAIRLg2O54DmWAb6lOVl0tg
         PZHQ==
Received: by 10.180.98.8 with SMTP id ee8mr5575021wib.14.1334426201362;
        Sat, 14 Apr 2012 10:56:41 -0700 (PDT)
Received: from localhost.localdomain (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id fl2sm9871765wib.2.2012.04.14.10.56.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 10:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195498>

Add a --null (-z) option to git-clean which prints out the files
and directories separated with a NUL character rather than '\n'.
This makes it useful in conjunction with xargs -0.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 Documentation/git-clean.txt |    7 ++++++-
 builtin/clean.c             |   33 +++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

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
index 0c7b3d0..b2947e3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,7 +16,7 @@
 static int force = -1; /* unset */
 
 static const char *const builtin_clean_usage[] = {
-	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-z] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
 	NULL
 };
 
@@ -34,11 +34,20 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static void print_path(const char *msg, const char *name, int use_nul)
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
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, config_set = 0, errors = 0;
+	int ignored_only = 0, config_set = 0, errors = 0, use_nul = 0;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
@@ -50,6 +59,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, "do not print names of files removed"),
 		OPT__DRY_RUN(&show_only, "dry run"),
+		OPT_BOOLEAN('z', "null", &use_nul,
+			    "paths are separated with NUL character"),
 		OPT__FORCE(&force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
@@ -152,20 +163,25 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
 			if (show_only && (remove_directories ||
 			    (matches == MATCHED_EXACTLY))) {
-				printf(_("Would remove %s\n"), qname);
+				print_path(_("Would remove %s\n"),
+					   qname, use_nul);
 			} else if (remove_directories ||
 				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
-					printf(_("Removing %s\n"), qname);
+					print_path(_("Removing %s\n"), qname,
+						   use_nul);
 				if (remove_dir_recursively(&directory,
 							   rm_flags) != 0) {
 					warning(_("failed to remove %s"), qname);
 					errors++;
 				}
 			} else if (show_only) {
-				printf(_("Would not remove %s\n"), qname);
+				if (!use_nul)
+					printf(_("Would not remove %s\n"),
+					       qname);
 			} else {
-				printf(_("Not removing %s\n"), qname);
+				if (!use_nul)
+					printf(_("Not removing %s\n"), qname);
 			}
 			strbuf_reset(&directory);
 		} else {
@@ -173,10 +189,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue;
 			qname = quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
-				printf(_("Would remove %s\n"), qname);
+				print_path(_("Would remove %s\n"), qname,
+					   use_nul);
 				continue;
 			} else if (!quiet) {
-				printf(_("Removing %s\n"), qname);
+				print_path(_("Removing %s\n"), qname, use_nul);
 			}
 			if (unlink(ent->name) != 0) {
 				warning(_("failed to remove %s"), qname);
-- 
1.7.10
