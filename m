From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 4/9] bisect: introduce a helper function to tolerate checkout failures.
Date: Sun, 24 Jul 2011 15:57:49 +1000
Message-ID: <1311487074-25070-5-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhx-0007mm-TY
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab1GXF6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:23 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1GXF6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:17 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9KiD8JIhV3ChamFVj6y9/DaedpC9UTYOcl5UHp9MJJ0=;
        b=ZUwn/EuMA68PJYHjzQSesPxMHk6wjRqgINlVnrWAhrxlNlQyuZ15pVDLbabZ3M7CEi
         mySN1Xl9zLjxHr7iGCoWPV3Bm6rjpRVTLGnJqKsp+ohTxph0a2C2wcfpM8wAnkcKCGrk
         pFjCuKMziI1UrdokG8ZHIHQnwg/+6EVjFFNiA=
Received: by 10.68.50.136 with SMTP id c8mr5013776pbo.142.1311487097021;
        Sat, 23 Jul 2011 22:58:17 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177722>

In the case that git bisect is being used on a repo with damaged trees,
git checkout may not succeed.

This function allows checkout to succeed even if the current commit
references a damaged tree. This will be useful for git bisect reset, for example.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b2186a8..486a860 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,6 +34,8 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+IGNORE_CHECKOUT_FAILURE=$(test -f "${GIT_DIR}/BISECT_IGNORE_CHECKOUT_FAILURE" && cat "${GIT_DIR}/BISECT_IGNORE_CHECKOUT_FAILURE")
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -325,6 +327,23 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
+bisect_checkout_with_ignore()
+{
+    ref=$1
+    if test -z "$IGNORE_CHECKOUT_FAILURE"; then
+	git checkout "$ref" -- || exit
+    else
+	if git checkout "$ref" -- 2>/dev/null; then
+	# If the current tree contains missing objects
+	# git checkout will fail. It might be
+	# possible to recover from this if we update
+	# the HEAD first.
+	    git update-ref --no-deref HEAD "$ref" &&
+	    git checkout "$ref" -- || exit
+	fi
+    fi
+}
+
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		gettext "We are not bisecting."; echo
-- 
1.7.6.347.g96e0b.dirty
