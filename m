From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 6/6] Make sure that index-pack --strict checks tag
 objects
Date: Fri, 12 Sep 2014 10:08:16 +0200 (CEST)
Message-ID: <71bf293f1e6fd292c8ae5725a5a71d5f21eea19d.1410509169.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de> <cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:09:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLun-0005kT-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaILIJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:09:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:52880 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbaILIIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:08:19 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MNHqL-1XQR1U1gEL-006yOt;
 Fri, 12 Sep 2014 10:08:17 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:XWb5DOqTMDdA+2ZKiRzSRO7neH8e15PxFyatHiaQcXrzH3WmLxG
 +r+IR4sk+jSTO3CSehDCV4PBhAfwr5PyewA2Vp/BQYtYInBGcDkQPi/svc46ziUpXS7wma3
 qgZe2tHsHBfBSV7GJ/AZNc2nsyqU2erfrj/iTpTNDYi3RrAyCuvoP2OmhNyx6HpIEI5GluS
 ABCvHU7ejCfRtdMxlHu0g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256912>

One of the most important use cases for the strict tag object checking
is when transfer.fsckobjects is set to true to catch invalid objects
early on. This new regression test essentially tests the same code path
by directly calling 'index-pack --strict' on a pack containing an
tag object without a 'tagger' line.

Technically, this test is not enough: it only exercises a code path that
*warns*, not one that *fails*. The reason is that hash-object and
pack-objects both insist on parsing the tag objects and would fail on
invalid tag objects at this time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5302-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4bbb718..61bc8da 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -243,4 +243,23 @@ test_expect_success 'running index-pack in the object store' '
     test -f .git/objects/pack/pack-${pack1}.idx
 '
 
+test_expect_success 'index-pack --strict warns upon missing tagger in tag' '
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
+    pack1=$(echo $tag $sha | git pack-objects tag-test) &&
+    echo remove tag object &&
+    thirtyeight=${tag#??} &&
+    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
+    git index-pack --strict tag-test-${pack1}.pack 2>err &&
+    grep "^error:.* expected .tagger. line" err
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
