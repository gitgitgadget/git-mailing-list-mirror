From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 02/11] git-p4: test debug macro
Date: Sat, 17 Dec 2011 20:36:51 -0500
Message-ID: <20111218013651.GA18735@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com>
 <4EED1B06.80007@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Dec 18 02:37:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc5gT-0003e7-Fa
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 02:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab1LRBg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 20:36:57 -0500
Received: from honk.padd.com ([74.3.171.149]:50889 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1LRBg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 20:36:56 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 5E6C2339A;
	Sat, 17 Dec 2011 17:36:55 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7C067313F0; Sat, 17 Dec 2011 20:36:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EED1B06.80007@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187409>

Call this from a test to have it pause and wait for you to
investigate.  It prints out its current directory and the
P4 environment variables.  It waits for ctrl-c before continuing
the test.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
luke@diamand.org wrote on Sat, 17 Dec 2011 22:43 +0000:
> >+# Go investigate when it pauses, then hit ctrl-c to continue the
> >+# test.  The other tests will run, and p4d will be cleaned up nicely.
> >+#
> >+# Note that the directory is deleted and created for every test run,
> >+# so you have to do the "cd" again.
> >+#
> >+debug() {
> >+        echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
> >+        echo cd \"$(pwd)\"
> >+        echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
> >+        trap echo SIGINT
> 
> Does that work with non-bash shells like ash? It didn't for me.
> 
> >+        sleep $((3600 * 24 * 30))
> >+        trap - SIGINT
> >+}
> >+

Indeed.  At least debian's ash is just dash, and version 0.5.7-2
doesn't know the symbolic signal names.

Thanks for noticing.

 t/lib-git-p4.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index a870f9a..b7b2c95 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -72,3 +72,31 @@ kill_p4d() {
 cleanup_git() {
 	rm -rf "$git"
 }
+
+#
+# This is a handy tool when developing or debugging tests.  Use
+# it inline to pause the script, perhaps like this:
+#
+#	"$GITP4" clone ... &&
+#	(
+#		cd "$git" &&
+#		debug &&
+#		git log --oneline >lines &&
+#		...
+#
+# Go investigate when it pauses, then hit ctrl-c to continue the
+# test.  The other tests will run, and p4d will be cleaned up nicely.
+#
+# Note that the directory is deleted and created for every test run,
+# so you have to do the "cd" again.
+#
+debug() {
+	echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
+	echo cd \"$(pwd)\"
+	echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
+	# 2 is SIGINT, ash/dash does not know symbolic names
+	trap echo 2
+	sleep $((3600 * 24 * 30))
+	trap - 2
+}
+
-- 
1.7.8.285.gb668d
