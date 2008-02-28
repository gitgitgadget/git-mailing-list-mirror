From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Expect the exit code of builtin checkout to be in portable
	range
Date: Thu, 28 Feb 2008 17:49:53 +0100
Message-ID: <20080228164953.GB4069@steel.home>
References: <20080228163047.GA4069@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 17:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlxv-0001TM-Iv
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 17:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310AbYB1Qt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 11:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758347AbYB1Qt4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 11:49:56 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:17246 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757601AbYB1Qt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 11:49:56 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jKuj8=
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (klopstock mo46) (RZmta 16.8)
	with ESMTP id D03fc3k1SGRpdL ; Thu, 28 Feb 2008 17:49:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1AAF5277BD;
	Thu, 28 Feb 2008 17:49:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id EDA7D56D24; Thu, 28 Feb 2008 17:49:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080228163047.GA4069@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75423>

This allows crashes to be noticed at least in bash and dash, which put
the signal which terminated the command in its exit status.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Thu, Feb 28, 2008 17:30:47 +0100:
> Noticed in t2008, which actually passed, but silently removed
> core-files (I saw segfaults in syslog) and did not properly check the
> exit code.  The change for the t2008 comes as seperate patch, but it
> should be noted that "! command" is *not* how you check for a command
> to have failed. It could have crashed.

So we'd better check the exit status in failure tests.
Like this, for instance

 t/t2008-checkout-subdir.sh |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 4a723dc..1295a09 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -67,16 +67,28 @@ test_expect_success 'checkout with simple prefix' '
 
 '
 
-test_expect_success 'relative path outside tree should fail' \
-	'! git checkout HEAD -- ../../Makefile'
+test_expect_success 'relative path outside tree should fail' '
+	git checkout HEAD -- ../../Makefile
+	test $? -gt 0 -a $? -le 128
+'
 
-test_expect_success 'incorrect relative path to file should fail (1)' \
-	'! git checkout HEAD -- ../file0'
+test_expect_success 'incorrect relative path to file should fail (1)' '
+	git checkout HEAD -- ../file0
+	test $? -gt 0 -a $? -le 128
+'
 
-test_expect_success 'incorrect relative path should fail (2)' \
-	'( cd dir1 && ! git checkout HEAD -- ./file0 )'
+test_expect_success 'incorrect relative path should fail (2)' '
+	( cd dir1 && {
+	    git checkout HEAD -- ./file0
+	    test $? -gt 0 -a $? -le 128
+	} )
+'
 
-test_expect_success 'incorrect relative path should fail (3)' \
-	'( cd dir1 && ! git checkout HEAD -- ../../file0 )'
+test_expect_success 'incorrect relative path should fail (3)' '
+	( cd dir1 && {
+	    git checkout HEAD -- ../../file0
+	    test $? -gt 0 -a $? -le 128
+	} )
+'
 
 test_done
-- 
1.5.4.3.253.g9f1d5

