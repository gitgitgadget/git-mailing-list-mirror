From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-local-fetch a builtin
Date: Thu,  3 Aug 2006 17:24:39 +0200
Message-ID: <11546186802823-git-send-email-matthias@spinlock.ch>
References: <11546186794129-git-send-email-matthias@spinlock.ch> <1154618679860-git-send-email-matthias@spinlock.ch> <11546186792277-git-send-email-matthias@spinlock.ch> <11546186792870-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Aug 03 17:25:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8f4w-0005Wl-LG
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWHCPZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWHCPZj
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:25:39 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:32455 "EHLO
	mail21.bluewin.ch") by vger.kernel.org with ESMTP id S964786AbWHCPZh
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:25:37 -0400
Received: from spinlock.ch (83.78.18.234) by mail21.bluewin.ch (Bluewin 7.3.110.2)
        id 44A3DCBA0079492F; Thu, 3 Aug 2006 15:25:33 +0000
Received: (nullmailer pid 5968 invoked by uid 1000);
	Thu, 03 Aug 2006 15:24:40 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g2e994
In-Reply-To: <11546186792870-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24727>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---


Please note! I added fetch.o to the list of LIB_OBJS. I don't know if
it should be done like that. builtin-local-fetch.o depends on fetch.o
and LIB_OBJS seemed to be the best place to add fetch.o.



 Makefile                               |    9 +++++----
 local-fetch.c => builtin-local-fetch.c |    3 ++-
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 785e188..c1285f5 100644
--- a/Makefile
+++ b/Makefile
@@ -194,7 +194,7 @@ # ... and all the rest that could be mov
 PROGRAMS = \
 	git-checkout-index$X \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
-	git-hash-object$X git-index-pack$X git-local-fetch$X \
+	git-hash-object$X git-index-pack$X \
 	git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
@@ -218,7 +218,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
 	git-repo-config$X git-name-rev$X git-pack-objects$X \
-	git-unpack-objects$X git-symbolic-ref$X
+	git-unpack-objects$X git-symbolic-ref$X git-local-fetch$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -262,7 +262,8 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o merge-file.o path-list.o unpack-trees.o $(DIFF_OBJS)
+	alloc.o merge-file.o path-list.o unpack-trees.o fetch.o \
+	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
@@ -277,7 +278,7 @@ BUILTIN_OBJS = \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
 	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
 	builtin-name-rev.o builtin-pack-objects.o builtin-unpack-objects.o \
-	builtin-symbolic-ref.o
+	builtin-symbolic-ref.o builtin-local-fetch.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/local-fetch.c b/builtin-local-fetch.c
similarity index 99%
rename from local-fetch.c
rename to builtin-local-fetch.c
index b216bdd..2a082d8 100644
--- a/local-fetch.c
+++ b/builtin-local-fetch.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+#include "builtin.h"
 #include "cache.h"
 #include "commit.h"
 #include "fetch.h"
@@ -203,7 +204,7 @@ static const char local_pull_usage[] =
  * If -s is specified, then a symlink is attempted.
  * If -n is _not_ specified, then a regular file-to-file copy is done.
  */
-int main(int argc, const char **argv)
+int cmd_local_fetch(int argc, const char **argv, const char *prefix)
 {
 	int commits;
 	const char **write_ref = NULL;
diff --git a/builtin.h b/builtin.h
index b767245..3da353f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -53,6 +53,7 @@ extern int cmd_name_rev(int argc, const 
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
+extern int cmd_local_fetch(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index e40e859..a4ce155 100644
--- a/git.c
+++ b/git.c
@@ -269,6 +269,7 @@ static void handle_internal_command(int 
 		{ "pack-objects", cmd_pack_objects, NEEDS_PREFIX },
 		{ "unpack-objects", cmd_unpack_objects, NEEDS_PREFIX },
 		{ "symbolic-ref", cmd_symbolic_ref, NEEDS_PREFIX },
+		{ "local-fetch", cmd_local_fetch, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g2e994
