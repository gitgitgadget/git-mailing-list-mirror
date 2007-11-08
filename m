From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 8 Nov 2007 14:14:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081414160.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 08 15:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq89t-00025f-3c
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbXKHOOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXKHOOo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:14:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:48528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752999AbXKHOOn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:14:43 -0500
Received: (qmail invoked by alias); 08 Nov 2007 14:14:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 08 Nov 2007 15:14:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l+MBQWaGlIMWW+D2RTM9gL17TyMTBRaQ4Ei8IKD
	8Yleo9i3LdQGzI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711081213580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64025>


Wow, the builtin commit is fast.  It sometimes triggers a racy
situation in the test case for "git add --refresh -- foo".

So when that test fails, simply sleep one second and try again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3700-add.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index a328bf5..f4950a3 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -152,7 +152,12 @@ test_expect_success 'git add --refresh' '
 	*) echo fail; (exit 1);;
 	esac &&
 	git add --refresh -- foo &&
-	test -z "`git diff-index HEAD -- foo`"
+	test -z "`git diff-index HEAD -- foo`" || {
+		echo Sleeping one second to avoid racy situation &&
+		sleep 1 &&
+		git add --refresh -- foo &&
+		test -z "`git diff-index HEAD -- foo`"
+	}
 '
 
 test_done
-- 
1.5.3.5.1634.g0fa78
