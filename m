From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Modifies the default git help message to be grouped by
	topic
Date: Mon, 1 Dec 2008 22:05:09 -0800
Message-ID: <20081202060509.GA48796@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 02 07:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7OPL-00046q-4r
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 07:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYLBGFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 01:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYLBGFU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 01:05:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:23249 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbYLBGFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 01:05:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2817569rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 22:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=l4tzx20/gis/0id9MVT/8tqOJvIFxFJvQIzm28SfB2o=;
        b=gqQZ6aeoHuLZnjKzVYJ2g8kqG0l+mDwpoBSnY3dpDL6Ygo0RyyeP3oue1/rR3ZZMQG
         NerEWeFrCZCxiu07d0YgYoQi214MwDx2rdUo5Ga1i7yeSvKZcEYlaLJ0DdrbwDrRHF/U
         mrrXnA5aVRAE2Bw0dSeEitRIsfmD1psNNoig8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=wU9ureiNu7+e0WO5i7qnbEMWoiJfRSUM+/IRDmyC2DcK9iN4SkD5faeKz6lNLmHFcI
         TXxUWz1NTA0wJ7A+PpSvYjJKQrUVm/ikVevCRe+gTJ0DrHbmADMhv5qTzf8Ig/JELqZi
         F27EsmdVOVoHvz1CQWuF+eRR8nIvuwVHy90ow=
Received: by 10.142.157.9 with SMTP id f9mr4781388wfe.241.1228197912794;
        Mon, 01 Dec 2008 22:05:12 -0800 (PST)
Received: from @ (adsl-76-254-71-52.dsl.pltn13.sbcglobal.net [76.254.71.52])
        by mx.google.com with ESMTPS id 22sm8072407wfd.53.2008.12.01.22.05.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 22:05:12 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102121>

It's difficult to process 21 commands (which is what is output
by default for git when no command is given).  They have been
re-grouped into 4 groups of 5-6 commands each, which is clearer
and easier for new users to process.

Also removes the common-cmd.h generation process, including
parts of the Makefile and the generate-cmdlist.sh file.

As discussed at the GitTogether.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

This is a followup patch based on Junio and Jeffs feedback. 
It also should apply cleanly which the other one would no 
longer to, since it was from the GitTogether and then resent.

 Makefile            |   13 ++++---------
 builtin-help.c      |   40 ++++++++++++++++++++++++++--------------
 generate-cmdlist.sh |   24 ------------------------
 3 files changed, 30 insertions(+), 47 deletions(-)
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 649cfb8..9a564cb 100644
--- a/Makefile
+++ b/Makefile
@@ -1117,7 +1117,7 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git.o: git.c common-cmds.h GIT-CFLAGS
+git.o: git.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -c $(filter %.c,$^)
 
@@ -1125,7 +1125,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
+builtin-help.o: builtin-help.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
@@ -1137,11 +1137,6 @@ $(BUILT_INS): git$X
 	ln -s git$X $@ 2>/dev/null || \
 	cp git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
-
-common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
-
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1363,7 +1358,7 @@ test-%$X: test-%.o $(GITLIBS)
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
-check: common-cmds.h
+check: 
 	if sparse; \
 	then \
 		for i in *.c; \
@@ -1498,7 +1493,7 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo TAGS tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
diff --git a/builtin-help.c b/builtin-help.c
index f076efa..537534a 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -6,7 +6,6 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
-#include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "help.h"
@@ -277,19 +276,32 @@ static struct cmdnames main_cmds, other_cmds;
 
 void list_common_cmds_help(void)
 {
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
-	}
+  puts("The most commonly used git commands are:\n\
+\n\
+Basic Commands\n\
+  init       Create an empty git repository or reinitialize an existing one\n\
+  add        Add file contents to the staging area\n\
+  status     Show the working tree and staging area status\n\
+  commit     Record changes in the staging area to the repository\n\
+\n\
+History Commands\n\
+  log        Show commit log history\n\
+  diff       Show changes between commits, commit and working tree, etc\n\
+  reset      Reset your staging area or working directory to a specified state\n\
+  show       Show various types of objects\n\
+\n\
+Branch Commands\n\
+  checkout   Checkout a branch or paths to the working tree\n\
+  branch     List, create, or delete branches\n\
+  merge      Join two or more development histories together\n\
+  rebase     Apply changes introduced in one branch onto another\n\
+  tag        Create, list, delete or verify a tag object signed with GPG\n\
+\n\
+Remote Commands\n\
+  clone      Clone a repository into a new directory\n\
+  fetch      Download objects and refs from another repository\n\
+  pull       Fetch from and merge with another repository or a local branch\n\
+  push       Update remote refs along with associated objects");
 }
 
 static int is_git_command(const char *s)
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
deleted file mode 100755
index a2913c2..0000000
--- a/generate-cmdlist.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help
-{
-    char name[16];
-    char help[80];
-};
-
-static struct cmdname_help common_cmds[] = {"
-
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /NAME/,/git-'"$cmd"'/H
-     ${
-            x
-            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-	    p
-     }' "Documentation/git-$cmd.txt"
-done
-echo "};"
-- 
1.6.0.8.gc9c8
