Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393501F453
	for <e@80x24.org>; Tue, 19 Feb 2019 18:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfBSSBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 13:01:39 -0500
Received: from egnor-li.ofb.net ([23.92.24.4]:39932 "EHLO egnor-li.ofb.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfBSSBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 13:01:38 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 13:01:37 EST
Received: from ofb.net (163.242.197.104.bc.googleusercontent.com [104.197.242.163])
        by egnor-li.ofb.net (Postfix) with ESMTP id A70BF118037;
        Tue, 19 Feb 2019 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 1E39C3E894;
        Tue, 19 Feb 2019 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ofb.net; s=ofb;
        t=1550598877; bh=5+m4EwvnnCLgA0GO6xN+oTnzJoBOnXbYYRrzRIiywkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vp6ulYQ+2iLfkD34KBM1mR3vpAf9JXwLoTtEjE2JWKUHdUnqo4qmwuY5R+kX8c2RJ
         yqqVG1H9Maeui1h8qwog9fes/A+zD3zmr5tdSPxCTMlxCR6OhubXTxIyY5N9LZfgB7
         KP26TNGPTY84glCrCDGpzyB4oOOXQY58O2+x1EiHyDye4pZRZ3UPuImoHfRE4E57SF
         WdsjYiw9MoUjfnG8IpP1gigidU2X5ftus/9DykiPOLpjC3oXIiLjN/93ClUa0uh6Sg
         RVKNOsXMKoYkV1e0qgy2dFsJZifem8j0gXm9dgYU/6wGh/HkEjh+/Mz35gCpNB7k/j
         EIQfLoupo4MoA==
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1gw9bI-0004lo-Hw; Tue, 19 Feb 2019 09:54:36 -0800
From:   Frederick Eaton <frederik@ofb.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frederick Eaton <frederik@ofb.net>
Subject: [PATCH] Prioritize list of commands appearing in git(1), via command-list.txt. Don't invoke 'sort' in Documentation/cmd-list.perl.
Date:   Tue, 19 Feb 2019 09:54:13 -0800
Message-Id: <20190219175413.18292-2-frederik@ofb.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqva8e5dxj.fsf@gitster-ct.c.googlers.com>
References: <xmqqva8e5dxj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Frederick Eaton <frederik@ofb.net>
---
 Documentation/cmd-list.perl |   2 +-
 command-list.txt            | 295 +++++++++++++++++++-----------------
 2 files changed, 158 insertions(+), 139 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe45..62c32f58da 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -43,7 +43,7 @@ sub format_one {
 }
 
 my %cmds = ();
-for (sort <>) {
+for (<>) {
 	next if /^#/;
 
 	chomp;
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..fb088dadea 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -43,164 +43,183 @@
 # specified here, which can only have "guide" attribute and nothing
 # else.
 #
+# February 2019: This list had been sorted alphabetically but has been
+# reordered to make it easier for people to learn from the main git(1)
+# manual page. The new ordering is according to approximate usefulness
+# / frequency of use / order of use, with some grouping by topic. The
+# idea is to make it possible to read the manual page from beginning
+# to end and see the most important commands first, rather than
+# getting them in alphabetical order - in other words, to make the
+# manual page more like a table of contents and less like an index.
+# Please consider this when adding new commands.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
+# From gittutorial
+git-help                                ancillaryinterrogators          complete
+git-config                              ancillarymanipulators           complete
+git-clone                               mainporcelain           init
+git-init                                mainporcelain           init
 git-add                                 mainporcelain           worktree
-git-am                                  mainporcelain
-git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators            complete
-git-archimport                          foreignscminterface
-git-archive                             mainporcelain
-git-bisect                              mainporcelain           info
-git-blame                               ancillaryinterrogators          complete
+git-commit                              mainporcelain           history
+git-diff                                mainporcelain           history
+git-status                              mainporcelain           info
+git-log                                 mainporcelain           info
 git-branch                              mainporcelain           history
-git-bundle                              mainporcelain
-git-cat-file                            plumbinginterrogators
-git-check-attr                          purehelpers
-git-check-ignore                        purehelpers
-git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
+git-merge                               mainporcelain           history
+gitk                                    mainporcelain
+git-pull                                mainporcelain           remote
+git-fetch                               mainporcelain           remote
+# From tutorial NEXT STEPS
+git-format-patch                        mainporcelain
+git-bisect                              mainporcelain           info
+giteveryday                             guide
+gitworkflows                            guide
+gitcvs-migration                        guide
+# From giteveryday
+git-reset                               mainporcelain           worktree
+git-rebase                              mainporcelain           history
+git-tag                                 mainporcelain           history
+git-push                                mainporcelain           remote
+git-send-email                          foreignscminterface             complete
+git-request-pull                        foreignscminterface             complete
+git-am                                  mainporcelain
+git-revert                              mainporcelain
+git-daemon                              synchingrepositories
+git-shell                               synchelpers
+git-http-backend                        synchingrepositories
+gitweb                                  ancillaryinterrogators
+# From user feedback
+git-grep                                mainporcelain           info
+git-show                                mainporcelain           info
+git-submodule                           mainporcelain
+git-cherry-pick                         mainporcelain
+git-clean                               mainporcelain
+# From gittutorial-2
+git-cat-file                            plumbinginterrogators
+git-ls-tree                             plumbinginterrogators
+git-ls-files                            plumbinginterrogators
+gitcore-tutorial                        guide
+gitglossary                             guide
+# From gitcore-tutorial
+git-update-index                        plumbingmanipulators
+git-diff-files                          plumbinginterrogators
+git-write-tree                          plumbingmanipulators
+git-read-tree                           plumbingmanipulators
 git-checkout-index                      plumbingmanipulators
-git-check-ref-format                    purehelpers
+git-show-branch                         ancillaryinterrogators          complete
+git-name-rev                            plumbinginterrogators
+git-merge-index                         plumbingmanipulators
+git-repack                              ancillarymanipulators           complete
+git-prune-packed                        plumbingmanipulators
+git-update-server-info                  synchingrepositories
+git-prune                               ancillarymanipulators
 git-cherry                              plumbinginterrogators          complete
-git-cherry-pick                         mainporcelain
+# Guides, reordered
+gittutorial                             guide
+gittutorial-2                           guide
+gitrevisions                            guide
+gitignore                               guide
+gitcli                                  guide
+gitrepository-layout                    guide
+gitdiffcore                             guide
+gitmodules                              guide
+githooks                                guide
+gitnamespaces                           guide
+gitattributes                           guide
+# All other commands, sorted by man page category and then by
+# approximate priority
+git-stash                               mainporcelain
+git-rm                                  mainporcelain           worktree
+git-mv                                  mainporcelain           worktree
+git-gui                                 mainporcelain
 git-citool                              mainporcelain
-git-clean                               mainporcelain
-git-clone                               mainporcelain           init
-git-column                              purehelpers
-git-commit                              mainporcelain           history
-git-commit-graph                        plumbingmanipulators
-git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators           complete
-git-count-objects                       ancillaryinterrogators
-git-credential                          purehelpers
-git-credential-cache                    purehelpers
-git-credential-store                    purehelpers
-git-cvsexportcommit                     foreignscminterface
-git-cvsimport                           foreignscminterface
-git-cvsserver                           foreignscminterface
-git-daemon                              synchingrepositories
+git-archive                             mainporcelain
+git-shortlog                            mainporcelain
 git-describe                            mainporcelain
-git-diff                                mainporcelain           history
-git-diff-files                          plumbinginterrogators
-git-diff-index                          plumbinginterrogators
-git-diff-tree                           plumbinginterrogators
-git-difftool                            ancillaryinterrogators          complete
+git-gc                                  mainporcelain
+git-notes                               mainporcelain
+git-worktree                            mainporcelain
+git-bundle                              mainporcelain
+git-range-diff                          mainporcelain
+git-stage                                                               complete
+git-reflog                              ancillarymanipulators           complete
+git-remote                              ancillarymanipulators           complete
+git-mergetool                           ancillarymanipulators           complete
+git-filter-branch                       ancillarymanipulators
+git-replace                             ancillarymanipulators           complete
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
-git-fetch                               mainporcelain           remote
-git-fetch-pack                          synchingrepositories
-git-filter-branch                       ancillarymanipulators
-git-fmt-merge-msg                       purehelpers
-git-for-each-ref                        plumbinginterrogators
-git-format-patch                        mainporcelain
-git-fsck                                ancillaryinterrogators          complete
-git-gc                                  mainporcelain
-git-get-tar-commit-id                   plumbinginterrogators
-git-grep                                mainporcelain           info
-git-gui                                 mainporcelain
-git-hash-object                         plumbingmanipulators
-git-help                                ancillaryinterrogators          complete
-git-http-backend                        synchingrepositories
-git-http-fetch                          synchelpers
-git-http-push                           synchelpers
+git-pack-refs                           ancillarymanipulators
+git-cvsimport                           foreignscminterface
+git-cvsserver                           foreignscminterface
+git-cvsexportcommit                     foreignscminterface
+git-svn                                 foreignscminterface
+git-p4                                  foreignscminterface
+git-quiltimport                         foreignscminterface
+git-archimport                          foreignscminterface
 git-imap-send                           foreignscminterface
-git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain           init
-git-instaweb                            ancillaryinterrogators          complete
-git-interpret-trailers                  purehelpers
-gitk                                    mainporcelain
-git-log                                 mainporcelain           info
-git-ls-files                            plumbinginterrogators
-git-ls-remote                           plumbinginterrogators
-git-ls-tree                             plumbinginterrogators
-git-mailinfo                            purehelpers
-git-mailsplit                           purehelpers
-git-merge                               mainporcelain           history
-git-merge-base                          plumbinginterrogators
+git-apply                               plumbingmanipulators            complete
 git-merge-file                          plumbingmanipulators
-git-merge-index                         plumbingmanipulators
-git-merge-one-file                      purehelpers
-git-mergetool                           ancillarymanipulators           complete
-git-merge-tree                          ancillaryinterrogators
-git-multi-pack-index                    plumbingmanipulators
 git-mktag                               plumbingmanipulators
+git-hash-object                         plumbingmanipulators
+git-update-ref                          plumbingmanipulators
+git-symbolic-ref                        plumbingmanipulators
+git-commit-tree                         plumbingmanipulators
+git-commit-graph                        plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators
-git-notes                               mainporcelain
-git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
-git-pack-redundant                      plumbinginterrogators
-git-pack-refs                           ancillarymanipulators
+git-unpack-objects                      plumbingmanipulators
+git-index-pack                          plumbingmanipulators
+git-multi-pack-index                    plumbingmanipulators
+git-blame                               ancillaryinterrogators          complete
+git-annotate                            ancillaryinterrogators
+git-instaweb                            ancillaryinterrogators          complete
+git-rerere                              ancillaryinterrogators
+git-fsck                                ancillaryinterrogators          complete
+git-whatchanged                         ancillaryinterrogators          complete
+git-difftool                            ancillaryinterrogators          complete
+git-merge-tree                          ancillaryinterrogators
+git-count-objects                       ancillaryinterrogators
+git-verify-commit                       ancillaryinterrogators
+git-verify-tag                          ancillaryinterrogators
+git-send-pack                           synchingrepositories
+git-fetch-pack                          synchingrepositories
 git-parse-remote                        synchelpers
-git-patch-id                            purehelpers
-git-prune                               ancillarymanipulators
-git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain           remote
-git-push                                mainporcelain           remote
-git-quiltimport                         foreignscminterface
-git-range-diff                          mainporcelain
-git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
-git-reflog                              ancillarymanipulators           complete
-git-remote                              ancillarymanipulators           complete
-git-repack                              ancillarymanipulators           complete
-git-replace                             ancillarymanipulators           complete
-git-request-pull                        foreignscminterface             complete
-git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain           worktree
-git-revert                              mainporcelain
+git-upload-pack                         synchelpers
+git-upload-archive                      synchelpers
+git-http-fetch                          synchelpers
+git-http-push                           synchelpers
+git-var                                 plumbinginterrogators
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
-git-rm                                  mainporcelain           worktree
-git-send-email                          foreignscminterface             complete
-git-send-pack                           synchingrepositories
-git-shell                               synchelpers
-git-shortlog                            mainporcelain
-git-show                                mainporcelain           info
-git-show-branch                         ancillaryinterrogators          complete
-git-show-index                          plumbinginterrogators
+git-for-each-ref                        plumbinginterrogators
 git-show-ref                            plumbinginterrogators
-git-sh-i18n                             purehelpers
+git-ls-remote                           plumbinginterrogators
+git-diff-tree                           plumbinginterrogators
+git-diff-index                          plumbinginterrogators
+git-merge-base                          plumbinginterrogators
+git-verify-pack                         plumbinginterrogators
+git-pack-redundant                      plumbinginterrogators
+git-unpack-file                         plumbinginterrogators
+git-show-index                          plumbinginterrogators
+git-get-tar-commit-id                   plumbinginterrogators
+git-merge-one-file                      purehelpers
 git-sh-setup                            purehelpers
-git-stash                               mainporcelain
-git-stage                                                               complete
-git-status                              mainporcelain           info
+git-check-ref-format                    purehelpers
+git-check-ignore                        purehelpers
+git-check-attr                          purehelpers
+git-credential                          purehelpers
+git-credential-cache                    purehelpers
+git-credential-store                    purehelpers
+git-fmt-merge-msg                       purehelpers
+git-check-mailmap                       purehelpers
+git-mailsplit                           purehelpers
+git-mailinfo                            purehelpers
+git-interpret-trailers                  purehelpers
+git-column                              purehelpers
 git-stripspace                          purehelpers
-git-submodule                           mainporcelain
-git-svn                                 foreignscminterface
-git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain           history
-git-unpack-file                         plumbinginterrogators
-git-unpack-objects                      plumbingmanipulators
-git-update-index                        plumbingmanipulators
-git-update-ref                          plumbingmanipulators
-git-update-server-info                  synchingrepositories
-git-upload-archive                      synchelpers
-git-upload-pack                         synchelpers
-git-var                                 plumbinginterrogators
-git-verify-commit                       ancillaryinterrogators
-git-verify-pack                         plumbinginterrogators
-git-verify-tag                          ancillaryinterrogators
-gitweb                                  ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators          complete
-git-worktree                            mainporcelain
-git-write-tree                          plumbingmanipulators
-gitattributes                           guide
-gitcli                                  guide
-gitcore-tutorial                        guide
-gitcvs-migration                        guide
-gitdiffcore                             guide
-giteveryday                             guide
-gitglossary                             guide
-githooks                                guide
-gitignore                               guide
-gitmodules                              guide
-gitnamespaces                           guide
-gitrepository-layout                    guide
-gitrevisions                            guide
-gittutorial-2                           guide
-gittutorial                             guide
-gitworkflows                            guide
+git-patch-id                            purehelpers
+git-sh-i18n                             purehelpers
-- 
2.20.1

