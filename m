From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 5/6] Add regression tests for stricter tag fsck'ing
Date: Wed, 10 Sep 2014 15:53:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409101553080.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 10 15:53:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiKl-0000Aw-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbaIJNxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:53:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:58977 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbaIJNxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:53:13 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LnxQO-1XyqAJ1KHo-00g2wo;
 Wed, 10 Sep 2014 15:53:11 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410356761.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:3BHdv9/7oDJl2q9/J1mm5J/OjlwF3ws3bwQMMj4uBtGKrM/x4kH
 LR+gaZYk0FOqlxRJ3FhgQXre7ux7Ef9wwlNcK/YVreL5UEXpKyk44hFdFWI41bhe8MWT+Rd
 w+NI3YNZz2AHv8aY0QvqicxdMKzezsGIxuIsoWd6tcjSUMNPgidtKOXxs20N59VfdeU0ajD
 6f1XhvH2pJd1mwRq8Raew==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256743>

The intent of the two new test cases is to catch general breakages in
the fsck_tag() function, not so much to test it extensively, trying to
strike the proper balance between thoroughness and speed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1450-fsck.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8c739c9..16b3e4a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -194,6 +194,45 @@ test_expect_success 'tag pointing to something else than its type' '
 	test_must_fail git fsck --tags
 '
 
+test_expect_success 'tag with incorrect tag name' '
+	sha=$(git rev-parse HEAD) &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type commit
+	tag wrong name format
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/wrong &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	git fsck --tags 2>out &&
+	cat out &&
+	grep "invalid .tag. name" out
+'
+
+test_expect_success 'tag with missing tagger' '
+	sha=$(git rev-parse HEAD) &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type commit
+	tag gutentag
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/wrong &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	git fsck --tags 2>out &&
+	cat out &&
+	grep "expected .tagger. line" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_cmp empty actual
-- 
2.0.0.rc3.9669.g840d1f9
