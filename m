From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 6/6] Make sure that index-pack --strict fails upon invalid
 tag objects
Date: Thu, 28 Aug 2014 16:47:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1408281647030.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 16:47:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN0zF-0007lu-LE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbaH1OrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:47:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:59026 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbaH1OrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 10:47:09 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MTjua-1Wwa7u40Qq-00QRMX;
 Thu, 28 Aug 2014 16:47:06 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:/Hv0VHfzj19e6vZTEm4RlGZpxIrFSg/lRLvXTEqIArx5lfAEyw3
 kpCpVojIUOHtXykjjn9nrMdT6VIrQ3ms2zqrHRLSaHMi3SuKXO0wGe/8t6ORX6/Y1v4aM8k
 oV+Ekym4AHYI/LT0CbjTvOPHxN5Dp/UNVhELZGVCQD7+c1vPwR9f6rcNIIg4gRNHK4CS2+k
 TCouZyPi+jNjMq7zhHihA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256090>

One of the most important use cases for the strict tag object checking
is when transfer.fsckobjects is set to true to catch invalid objects
early on. This new regression test essentially tests the same code path
by directly calling 'index-pack --strict' on a pack containing an
invalid tag object.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5302-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4bbb718..80bd3ee 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -243,4 +243,23 @@ test_expect_success 'running index-pack in the object store' '
     test -f .git/objects/pack/pack-${pack1}.idx
 '
 
+test_expect_success 'index-pack --strict fails upon invalid tag' '
+    sha=$(git rev-parse HEAD) &&
+    cat >wrong-tag <<EOF &&
+object $sha
+type commit
+tag guten tag
+
+This is an invalid tag.
+EOF
+
+    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+    pack1=$(echo $tag | git pack-objects tag-test) &&
+    echo remove tag object &&
+    thirtyeight=${tag#??} &&
+    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
+    test_must_fail git index-pack --strict tag-test-${pack1}.pack 2> err &&
+    grep "invalid .tag. name" err
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
