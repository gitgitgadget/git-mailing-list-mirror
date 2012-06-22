From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4 v8] Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Fri, 22 Jun 2012 11:03:24 +0200
Message-ID: <1340355806-6894-3-git-send-email-Matthieu.Moy@imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 11:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShzmZ-0008S2-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761788Ab2FVJDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:03:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42362 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761779Ab2FVJDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:03:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5M93Ghs032375
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 11:03:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmG-0003h8-K0; Fri, 22 Jun 2012 11:03:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmG-0001nu-Io; Fri, 22 Jun 2012 11:03:40 +0200
X-Mailer: git-send-email 1.7.11.rc3.235.gd0d1d08
In-Reply-To: <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 Jun 2012 11:03:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M93Ghs032375
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340960599.8418@USVW+qLlZxbCVAUJguu7IQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200425>

From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>

To use the feature of core.excludesfile, the user needs:

 1. to create such a file,

 2. and add configuration variable to point at it.

Instead, we can make this a one-step process by choosing a default value
which points to a filename in the user's $HOME, that is unlikely to
already exist on the system, and only use the presence of the file as a
cue that the user wants to use that feature.

We use "${XDG_CONFIG_HOME:-$HOME/.config/git}/ignore" as a default value.
It goes in the same directory as the newly added configuration
file ("${XDG_CONFIG_HOME:-$HOME/.config/git}/config), and follows the XDG
specification.

Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt    |  4 +++-
 Documentation/gitignore.txt |  4 +++-
 dir.c                       |  7 ++++++-
 t/t1306-xdg-files.sh        | 29 +++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..20e9531 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -483,7 +483,9 @@ core.excludesfile::
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  "`~/`" is expanded
 	to the value of `$HOME` and "`~user/`" to the specified user's
-	home directory.  See linkgit:gitignore[5].
+	home directory. Its default value is $XDG_CONFIG_HOME/git/ignore.
+	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ignore
+	is used instead. See linkgit:gitignore[5].
 
 core.askpass::
 	Some commands (e.g. svn and http interfaces) that interactively
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..c1f692a 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -50,7 +50,9 @@ the repository but are specific to one user's workflow) should go into
 the `$GIT_DIR/info/exclude` file.  Patterns which a user wants git to
 ignore in all situations (e.g., backup or temporary files generated by
 the user's editor of choice) generally go into a file specified by
-`core.excludesfile` in the user's `~/.gitconfig`.
+`core.excludesfile` in the user's `~/.gitconfig`. Its default value is
+$XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set or empty,
+$HOME/.config/git/ignore is used instead.
 
 The underlying git plumbing tools, such as
 'git ls-files' and 'git read-tree', read
diff --git a/dir.c b/dir.c
index ed1510f..8c6f47f 100644
--- a/dir.c
+++ b/dir.c
@@ -1234,12 +1234,17 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
+	char *xdg_path;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
+	if (!excludes_file) {
+		home_config_paths(NULL, &xdg_path, "ignore");
+		excludes_file = xdg_path;
+	}
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access(excludes_file, R_OK))
+	if (!access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 5b971d9..05103f5 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -67,4 +67,33 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
 '
 
 
+test_expect_success 'Setup' '
+	git init git &&
+	cd git &&
+	echo foo >to_be_excluded
+'
+
+
+test_expect_success 'Exclusion of a file in the XDG ignore file' '
+	mkdir -p "$HOME"/.config/git/ &&
+	echo to_be_excluded >"$HOME"/.config/git/ignore &&
+	test_must_fail git add to_be_excluded
+'
+
+
+test_expect_success 'Exclusion in both XDG and local ignore files' '
+	echo to_be_excluded >.gitignore &&
+	test_must_fail git add to_be_excluded
+'
+
+
+test_expect_success 'Exclusion in a non-XDG global ignore file' '
+	rm .gitignore &&
+	echo >"$HOME"/.config/git/ignore &&
+	echo to_be_excluded >"$HOME"/my_gitignore &&
+	git config core.excludesfile "$HOME"/my_gitignore &&
+	test_must_fail git add to_be_excluded
+'
+
+
 test_done
-- 
1.7.11.rc3.235.gd0d1d08
