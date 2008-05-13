From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] filter-branch: fix variable export logic
Date: Tue, 13 May 2008 04:46:38 -0400
Message-ID: <20080513084638.GD23799@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvqAU-00086Q-Le
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460AbYEMIql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbYEMIql
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:46:41 -0400
Received: from peff.net ([208.65.91.99]:2310 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758298AbYEMIqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:46:40 -0400
Received: (qmail 19989 invoked by uid 111); 13 May 2008 08:46:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 04:46:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 04:46:38 -0400
Content-Disposition: inline
In-Reply-To: <20080513084338.GA23729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82004>

filter-branch tries to restore "old" copies of some
environment variables by using the construct:

  unset var
  test -z "$old_var" || var="$old_var" && export var

However, by the short-circuit logic, we will always run
'export var'. On bash and dash, exporting an unset variable
has no effect. However, on some shells (such as FreeBSD's
/bin/sh), the shell exports the empty value.

This manifested itself in this case as git-filter-branch
setting GIT_INDEX_FILE to the empty string, which in turn
caused its call to git-read-tree to fail, leaving the
working tree pointing at the original HEAD instead of the
rewritten one.

To fix this, we change the short-circuit logic to better
match the intent:

  test -z "$old_var" || { var="$old_var" && export var; }

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 333f6a8..0304dc5 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -435,11 +435,11 @@ rm -rf "$tempdir"
 trap - 0
 
 unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
-test -z "$ORIG_GIT_DIR" || GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
-test -z "$ORIG_GIT_WORK_TREE" || GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
-	export GIT_WORK_TREE
-test -z "$ORIG_GIT_INDEX_FILE" || GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
-	export GIT_INDEX_FILE
+test -z "$ORIG_GIT_DIR" || { GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR; }
+test -z "$ORIG_GIT_WORK_TREE" || { GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+	export GIT_WORK_TREE; }
+test -z "$ORIG_GIT_INDEX_FILE" || { GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+	export GIT_INDEX_FILE; }
 git read-tree -u -m HEAD
 
 exit $ret
-- 
1.5.5.1.296.gf618c
