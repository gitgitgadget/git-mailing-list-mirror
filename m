From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH v2] submodule: Fix documentation of update subcommand
Date: Wed, 18 Feb 2015 23:48:36 +0100
Message-ID: <1424299716-21138-1-git-send-email-sojkam1@fel.cvut.cz>
References: <xmqqvbj0yx6c.fsf@gitster.dls.corp.google.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 23:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YODY7-0000WH-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 23:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbbBRW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 17:56:50 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:39758 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbbBRW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 17:56:49 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2015 17:56:49 EST
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id EF0693CFFB7;
	Wed, 18 Feb 2015 23:49:26 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id bCqwdqnTmf9a; Wed, 18 Feb 2015 23:49:25 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id E69143CFFB4;
	Wed, 18 Feb 2015 23:49:24 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YODQk-0005W2-OZ; Wed, 18 Feb 2015 23:49:18 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <xmqqvbj0yx6c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264069>

The documentation of 'git submodule update' has several problems:

1) It says that submodule.$name.update can be overridden by --checkout
   only if its value is `none`. This is not true, because both
   implementation and documentation of --checkout specifies that the
   override applies to all possible values.

2) The documentation of submodule.$name.update key is scattered across
   three places, which is confusing.

3) The documentation of submodule.$name.update in gitmodules.txt is
   incorrect, because the code always uses the value from .git/config
   and never from .gitmodules.

This patch fixes all three problems. Now, submodule.$name.update is
fully documented in config.txt and the other files just refer to it.
This is based on discussion between myself, Junio C Hamano and Jens
Lehmann.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/config.txt        | 27 ++++++++++++++++++++++-----
 Documentation/git-submodule.txt | 17 ++++++++---------
 Documentation/gitmodules.txt    | 18 ++++++------------
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..f30cbbc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2411,12 +2411,29 @@ status.submodulesummary::
 
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
+	The default updating strategy for a submodule, used by `git
+	submodule update`. This variable is populated by `git
+	submodule init` from linkgit:gitmodules[5].
+
+	If the value is 'checkout' (the default), the new commit
+	specified in the superproject will be checked out in the
+	submodule on a detached HEAD.
+	If 'rebase', the current branch of the submodule will be
+	rebased onto the commit specified in the superproject.
+	If 'merge', the commit specified in the superproject will be
+	merged into the current branch in the submodule. If 'none',
+	the submodule with name `$name` will not be updated by
+	default.
+	If the value is of form '!command', it will cause `command` to
+	be run. `command` can be any arbitrary shell command that
+	takes a single argument, namely the sha1 to update to.
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..c92908e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -154,14 +154,13 @@ If `--force` is specified, the submodule's work tree will be removed even if
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
+	tree of the submodules. The "updating" can take various forms
+	and can be configured in .git/config by the
+	`submodule.$name.update` key or by explicitely giving one of
+	'--checkout' (the default), '--merge' or '--rebase' options. See
+	linkgit:git-config[1] for details.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -302,7 +301,7 @@ the submodule itself.
 	Checkout the commit recorded in the superproject on a detached HEAD
 	in the submodule. This is the default behavior, the main use of
 	this option is to override `submodule.$name.update` when set to
-	`merge`, `rebase` or `none`.
+	other value than `checkout`.
 	If the key `submodule.$name.update` is either not explicitly set or
 	set to `checkout`, this option is implicit.
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f6c0dfd..59efbfe 100644
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
+	'none'. See linkgit:git-config[1] for their meaning and other
+	values that can be configured manually by users.
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-- 
2.1.4
