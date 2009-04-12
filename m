From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] t1301-shared-repo: Fix forced modes test, but it still shows a flaw
Date: Sun, 12 Apr 2009 21:22:02 +0200
Message-ID: <200904122122.03040.j6t@kdbg.org>
References: <49E10C55.1050005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 21:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt5Hl-0004S0-RK
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 21:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbZDLTWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 15:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbZDLTWJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 15:22:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49290 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbZDLTWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 15:22:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6F66E2C400B;
	Sun, 12 Apr 2009 21:22:03 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 26E593BEBE;
	Sun, 12 Apr 2009 21:22:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49E10C55.1050005@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116389>

This test was added recently (5a688fe, "core.sharedrepository = 0mode"
should set, not loosen; 2009-03-28). It checked the result of a sed
invocation for emptyness, but in some cases it forgot to print anything
at all, so that those checks would never be false.

Due to this mistake, it went unnoticed that the files in objects/info are
not necessarily 0440, but can also be 0640. This directory is now exempt
from the check.

Moreover, COMMIT_EDITMSG is still world-readable. This is either a bug in
git, or a flaw in the test (the first sed expression). This patch does not
disambiguate these two cases, but only declares the test case as an
expected failure.

Finally, this test cannot be run on Windows (requires POSIXPERM).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Sorry, the first round was whitespace damaged for some reason.

I could now test the result on Linux, and, lo and behold, it shows a bug:
Either in git, or in the test: COMMIT_EDITMSG is still world-readable, as
is shown by the first sed expression that was fixed (2nd hunk).

-- Hannes

 t/t1301-shared-repo.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 750fbb3..71be308 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -126,7 +126,7 @@ test_expect_success POSIXPERM 'git reflog expire honors 
core.sharedRepository' '
 	esac
 '
 
-test_expect_success 'forced modes' '
+test_expect_failure POSIXPERM 'forced modes' '
 	mkdir -p templates/hooks &&
 	echo update-server-info >templates/hooks/post-update &&
 	chmod +x templates/hooks/post-update &&
@@ -145,7 +145,7 @@ test_expect_success 'forced modes' '
 	xargs ls -ld >actual &&
 
 	# Everything must be unaccessible to others
-	test -z "$(sed -n -e "/^.......---/d" actual)" &&
+	test -z "$(sed -e "/^.......---/d" actual)" &&
 
 	# All directories must have either 2770 or 770
 	test -z "$(sed -n -e "/^drwxrw[sx]---/d" -e "/^d/p" actual)" &&
@@ -156,10 +156,12 @@ test_expect_success 'forced modes' '
 		p
 	}" actual)" &&
 
-	# All files inside objects must be 0440
+	# All files inside objects (except objects/info) must be 0440
 	test -z "$(sed -n -e "/objects\//{
 		/^d/d
+		/info/d
 		/^-r--r-----/d
+		p
 	}" actual)"
 '
 
-- 
1.6.2.1.224.g2225f
