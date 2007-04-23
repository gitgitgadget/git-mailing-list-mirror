From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] dir.c(common_prefix): Fix two bugs
Date: Mon, 23 Apr 2007 10:21:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231020070.8822@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 23 10:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfto5-0001hy-8E
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 10:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXDWIVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 04:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbXDWIVx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 04:21:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:38177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753906AbXDWIVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 04:21:53 -0400
Received: (qmail invoked by alias); 23 Apr 2007 08:21:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 23 Apr 2007 10:21:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UKcA/SrjUbT1dRH1G8TKYk5V06NmR8SeW9HI9Rf
	yuFUaUxZnuK2Mx
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45301>


The function common_prefix() is used to find the common subdirectory of
a couple of pathnames. When checking if the next pathname matches up with
the prefix, it incorrectly checked the whole path, not just the prefix
(including the slash). Thus, the expensive part of the loop was executed
always.

The other bug is more serious: if the first and the last pathname in the
list have a longer common prefix than the common prefix for _all_ pathnames
in the list, the longer one would be chosen. This bug was probably hidden
by the fact that bash's wildcard expansion sorts the results, and the code
just so happens to work with sorted input.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	If you're up for a very surprising error message, run the test 
	without compiling git-add first...

 dir.c          |    3 ++-
 t/t3700-add.sh |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 6564a92..d306352 100644
--- a/dir.c
+++ b/dir.c
@@ -34,8 +34,9 @@ int common_prefix(const char **pathspec)
 	prefix = slash - path + 1;
 	while ((next = *++pathspec) != NULL) {
 		int len = strlen(next);
-		if (len >= prefix && !memcmp(path, next, len))
+		if (len >= prefix && !memcmp(path, next, prefix))
 			continue;
+		len = prefix - 1;
 		for (;;) {
 			if (!len)
 				return 0;
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 08e0352..ad8cc7d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -104,4 +104,10 @@ test_expect_success 'add ignored ones with -f' '
 	git-ls-files --error-unmatch d.ig/d.if d.ig/d.ig
 '
 
+mkdir 1 1/2 1/3
+touch 1/2/a 1/3/b 1/2/c
+test_expect_success 'check correct prefix detection' '
+	git add 1/2/a 1/3/b 1/2/c
+'
+
 test_done
-- 
1.5.1.1.2671.g2bc0-dirty
