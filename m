From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Consolidate command list to one.
Date: Sat,  1 Dec 2007 23:45:59 -0800
Message-ID: <1196581559-1614-2-git-send-email-gitster@pobox.com>
References: <1196581559-1614-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyjZt-0004U3-EY
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbXLBHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbXLBHqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:46:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56176 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbXLBHqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:46:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 463572EF
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:46:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B66B39A3B5
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:46:25 -0500 (EST)
X-Mailer: git-send-email 1.5.3.6.2090.g4ece0
In-Reply-To: <1196581559-1614-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66768>

The categorized list of commands in git(7) and the list of common
commands in "git help" output were maintained separately, which was
insane.  This consolidates them to a single command-list.txt file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile      |    4 +-
 Documentation/cmd-list.perl |  138 +-----------------------------------------
 Makefile                    |    8 +-
 command-list.txt            |  128 +++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh         |   25 +-------
 5 files changed, 140 insertions(+), 163 deletions(-)
 create mode 100644 command-list.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d886641..de11ee0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,9 +122,9 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 
 $(cmds_txt): cmd-list.made
 
-cmd-list.made: cmd-list.perl $(MAN1_TXT)
+cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(RM) $@
-	perl ./cmd-list.perl
+	perl ./cmd-list.perl ../command-list.txt
 	date >$@
 
 git.7 git.html: git.txt
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index b709551..93b84b1 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -28,8 +28,8 @@ sub format_one {
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
 		print $out "gitlink:$name\[1\]::\n\t";
-		if ($attr) {
-			print $out "($attr) ";
+		if ($attr =~ / deprecated /) {
+			print $out "(deprecated) ";
 		}
 		print $out "$text.\n\n";
 	}
@@ -39,12 +39,12 @@ sub format_one {
 }
 
 my %cmds = ();
-while (<DATA>) {
+for (sort <>) {
 	next if /^#/;
 
 	chomp;
 	my ($name, $cat, $attr) = /^(\S+)\s+(.*?)(?:\s+(.*))?$/;
-	push @{$cmds{$cat}}, [$name, $attr];
+	push @{$cmds{$cat}}, [$name, " $attr "];
 }
 
 for my $cat (qw(ancillaryinterrogators
@@ -71,133 +71,3 @@ for my $cat (qw(ancillaryinterrogators
 		rename "$out+", "$out";
 	}
 }
-
-# The following list is sorted with "sort -d" to make it easier
-# to find entry in the resulting git.html manual page.
-__DATA__
-git-add                                 mainporcelain
-git-am                                  mainporcelain
-git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators
-git-archimport                          foreignscminterface
-git-archive                             mainporcelain
-git-bisect                              mainporcelain
-git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain
-git-bundle                              mainporcelain
-git-cat-file                            plumbinginterrogators
-git-check-attr                          purehelpers
-git-checkout                            mainporcelain
-git-checkout-index                      plumbingmanipulators
-git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators
-git-cherry-pick                         mainporcelain
-git-citool                              mainporcelain
-git-clean                               mainporcelain
-git-clone                               mainporcelain
-git-commit                              mainporcelain
-git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators
-git-count-objects                       ancillaryinterrogators
-git-cvsexportcommit                     foreignscminterface
-git-cvsimport                           foreignscminterface
-git-cvsserver                           foreignscminterface
-git-daemon                              synchingrepositories
-git-describe                            mainporcelain
-git-diff                                mainporcelain
-git-diff-files                          plumbinginterrogators
-git-diff-index                          plumbinginterrogators
-git-diff-tree                           plumbinginterrogators
-git-fast-import				ancillarymanipulators
-git-fetch                               mainporcelain
-git-fetch-pack                          synchingrepositories
-git-filter-branch                       ancillarymanipulators
-git-fmt-merge-msg                       purehelpers
-git-for-each-ref                        plumbinginterrogators
-git-format-patch                        mainporcelain
-git-fsck	                        ancillaryinterrogators
-git-gc                                  mainporcelain
-git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain
-git-gui                                 mainporcelain
-git-hash-object                         plumbingmanipulators
-git-http-fetch                          synchelpers
-git-http-push                           synchelpers
-git-imap-send                           foreignscminterface
-git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain
-git-instaweb                            ancillaryinterrogators
-gitk                                    mainporcelain
-git-log                                 mainporcelain
-git-lost-found                          ancillarymanipulators	deprecated
-git-ls-files                            plumbinginterrogators
-git-ls-remote                           plumbinginterrogators
-git-ls-tree                             plumbinginterrogators
-git-mailinfo                            purehelpers
-git-mailsplit                           purehelpers
-git-merge                               mainporcelain
-git-merge-base                          plumbinginterrogators
-git-merge-file                          plumbingmanipulators
-git-merge-index                         plumbingmanipulators
-git-merge-one-file                      purehelpers
-git-mergetool                           ancillarymanipulators
-git-merge-tree                          ancillaryinterrogators
-git-mktag                               plumbingmanipulators
-git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain
-git-name-rev                            plumbinginterrogators
-git-pack-objects                        plumbingmanipulators
-git-pack-redundant                      plumbinginterrogators
-git-pack-refs                           ancillarymanipulators
-git-parse-remote                        synchelpers
-git-patch-id                            purehelpers
-git-peek-remote                         purehelpers	deprecated
-git-prune                               ancillarymanipulators
-git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain
-git-push                                mainporcelain
-git-quiltimport                         foreignscminterface
-git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain
-git-receive-pack                        synchelpers
-git-reflog                              ancillarymanipulators
-git-relink                              ancillarymanipulators
-git-remote                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-request-pull                        foreignscminterface
-git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain
-git-revert                              mainporcelain
-git-rev-list                            plumbinginterrogators
-git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain
-git-runstatus                           ancillaryinterrogators
-git-send-email                          foreignscminterface
-git-send-pack                           synchingrepositories
-git-shell                               synchelpers
-git-shortlog                            mainporcelain
-git-show                                mainporcelain
-git-show-branch                         ancillaryinterrogators
-git-show-index                          plumbinginterrogators
-git-show-ref                            plumbinginterrogators
-git-sh-setup                            purehelpers
-git-stash                               mainporcelain
-git-status                              mainporcelain
-git-stripspace                          purehelpers
-git-submodule                           mainporcelain
-git-svn                                 foreignscminterface
-git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain
-git-tar-tree                            plumbinginterrogators	deprecated
-git-unpack-file                         plumbinginterrogators
-git-unpack-objects                      plumbingmanipulators
-git-update-index                        plumbingmanipulators
-git-update-ref                          plumbingmanipulators
-git-update-server-info                  synchingrepositories
-git-upload-archive                      synchelpers
-git-upload-pack                         synchelpers
-git-var                                 plumbinginterrogators
-git-verify-pack                         plumbinginterrogators
-git-verify-tag                          ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators
-git-write-tree                          plumbingmanipulators
diff --git a/Makefile b/Makefile
index c35c870..d5d2c7c 100644
--- a/Makefile
+++ b/Makefile
@@ -796,7 +796,7 @@ git-merge-subtree$X: git-merge-recursive$X
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh
+common-cmds.h: ./generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
@@ -1138,7 +1138,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '1,/^__DATA__/d' Documentation/cmd-list.perl | \
+		sed -e '/^#/d' command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -1146,9 +1146,9 @@ check-docs::
 		esac ; \
 	done; \
 	( \
-		sed -e '1,/^__DATA__/d' \
+		sed -e '/^#/d' \
 		    -e 's/[ 	].*//' \
-		    -e 's/^/listed /' Documentation/cmd-list.perl; \
+		    -e 's/^/listed /' command-list.txt; \
 		ls -1 Documentation/git*txt | \
 		sed -e 's|Documentation/|documented |' \
 		    -e 's/\.txt//'; \
diff --git a/command-list.txt b/command-list.txt
new file mode 100644
index 0000000..d30e869
--- /dev/null
+++ b/command-list.txt
@@ -0,0 +1,128 @@
+# List of known git commands.
+# command name				category [deprecated] [common]
+git-add                                 mainporcelain common
+git-am                                  mainporcelain
+git-annotate                            ancillaryinterrogators
+git-apply                               plumbingmanipulators
+git-archimport                          foreignscminterface
+git-archive                             mainporcelain
+git-bisect                              mainporcelain common
+git-blame                               ancillaryinterrogators
+git-branch                              mainporcelain common
+git-bundle                              mainporcelain
+git-cat-file                            plumbinginterrogators
+git-check-attr                          purehelpers
+git-checkout                            mainporcelain common
+git-checkout-index                      plumbingmanipulators
+git-check-ref-format                    purehelpers
+git-cherry                              ancillaryinterrogators
+git-cherry-pick                         mainporcelain
+git-citool                              mainporcelain
+git-clean                               mainporcelain
+git-clone                               mainporcelain common
+git-commit                              mainporcelain common
+git-commit-tree                         plumbingmanipulators
+git-config                              ancillarymanipulators
+git-count-objects                       ancillaryinterrogators
+git-cvsexportcommit                     foreignscminterface
+git-cvsimport                           foreignscminterface
+git-cvsserver                           foreignscminterface
+git-daemon                              synchingrepositories
+git-describe                            mainporcelain
+git-diff                                mainporcelain common
+git-diff-files                          plumbinginterrogators
+git-diff-index                          plumbinginterrogators
+git-diff-tree                           plumbinginterrogators
+git-fast-import				ancillarymanipulators
+git-fetch                               mainporcelain common
+git-fetch-pack                          synchingrepositories
+git-filter-branch                       ancillarymanipulators
+git-fmt-merge-msg                       purehelpers
+git-for-each-ref                        plumbinginterrogators
+git-format-patch                        mainporcelain
+git-fsck	                        ancillaryinterrogators
+git-gc                                  mainporcelain
+git-get-tar-commit-id                   ancillaryinterrogators
+git-grep                                mainporcelain common
+git-gui                                 mainporcelain
+git-hash-object                         plumbingmanipulators
+git-http-fetch                          synchelpers
+git-http-push                           synchelpers
+git-imap-send                           foreignscminterface
+git-index-pack                          plumbingmanipulators
+git-init                                mainporcelain common
+git-instaweb                            ancillaryinterrogators
+gitk                                    mainporcelain
+git-log                                 mainporcelain common
+git-lost-found                          ancillarymanipulators	deprecated
+git-ls-files                            plumbinginterrogators
+git-ls-remote                           plumbinginterrogators
+git-ls-tree                             plumbinginterrogators
+git-mailinfo                            purehelpers
+git-mailsplit                           purehelpers
+git-merge                               mainporcelain common
+git-merge-base                          plumbinginterrogators
+git-merge-file                          plumbingmanipulators
+git-merge-index                         plumbingmanipulators
+git-merge-one-file                      purehelpers
+git-mergetool                           ancillarymanipulators
+git-merge-tree                          ancillaryinterrogators
+git-mktag                               plumbingmanipulators
+git-mktree                              plumbingmanipulators
+git-mv                                  mainporcelain common
+git-name-rev                            plumbinginterrogators
+git-pack-objects                        plumbingmanipulators
+git-pack-redundant                      plumbinginterrogators
+git-pack-refs                           ancillarymanipulators
+git-parse-remote                        synchelpers
+git-patch-id                            purehelpers
+git-peek-remote                         purehelpers	deprecated
+git-prune                               ancillarymanipulators
+git-prune-packed                        plumbingmanipulators
+git-pull                                mainporcelain common
+git-push                                mainporcelain common
+git-quiltimport                         foreignscminterface
+git-read-tree                           plumbingmanipulators
+git-rebase                              mainporcelain common
+git-receive-pack                        synchelpers
+git-reflog                              ancillarymanipulators
+git-relink                              ancillarymanipulators
+git-remote                              ancillarymanipulators
+git-repack                              ancillarymanipulators
+git-request-pull                        foreignscminterface
+git-rerere                              ancillaryinterrogators
+git-reset                               mainporcelain common
+git-revert                              mainporcelain
+git-rev-list                            plumbinginterrogators
+git-rev-parse                           ancillaryinterrogators
+git-rm                                  mainporcelain common
+git-runstatus                           ancillaryinterrogators
+git-send-email                          foreignscminterface
+git-send-pack                           synchingrepositories
+git-shell                               synchelpers
+git-shortlog                            mainporcelain
+git-show                                mainporcelain common
+git-show-branch                         ancillaryinterrogators
+git-show-index                          plumbinginterrogators
+git-show-ref                            plumbinginterrogators
+git-sh-setup                            purehelpers
+git-stash                               mainporcelain
+git-status                              mainporcelain common
+git-stripspace                          purehelpers
+git-submodule                           mainporcelain
+git-svn                                 foreignscminterface
+git-symbolic-ref                        plumbingmanipulators
+git-tag                                 mainporcelain common
+git-tar-tree                            plumbinginterrogators	deprecated
+git-unpack-file                         plumbinginterrogators
+git-unpack-objects                      plumbingmanipulators
+git-update-index                        plumbingmanipulators
+git-update-ref                          plumbingmanipulators
+git-update-server-info                  synchingrepositories
+git-upload-archive                      synchelpers
+git-upload-pack                         synchelpers
+git-var                                 plumbinginterrogators
+git-verify-pack                         plumbinginterrogators
+git-verify-tag                          ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators
+git-write-tree                          plumbingmanipulators
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 1ba27ec..a2913c2 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,29 +9,8 @@ struct cmdname_help
 
 static struct cmdname_help common_cmds[] = {"
 
-sort <<\EOF |
-add
-bisect
-branch
-checkout
-clone
-commit
-diff
-fetch
-grep
-init
-log
-merge
-mv
-pull
-push
-rebase
-reset
-rm
-show
-status
-tag
-EOF
+sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
+sort |
 while read cmd
 do
      sed -n '
-- 
1.5.3.6.2090.g4ece0
