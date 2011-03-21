From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Work around broken ln on solaris as used in t8006
Date: Sun, 20 Mar 2011 21:12:26 -0400
Message-ID: <1300669946-26326-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <1300669724-sup-450@pinkfloyd.chass.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 02:12:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Tfm-0006qp-1p
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab1CUBMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:12:38 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50985 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1CUBMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:12:37 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:48385 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Q1Tfg-0000sp-JM; Sun, 20 Mar 2011 21:12:36 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Q1Tfg-0006r5-IM; Sun, 20 Mar 2011 21:12:36 -0400
X-Mailer: git-send-email 1.7.3.3
In-Reply-To: <1300669724-sup-450@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169545>

The test setup in t8006-blame-textconv.sh used ln -sf to overwrite an
existing symlink.  Unfortunately, both /usr/bin/ln and
/usr/xpg4/bin/ln on solaris 9 don't properly handle -f when -s is
used.  This caused the test setup to fail which caused subsequent
checks to also fail.

This patch changes the setup to rm the symlink and then create the new
one using only -s.

The upstream Solaris bug (fixed in 10, but not 9) is documented here:
http://bugs.opensolaris.org/view_bug.do?bug_id=4372462

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 t/t8006-blame-textconv.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index ea64cd8..32ec82a 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -25,7 +25,8 @@ test_expect_success 'setup ' '
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
 	if test_have_prereq SYMLINKS; then
-		ln -sf two.bin symlink.bin
+		rm symlink.bin &&
+		ln -s two.bin symlink.bin
 	fi &&
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
-- 
1.7.1
