From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 18:36:27 +0100
Message-ID: <54B5579B.4080607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:36:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB5OP-0008GZ-D7
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 18:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbbAMRge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 12:36:34 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:55523 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752246AbbAMRgc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 12:36:32 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kMJqd2k8Mz5tlN
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 18:36:29 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DEEDC19F8CC
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 18:36:27 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262339>

For some unknown reason, the dd on my Windows box segfaults every now
and than, but since recently, it does so much more often than it used
to, which makes running the test suite burdensome.

Get rid of four invocations of dd and use test-genrandom instead.

The new code does change some properties of the generated files:

 - They are a bit smaller.
 - They are not sparse anymore.
 - They do not compress well anymore.
 - The smaller of the four files is now a prefix of the larger.

Fortunately, the tests do not depend on these properties, which would
have a big influence on the size of the generated pack files. There *is*
a test in t1050 that checks the size of pack files generated from large
blobs, but it runs in its own repository with its own set of files (that
are already generated with test-genrandom!).

To emphasize that three of the large blobs are exact copies, use cp to
allocate them.

While we are here, replace cmp with test_cmp_bin to document the
binary-ness of the comparison, which was hinted at by a comment, but not
stated explicitly.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I won't mind if the first paragraph of the proposed commit message is
 removed, but without the motivation, this commit reads as if it were
 merely code churn.

 The existing test-genrandom invocations look like this:

   test-genrandom "a" $(( 66 * 1024 )) >mid1

 I chose not to mimick this style because being precise with the file
 size is not important for the files generated here.

 t/t1050-large.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f5a9119..f653121 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -9,10 +9,10 @@ test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
 	git config --global core.bigfilethreshold 200k &&
-	echo X | dd of=large1 bs=1k seek=2000 &&
-	echo X | dd of=large2 bs=1k seek=2000 &&
-	echo X | dd of=large3 bs=1k seek=2000 &&
-	echo Y | dd of=huge bs=1k seek=2500 &&
+	test-genrandom seed1 2000000 >large1 &&
+	cp large1 large2 &&
+	cp large1 large3 &&
+	test-genrandom seed2 2500000 >huge &&
 	GIT_ALLOC_LIMIT=1500k &&
 	export GIT_ALLOC_LIMIT
 '
@@ -61,7 +61,7 @@ test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
 	git checkout another &&
-	cmp large1 another ;# this must not be test_cmp
+	test_cmp_bin large1 another
 '
 
 test_expect_success 'packsize limit' '
@@ -162,7 +162,7 @@ test_expect_success 'pack-objects with large loose object' '
 	test_create_repo packed &&
 	mv pack-* packed/.git/objects/pack &&
 	GIT_DIR=packed/.git git cat-file blob $SHA1 >actual &&
-	cmp huge actual
+	test_cmp_bin huge actual
 '
 
 test_expect_success 'tar achiving' '
-- 
2.0.0.12.gbcf935e
