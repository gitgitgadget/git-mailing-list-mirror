From: eletuchy@gmail.com
Subject: [PATCH] adds --date=raw support to git blame and related documentation
Date: Mon, 23 Feb 2009 00:57:09 -0800
Message-ID: <1235379429-20934-1-git-send-email-eletuchy@gmail.com>
Cc: eletuchy@facebook.com, Eugene Letuchy <eugene@facebook.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 09:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWe9-0004LG-NF
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 09:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbZBWI5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 03:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbZBWI5N
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 03:57:13 -0500
Received: from outmail001.ash1.tfbnw.net ([69.63.184.101]:34937 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750971AbZBWI5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 03:57:12 -0500
Received: from [10.18.255.178] ([10.18.255.178:44880] helo=facebook.com)
	by mta004.ash1.facebook.com (envelope-from <eletuchy@facebook.com>)
	(ecelerity 2.2.2.37 r(28805/28844)) with ESMTP
	id 7A/AB-17105-6E462A94; Mon, 23 Feb 2009 00:57:10 -0800
Received: by dev051.snc1.facebook.com (Postfix, from userid 1200)
	id A4E7411C217; Mon, 23 Feb 2009 00:57:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.14.g07c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111122>

From: Eugene Letuchy <eugene@facebook.com>

In the wake of Linus' 7dff9b3, git blame --date support needs to
incorporate --date=raw in addition to the previously supported
date formats.

Test: > git grep relative | grep iso | grep -v raw
      > git blame --date=raw builtin-blame.c

Signed-off-by: Eugene Letuchy <eugene@facebook.com>
---
 Documentation/blame-options.txt        |    4 ++--
 Documentation/config.txt               |    2 +-
 Documentation/git-rev-list.txt         |    2 +-
 builtin-blame.c                        |    6 +++++-
 contrib/completion/git-completion.bash |    2 +-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index e6717af..1316d4e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -36,7 +36,7 @@ of lines before or after the line given by <start>.
 	Show long rev (Default: off).
 
 -t::
-	Show raw timestamp (Default: off).
+	Synomym for --date=raw (Default: off).
 
 -S <revs-file>::
 	Use revs from revs-file instead of calling linkgit:git-rev-list[1].
@@ -72,7 +72,7 @@ of lines before or after the line given by <start>.
 
 --date <format>::
 	The value is one of the following alternatives:
-	{relative,local,default,iso,rfc,short}. If --date is not
+	{relative,local,default,iso,rfc,short,raw}. If --date is not
 	provided, the value of the blame.date config variable is
 	used. If the blame.date config variable is also not set, the
 	iso format is used. For more information, See the discussion
diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..f73d569 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1010,7 +1010,7 @@ interactive.singlekey::
 log.date::
 	Set default date-time mode for the log command. Setting log.date
 	value is similar to using 'git-log'\'s --date option. The value is one of the
-	following alternatives: {relative,local,default,iso,rfc,short}.
+	following alternatives: {relative,local,default,iso,rfc,short,raw}.
 	See linkgit:git-log[1].
 
 log.showroot::
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 1c9cc28..c226601 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -35,7 +35,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date={local|relative|default|iso|rfc|short} ]
+	     [ \--date={local|relative|default|iso|rfc|short|raw} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/builtin-blame.c b/builtin-blame.c
index 48cedfd..bb0d20b 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2288,12 +2288,16 @@ parse_done:
 	case DATE_RELATIVE:
 		blame_date_width = sizeof("14 minutes ago");
 		break;
+	case DATE_RAW:
+		blame_date_width = sizeof("1235155266 -0800");
+		output_option |= OUTPUT_RAW_TIMESTAMP;
+		break;
 	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
-	blame_date_width -= 1; /* strip the null */
+	blame_date_width -= 1; /* strip the terminating null */
 
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..3454c1b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1016,7 +1016,7 @@ _git_log ()
 		;;
 	--date=*)
 		__gitcomp "
-			relative iso8601 rfc2822 short local default
+			relative iso8601 rfc2822 short local default raw
 		" "" "${cur##--date=}"
 		return
 		;;
-- 
1.6.2.rc1.14.g07c3.dirty
