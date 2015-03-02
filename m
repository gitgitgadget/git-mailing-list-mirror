From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH v6] submodule: Improve documentation of update subcommand
Date: Mon,  2 Mar 2015 23:57:58 +0100
Message-ID: <1425337078-24154-1-git-send-email-sojkam1@fel.cvut.cz>
References: <87k2yzrpm8.fsf@steelpick.2x.cz>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:58:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSZHy-0007Wj-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 23:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbbCBW6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 17:58:10 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:52339 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbCBW6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 17:58:09 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id D102919F37AD;
	Mon,  2 Mar 2015 23:58:07 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id OF_tcl3_ffCL; Mon,  2 Mar 2015 23:58:05 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id D8F8319F37AC;
	Mon,  2 Mar 2015 23:58:05 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YSZHk-0006IB-6V; Mon, 02 Mar 2015 23:58:00 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <87k2yzrpm8.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264631>

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

Fix all these problems by documenting submodule.*.update in
git-submodule.txt and make everybody else refer to it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/config.txt        | 14 +++++----
 Documentation/git-submodule.txt | 66 ++++++++++++++++++++++++++++-------------
 Documentation/gitmodules.txt    | 21 ++++++-------
 3 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..0a6852d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2411,12 +2411,16 @@ status.submodulesummary::
 
 submodule.<name>.path::
 submodule.<name>.url::
+	The path within this project and URL for a submodule. These
+	variables are initially populated by 'git submodule init'. See
+	linkgit:git-submodule[1] and linkgit:gitmodules[5] for
+	details.
+
 submodule.<name>.update::
-	The path within this project, URL, and the updating strategy
-	for a submodule.  These variables are initially populated
-	by 'git submodule init'; edit them to override the
-	URL and other values found in the `.gitmodules` file.  See
-	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
+	The default update procedure for a submodule. This variable
+	is populated by `git submodule init` from the
+	linkgit:gitmodules[5] file. See description of 'update'
+	command in linkgit:git-submodule[1].
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..2c25916 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -154,27 +154,51 @@ If `--force` is specified, the submodule's work tree will be removed even if
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
 +
+--
+Update the registered submodules to match what the superproject
+expects by cloning missing submodules and updating the working tree of
+the submodules. The "updating" can be done in several ways depending
+on command line options and the value of `submodule.<name>.update`
+configuration variable. Supported update procedures are:
+
+	checkout;; the commit recorded in the superproject will be
+	    checked out in the submodule on a detached HEAD. This is
+	    done when `--checkout` option is given, or no option is
+	    given, and `submodule.<name>.update` is unset, or if it is
+	    set to 'checkout'.
++
+If `--force` is specified, the submodule will be checked out (using
+`git checkout --force` if appropriate), even if the commit specified
+in the index of the containing repository already matches the commit
+checked out in the submodule.
+
+	rebase;; the current branch of the submodule will be rebased
+	    onto the commit recorded in the superproject. This is done
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
+
+When no option is given and `submodule.<name>.update` is set to 'none',
+the submodule is not updated.
+
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
-+
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
-+
-If `--force` is specified, the submodule will be checked out (using
-`git checkout --force` if appropriate), even if the commit specified in the
-index of the containing repository already matches the commit checked out in
-the submodule.
-
+--
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
@@ -238,10 +262,12 @@ OPTIONS
 	When running add, allow adding an otherwise ignored submodule path.
 	When running deinit the submodule work trees will be removed even if
 	they contain local changes.
-	When running update, throw away local changes in submodules when
-	switching to a different commit; and always run a checkout operation
-	in the submodule, even if the commit listed in the index of the
-	containing repository matches the commit checked out in the submodule.
+	When running update (only effective with the checkout procedure),
+	throw away local changes in submodules when switching to a
+	different commit; and always run a checkout operation in the
+	submodule, even if the commit listed in the index of the
+	containing repository matches the commit checked out in the
+	submodule.
 
 --cached::
 	This option is only valid for status and summary commands.  These
@@ -302,7 +328,7 @@ the submodule itself.
 	Checkout the commit recorded in the superproject on a detached HEAD
 	in the submodule. This is the default behavior, the main use of
 	this option is to override `submodule.$name.update` when set to
-	`merge`, `rebase` or `none`.
+	a value other than `checkout`.
 	If the key `submodule.$name.update` is either not explicitly set or
 	set to `checkout`, this option is implicit.
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f6c0dfd..ac70eca 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -38,18 +38,15 @@ submodule.<name>.url::
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
+	Defines the default update procedure for the named submodule,
+	i.e. how the submodule is updated by "git submodule update"
+	command in the superproject. This is only used by `git
+	submodule init` to initialize the configuration variable of
+	the same name. Allowed values here are 'checkout', 'rebase',
+	'merge' or 'none'. See description of 'update' command in
+	linkgit:git-submodule[1] for their meaning. Note that the
+	'!command' form is intentionally ignored here for security
+	reasons.
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-- 
2.1.4
