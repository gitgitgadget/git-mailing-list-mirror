From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 00:02:34 +0100
Message-ID: <20071113230234.GI3268@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 00:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4mw-0007ky-4e
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbXKMXCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbXKMXCk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:02:40 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:38027 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759603AbXKMXCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:02:39 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo53) (RZmta 14.0)
	with ESMTP id 202248jADIfiFk ; Wed, 14 Nov 2007 00:02:37 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E03D6277AE;
	Wed, 14 Nov 2007 00:02:34 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AE73B56D22; Wed, 14 Nov 2007 00:02:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071113194909.GD3268@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64901>

Ignore exit code of git push in t5404, as it is not relevant for the
test: it already checks whether the references updated correctly.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This one is on top of what is in next. It also include the check for
deleting remote braches I sent before. Regarding this one: if a remote
branch is deleted, shouldn't the matching tracking branch be removed
as well? The code in master seem to do that.

 t/t5404-tracking-branches.sh |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 20718d4..a51bbdc 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup' '
 	git commit -m 1 &&
 	git branch b1 &&
 	git branch b2 &&
+	git branch b3 &&
 	git clone . aa &&
 	git checkout b1 &&
 	echo b1 >>file &&
@@ -19,10 +20,13 @@ test_expect_success 'setup' '
 	git commit -a -m b2
 '
 
+start_dir="$(pwd)"
+
 test_expect_success 'check tracking branches updated correctly after push' '
 	cd aa &&
 	b1=$(git rev-parse origin/b1) &&
 	b2=$(git rev-parse origin/b2) &&
+	b3=$(git rev-parse origin/b3) &&
 	git checkout -b b1 origin/b1 &&
 	echo aa-b1 >>file &&
 	git commit -a -m aa-b1 &&
@@ -32,9 +36,28 @@ test_expect_success 'check tracking branches updated correctly after push' '
 	git checkout master &&
 	echo aa-master >>file &&
 	git commit -a -m aa-master &&
-	git push &&
-	test "$(git rev-parse origin/b1)" = "$b1" &&
-	test "$(git rev-parse origin/b2)" = "$b2"
+	{
+		git push
+		test "$(git rev-parse origin/b1)" = "$b1" &&
+		test "$(git rev-parse origin/b2)" = "$b2" &&
+		test "$(git rev-parse origin/b3)" = "$b3" &&
+		test "$(git rev-parse origin/master)" = \
+		"$(git rev-parse master)"
+	}
+'
+
+test_expect_success 'delete remote branch' '
+	git push origin :refs/heads/b3
+	{
+		git rev-parse origin/b3
+		test $? != 0 || \
+		say "Hmm... Maybe tracking ref should be deleted?"
+        } &&
+	cd "$start_dir" &&
+	{
+		git rev-parse refs/heads/b3
+		test $? != 0
+        }
 '
 
 test_done
