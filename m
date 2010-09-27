From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2 2/2] diff: add synonyms for -M, -C, -B
Date: Mon, 27 Sep 2010 16:58:26 -0700
Message-ID: <1285631906-18200-2-git-send-email-kevin@sb.org>
References: <FFDB2371-6C96-472C-A650-412546636450@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 01:59:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0NbQ-0002pW-ED
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 01:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759381Ab0I0X7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 19:59:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49016 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759278Ab0I0X7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 19:59:11 -0400
Received: by pwi1 with SMTP id 1so181662pwi.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 16:59:11 -0700 (PDT)
Received: by 10.142.199.18 with SMTP id w18mr7136417wff.336.1285631951409;
        Mon, 27 Sep 2010 16:59:11 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id 9sm8046929wfd.12.2010.09.27.16.59.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 16:59:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.72.g8af0.dirty
In-Reply-To: <FFDB2371-6C96-472C-A650-412546636450@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157378>

Add new long-form options --detect-renames[=<n>], --detect-copies[=<n>],
and --break-rewrites[=[<n>][/<m>]] as synonyms for the -M, -C, and -B
options (respectively).

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
After thinking about it, I decided that --rename-threshold doesn't make sense
as a long-form option because it doesn't make its meaning obvious when you
don't specify the optional argument. I also figured it doesn't need to match
exactly with the rename-threshold merge strategy option as merge-recursive
already turns on rename detection and the option just controls the threshold.
However, the option to git-diff actually turns on rename detection instead of
just controlling the threshold.

 Documentation/diff-options.txt |    3 +++
 diff.c                         |   25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f77a0f8..a511529 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -207,6 +207,7 @@ endif::git-format-patch[]
 	digits can be specified with `--abbrev=<n>`.
 
 -B[<n>][/<m>]::
+--break-rewrites[=[<n>][/<m>]]::
 	Break complete rewrite changes into pairs of delete and
 	create. This serves two purposes:
 +
@@ -229,6 +230,7 @@ eligible for being picked up as a possible source of a rename to
 another file.
 
 -M[<n>]::
+--detect-renames[=<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -244,6 +246,7 @@ endif::git-log[]
 	hasn't changed.
 
 -C[<n>]::
+--detect-copies[=<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
diff --git a/diff.c b/diff.c
index d862234..d8fcf06 100644
--- a/diff.c
+++ b/diff.c
@@ -3140,16 +3140,19 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		return stat_opt(options, av);
 
 	/* renames options */
-	else if (!prefixcmp(arg, "-B")) {
+	else if (!prefixcmp(arg, "-B") || !prefixcmp(arg, "--break-rewrites=") ||
+		 !strcmp(arg, "--break-rewrites")) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 	}
-	else if (!prefixcmp(arg, "-M")) {
+	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
+		 !strcmp(arg, "--detect-renames")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
-	else if (!prefixcmp(arg, "-C")) {
+	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--detect-copies=") ||
+		 !strcmp(arg, "--detect-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
@@ -3366,6 +3369,22 @@ static int diff_scoreopt_parse(const char *opt)
 	if (*opt++ != '-')
 		return -1;
 	cmd = *opt++;
+	if (cmd == '-') {
+		/* convert the long-form arguments into short-form versions */
+		if (!prefixcmp(opt, "break-rewrites")) {
+			opt += strlen("break-rewrites");
+			if (*opt == 0 || *opt++ == '=')
+				cmd = 'B';
+		} else if (!prefixcmp(opt, "detect-copies")) {
+			opt += strlen("detect-copies");
+			if (*opt == 0 || *opt++ == '=')
+				cmd = 'C';
+		} else if (!prefixcmp(opt, "detect-renames")) {
+			opt += strlen("detect-renames");
+			if (*opt == 0 || *opt++ == '=')
+				cmd = 'M';
+		}
+	}
 	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
 		return -1; /* that is not a -M, -C nor -B option */
 
-- 
1.7.3.72.g8af0.dirty
