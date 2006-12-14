X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-reset [--mixed] <tree> [--] <paths>...
Date: Thu, 14 Dec 2006 01:24:47 -0800
Message-ID: <7vwt4u96e8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 09:24:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34291>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gumpf-0006KY-Mu for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932128AbWLNJYt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWLNJYt
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:24:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35812 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932128AbWLNJYs (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 04:24:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214092447.BLNX25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 04:24:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yZQ81V0061kojtg0000000; Thu, 14 Dec 2006
 04:24:09 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sometimes it is asked on the list how to revert selected path in
the index from a tree, most often HEAD, without affecting the
files in the working tree.  A similar operation that also
affects the working tree files has been available in the form of
"git checkout <tree> -- <paths>...".

By definition --soft would never affect either the index nor the
working tree files, and --hard is the way to make the working
tree files as close to pristine, so this new option is available
only for the default --mixed case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I haven't looked at Documentation/git-reset.txt recently.  It
   most likely needs not just addition to describe this new
   format, but more a heavier rewrite similar to what we made to
   git-commit documentation recently.

 git-reset.sh |   68 +++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 03d2c3b..e95c252 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -1,35 +1,59 @@
 #!/bin/sh
-
-USAGE='[--mixed | --soft | --hard]  [<commit-ish>]'
+#
+# Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
+#
+USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
+update= rev= reset_type=--mixed
+
+while case $# in 0) break ;; esac
+do
+	case "$1" in
+	--mixed | --soft | --hard)
+		reset_type="$1"
+		;;
+	--)
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		rev=$(git-rev-parse --verify "$1") || exit
+		shift
+		break
+		;;
+	esac
+	shift
+done
+
+: ${rev=HEAD}
+rev=$(git-rev-parse --verify $rev^0) || exit
+
+# Skip -- in "git reset HEAD -- foo" and "git reset -- foo".
+case "$1" in --) shift ;; esac
+
+# git reset --mixed tree [--] paths... can be used to
+# load chosen paths from the tree into the index without
+# affecting the working tree nor HEAD.
+if test $# != 0
+then
+	test "$reset_type" == "--mixed" ||
+		die "Cannot do partial $reset_type reset."
+	git ls-tree -r --full-name $rev -- "$@" |
+	git update-index --add --index-info || exit
+	git update-index --refresh
+	exit
+fi
+
 TOP=$(git-rev-parse --show-cdup)
 if test ! -z "$TOP"
 then
 	cd "$TOP"
 fi
 
-update=
-reset_type=--mixed
-case "$1" in
---mixed | --soft | --hard)
-	reset_type="$1"
-	shift
-	;;
--*)
-        usage ;;
-esac
-
-case $# in
-0) rev=HEAD ;;
-1) rev=$(git-rev-parse --verify "$1") || exit ;;
-*) usage ;;
-esac
-rev=$(git-rev-parse --verify $rev^0) || exit
-
-# We need to remember the set of paths that _could_ be left
-# behind before a hard reset, so that we can remove them.
 if test "$reset_type" = "--hard"
 then
 	update=-u
-- 
1.4.4.2.g86bd

