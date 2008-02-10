From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a test for git-daemon and clone via git:// protocol
Date: Sun, 10 Feb 2008 13:45:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101343480.11591@racer.site>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site> <alpine.LNX.1.00.0802091205530.13593@iabervon.org> <alpine.LSU.1.00.0802100302050.11591@racer.site> <alpine.LNX.1.00.0802092208280.13593@iabervon.org> <7vhcgh4fb9.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802101210340.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOCV5-0002jp-9J
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 14:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbYBJNpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 08:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbYBJNpK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:45:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:34942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750769AbYBJNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 08:45:08 -0500
Received: (qmail invoked by alias); 10 Feb 2008 13:45:05 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 10 Feb 2008 14:45:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FyvsH9E2FSu+koS7nEiK2equwcN3oFPs9rg8yfg
	nidkjAFRPJjUra
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802101210340.11591@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73355>


The new test, t5703-daemon.sh, sets up a simple git-daemon at port 8111
(you can override it with the environment variable GIT_DAEMON_TEST_PORT),
and then tries to clone via git:// from it, first without the
git-daemon-export-ok file (which should fail), and then with it (which
should succeed).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---


	On Sun, 10 Feb 2008, Johannes Schindelin wrote:

	> On Sat, 9 Feb 2008, Junio C Hamano wrote:
	> 
	> > Thanks.  The patch makes sense.
	> > 
	> > I wonder this deserves a new test case to protect the fix from 
	> > future regressions.
	> 
	> It would probably make sense; this would also exercise 
	> git-daemon for the first time in our test suite.

	How's this?

 t/t5703-daemon.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t5703-daemon.sh

diff --git a/t/t5703-daemon.sh b/t/t5703-daemon.sh
new file mode 100755
index 0000000..10696a1
--- /dev/null
+++ b/t/t5703-daemon.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git daemon and cloning via git:// protocol'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir first &&
+	(cd first &&
+	 git init &&
+	 echo biomimicry > ted &&
+	 git add ted &&
+	 test_tick &&
+	 git commit -m initial &&
+	 git gc)
+
+'
+
+PORT=${GIT_DAEMON_TEST_PORT:-8111}
+
+start_daemon () {
+	trap 'kill "$DAEMON_PID"' 0
+	git daemon --base-path="$(pwd)" \
+		--port="$PORT" \
+		--detach \
+		--pid-file=pid-file \
+		-- "$(pwd)/first"
+	DAEMON_PID=$(cat pid-file)
+}
+
+test_expect_success 'daemon' '
+
+	start_daemon &&
+	test -f pid-file
+
+'
+
+test_expect_success 'clone fails without export-ok' '
+
+	! git clone git://127.0.0.1:"$PORT"/first second
+
+'
+
+test_expect_success 'clone succeeds with export-ok' '
+
+	: > first/.git/git-daemon-export-ok &&
+	git clone git://127.0.0.1:"$PORT"/first second &&
+	for f in refs/heads/master objects/pack/*.pack
+	do
+		cmp first/.git/$f second/.git/$f || break
+	done
+
+'
+
+test_done
-- 
1.5.4.1264.gb53928
