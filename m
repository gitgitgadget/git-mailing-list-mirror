From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/7] Add -q/--quiet switch to git-ls-files
Date: Fri, 23 Nov 2007 20:20:44 +0100
Message-ID: <1195845650-85962-2-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive6K-0008CJ-OJ
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbXKWTVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbXKWTVs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:48 -0500
Received: from wincent.com ([72.3.236.74]:60678 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756307AbXKWTVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKolw018032;
	Fri, 23 Nov 2007 13:20:53 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65915>

When using the --error-unmatch switch to git-ls-files you may only be
interested in the exit status rather than the actual listing that would
normally be printed to the stdout.

To make this kind of workflow easier, the -q/--quiet switch suppresses
all non-error output.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-ls-files.txt    |    7 ++++++-
 builtin-ls-files.c                |   12 +++++++++++-
 t/t3020-ls-files-error-unmatch.sh |   12 ++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 2ec0c0d..33481b6 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -9,7 +9,7 @@ git-ls-files - Show information about files in the index and the working tree
 SYNOPSIS
 --------
 [verse]
-'git-ls-files' [-z] [-t] [-v]
+'git-ls-files' [-z] [-t] [-v] [-q]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*
 		(-[c|d|o|i|s|u|k|m])\*
 		[-x <pattern>|--exclude=<pattern>]
@@ -107,6 +107,11 @@ OPTIONS
 	Similar to `-t`, but use lowercase letters for files
 	that are marked as 'always matching index'.
 
+-q|--quiet::
+	Suppress all non-error output. This may be useful in conjunction
+	with --error-unmatch when you are only interested in the exit
+	status.
+
 --full-name::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 7f60709..6c710a8 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -20,6 +20,7 @@ static int show_unmerged;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int quiet;
 static int line_terminator = '\n';
 
 static int prefix_len;
@@ -83,6 +84,8 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	if (pathspec && !match(pathspec, ps_matched, ent->name, len))
 		return;
 
+	if (quiet)
+		return;
 	fputs(tag, stdout);
 	write_name_quoted(ent->name + offset, stdout, line_terminator);
 }
@@ -205,6 +208,8 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		tag = alttag;
 	}
 
+	if (quiet)
+		return;
 	if (!show_stage) {
 		fputs(tag, stdout);
 	} else {
@@ -385,7 +390,8 @@ static void overlay_tree(const char *tree_name, const char *prefix)
 }
 
 static const char ls_files_usage[] =
-	"git-ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
+	"git-ls-files [-z] [-t] [-v] [-q|--quiet] "
+	"(--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
 	"[ --exclude-per-directory=<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -423,6 +429,10 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 				show_valid_bit = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
+			quiet = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
 			show_cached = 1;
 			continue;
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index c83f820..5178322 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -23,5 +23,17 @@ test_expect_success \
     'git ls-files --error-unmatch should succeed eith matched paths.' \
     'git ls-files --error-unmatch foo bar'
 
+test_expect_success \
+    'git ls-files -q --error-unmatch should be quiet with unmatched path.' \
+    'git ls-files -q --error-unmatch foo bar-does-not-match 1> out 2> err ||
+     test $(cat out | wc -l) -eq 0 &&
+     test $(cat err | wc -l) -gt 0'
+
+test_expect_success \
+   'git ls-files -q --error-unmatch should be quiet with matched paths.' \
+   'git ls-files -q --error-unmatch foo bar 1> out 2> err ||
+    test $(cat out | wc -l) -eq 0 &&
+    test $(cat err | wc -l) -eq 0'
+
 test_done
 1
-- 
1.5.3.6.886.g3364
