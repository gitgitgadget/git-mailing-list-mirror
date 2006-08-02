From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-prune-packed a builtin
Date: Wed, 2 Aug 2006 18:17:29 +0200
Message-ID: <20060802161729.GE20971@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Aug 02 18:17:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8JPk-0001YM-N7
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 18:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHBQRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWHBQRl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 12:17:41 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:42378 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S932088AbWHBQRk
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 12:17:40 -0400
Received: from spinlock.ch (81.62.57.222) by mail17.bluewin.ch (Bluewin 7.3.110.2)
        id 44B3612F004AAF75; Wed, 2 Aug 2006 16:17:39 +0000
Received: (nullmailer pid 6739 invoked by uid 1000);
	Wed, 02 Aug 2006 16:17:29 -0000
To: git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-5-386 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24652>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                                 |    6 +++---
 prune-packed.c => builtin-prune-packed.c |    2 +-
 builtin.h                                |    1 +
 git.c                                    |    1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 2562a2c..e39c9da 100644
--- a/Makefile
+++ b/Makefile
@@ -196,7 +196,7 @@ PROGRAMS = \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
-	git-peek-remote$X git-prune-packed$X git-receive-pack$X \
+	git-peek-remote$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
@@ -216,7 +216,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
-	git-fmt-merge-msg$X git-prune$X git-mv$X
+	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -273,7 +273,7 @@ BUILTIN_OBJS = \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
-	builtin-mv.o
+	builtin-mv.o builtin-prune-packed.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/prune-packed.c b/builtin-prune-packed.c
similarity index 96%
rename from prune-packed.c
rename to builtin-prune-packed.c
index d24b097..8ca8c8c 100644
--- a/prune-packed.c
+++ b/builtin-prune-packed.c
@@ -54,7 +54,7 @@ static void prune_packed_objects(void)
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_prune_packed(int argc, char **argv, const char *prefix)
 {
 	int i;
 
diff --git a/builtin.h b/builtin.h
index f10d3b7..7ddfe28 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,6 +20,7 @@ extern int cmd_format_patch(int argc, co
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
+extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 110e82e..5b50762 100644
--- a/git.c
+++ b/git.c
@@ -263,6 +263,7 @@ static void handle_internal_command(int 
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, NEEDS_PREFIX },
 		{ "prune", cmd_prune, NEEDS_PREFIX },
 		{ "mv", cmd_mv, NEEDS_PREFIX },
+		{ "prune-packed", cmd_prune_packed, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g767b2

-- 
Matthias Kestenholz
www.spinlock.ch
