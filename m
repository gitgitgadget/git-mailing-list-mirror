From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] clone: bsd shell portability fix
Date: Tue, 13 May 2008 04:45:56 -0400
Message-ID: <20080513084556.GC23799@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvq9o-0007uB-Fi
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbYEMIp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758720AbYEMIp6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:45:58 -0400
Received: from peff.net ([208.65.91.99]:2306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756970AbYEMIp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:45:58 -0400
Received: (qmail 19923 invoked by uid 111); 13 May 2008 08:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 04:45:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 04:45:56 -0400
Content-Disposition: inline
In-Reply-To: <20080513084338.GA23729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82003>

When using /bin/sh from FreeBSD 6.1, the value of $? is lost
when calling a function inside the 'trap' action. This
resulted in clone erroneously indicating success when it
should have reported failure.

As a workaround, we save the value of $? before calling any
functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-clone.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9d88d1c..547228e 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -240,7 +240,6 @@ die "working tree '$GIT_WORK_TREE' already exists."
 D=
 W=
 cleanup() {
-	err=$?
 	test -z "$D" && rm -rf "$dir"
 	test -z "$W" && test -n "$GIT_WORK_TREE" && rm -rf "$GIT_WORK_TREE"
 	cd ..
@@ -248,7 +247,7 @@ cleanup() {
 	test -n "$W" && rm -rf "$W"
 	exit $err
 }
-trap cleanup 0
+trap 'err=$?; cleanup' 0
 mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
 test -n "$GIT_WORK_TREE" && mkdir -p "$GIT_WORK_TREE" &&
 W=$(cd "$GIT_WORK_TREE" && pwd) && GIT_WORK_TREE="$W" && export GIT_WORK_TREE
-- 
1.5.5.1.296.gf618c
