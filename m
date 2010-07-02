From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] Makefile: work around ksh's failure to handle missing list argument to for loop
Date: Fri,  2 Jul 2010 11:50:29 -0700
Message-ID: <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
References: <80typu1ozt.fsf@tiny.isode.net>
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, PWalker752@aol.com,
	newsletter@dirk.my1.cc, bruce.stephens@isode.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 02 20:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlIc-0000f8-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 20:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759583Ab0GBStI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 14:49:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59447 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759764Ab0GBStE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 14:49:04 -0400
Received: by mail.nrlssc.navy.mil id o62IkeIb010106; Fri, 2 Jul 2010 13:46:40 -0500
In-Reply-To: <80typu1ozt.fsf@tiny.isode.net>
X-OriginalArrivalTime: 02 Jul 2010 18:46:40.0698 (UTC) FILETIME=[E8C469A0:01CB1A16]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150146>

From: Brandon Casey <drafnel@gmail.com>

ksh does not like it when the list argument is missing in a for loop.  This
can happen when NO_CURL is set which causes REMOTE_CURL_ALIASES to be unset.
In this case, the for loop in the Makefile expands to look like this:

   for p in ; do

and ksh complains like this:

   /bin/ksh: syntax error at line 15 : `;' unexpected

The existing attempt to work around this issue, introduced by 70b89f87,
tried to protect the for loop by first testing whether REMOTE_CURL_ALIASES
was empty, but it does not seem to work.  So adopt Bruce Stephens's
suggestion (which comes from OpenSSL) for working around this issue.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 527d872..bc3c570 100644
--- a/Makefile
+++ b/Makefile
@@ -2085,13 +2085,13 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	done && \
-	{ test x"$(REMOTE_CURL_ALIASES)" = x || \
-		for p in $(REMOTE_CURL_ALIASES); do \
+	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
+	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-	done; } && \
+	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
-- 
1.7.2.rc1
