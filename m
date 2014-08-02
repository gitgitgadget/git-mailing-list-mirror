From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 1/2] t5704: Fix the test that checks for excluded tags
Date: Sat,  2 Aug 2014 10:39:06 +0200
Message-ID: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 10:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDUqh-0002ks-ML
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 10:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbaHBIjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 04:39:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:61995 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbaHBIjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 04:39:10 -0400
Received: from localhost ([87.180.61.8]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1WwVxO1FbO-00IBnp; Sat, 02 Aug 2014 10:39:08
 +0200
X-Mailer: git-send-email 2.0.3
X-Provags-ID: V03:K0:FtHItNXmABGqsfLUu+U0NHBrE5Ho5ZFNbElhrVaXdZ1D8AF9cF7
 N5PsAgN/DExILZ6igN+x8nvYXO90B6bbAJayZ3Kcrq9krDvMv0IJ3JEhTf7DqGm/bwtUPUu
 ypY1KdHH/LyM1yLGs+sfY0AQjX3Tq7VGDAUnsBElRdmOX4tD3spgUb0Yy4Zvw2gklUlgZIz
 jPBHcga8oQLtvRQsrnd1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254691>

In c9a42c4 (bundle: allow rev-list options to exclude annotated tags,
2009-01-02), we added a test to check whether annotated tags, which fall
outside the specified date range, are excluded from bundles. However,
when initializing the repository, a command to create a lightweight tag
was used. Fix this by replacing `git tag` by `git tag -a`. Furthermore,
explicitly mention in the test message that an annotated tag is created
and also test whether tags within the specified date range are included
properly.

Note that this fix reveals that the annotated tag exclusion actually
does not work. Therefore, the test is marked expect-failure for now.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 t/t5704-bundle.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a45c316..2f063ea 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -6,7 +6,7 @@ test_description='some bundle related tests'
 test_expect_success 'setup' '
 	test_commit initial &&
 	test_tick &&
-	git tag -m tag tag &&
+	git tag -am tag tag &&
 	test_commit second &&
 	test_commit third &&
 	git tag -d initial &&
@@ -14,7 +14,10 @@ test_expect_success 'setup' '
 	git tag -d third
 '
 
-test_expect_success 'tags can be excluded by rev-list options' '
+test_expect_failure 'annotated tags can be excluded by rev-list options' '
+	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
+	git ls-remote bundle > output &&
+	grep tag output &&
 	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
 	git ls-remote bundle > output &&
 	! grep tag output
-- 
2.0.3
