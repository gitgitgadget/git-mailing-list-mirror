From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Mon, 26 Jun 2006 02:02:31 +0200
Message-ID: <E1FueYh-0004XE-Fg@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 26 02:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FueYn-0005Zf-Tl
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 02:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWFZACe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWFZACe
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 20:02:34 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5348 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964927AbWFZACe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 20:02:34 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22650>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
> ... and by the far the most common use is to pass more than one pattern. 
> Also, the usage is "[-e] <pattern> [-e <pattern>...]".

Here is a patch to allow combination of patterns with 'and' instead of
'or'. This makes it easier to search for combinations of words in a line
without using grep multiple times combined by pipes. So it is still
possible to use -A/-B/-C (something I miss in normal grep). --and
cannot be passed down, so we have to use the built-in version if it is
set.

 Documentation/git-grep.txt |    5 ++++-
 builtin-grep.c             |   17 +++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ebfe51b..df9d705 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
-	   [-f <file>] [-e] <pattern> [-e <pattern> [..]]
+	   [-f <file>] [-e] <pattern> [-e <pattern> [..]] [--and]
 	   [<tree>...]
 	   [--] [<path>...]
 
@@ -77,6 +77,9 @@ OPTIONS
 	scripts passing user input to grep. You can specify multiple
 	patterns which will be combined by 'or'.
 
+--and::
+	Combine multiple patterns by 'and' instead of 'or'.
+
 `<tree>...`::
 	Search blobs in the trees for specified patterns.
 
diff --git a/builtin-grep.c b/builtin-grep.c
index d0677cc..a2a034a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -96,6 +96,7 @@ struct grep_opt {
 	regex_t regexp;
 	unsigned linenum:1;
 	unsigned invert:1;
+	unsigned and:1;
 	unsigned name_only:1;
 	unsigned unmatch_name_only:1;
 	unsigned count:1;
@@ -268,7 +269,11 @@ static int grep_buffer(struct grep_opt *
 				    word_char(bol[pmatch[0].rm_eo]))
 					hit = 0;
 			}
-			if (hit)
+			if (opt->and && !hit) {
+				hit = 0;
+				break;
+			}
+			if (!opt->and && hit)
 				break;
 		}
 		/* "grep -v -e foo -e bla" should list lines
@@ -553,10 +558,10 @@ static int grep_cache(struct grep_opt *o
 #ifdef __unix__
 	/*
 	 * Use the external "grep" command for the case where
-	 * we grep through the checked-out files. It tends to
-	 * be a lot more optimized
+	 * we grep through the checked-out files and do not use
+	 * non-standard options. It tends to be a lot more optimized.
 	 */
-	if (!cached) {
+	if (!cached && !opt->and) {
 		hit = external_grep(opt, paths, cached);
 		if (hit >= 0)
 			return hit;
@@ -690,6 +695,10 @@ int cmd_grep(int argc, const char **argv
 			opt.binary = GREP_BINARY_TEXT;
 			continue;
 		}
+		if (!strcmp("--and", arg)) {
+			opt.and = 1;
+			continue;
+		}
 		if (!strcmp("-i", arg) ||
 		    !strcmp("--ignore-case", arg)) {
 			opt.regflags |= REG_ICASE;
-- 
1.4.1.rc1.g72a4-dirty
