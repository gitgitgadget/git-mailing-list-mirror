From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Wed, 23 Jul 2008 02:31:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230229410.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTDa-0007cA-GY
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYGWBbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYGWBbj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:31:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:48901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751856AbYGWBbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:31:38 -0400
Received: (qmail invoked by alias); 23 Jul 2008 01:31:36 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp046) with SMTP; 23 Jul 2008 03:31:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+N5SNSN9SNGcsvWki6wC9vEWmb69vzt1dcFJ7LiN
	4sgq9RE7RTwG5p
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807230203350.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89594>


When a file's crlf attribute is explicitely set, it does not make sense
to ignore it when adding the file, just because the config variable
core.autocrlf has not been set.

The alternative would be risking to get CR/LF files into the repository
just because one user forgot to set core.autocrlf.

This patch does not affect the case when the crlf attribute is unset,
or when checking files out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Okay, so I lied and did not go to sleep (but that part comes 
	now).  Only the wording in the commit message has changed.

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
