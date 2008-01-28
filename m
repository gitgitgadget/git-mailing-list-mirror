From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add test for rebase -i with commits that do not pass
 pre-commit
Date: Mon, 28 Jan 2008 16:33:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281632300.23907@racer.site>
References: <20080128154232.900.qmail@c07ab49f5b12dd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 17:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJWwA-00070j-Bb
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 17:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbYA1Qdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYA1Qdt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 11:33:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:51151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752624AbYA1Qds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 11:33:48 -0500
Received: (qmail invoked by alias); 28 Jan 2008 16:33:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 28 Jan 2008 17:33:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eaVBHUcTePbuY4nPVkY+j+/ljOR0I5ObFn8Mbwz
	oJqu4gkfpgBl9Q
X-X-Sender: gene099@racer.site
In-Reply-To: <20080128154232.900.qmail@c07ab49f5b12dd.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71894>


This accompanies c5b09feb(Avoid update hook during git-rebase --interactive)
to prove that Debian's Bug#458782 (git-core: git-rebase doesn't work when
trying to squash changes into commits created with --no-verify) is indeed
fixed now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 28 Jan 2008, Gerrit Pape wrote:

	> Hi, IIRC I managed to reproduce the problem below, but currently 
	> don't have the time to track it down.  Hopefully someone else 
	> can work on it, there's even a patch suggested.

	It is even in 1.5.4-rc1.

 t/t3404-rebase-interactive.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 74a7eb3..e33ea4e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -324,4 +324,20 @@ test_expect_success 'rebase a detached HEAD' '
 	test $grandparent = $(git rev-parse HEAD~2)
 '
 
+test_expect_success 'rebase a commit violating pre-commit' '
+
+	mkdir -p .git/hooks &&
+	PRE_COMMIT=.git/hooks/pre-commit &&
+	echo "#!/bin/sh" > $PRE_COMMIT &&
+	echo "test -z \"\$(git diff --cached --check)\"" >> $PRE_COMMIT &&
+	chmod a+x $PRE_COMMIT &&
+	echo "monde! " >> file1 &&
+	test_tick &&
+	! git commit -m doesnt-verify file1 &&
+	git commit -m doesnt-verify --no-verify file1 &&
+	test_tick &&
+	FAKE_LINES=2 git rebase -i HEAD~2
+
+'
+
 test_done
-- 
1.5.4.rc5.15.g8231f
