From: Dave Williams <dave@opensourcesolutions.co.uk>
Subject: [PATCH] check-ignore: Add option to ignore index contents
Date: Thu, 29 Aug 2013 23:46:52 +0100
Message-ID: <20130829224652.GA13621@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 00:54:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFB6k-0007Et-5G
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520Ab3H2WyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:54:24 -0400
Received: from 46-65-59-139.zone16.bethere.co.uk ([46.65.59.139]:56208 "EHLO
	loganberry.opensourcesolutions.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755254Ab3H2WyW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 18:54:22 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2013 18:54:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id 1708AEEDCAF;
	Thu, 29 Aug 2013 23:46:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at loganberry.opensourcesolutions.co.uk
Received: from loganberry.opensourcesolutions.co.uk ([127.0.0.1])
	by localhost (loganberry.opensourcesolutions.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aLk3MPJax1jC; Thu, 29 Aug 2013 23:46:52 +0100 (BST)
Received: from tangerine (tangerine.opensourcesolutions.co.uk [192.168.149.59])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id 633DCEEDBC3;
	Thu, 29 Aug 2013 23:46:52 +0100 (BST)
Received: by tangerine (Postfix, from userid 1000)
	id 5D070100449; Thu, 29 Aug 2013 23:46:52 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233381>

check-ignore currently shows how .gitignore rules would treat untracked
paths. Tracked paths do not generate useful output.  This prevents
debugging of why a path became tracked unexpectedly unless that path is
first removed from the index with git rm --cached <path>

This option (-i, --ignore-index) simply by-passes the check for the path
being in the index and hence allows tracked path to be checked too.

Whilst this behaviour deviates from the characteristics of git add and
git status its use case is unlikely to cause any user confusion.

Signed-off-by: Dave Williams <dave@opensourcesolutions.co.uk>
---
 Documentation/git-check-ignore.txt |  6 ++++++
 builtin/check-ignore.c             | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index d2df487..bb878ff 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -45,6 +45,12 @@ OPTIONS
 	not be possible to distinguish between paths which match a
 	pattern and those which don't.
 
+-i, --ignore-index::
+	Don't look in the index when undertaking the checks. This means
+	the results deviate from those seen by git add and git status
+	but is useful when understanding why a path became tracked by
+	e.g. git add . and was not ignored as expected by the rules.
+
 OUTPUT
 ------
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 4a8fc70..c8f6ae1 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -5,7 +5,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 
-static int quiet, verbose, stdin_paths, show_non_matching;
+static int quiet, verbose, stdin_paths, show_non_matching, ignore_index;
 static const char * const check_ignore_usage[] = {
 "git check-ignore [options] pathname...",
 "git check-ignore [options] --stdin < <list-of-paths>",
@@ -24,6 +24,8 @@ static const struct option check_ignore_options[] = {
 		    N_("input paths are terminated by a null character")),
 	OPT_BOOLEAN('n', "non-matching", &show_non_matching,
 		    N_("show non-matching input paths")),
+	OPT_BOOLEAN('i', "ignore-index", &ignore_index,
+		    N_("ignore index when checking")),
 	OPT_END()
 };
 
@@ -82,7 +84,9 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(pathspec);
+	if (!ignore_index) {
+		seen = find_pathspecs_matching_against_index(pathspec);
+	}
 	for (i = 0; pathspec[i]; i++) {
 		path = pathspec[i];
 		full_path = prefix_path(prefix, prefix
@@ -90,7 +94,7 @@ static int check_ignore(struct dir_struct *dir,
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
 		exclude = NULL;
-		if (!seen[i]) {
+		if (ignore_index || !seen[i]) {
 			exclude = last_exclude_matching(dir, full_path, &dtype);
 		}
 		if (!quiet && (exclude || show_non_matching))
-- 
1.8.4.rc3
