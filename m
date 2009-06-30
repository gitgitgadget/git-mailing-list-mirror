From: Jason Holden <jason.k.holden@gmail.com>
Subject: [PATCH 2/2] Don't clean any untracked submodule's .git dir by default in git-clean
Date: Mon, 29 Jun 2009 22:10:45 -0400
Message-ID: <1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
 <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
Cc: Jason Holden <jason.k.holden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 04:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLSot-0005k4-Hb
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 04:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZF3CLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 22:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZF3CLP
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 22:11:15 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:61503 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbZF3CLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 22:11:12 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1947627qwb.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Q1qGk+z4eFjj/BnOkEE+GjYWs7pM72doWdxZ6AGeJTQ=;
        b=DdVv+X6Cx0I2a4cXvzTu5ec76NAr57TY59TrWrUhM8AxWNmOGoIlth9yEOXwfroQLy
         eK2wEg2tId1Bw1AomtHhQ1YHr4m4yLU7fD52uS2Q+S/LLK7LYuJlhlZswVv+YNFOcZi5
         AlAXhvB6vwqh3Eg7i9YtbKV65MQ45MkwgNQEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lLeDUDqP3Ow2UiyqnJD9AQrejAxK5wqgnFP1JXRkIDFZ6D/1zNYdn0EvxWMN/1sMEI
         zAIt0RdLOjroZS2Ud/ClyWbvnB3+XbQaXinSnf5Jb8kAukFAoZLI4jlT0lRHprPEo/jv
         1ms9ZsnUoPyb+45gW+cLPby/coraOgnz1DZd8=
Received: by 10.224.37.145 with SMTP id x17mr2250042qad.72.1246327875687;
        Mon, 29 Jun 2009 19:11:15 -0700 (PDT)
Received: from localhost (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 4sm683818qwe.38.2009.06.29.19.11.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 19:11:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.207.ga8208
In-Reply-To: <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122482>

Git-clean is not safe when the submodules are not tracked in mainline.  If
we run git-clean on the mainline branch, when we have a submodule that only
exists on a local branch, the entire .git directory of the untracked
submodule will get deleted, possibly losing any un-pushed local changes to
the submodule.

This change doesn't delete any untracked submodule's .git directories during
the recursive-delete (unless forced with the -m option to git-clean), so that
the submodule history can be restored w/ the proper git commands.

# Example illustrating problem:
# Clone mainline project
git clone git://github.com/thoughtbot/paperclip.git
cd paperclip/

# Add a submodule not tracked by mainline
git checkout -b test_submodule_clean
git submodule add git://github.com/technoweenie/attachment_fu.git attachement_fu
git commit -m "add submodule"

# Make a modification to the submodule.  Note that we haven't pushed the change
cd attachement_fu/
git checkout -b mod_readme_in_submodule
vi README
git add README
git commit -m "Small change in submodule"

# Go back to mainline's master branch and do a clean
cd ..
git checkout master
git clean -f -d

# Our change to the submodule, that was never pushed, is now gone forever
# because all the history stored in the submodule's .git direct is deleted.
# There is no recovering from this.
# This breaks the "git must be safe" rule, as we've lost potentially a lot of
# changes to any submodule projects that didn't get pushed yet. Solve
# this issue by not deleting any .git directories we come across during a
# git-clean, unless the "-m" option is passed to git-clean.

Signed-off-by: Jason Holden <jason.k.holden@gmail.com>
---
 Documentation/git-clean.txt |    6 +++++-
 builtin-clean.c             |   15 +++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index be894af..04a5a65 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-q] [-m] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -41,6 +41,10 @@ OPTIONS
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
+-m::
+	Clean any .git directories that may be left-over, untracked
+	submodules.
+
 -x::
 	Don't use the ignore rules.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
diff --git a/builtin-clean.c b/builtin-clean.c
index cd82407..60d78dc 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -15,7 +15,7 @@
 static int force = -1; /* unset */
 
 static const char *const builtin_clean_usage[] = {
-	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-q] [-m] [-x | -X] [--] <paths>...",
 	NULL
 };
 
@@ -31,6 +31,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int i;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
+	int rm_untracked_submodules = 0;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
 	const char *path, *base;
@@ -44,6 +45,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('f', NULL, &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
+		OPT_BOOLEAN('m', NULL, &rm_untracked_submodules,
+				"remove untracked submodules"),
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),
@@ -59,6 +62,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
+
+	int keep_dot_git = 0;
+	if (rm_untracked_submodules == 0)
+		keep_dot_git = 1;
+	else
+		printf("Any untracked .git directories will be deleted (abandoned submodules)\n");
+
+
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.flags |= DIR_SHOW_IGNORED;
@@ -141,7 +152,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
 					printf("Removing %s\n", qname);
-				if (remove_dir_recursively(&directory, 0, 0) != 0) {
+				if (remove_dir_recursively(&directory, 0, keep_dot_git) != 0) {
 					warning("failed to remove '%s'", qname);
 					errors++;
 				}
-- 
1.6.3.2.207.ga8208
