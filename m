From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 3/3] Add configuration option for default untracked files mode
Date: Thu, 5 Jun 2008 14:47:50 +0200
Message-ID: <3a9bed01c38e8f10dbde8f422e9c039faef126b1.1212995703.git.marius@trolltech.com>
References: <f6ce4457c92b77210ceceeddb32cf30ca65103ed.1212995703.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 09:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5bib-00023e-DE
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 09:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbYFIHWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 03:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbYFIHWA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 03:22:00 -0400
Received: from hoat.troll.no ([62.70.27.150]:44924 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757510AbYFIHV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2008 03:21:58 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id CA64E20AC5;
	Mon,  9 Jun 2008 09:21:52 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 96F82202F2;
	Mon,  9 Jun 2008 09:21:52 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84366>

By default, the untracked files mode for commit/status is 'normal'

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt     |   19 +++++++++++++++++++
 Documentation/git-commit.txt |    4 ++++
 t/t7502-status.sh            |   18 ++++++++++++++++++
 wt-status.c                  |   13 +++++++++++++
 4 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c298dc2..7ce7816 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1010,6 +1010,25 @@ status.relativePaths::
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
++
+--
+		- 'no'     - Show no untracked files
+		- 'normal' - Shows untracked files and directories
+		- 'all'    - Shows also individual files in untracked directories.
+--
++
+If this variable is not specified, it defaults to 'normal'.
+This variable can be overridden with the -u|--untracked-files option
+of linkgit:git-status[1] and linkgit:git-commit[1].
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a6db831..1235aae 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -161,6 +161,10 @@ the handling of untracked files. The possible options are:
 		- 'normal' - Shows untracked files and directories
 		- 'all'    - Also shows individual files in untracked directories.
 --
++
+See linkgit:git-config[1] for configuration variable
+used to change the default for when the option is not
+specified.
 
 -v|--verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index d84bda1..38a48b5 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -89,6 +89,12 @@ test_expect_success 'status -uno' '
 	test_cmp expect output
 '
 
+test_expect_success 'status (status.showUntrackedFiles no)' '
+	git config status.showuntrackedfiles no
+	git status >output &&
+	test_cmp expect output
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -117,6 +123,12 @@ test_expect_success 'status -unormal' '
 	test_cmp expect output
 '
 
+test_expect_success 'status (status.showUntrackedFiles normal)' '
+	git config status.showuntrackedfiles normal
+	git status >output &&
+	test_cmp expect output
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -143,7 +155,13 @@ cat >expect <<EOF
 EOF
 test_expect_success 'status -uall' '
 	git status -uall >output &&
+	test_cmp expect output
+'
+test_expect_success 'status (status.showUntrackedFiles all)' '
+	git config status.showuntrackedfiles all
+	git status >output &&
 	rm -rf dir3 &&
+	git config --unset status.showuntrackedfiles &&
 	test_cmp expect output
 '
 
diff --git a/wt-status.c b/wt-status.c
index 23017e4..28c9e63 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -397,5 +397,18 @@ int git_status_config(const char *k, const char *v, void *cb)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.showuntrackedfiles")) {
+		if (!v)
+			return config_error_nonbool(v);
+		else if (!strcmp(v, "no"))
+			show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+		else if (!strcmp(v, "normal"))
+			show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+		else if (!strcmp(v, "all"))
+			show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+		else
+			return error("Invalid untracked files mode '%s'", v);
+		return 0;
+	}
 	return git_color_default_config(k, v, cb);
 }
-- 
1.5.6.rc0.160.gf7c043.dirty
