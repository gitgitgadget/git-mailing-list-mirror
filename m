From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Diff overhaul, adding the other half of copy detection.
Date: Sat, 21 May 2005 02:42:35 -0700
Message-ID: <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:44:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQW0-0004ad-Hs
	for gcvg-git@gmane.org; Sat, 21 May 2005 11:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVEUJoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 05:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEUJoe
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 05:44:34 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56772 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261714AbVEUJmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 05:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521094237.ZXSW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 05:42:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 02:37:31 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch extends diff-cache and diff-files to report the
unmodified files to diff-core as well when -C (copy detection)
is in effect, so that the unmodified files can also be used as
the source candidates.  The existing test t4003 has been
extended to cover this case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c             |    3 ++-
diff-files.c             |    2 +-
t/t4003-diff-rename-1.sh |   38 +++++++++++++++++++++++++++++++++++++-
3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -71,7 +71,8 @@ static int show_modified(struct cache_en
 	}
 
 	oldmode = old->ce_mode;
-	if (mode == oldmode && !memcmp(sha1, old->sha1, 20))
+	if (mode == oldmode && !memcmp(sha1, old->sha1, 20) &&
+	    detect_rename < 2)
 		return 0;
 
 	mode = ntohl(mode);
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -126,7 +126,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st);
-		if (!changed)
+		if (!changed && detect_rename < 2)
 			continue;
 
 		oldmode = ntohl(ce->ce_mode);
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -22,6 +22,10 @@ test_expect_success \
     rm -f COPYING &&
     git-update-cache --add --remove COPYING COPYING.?'
 
+# tree has COPYING.  work tree has COPYING.1 and COPYING.2,
+# both are slightly edited.  So we say you copy-and-edit one,
+# and rename-and-edit the other.
+
 GIT_DIFF_OPTS=-u0 git-diff-cache -M $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
 cat >expected <<\EOF
@@ -58,7 +62,11 @@ test_expect_success \
 test_expect_success \
     'prepare work tree again' \
     'mv COPYING.2 COPYING &&
-     git-update-cache --add --remove COPYING COPYING.1'
+     git-update-cache --add --remove COPYING COPYING.1 COPYING.2'
+
+# tree has COPYING.  work tree has COPYING and COPYING.1,
+# both are slightly edited.  So we say you edited one,
+# and copy-and-edit the other.
 
 GIT_DIFF_OPTS=-u0 git-diff-cache -C $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current
@@ -90,4 +98,32 @@ test_expect_success \
     'validate output from rename/copy detection' \
     'diff -u current expected'
 
+test_expect_success \
+    'prepare work tree once again' \
+    'cat ../../COPYING >COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1'
+
+# tree has COPYING.  work tree has the same COPYING and COPYING.1,
+# but COPYING is not edited.  We say you copy-and-edit COPYING.1;
+# this is only possible because -C mode now reports the unmodified
+# file to the diff-core.
+
+GIT_DIFF_OPTS=-u0 git-diff-cache -C $tree |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
 test_done
------------------------------------------------

