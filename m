From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add --filedirstat diff option
Date: Wed, 3 Sep 2008 02:51:48 +0300
Message-ID: <20080902235148.GA25312@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 01:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kafg8-0004CM-P9
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbYIBXvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYIBXvu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:51:50 -0400
Received: from zakalwe.fi ([80.83.5.154]:43695 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbYIBXvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:51:50 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 87F832BC68; Wed,  3 Sep 2008 02:51:48 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94742>

--filedirstat is the same as --dirstat, but it counts "damaged files"
instead of "damaged lines" (lines that are added or removed).

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This is version 2 of the patch. It fixes --filedirstat option handling.

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
index 135dec4..393dea7 100644
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
+	else if (opt_arg(arg, 0, "filedirstat", &options->dirstat_percent)) {
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
