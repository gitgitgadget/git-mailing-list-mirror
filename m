From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH v3] submodule: Improve documentation of update subcommand
Date: Thu, 19 Feb 2015 19:52:52 +0100
Message-ID: <1424371972-13393-1-git-send-email-sojkam1@fel.cvut.cz>
References: <87d255zt0j.fsf@steelpick.2x.cz>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 19:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOWDs-00042E-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbBSSxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 13:53:11 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:40890 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbbBSSxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 13:53:10 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5811E4CC666;
	Thu, 19 Feb 2015 19:53:05 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id KAslkXRzRzFW; Thu, 19 Feb 2015 19:53:03 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4E5414CC662;
	Thu, 19 Feb 2015 19:53:03 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YOWDe-0003Uh-PG; Thu, 19 Feb 2015 19:53:02 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <87d255zt0j.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264109>

The documentation of 'git submodule update' has several problems:

1) It mentions that value 'none' of submodule.$name.update can be
   overridden by --checkout, but other combinations of configuration
   values and command line options are not mentioned.

2) The documentation of submodule.$name.update is scattered across three
   places, which is confusing.

3) The documentation of submodule.$name.update in gitmodules.txt is
   incorrect, because the code always uses the value from .git/config
   and never from .gitmodules.

4) Documentation of --force was incomplete, because it is only effective
   in case of checkout method of update.

This patch fixes all these problems. Now, submodule.$name.update is
fully documented in git-submodule.txt and the other files just refer to
it. This is based on discussion between Junio C Hamano, Jens Lehmann and
myself.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/config.txt        | 15 +++++++----
 Documentation/git-submodule.txt | 58 +++++++++++++++++++++++++++++------------
 Documentation/gitmodules.txt    | 18 +++++--------
 3 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..fb2ae37 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2411,12 +2411,17 @@ status.submodulesummary::
 
 submodule.<name>.path::
 submodule.<name>.url::
+	The path within this project and URL for a submodule. These
+	variables are initially populated by 'git submodule init';
+	edit them to override the URL and other values found in the
+	`.gitmodules` file. See linkgit:git-submodule[1] and
+	linkgit:gitmodules[5] for details.
+
 submodule.<name>.update::
-	The path within this project, URL, and the updating strategy
-	for a submodule.  These variables are initially populated
-	by 'git submodule init'; edit them to override the
-	URL and other values found in the `.gitmodules` file.  See
-	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
+	The default updating strategy for a submodule. This variable
+	is populated by `git submodule init` from the
+	linkgit:gitmodules[5] file. See description of 'update'
+	command in linkgit:git-submodule[1].
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..72c6fb2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -154,14 +154,36 @@ If `--force` is specified, the submodule's work tree will be removed even if
 it contains local modifications.
 
 update::
-	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless `--rebase` or
-	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
-	`--checkout`. Setting the key `submodule.$name.update` to `!command`
-	will cause `command` to be run. `command` can be any arbitrary shell
-	command that takes a single argument, namely the sha1 to update to.
+	Update the registered submodules to match what the superproject
+	expects by cloning missing submodules and updating the working
+	tree of the submodules. The "updating" can be done in several
+	ways depending on command line options and the value of
+	`submodule.<name>.update` in .git/config:
+
+	checkout;; the new commit recorded in the superproject will be
+	    checked out in the submodule on a detached HEAD. This is
+	    done when `--checkout` option is given, or no option is
+	    given, and `submodule.<name>.update` is unset, or if it is set
+	    to 'checkout'.
+
+	rebase;; the current branch of the submodule will be rebased
+	    onto the commit recoded in the superproject. This is done
+	    when `--rebase` option is given, or no option is given, and
+	    `submodule.<name>.update` is set to 'rebase'.
+
+	merge;; the commit recorded in the superproject will be merged
+	    into the current branch in the submodule. This is done
+	    when `--merge` option is given, or no option is given, and
+	    `submodule.<name>.update` is set to 'merge'.
+
+	custom command;; arbitrary shell command that takes a single
+	    argument (the sha1 of the commit recorded in the
+	    superproject) is executed. This is done when no option is
+	    given, and `submodule.<name>.update` has the form of
+	    '!command'.
++
+When no option is given and `submodule.<name>.update` is set to 'none',
+the submodule is not updated.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -170,10 +192,11 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 +
-If `--force` is specified, the submodule will be checked out (using
-`git checkout --force` if appropriate), even if the commit specified in the
-index of the containing repository already matches the commit checked out in
-the submodule.
+If `--force` is specified and the checkout method of update is used, the
+submodule will be checked out (using `git checkout --force` if
+appropriate), even if the commit specified in the index of the
+containing repository already matches the commit checked out in the
+submodule.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -238,10 +261,11 @@ OPTIONS
 	When running add, allow adding an otherwise ignored submodule path.
 	When running deinit the submodule work trees will be removed even if
 	they contain local changes.
-	When running update, throw away local changes in submodules when
-	switching to a different commit; and always run a checkout operation
-	in the submodule, even if the commit listed in the index of the
-	containing repository matches the commit checked out in the submodule.
+	When running update and the checkout method is used, throw away
+	local changes in submodules when switching to a different
+	commit; and always run a checkout operation in the submodule,
+	even if the commit listed in the index of the containing
+	repository matches the commit checked out in the submodule.
 
 --cached::
 	This option is only valid for status and summary commands.  These
@@ -302,7 +326,7 @@ the submodule itself.
 	Checkout the commit recorded in the superproject on a detached HEAD
 	in the submodule. This is the default behavior, the main use of
 	this option is to override `submodule.$name.update` when set to
-	`merge`, `rebase` or `none`.
+	other value than `checkout`.
 	If the key `submodule.$name.update` is either not explicitly set or
 	set to `checkout`, this option is implicit.
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f6c0dfd..a51183c 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -38,18 +38,12 @@ submodule.<name>.url::
 In addition, there are a number of optional keys:
 
 submodule.<name>.update::
-	Defines what to do when the submodule is updated by the superproject.
-	If 'checkout' (the default), the new commit specified in the
-	superproject will be checked out in the submodule on a detached HEAD.
-	If 'rebase', the current branch of the submodule will be rebased onto
-	the commit specified in the superproject. If 'merge', the commit
-	specified in the superproject will be merged into the current branch
-	in the submodule.
-	If 'none', the submodule with name `$name` will not be updated
-	by default.
-
-	This config option is overridden if 'git submodule update' is given
-	the '--merge', '--rebase' or '--checkout' options.
+	Defines what to do when the submodule is updated by the
+	superproject. This is only used by `git submodule init` to
+	initialize the variable of the same name in .git/config.
+	Allowed values here are 'checkout', 'rebase', 'merge' or
+	'none'. See description of 'update' command in
+	linkgit:git-submodule[1] for their meaning.
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-- 
2.1.4
