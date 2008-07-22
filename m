From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Respect crlf attribute even if core.autocrlf has not been
 set
Date: Tue, 22 Jul 2008 22:56:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222255450.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 23:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPr1-0006C8-72
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYGVV4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbYGVV4H
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:56:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:50511 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753517AbYGVV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:56:04 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:56:02 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp059) with SMTP; 22 Jul 2008 23:56:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h0EZAebPhSBLt3lqNEuB2cYg8uO4siJeN/hN0fh
	PiuYrJ0DfvfhjY
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89550>


When a file's crlf attribute is explicitely set, it does not make sense
to ignore it, just because the config variable core.autocrlf has not
been set.

This patch does not affect the case when the crlf attribute is unset.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	There have been no comments on this patch so far, however I think
	that this is a valid fix which should be in 1.6.0.

 convert.c       |    2 +-
 t/t0020-crlf.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/convert.c b/convert.c
index 78efed8..d038d2f 100644
--- a/convert.c
+++ b/convert.c
@@ -126,7 +126,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	struct text_stat stats;
 	char *dst;
 
-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
+	if ((action == CRLF_BINARY) || (!auto_crlf && action < 0) || !len)
 		return 0;
 
 	gather_stats(src, len, &stats);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1be7446..0bb3e6f 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -436,4 +436,14 @@ test_expect_success 'invalid .gitattributes (must not crash)' '
 
 '
 
+test_expect_success 'attribute crlf is heeded even without core.autocrlf' '
+
+	echo "allcrlf crlf=input" > .gitattributes &&
+	git config --unset core.autocrlf &&
+	git add allcrlf &&
+	git show :allcrlf | append_cr > expect &&
+	test_cmp allcrlf expect
+
+'
+
 test_done
-- 
1.6.0.rc0.22.gf2096d.dirty
