From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 1/2] git-clone: split up long &&-command-chain and use a function for cleanup
Date: Fri, 6 Jul 2007 00:54:33 +0200
Message-ID: <20070705225433.GA26061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:54:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6aDi-0005bD-M5
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 00:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759403AbXGEWyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759414AbXGEWyk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 18:54:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:55191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753760AbXGEWyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 18:54:39 -0400
Received: (qmail invoked by alias); 05 Jul 2007 22:54:37 -0000
Received: from pD9EBB432.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.50]
  by mail.gmx.net (mp025) with SMTP; 06 Jul 2007 00:54:37 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+p/iIzMByp3pBkbUF7uJiuUeOxn/s2x1TBAIu9w1
	s05d6hG4EJiDe2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51702>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This is in preparation for the next patch.

Actually the old cleanup code could leave the repository directory if
    D=$(cd "$dir" && pwd)
failed before this patch.
---
 git-clone.sh |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index bd44ce1..59a457b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -176,15 +176,24 @@ dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 [ -e "$dir" ] && die "destination directory '$dir' already exists."
-mkdir -p "$dir" &&
-D=$(cd "$dir" && pwd) &&
-trap 'err=$?; cd ..; rm -rf "$D"; exit $err' 0
+D=
+cleanup() {
+	err=$?
+	test -z "$D" && rm -rf "$dir"
+	cd ..
+	test -n "$D" && rm -rf "$D"
+	exit $err
+}
+trap cleanup 0
+mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
 case "$bare" in
 yes)
 	GIT_DIR="$D" ;;
 *)
 	GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init ${template+"$template"} || usage
+esac
+export GIT_DIR
+git-init ${template+"$template"} || usage
 
 if test -n "$reference"
 then
-- 
1.5.2.2.647.ga00fe
