From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] git-commit: filter out log message lines only when editor was run.
Date: Sat, 24 Jun 2006 00:04:05 +0200
Message-ID: <20060623220405.1915.28636.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:04:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FttlK-0002ch-6h
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbWFWWD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWFWWD7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:03:59 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:41133 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752091AbWFWWD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 18:03:59 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 7121052946;
	Sat, 24 Jun 2006 00:03:58 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FttlF-0003JW-S9; Sat, 24 Jun 2006 00:04:21 +0200
To: junkio@cox.net
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22441>


The current behaviour strips out lines starting with a # even when fed
through stdin or -m.  This is particularly bad when importing history from
another SCM (tailor 0.9.23 uses git-commit).  In the best cases all lines
are stripped and the commit fails with a confusing "empty log message"
error, but in many cases the commit is done, with loss of information.

Note that it is quite peculiar to just have "#" handled as a leading
comment char here.  One commonly meet CVS: or CG: or STG: as prefixes, and
using GIT: would be more robust as well as consistent with other commit
tools.  However, that would break any tool relying on the # (if any).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 git-commit.sh |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 6dd04fd..aa3b1ea 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -691,13 +691,18 @@ t)
 	fi
 esac
 
-sed -e '
-    /^diff --git a\/.*/{
-	s///
-	q
-    }
-    /^#/d
-' "$GIT_DIR"/COMMIT_EDITMSG |
+if test -z "$no_edit"
+then
+    sed -e '
+        /^diff --git a\/.*/{
+	    s///
+	    q
+	}
+	/^#/d
+    ' "$GIT_DIR"/COMMIT_EDITMSG
+else
+    cat "$GIT_DIR"/COMMIT_EDITMSG
+fi |
 git-stripspace >"$GIT_DIR"/COMMIT_MSG
 
 if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
