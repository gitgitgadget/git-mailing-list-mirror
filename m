From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] valgrind tests: be super-super paranoid when creating
 symlinks
Date: Wed, 21 Jan 2009 23:31:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212331280.3586@pacific.mpi-cbg.de>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPldN-00025T-Gd
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZAUWbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZAUWbx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:31:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:50292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753132AbZAUWbw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:31:52 -0500
Received: (qmail invoked by alias); 21 Jan 2009 22:31:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 21 Jan 2009 23:31:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PB6B+rRbPtztGJQNzcXxkpuq5eYVOZioASwAAJl
	8kMeEXqaw+wUtv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106689>


Even if there is only a faint, almost neglible chance that two parallel
tests create the symlinks needed for the valgrind test at the same time,
Peff wrote more than just a couple mails about the issue.

To get rid of that threat^Wthread, use a locking mechanism to make
sure a symlink is only created by one test invocation, and the other
has to wait.

Peff, do you see how much I like you?

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6acc6e0..07e657e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -490,8 +490,19 @@ else
 	make_symlink () {
 		test -h "$2" &&
 		test "$1" = "$(readlink "$2")" || {
-			rm -f "$2" &&
-			ln -s "$1" "$2"
+			# be super paranoid
+			if mkdir "$2".lock
+			then
+				rm -f "$2" &&
+				ln -s "$1" "$2" &&
+				rm -r "$2".lock
+			else
+				while test -d "$2".lock
+				do
+					say "Waiting for lock on $2."
+					sleep 1
+				done
+			fi
 		}
 	}
 
-- 
1.6.1.442.g112f5
