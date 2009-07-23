From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Add a test showing that 'git repack' throws away
 grafted-away parents
Date: Thu, 23 Jul 2009 17:33:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907231733300.8306@pacific.mpi-cbg.de>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 17:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU0Iw-0004qv-TM
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 17:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZGWPdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZGWPdr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 11:33:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:57152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753324AbZGWPdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 11:33:46 -0400
Received: (qmail invoked by alias); 23 Jul 2009 15:33:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 23 Jul 2009 17:33:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1CkszTAf1ZnR0pRQrbXg4wBSVKu7yywwsOQNwy3
	5HbBoCkqDyvULe
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1248362827u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123873>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Bjoern said that the reflogs are not thrown away if there is no 
	"sleep 1" (which I turned into "test-chmtime -1 .git/logs/HEAD
	.git/logs/refs/heads/master" only to delete it as things worked 
	here without it).

 t/t7700-repack.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 87c9b0e..a4dddb7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -149,5 +149,17 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	test_must_fail git show $csha1
 '
 
+test_expect_failure 'objects made unreachable by grafts only are kept' '
+	test_tick &&
+	git commit --allow-empty -m "commit 4" &&
+	H0=$(git rev-parse HEAD) &&
+	H1=$(git rev-parse HEAD^) &&
+	H2=$(git rev-parse HEAD^^) &&
+	echo "$H0 $H2" > .git/info/grafts &&
+	git reflog expire --expire=now --expire-unreachable=now --all &&
+	git repack -a -d &&
+	git cat-file -t $H1
+	'
+
 test_done
 
-- 
1.6.4.rc1.289.gf87df
