From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 5/6] Add regression tests for stricter tag fsck'ing
Date: Fri, 12 Sep 2014 10:08:12 +0200 (CEST)
Message-ID: <69c1f8b3499986a7cd6148db0159fef0ee2d6366.1410509168.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de> <cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLuS-0005XF-T2
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaILIIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:08:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:58950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbaILIIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:08:16 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LoE4f-1XzUjE2FIH-00gISh;
 Fri, 12 Sep 2014 10:08:13 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:wOHg/JCuqyRl01o33HILbI9J2gic3+Oy5YDfn9ZCRiKKqjlZ/Nw
 OP0Z0cjc0zKMWmQQ2iLwOR6kvZ22riDjE0zf5vBxTqCtucN2AOXqifu4LfO3EbaS+Ei38DT
 KuD2pgx8Wmph+iFWmunVidRIAcHUZauZdcOSp1jlCF1UQpTSaVhQX+2ABJHm81v9jbEil3t
 ADlatmVPE6SP1lWTQeUbQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256911>

The intent of the new test case is to catch general breakages in
the fsck_tag() function, not so much to test it extensively, trying to
strike the proper balance between thoroughness and speed.

While it *would* have been nice to test the code path where fsck_object()
encounters an invalid tag object, this is not possible using git fsck: tag
objects are parsed already before fsck'ing (and the parser already fails
upon such objects).

Even worse: we would not even be able write out invalid tag objects
because git hash-object parses those objects, too, unless we resorted to
really ugly hacks such as using something like this in the unit tests
(essentially depending on Perl *and* Compress::Zlib):

	hash_invalid_object () {
		contents="$(printf '%s %d\0%s' "$1" ${#2} "$2")" &&
		sha1=$(echo "$contents" | test-sha1) &&
		suffix=${sha1#??} &&
		mkdir -p .git/objects/${sha1%$suffix} &&
		echo "$contents" |
		perl -MCompress::Zlib -e 'undef $/; print compress(<>)' \
			> .git/objects/${sha1%$suffix}/$suffix &&
		echo $sha1
	}

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8c739c9..2b6a6f2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -194,6 +194,26 @@ test_expect_success 'tag pointing to something else than its type' '
 	test_must_fail git fsck --tags
 '
 
+test_expect_success 'tag with incorrect tag name & missing tagger' '
+	sha=$(git rev-parse HEAD) &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type commit
+	tag wrong name format
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
+	grep "invalid .tag. name" out &&
+	grep "expected .tagger. line" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_cmp empty actual
-- 
2.0.0.rc3.9669.g840d1f9
