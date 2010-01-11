From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH] Remove empty directories when checking out a commit with fewer submodules
Date: Mon, 11 Jan 2010 02:59:54 +0000
Message-ID: <1263178794-3140-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 04:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUB6B-0002BW-6D
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 04:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab0AKDhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 22:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879Ab0AKDhf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 22:37:35 -0500
Received: from master.pcc.me.uk ([207.192.74.179]:58363 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab0AKDhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 22:37:34 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2010 22:37:34 EST
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NUAYt-0007jb-Nw; Mon, 11 Jan 2010 03:03:23 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NUAVx-0000pE-QR; Mon, 11 Jan 2010 03:00:21 +0000
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136600>

Change the unlink_entry function to use rmdir to remove submodule
directories.  Currently we try to use unlink, which will never succeed.

Of course rmdir will only succeed for empty (i.e. not checked out)
submodule directories.  Behaviour if a submodule is checked out stays
essentially the same: print a warning message and keep the submodule
directory.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 t/t7400-submodule-basic.sh |    9 +++++++++
 unpack-trees.c             |   12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a0cc99a..1a4dc5f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -299,6 +299,15 @@ test_expect_success 'ls-files gracefully handles trailing slash' '
 
 '
 
+test_expect_success 'moving to a commit without submodule does not leave empty dir' '
+	rm -rf init &&
+	mkdir init &&
+	git reset --hard &&
+	git checkout initial &&
+	test ! -d init &&
+	git checkout second
+'
+
 test_expect_success 'submodule <invalid-path> warns' '
 
 	git submodule no-such-submodule 2> output.err &&
diff --git a/unpack-trees.c b/unpack-trees.c
index dd5999c..b69847d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,8 +61,16 @@ static void unlink_entry(struct cache_entry *ce)
 {
 	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return;
-	if (unlink_or_warn(ce->name))
-		return;
+	if (S_ISGITLINK(ce->ce_mode)) {
+		if (rmdir(ce->name)) {
+			warning("unable to rmdir %s: %s",
+				ce->name, strerror(errno));
+			return;
+		}
+	}
+	else
+		if (unlink_or_warn(ce->name))
+			return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-- 
1.6.5
