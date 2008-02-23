From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Add merge-subtree back
Date: Sat, 23 Feb 2008 11:16:21 -0800
Message-ID: <7vprun32m2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 20:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSzrw-0006bz-1N
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYBWTQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYBWTQb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:16:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYBWTQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:16:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35E8A160D;
	Sat, 23 Feb 2008 14:16:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1125E160B; Sat, 23 Feb 2008 14:16:23 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74839>

An earlier commit e1b3a2c (Build-in merge-recursive) made the
subtree merge strategy backend unavailable.  This resurrects
it.

A new test t6029 currently only tests the strategy is available,
but it should be enhanced to check the real "subtree" case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                 |    8 +++-----
 git.c                    |    1 +
 t/t6029-merge-subtree.sh |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)
 create mode 100755 t/t6029-merge-subtree.sh

diff --git a/Makefile b/Makefile
index 90c0dd8..40fa41b 100644
--- a/Makefile
+++ b/Makefile
@@ -261,17 +261,18 @@ PROGRAMS = \
 # Empty...
 EXTRA_PROGRAMS =
 
+# List built-in command $C whose implementation cmd_$C() is not in
+# builtin-$C.o but is linked in as part of some other command.
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
 	git-fsck-objects$X git-cherry-pick$X git-peek-remote$X git-status$X \
+	git-merge-subtree$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
-ALL_PROGRAMS += git-merge-subtree$X
-
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X gitweb/gitweb.cgi
 
@@ -807,9 +808,6 @@ help.o: help.c common-cmds.h GIT-CFLAGS
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
 
-git-merge-subtree$X: git-merge-recursive$X
-	$(QUIET_BUILT_IN)$(RM) $@ && ln git-merge-recursive$X $@
-
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
 
diff --git a/git.c b/git.c
index fc15686..bd424ea 100644
--- a/git.c
+++ b/git.c
@@ -332,6 +332,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
new file mode 100755
index 0000000..3900a05
--- /dev/null
+++ b/t/t6029-merge-subtree.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='subtree merge strategy'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	s="1 2 3 4 5 6 7 8"
+	for i in $s; do echo $i; done >hello &&
+	git add hello &&
+	git commit -m initial &&
+	git checkout -b side &&
+	echo >>hello world &&
+	git add hello &&
+	git commit -m second &&
+	git checkout master &&
+	for i in mundo $s; do echo $i; done >hello &&
+	git add hello &&
+	git commit -m master
+
+'
+
+test_expect_success 'subtree available and works like recursive' '
+
+	git merge -s subtree side &&
+	for i in mundo $s world; do echo $i; done >expect &&
+	diff -u expect hello
+
+'
+
+test_done
-- 
1.5.4.2.300.g8d945
