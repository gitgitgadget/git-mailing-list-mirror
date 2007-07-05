From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2/2] make git-clone GIT_WORK_TREE aware
Date: Fri, 6 Jul 2007 01:10:44 +0200
Message-ID: <20070705231044.GB26061@moooo.ath.cx>
References: <20070705225433.GA26061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 01:10:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6aTM-0000yF-76
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 01:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbXGEXKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 19:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759656AbXGEXKr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 19:10:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:55319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752511AbXGEXKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 19:10:46 -0400
Received: (qmail invoked by alias); 05 Jul 2007 23:10:45 -0000
Received: from pD9EBB432.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.50]
  by mail.gmx.net (mp046) with SMTP; 06 Jul 2007 01:10:45 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18aXq4QmKgauuQE20OpvkC/Qqh4xM8B8KUyL4i0Oq
	T5qGmiacOJYzAT
Content-Disposition: inline
In-Reply-To: <20070705225433.GA26061@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51703>

If GIT_WORK_TREE is set git-clone will use that path for the
working tree.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
All those import scripts which call git init too probably have
problems when GIT_WORK_TREE is exported.  Perhaps a simple

    test -n "$GIT_WORK_TREE" ||
    die "GIT_WORK_TREE is not supported by this script yet"

is enough for the moment for those scripts.
---
 git-clone.sh |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 59a457b..b72a242 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -176,22 +176,29 @@ dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 [ -e "$dir" ] && die "destination directory '$dir' already exists."
+[ yes = "$bare" ] && unset GIT_WORK_TREE
+[ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
+die "working tree '$GIT_WORK_TREE' already exists."
 D=
+W=
 cleanup() {
 	err=$?
 	test -z "$D" && rm -rf "$dir"
+	test -z "$W" && test -n "$GIT_WORK_TREE" && rm -rf "$GIT_WORK_TREE"
 	cd ..
 	test -n "$D" && rm -rf "$D"
+	test -n "$W" && rm -rf "$W"
 	exit $err
 }
 trap cleanup 0
 mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
-case "$bare" in
-yes)
-	GIT_DIR="$D" ;;
-*)
-	GIT_DIR="$D/.git" ;;
-esac
+test -n "$GIT_WORK_TREE" && mkdir -p "$GIT_WORK_TREE" &&
+W=$(cd "$GIT_WORK_TREE" && pwd) && export GIT_WORK_TREE="$W"
+if test yes = "$bare" || test -n "$GIT_WORK_TREE"; then
+	GIT_DIR="$D"
+else
+	GIT_DIR="$D/.git"
+fi
 export GIT_DIR
 git-init ${template+"$template"} || usage
 
@@ -347,7 +354,11 @@ then
 	done < "$GIT_DIR/CLONE_HEAD"
 fi
 
-cd "$D" || exit
+if test -n "$W"; then
+	cd "$W" || exit
+else
+	cd "$D" || exit
+fi
 
 if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
-- 
1.5.2.2.647.ga00fe
