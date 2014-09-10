From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 6/6] Make sure that index-pack --strict fails upon invalid
 tag objects
Date: Wed, 10 Sep 2014 15:53:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 10 15:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiKu-0000EY-6u
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaIJNxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:53:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:59335 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaIJNxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:53:19 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lwoiq-1YPCia1tk0-016M77;
 Wed, 10 Sep 2014 15:53:16 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410356761.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7DqF3xMEtCZ75k28vS/fRicI1cwHu8WVdxI1zf1x41RhqhbBmiE
 QHaTVWL41noCe+wZDg63DGY+glEJ2CLL2NbXX7Pn4twwj4iNOGN4+xrZ8r+qDXsP6fptsLG
 YbZFxiInp7seVH8e0lk8gc+M2+SmnHavGJCPzhxqCly9V21yKsU9/EPlD/kwr7fFL+uu4Vo
 kBYanxgFmDGQaM9gjZmSw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256741>

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
