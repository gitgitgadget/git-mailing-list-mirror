From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add --filedirstat diff option
Date: Mon, 1 Sep 2008 04:12:59 +0300
Message-ID: <20080901011259.GA31696@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 03:14:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZxze-0006Si-0Q
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbYIABNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 21:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYIABND
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:13:03 -0400
Received: from zakalwe.fi ([80.83.5.154]:41034 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYIABNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 21:13:01 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id BBFEA2BC68; Mon,  1 Sep 2008 04:12:59 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94520>

--filedirstat is the same as --dirstat, but it counts "damaged files"
instead of "damaged lines" (lines that are added or removed).

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
Example of Linux v2.6.25..v2.6.26:

$ git diff --filedirstat v2.6.25..v2.6.26 
   3.3% arch/arm/
   6.0% arch/powerpc/
   3.8% arch/x86/
  12.1% arch/
   3.4% drivers/media/video/
   6.8% drivers/net/
  26.5% drivers/
   6.4% fs/
   4.5% include/linux/
  13.0% include/
   5.9% net/

$ git diff --dirstat v2.6.25..v2.6.26 
   4.9% arch/arm/
   9.0% arch/powerpc/configs/
  14.6% arch/
   5.0% drivers/media/video/
   4.2% drivers/media/
   5.5% drivers/net/sk98lin/
   6.6% drivers/net/wireless/
   5.7% drivers/net/
   4.8% drivers/s390/net/
  17.8% drivers/
   6.4% include/
   5.1% net/


 Documentation/diff-options.txt |    3 +++
 diff.c                         |   11 +++++++++--
 diff.h                         |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1759386..6e84f40 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -66,6 +66,9 @@ endif::git-format-patch[]
 	the "--cumulative" flag, which adds up percentages recursively
 	even when they have been already reported for a sub-directory.
 
+--filedirstat[=limit]::
+	Same as --dirstat, but count changed files instead of lines.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 135dec4..48f33d6 100644
--- a/diff.c
+++ b/diff.c
@@ -1110,9 +1110,13 @@ static void show_dirstat(struct diff_options *options)
 		/*
 		 * Original minus copied is the removed material,
 		 * added is the new material.  They are both damages
-		 * made to the preimage.
+		 * made to the preimage. In --filedirstat mode, count
+		 * damaged files, not damaged lines. This is done by
+		 * counting only a single damaged line per file.
 		 */
 		damage = (p->one->size - copied) + added;
+		if (options->filedirstat && damage > 0)
+			damage = 1;
 
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
 		dir.files[dir.nr].name = name;
@@ -2474,7 +2478,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
 	else if (!strcmp(arg, "--cumulative"))
 		options->output_format |= DIFF_FORMAT_CUMULATIVE;
-	else if (!strcmp(arg, "--check"))
+	else if (opt_arg(arg, 'X', "filedirstat", &options->dirstat_percent)) {
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+		options->filedirstat = 1;
+	} else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
diff --git a/diff.h b/diff.h
index 50fb5dd..2832bb8 100644
--- a/diff.h
+++ b/diff.h
@@ -86,6 +86,7 @@ struct diff_options {
 	int rename_limit;
 	int warn_on_too_large_rename;
 	int dirstat_percent;
+	int filedirstat;
 	int setup;
 	int abbrev;
 	const char *prefix;
-- 
1.6.0.1
