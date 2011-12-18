From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv3 02/11] git-p4: test debug macro
Date: Sun, 18 Dec 2011 09:06:33 -0500
Message-ID: <20111218140633.GB16487@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com>
 <4EED1B06.80007@diamand.org>
 <20111218013651.GA18735@padd.com>
 <20111218032238.GA6368@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 15:06:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcHO1-0000M4-VY
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 15:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab1LROGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 09:06:38 -0500
Received: from honk.padd.com ([74.3.171.149]:44016 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1LROGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 09:06:36 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id EF60B339A;
	Sun, 18 Dec 2011 06:06:35 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 929C0313F0; Sun, 18 Dec 2011 09:06:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111218032238.GA6368@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187422>

Call this from a test to have it pause and wait for you to
investigate.  It prints out its current directory and the
P4 environment variables.  It waits for ctrl-c before continuing
the test.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
jrnieder@gmail.com wrote on Sat, 17 Dec 2011 21:26 -0600:
> Pete Wyckoff wrote:
> 
> > +	# 2 is SIGINT, ash/dash does not know symbolic names
> > +	trap echo 2
> 
> 'trap "$cmd" INT' works, and it's even in POSIX. ;)
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap

Nicer to use the constant.  It works on both.  Unfortunately
ash has other issues regarding handling ctrl-c from subprocesses.
Point this out in the comments.

 t/lib-git-p4.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index a870f9a..4c30960 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -72,3 +72,34 @@ kill_p4d() {
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
+# The continuation feature only works in shells that do not propagate
+# a child-caught ctrl-c, namely bash.  With ash, the entire test run
+# will exit on the ctrl-c.
+#
+debug() {
+	echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
+	echo cd \"$(pwd)\"
+	echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
+	trap "echo" INT
+	sleep $((3600 * 24 * 30))
+	trap - INT
+}
+
-- 
1.7.8.285.gb668d
