From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix test for cleanup failure in t7300 on Windows
Date: Tue, 4 Mar 2008 00:48:56 +0100
Message-ID: <20080303234856.GB28158@steel.home>
References: <20080226202227.GA1245@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 00:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWKPp-0006Ec-0n
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYCCXs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbYCCXs7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:48:59 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:46533 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYCCXs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:48:58 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSg3Lc=
Received: from tigra.home (Fa8a4.f.strato-dslnet.de [195.4.168.164])
	by post.webmailer.de (mrclete mo35) (RZmta 16.8)
	with ESMTP id a047eek23M3Hw1 ; Tue, 4 Mar 2008 00:48:56 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 50476277BD;
	Tue,  4 Mar 2008 00:48:56 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 363EC56D24; Tue,  4 Mar 2008 00:48:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080226202227.GA1245@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76000>

Keep the file open to: the OS does not allow removal of open files.
The saner systems just have a saner permission model and chmod 0
is enough for the test.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Tue, Feb 26, 2008 21:22:27 +0100:
> Just a heads-up.
> 
> The test is fails because it uses "chmod 0" to enforce an error while
> deleting files by "git clean -f -d". This does not work on windows,
> because the directories even without write permission on them can be
> freely modified (the contained names can be removed). Maybe even the
> removal of list permission does not mean a thing either to cygwin or
> windows (that last one being more likely the case: it is more wrong).
> 
> So git-clean succeeds and the test fails.
> 
> It probably can be worked around by opening the file and keeping it open.
> 
> The patch below may fix it (haven't tested yet).
> 

It is tested now.

 t/t7300-clean.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 3840364..4037142 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -320,8 +320,9 @@ test_expect_success 'removal failure' '
 
 	mkdir foo &&
 	touch foo/bar &&
+	exec <foo/bar &&
 	chmod 0 foo &&
-	! git clean -f -d
+	test_must_fail git clean -f -d
 
 '
 chmod 755 foo
-- 
1.5.4.3.469.gf84e2

