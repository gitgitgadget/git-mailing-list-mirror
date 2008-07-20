From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-merge -s theirs
Date: Sun, 20 Jul 2008 19:21:30 +0900
Message-ID: <20080720192130.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 12:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKW3k-0001kA-Gc
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbYGTKVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbYGTKVg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:21:36 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48310 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640AbYGTKVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:21:35 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 48D61C88B1;
	Sun, 20 Jul 2008 05:21:26 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id I7NGQE1XRCYI; Sun, 20 Jul 2008 05:21:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=3UgVMMnCHdRb1PqYXX2j64QkhsEBNZjuVm9yTZY/Onw6I5C12P+Dt3K/dgxGzn/9p15p4lD3cNeyiphGe30zk7XJ9D98+t1N04W3u7fBMZsrjJj+3zT/oV91JawYK71rFU5aLFq25LE5nWTM6hBABKvTbVUFSLEaEVq7I8OkNHQ=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:not.  The reason was explained on the mailing list recently;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89178>

Sometimes people wonder why "-s ours" strategy exists but "-s theirs" does
not.  The reason was explained on the mailing list recently:

  Quoting Junio C Hamano <gitster@pobox.com>:

  > One big problem "-s theirs" has, compared to the "reset to origin,
  > discarding or setting aside the failed history" is that your 'master'
  > history that your further development is based on will keep your failed
  > crap in it forever if you did "-s theirs".  Hopefully you will become a
  > better programmer over time, and you may eventually have something worth
  > sharing with the world near the tip of your master branch.  When that
  > happens, however, you _cannot_ offer your master branch to be pulled by
  > the upstream, as the wider world will not be interested in your earlier
  > mistakes at all.

This patch steals much code from "git-merge-resolve" to add "theirs"
strategy.  Its purpose is to always fail and suggest using the preferred
command "git reset --hard the-other-commit".

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Makefile            |    3 ++-
 builtin-merge.c     |    1 +
 git-merge-theirs.sh |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletions(-)
 create mode 100755 git-merge-theirs.sh

diff --git a/Makefile b/Makefile
index 2b670d7..22f699a 100644
--- a/Makefile
+++ b/Makefile
@@ -240,6 +240,7 @@ SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
+SCRIPT_SH += git-merge-theirs.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
@@ -1433,7 +1434,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-subtree | \
+		git-merge-resolve | git-merge-subtree | git-merge-theirs | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
 		esac ; \
diff --git a/builtin-merge.c b/builtin-merge.c
index edc6016..8ed815b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -55,6 +55,7 @@ static struct strategy all_strategy[] = {
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
+	{ "theirs",     NO_FAST_FORWARD | NO_TRIVIAL },
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
 };
 
diff --git a/git-merge-theirs.sh b/git-merge-theirs.sh
new file mode 100755
index 0000000..e228d2b
--- /dev/null
+++ b/git-merge-theirs.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+	case ",$sep_seen,$head,$arg," in
+	*,--,)
+		sep_seen=yes
+		;;
+	,yes,,*)
+		head=$arg
+		;;
+	,yes,*)
+		remotes="$remotes$arg "
+		;;
+	*)
+		bases="$bases$arg "
+		;;
+	esac
+done
+
+# Give up if we are given two or more remotes -- not handling octopus.
+case "$remotes" in
+?*' '?*)
+	exit 2 ;;
+esac
+
+echo "If you wanted to say the other history is better than your history," 
+echo "use 'git reset --hard $remotes' instead." 
+echo "If you want to keep a record of your failure, you can create a" 
+echo "new branch from the current HEAD before running the reset command." 
+
+exit 2
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
