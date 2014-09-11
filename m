From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 6/6] Make sure that index-pack --strict checks tag
 objects
Date: Thu, 11 Sep 2014 16:26:45 +0200 (CEST)
Message-ID: <2738eace005dce9002c1a1f5e87ad63aebdf83ef.1410445431.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info> <cover.1410445430.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 11 16:27:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS5L7-0004wM-0B
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 16:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaIKO0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 10:26:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:59238 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845AbaIKO0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 10:26:48 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MS0c2-1XvHK819UA-00T9U6;
 Thu, 11 Sep 2014 16:26:46 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410445430.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:avJFMPAG8vfnEedV1gq6SbtTaGvxNvCo6lexfKln5hbdauBsRnn
 Hv51d9HQdT8QppQ9r4AlhOjHep7EUuwedQbNIpi6yGoUAsuEmLYUFqEOHJ5zHfd4vB0kmdl
 g/UhpD7jooX2/x3o0YUOPvfMH6rMftVRRqhye5YtwZJ0qFg+y52gyib8TaFUM/J/MQa7Prz
 ZSSa1bLtYLZEsz9VAIZFQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256844>

One of the most important use cases for the strict tag object checking
is when transfer.fsckobjects is set to true to catch invalid objects
early on. This new regression test essentially tests the same code path
by directly calling 'index-pack --strict' on a pack containing an
tag object without a 'tagger' line.

Technically, this test is not enough: it only exercises a code path that
*warns*, not one that *fails*. The reason is that it would be exquisitely
convoluted to test that: not only hash-object, but also pack-index
actually *parse* tag objects when encountering them. Therefore we would
have to actively *break* pack-index in order to test this. Or rewrite
both hash-object and pack-index in shell script. Ain't gonna happen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5302-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4bbb718..4d033df 100755
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
+    git index-pack --strict tag-test-${pack1}.pack 2> err &&
+    grep "^error:.* expected .tagger. line" err
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
