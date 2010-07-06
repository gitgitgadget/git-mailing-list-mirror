From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2 v2] Makefile: work around ksh's failure to handle missing list argument to for loop
Date: Tue,  6 Jul 2010 14:56:51 -0700
Message-ID: <vUheaJEBKF4RpCQidVNBD1qrdnnqrcfK_TfSmMUj8l53PCm3F-faBNN2Pxk97G5Mf5GY3dVoDgwkpzK8xO7nXw@cipher.nrlssc.navy.mil>
References: <7v630t72vo.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	git@drmicha.warpmail.net, PWalker752@aol.com,
	newsletter@dirk.my1.cc, bruce.stephens@isode.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 06 23:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWG4y-0000DY-HH
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab0GFVxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 17:53:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49692 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab0GFVxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 17:53:19 -0400
Received: by mail.nrlssc.navy.mil id o66LqqAE008444; Tue, 6 Jul 2010 16:52:52 -0500
In-Reply-To: <7v630t72vo.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Jul 2010 21:52:52.0071 (UTC) FILETIME=[9513A770:01CB1D55]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150413>

From: Brandon Casey <drafnel@gmail.com>

ksh does not like it when the list argument is missing in a 'for' loop.
This can happen when NO_CURL is set which causes REMOTE_CURL_ALIASES to be
unset.  In this case, the 'for' loop in the Makefile is expanded to look
like this:

   for p in ; do

and ksh complains like this:

   /bin/ksh: syntax error at line 15 : `;' unexpected

The existing attempt to work around this issue, introduced by 70b89f87,
tried to protect the 'for' loop by first testing whether REMOTE_CURL_ALIASES
was empty, but this does not work since, as Johannes Sixt explains, "Before
the test for emptyness can happen, the complete statement must be parsed,
but ksh finds a syntax error in the statement and, therefore, cannot even
begin to execute the statement. (ksh doesn't follow POSIX in this regard,
where this would not be a syntax error.)".

Make's $(foreach) function could be used to avoid this shell glitch, but
since it has already caused a problem once before by generating a command
line that exceeded the maximum argument list length on IRIX, let's adopt
Bruce Stephens's suggestion for working around this issue in the same way
the OpenSSL folks have done it.  This solution first assigns the contents
of the REMOTE_CURL_ALIASES make variable to a shell variable and then
supplies the shell variable as the list argument in the 'for' loop.  This
satisfies ksh and has the expected behavior even if $(REMOTE_CURL_ALIASES)
is empty.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 07/05/2010 09:36 PM, Junio C Hamano wrote:
> Well your patch fixes the issue, and I would actually prefer it as long as
> it is explained well ;-).

Heh, ok, hopefully this commit message does a better job.

-Brandon


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
