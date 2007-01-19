From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation/git.txt: command re-classification
Date: Thu, 18 Jan 2007 22:32:38 -0800
Message-ID: <7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 07:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7nIv-0002Lp-5p
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 07:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXASGcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 01:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbXASGcl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 01:32:41 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43877 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbXASGck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 01:32:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119063240.HAMZ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 19 Jan 2007 01:32:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CuXl1W00F1kojtg0000000; Fri, 19 Jan 2007 01:31:46 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701181713200.2577@xanadu.home> (Nicolas Pitre's
	message of "Thu, 18 Jan 2007 17:25:41 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37152>

This adds two new classes (pure-helpers and "Interacting with
Others") to the command list in the main manual page.  The
latter class is primarily about foreign SCM interface and is
placed before low-level (plumbing) commands.

Also it promotes a handful commands to mainporcelain category
while demotes some others.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I unfortunately had to drop your patch on the floor, because
   I was cooking a few patches to automate the maintenance of
   the command list (which are now in 'master' and the product is
   being served at www.kernel.org/pub/software/scm/git/docs/),
   which majorly conflicted with your work.

   So here is a counterproposal; I moved commands across groups
   after looking at what your patch did, but classified some of
   them differently.

 Documentation/Makefile      |    5 ++-
 Documentation/cmd-list.perl |   88 ++++++++++++++++++++++---------------------
 Documentation/git.txt       |   35 ++++++++++++++++-
 3 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 96755ad..19b2505 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,7 +76,10 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-mainporcelain.txt \
 	cmds-plumbinginterrogators.txt \
 	cmds-plumbingmanipulators.txt \
-	cmds-synchingrepositories.txt
+	cmds-synchingrepositories.txt \
+	cmds-synchelpers.txt \
+	cmds-purehelpers.txt \
+	cmds-foreignscminterface.txt
 
 $(cmds_txt): cmd-list.perl $(MAN1_TXT) $(MAN7_TXT)
 	perl ./cmd-list.perl
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5680dcb..9443ab3 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -45,7 +45,10 @@ for my $cat (qw(ancillaryinterrogators
 		mainporcelain
 		plumbinginterrogators
 		plumbingmanipulators
-		synchingrepositories)) {
+		synchingrepositories
+		foreignscminterface
+		purehelpers
+		synchelpers)) {
 	my $out = "cmds-$cat.txt";
 	open O, '>', "$out+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
@@ -60,9 +63,9 @@ git-add                                 mainporcelain
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
 git-applymbox                           mainporcelain
-git-applypatch                          ancillarymanipulators
+git-applypatch                          purehelpers
 git-apply                               plumbingmanipulators
-git-archimport                          ancillarymanipulators
+git-archimport                          foreignscminterface
 git-archive                             mainporcelain
 git-bisect                              mainporcelain
 git-blame                               ancillaryinterrogators
@@ -70,7 +73,7 @@ git-branch                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-checkout-index                      plumbingmanipulators
 git-checkout                            mainporcelain
-git-check-ref-format                    ancillaryinterrogators
+git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-clean                               mainporcelain
@@ -79,11 +82,11 @@ git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
 git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
-git-cvsexportcommit                     ancillarymanipulators
-git-cvsimport                           ancillarymanipulators
-git-cvsserver                           ancillarymanipulators
-git-daemon                              ancillaryinterrogators
-git-describe                            plumbinginterrogators
+git-cvsexportcommit                     foreignscminterface
+git-cvsimport                           foreignscminterface
+git-cvsserver                           foreignscminterface
+git-daemon                              synchingrepositories
+git-describe                            mainporcelain
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff                                mainporcelain
@@ -91,34 +94,34 @@ git-diff-stages                         plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-fetch                               mainporcelain
 git-fetch-pack                          synchingrepositories
-git-fmt-merge-msg                       ancillaryinterrogators
+git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
 git-fsck-objects                        plumbinginterrogators
-git-gc                                  ancillarymanipulators
+git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain
 git-hash-object                         plumbingmanipulators
-git-http-fetch                          synchingrepositories
-git-http-push                           synchingrepositories
-git-imap-send                           ancillaryinterrogators
+git-http-fetch                          synchelpers
+git-http-push                           synchelpers
+git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                plumbingmanipulators
+git-init                                mainporcelain
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
 git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
 git-lost-found                          ancillarymanipulators
 git-ls-files                            plumbinginterrogators
-git-ls-remote                           mainporcelain
+git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
-git-mailinfo                            ancillaryinterrogators
-git-mailsplit                           ancillaryinterrogators
+git-mailinfo                            purehelpers
+git-mailsplit                           purehelpers
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge                               mainporcelain
-git-merge-one-file                      ancillarymanipulators
+git-merge-one-file                      purehelpers
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
@@ -126,24 +129,24 @@ git-mv                                  mainporcelain
 git-name-rev                            plumbinginterrogators
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
-git-pack-refs                           mainporcelain
-git-parse-remote                        ancillaryinterrogators
-git-patch-id                            ancillaryinterrogators
-git-peek-remote                         synchingrepositories
+git-pack-refs                           ancillarymanipulators
+git-parse-remote                        synchelpers
+git-patch-id                            purehelpers
+git-peek-remote                         purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain
 git-push                                mainporcelain
-git-quiltimport                         ancillarymanipulators
+git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain
-git-receive-pack                        synchingrepositories
+git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
-git-repack                              mainporcelain
-git-repo-config                         plumbingmanipulators
-git-request-pull                        ancillaryinterrogators
-git-rerere                              mainporcelain
+git-repack                              ancillarymanipulators
+git-repo-config                         ancillarymanipulators
+git-request-pull                        foreignscminterface
+git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain
 git-resolve                             mainporcelain
 git-revert                              mainporcelain
@@ -151,34 +154,33 @@ git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain
 git-runstatus                           ancillaryinterrogators
-git-send-email                          ancillaryinterrogators
+git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
-git-shell                               synchingrepositories
+git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain
 git-show-branch                         mainporcelain
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
-git-sh-setup                            ancillarymanipulators
+git-sh-setup                            purehelpers
 git-ssh-fetch                           synchingrepositories
 git-ssh-upload                          synchingrepositories
 git-status                              mainporcelain
-git-stripspace                          ancillaryinterrogators
-git-svn                                 ancillarymanipulators
-git-svnimport                           ancillarymanipulators
-git-symbolic-ref                        ancillaryinterrogators
-git-symbolic-ref                        ancillarymanipulators
-git-tag                                 ancillarymanipulators
+git-stripspace                          purehelpers
+git-svn                                 foreignscminterface
+git-svnimport                           foreignscminterface
+git-symbolic-ref                        plumbingmanipulators
+git-tag                                 mainporcelain
 git-tar-tree                            plumbinginterrogators
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
-git-update-ref                          ancillarymanipulators
+git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
-git-upload-archive                      synchingrepositories
-git-upload-pack                         synchingrepositories
+git-upload-archive                      synchelpers
+git-upload-pack                         synchelpers
 git-var                                 plumbinginterrogators
 git-verify-pack                         plumbinginterrogators
-git-verify-tag                          mainporcelain
-git-whatchanged                         mainporcelain
+git-verify-tag                          ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators
 git-write-tree                          plumbingmanipulators
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ac22206..ded48b5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -93,6 +93,16 @@ Interrogators:
 
 include::cmds-ancillaryinterrogators.txt[]
 
+
+Interacting with Others
+~~~~~~~~~~~~~~~~~~~~~~~
+
+These commands are to interact with foreign SCM and with other
+people via patch over e-mail.
+
+include::cmds-foreignscminterface.txt[]
+
+
 Low-level commands (plumbing)
 -----------------------------
 
@@ -102,11 +112,20 @@ development of alternative porcelains.  Developers of such porcelains
 might start by reading about gitlink:git-update-index[1] and
 gitlink:git-read-tree[1].
 
-We divide the low-level commands into commands that manipulate objects (in
+The interface (input, output, set of options and the semantics)
+to these low-level commands are meant to be a lot more stable
+than Porcelain level commands, because these commands are
+primarily for scripted use.  To put it another way, the
+interface to Plumbing commands are subject to change in order to
+improve the end user experience.
+
+The following description divides
+the low-level commands into commands that manipulate objects (in
 the repository, index, and working tree), commands that interrogate and
 compare objects, and commands that move objects and references between
 repositories.
 
+
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -127,6 +146,20 @@ Synching repositories
 
 include::cmds-synchingrepositories.txt[]
 
+The following are helper programs used by the above; end users
+typically do not use them directly.
+
+include::cmds-synchelpers.txt[]
+
+
+Internal helper commands
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+These are internal helper commands used by other commands; end
+users typically do not use them directly.
+
+include::cmds-purehelpers.txt[]
+
 
 Configuration Mechanism
 -----------------------
-- 
1.5.0.rc1.g72fe
