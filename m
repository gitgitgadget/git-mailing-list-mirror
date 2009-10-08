From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] ls-files: make option parser keep argv[0]
Date: Thu,  8 Oct 2009 10:20:28 -0400
Message-ID: <1255011628-31841-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 16:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvtsQ-0001Im-OG
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 16:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025AbZJHOVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 10:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757360AbZJHOVo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 10:21:44 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:54799 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302AbZJHOVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 10:21:43 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:57437 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Mvtre-0006x1-1H; Thu, 08 Oct 2009 10:21:06 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Mvtrd-0008Kp-V4; Thu, 08 Oct 2009 10:21:06 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n98EL5wf032039;
	Thu, 8 Oct 2009 10:21:05 -0400
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129693>

The ls-files built-in was not asking the option parser to maintain
argv[0].  This led to the possibility of fprintf(stderr, "...", NULL).
On Solaris, this was causing a segfault.  On glibc systems, printed
error messages didn't contain proper strings, but rather, "(null)":...

A trigger for this bug was: `git ls-files -i`

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 builtin-ls-files.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..9a3705a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -482,7 +482,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
-			ls_files_usage, 0);
+			ls_files_usage, PARSE_OPT_KEEP_ARGV0);
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
@@ -505,7 +505,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec(prefix, argv + 1);
 
 	/* be nice with submodule paths ending in a slash */
 	read_cache();
-- 
1.6.4.4
