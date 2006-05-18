From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Thu, 18 May 2006 23:35:20 +0200
Message-ID: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 23:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgq5t-0001eN-P3
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWERVbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWERVbe
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:31:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:26011 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751337AbWERVbd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 17:31:33 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8237C9AA83;
	Thu, 18 May 2006 23:31:32 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FgqH5-0001qh-C0; Thu, 18 May 2006 23:43:17 +0200
To: junkio@cox.net
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20302>


This test fails with 1.3.x and HEAD.  This is a very serious bug, since it
causes data loss.

I am not sure whether it is normal that git-fsck-objects does not retun an
error code, while we can see it reports the inconsistency in --verbose
mode.  At least trying to directly access the dropped commit triggers an
error anyway.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t6200-prune-grafts.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t6200-prune-grafts.sh b/t/t6200-prune-grafts.sh
new file mode 100755
index 0000000..80d0d59
--- /dev/null
+++ b/t/t6200-prune-grafts.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+set -e
+
+test_description='Test that git-prune does not nuke revs hidden by a graft'
+
+. ./test-lib.sh
+
+echo First > A && git-add A && git-commit -m "Add A."
+echo First > B && git-add B && git-commit -m "Add B."
+echo Second >> A && git-update-index A && git-commit -m "Append to A."
+
+test_expect_success 'initial state is valid' 'git-fsck-objects'
+
+echo $(git-rev-parse HEAD) $(git-rev-parse HEAD^^) > .git/info/grafts
+
+test_expect_success 'grafted state is valid' 'git-fsck-objects'
+test_expect_success 'prune with the graft in effect' 'git-prune'
+test_expect_success 'grafted state is valid' 'git-fsck-objects'
+
+rm .git/info/grafts
+
+test_expect_success 'grafted state is still valid' 'git-fsck-objects'
+test_expect_success 'previously-hidden rev is still there' 'git-cat-file commit HEAD^'
+
+test_done
