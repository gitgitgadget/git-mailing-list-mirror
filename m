From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/5] make remove-dashes: apply to scripts and programs as well, not just to builtins
Date: Fri, 11 Jul 2008 02:12:06 +0200
Message-ID: <581f7ee17a4fb122f4df258d9cc0631b763fe9e1.1215734605.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
 <8275a6b4a676d33a1ae80f29f85c52b7bbda9a84.1215734605.git.vmiklos@frugalware.org>
 <9568dd5d03cd0f1da8872fd71f8bb253560e2352.1215734605.git.vmiklos@frugalware.org>
 <eb505d0d8f7d2bf50073414baa799a80a9df7453.1215734605.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH6Nb-0001Dn-AV
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbYGKAT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYGKAT4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 20:19:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44267 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbYGKATz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 20:19:55 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 3359A1DDC5B;
	Fri, 11 Jul 2008 02:19:54 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D6DCC1A990C; Fri, 11 Jul 2008 02:12:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <eb505d0d8f7d2bf50073414baa799a80a9df7453.1215734605.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215734604.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88067>

All programs and scripts are now moved outside PATH, so it's a good idea
not to use the dashed forms for them, either.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile       |    2 +-
 fixup-builtins |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 4796565..2b54d92 100644
--- a/Makefile
+++ b/Makefile
@@ -1296,7 +1296,7 @@ check: common-cmds.h
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
 remove-dashes:
-	./fixup-builtins $(BUILT_INS)
+	./fixup-builtins $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
 
 ### Installation rules
 
diff --git a/fixup-builtins b/fixup-builtins
index 49e861d..63dfa4c 100755
--- a/fixup-builtins
+++ b/fixup-builtins
@@ -1,16 +1,16 @@
 #!/bin/sh
 while [ "$1" ]
 do
-	old="$1"
-	new=$(echo "$1" | sed 's/git-/git /')
-	echo "Converting '$old' to '$new'"
-	git ls-files '*.sh' | while read file
-	do
-		sed "s/\\<$old\\>/$new/g" < $file > $file.new
-		chmod --reference=$file $file.new
-		mv $file.new $file
-	done
+	if [ "$1" != "git-sh-setup" -a "$1" != "git-parse-remote" -a "$1" != "git-svn" ]; then
+		old="$1"
+		new=$(echo "$1" | sed 's/git-/git /')
+		echo "Converting '$old' to '$new'"
+		sed -i "s/\\<$old\\>/$new/g" $(git ls-files '*.sh')
+	fi
 	shift
 done
+
+sed -i 's/git merge-one-file/git-merge-one-file/g
+s/git rebase-todo/git-rebase-todo/g' $(git ls-files '*.sh')
 git update-index --refresh >& /dev/null
 exit 0
-- 
1.5.6.2.450.g8d367.dirty
