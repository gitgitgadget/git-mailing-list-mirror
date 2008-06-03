From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add configuration option for default untracked files mode
Date: Tue, 3 Jun 2008 15:12:50 +0200
Message-ID: <de684211037cc61f1e0510fcf38a51f571765efd.1212498900.git.marius@trolltech.com>
References: <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jun 03 15:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3WSM-0000Yd-2k
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYFCNUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYFCNUr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:20:47 -0400
Received: from hoat.troll.no ([62.70.27.150]:44407 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbYFCNUp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 09:20:45 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 7E5EA20A83;
	Tue,  3 Jun 2008 15:20:39 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 6AB8720A46;
	Tue,  3 Jun 2008 15:20:39 +0200 (CEST)
Content-Disposition: inline
Apparently-To: <marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83653>

By default, the untracked files mode for commit/status is 'normal'.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt     |   15 +++++++++++++++
 Documentation/git-commit.txt |    4 +++-
 wt-status.c                  |   13 +++++++++++++
 3 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5331b45..12c0be3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1013,6 +1013,21 @@ status.relativePaths::
 	relative to the repository root (this was the default for git
 	prior to v1.5.4).
 
+status.showUntrackedFiles::
+	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
+	files which are not currently tracked by Git. Directories which
+	contain only untracked files, are shown with the directory name
+	only. Showing untracked files means that Git needs to lstat() all
+	all the files in the whole repository, which might be slow on some
+	systems. So, this variable controls how the commands displays
+	the untracked files. Possible values are:
+		none   - Show no untracked files
+		normal - Shows untracked files and directories
+		all    - Shows also individual files in untracked directories.
+	If this variable is not specified, it defaults to 'normal'.
+	This variable can be overridden with the -u|--untracked-files option
+	of linkgit:git-status[1] and linkgit:git-commit[1].
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d8a3aa3..bcbc2c2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -158,7 +158,9 @@ but can be used to amend a merge commit.
 		normal - Shows untracked files and directories
 		all    - Also shows individual files in untracked directories.
 	If the mode parameter is not specified, the defaults is
-	'all'.
+	'all'. See linkgit:git-config[1] for configuration variable
+	used to change the default for when the option is not
+	specified.
 
 -v|--verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/wt-status.c b/wt-status.c
index 742a474..9ffe1c3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -397,5 +397,18 @@ int git_status_config(const char *k, const char *v, void *cb)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.showuntrackedfiles")) {
+		if (!v)
+			return config_error_nonbool(v);
+		else if (!strcmp(v, "none"))
+			show_untracked_files = NONE_UNTRACKED;
+		else if (!strcmp(v, "normal"))
+			show_untracked_files = NORMAL_UNTRACKED;
+		else if (!strcmp(v, "all"))
+			show_untracked_files = ALL_UNTRACKED;
+		else
+			return error("Invalid untracked files mode '%s'", v);
+		return 0;
+	}
 	return git_color_default_config(k, v, cb);
 }
-- 
1.5.5.GIT
