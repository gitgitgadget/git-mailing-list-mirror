From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] t1050-large: generate large files without dd
Date: Wed, 14 Jan 2015 21:28:56 +0100
Message-ID: <54B6D188.7010500@kdbg.org>
References: <54B5579B.4080607@kdbg.org> <20150113214733.GA16582@peff.net> <54B59D24.7030508@kdbg.org> <20150113223849.GA3144@peff.net> <xmqq4mruckrp.fsf@gitster.dls.corp.google.com> <20150114112659.GA23474@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUYv-0001iW-0M
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbbANU3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:29:03 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:17065 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751191AbbANU3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:29:02 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kN0cB1dm8z5tl9;
	Wed, 14 Jan 2015 21:28:57 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 33B8719F451;
	Wed, 14 Jan 2015 21:28:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150114112659.GA23474@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262420>

For some unknown reason, the dd on my Windows box segfaults randomly,
but since recently, it does so much more often than it used to, which
makes running the test suite burdensome.

Use printf to write large files instead of dd. To emphasize that three
of the large blobs are exact copies, use cp to allocate them.

The new code makes the files a bit smaller, and they are not sparse
anymore, but the tests do not depend on these properties. We do not want
to use test-genrandom here (which is used to generate large files
elsewhere in t1050), so that the files can be compressed well (which
keeps the run-time short).

The files are now large text files, not binary files. But since they
are larger than core.bigfilethreshold they are diagnosed as binary
by Git. For this reason, the 'git diff' tests that check the output
for "Binary files differ" still pass.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
V2:
 - use printf instead of test-genrandom
 - use test_cmp, not test_cmp_bin because the files are text now

Am 14.01.2015 um 12:27 schrieb Jeff King:
> On Tue, Jan 13, 2015 at 03:40:10PM -0800, Junio C Hamano wrote:
>> Are we depending on the binary-ness of these test files by the way?
>> The leading NUL \0 looked a bit strange to me.
> 
> I don't think so. We do not want to do a text diff, because that would
> overflow our GIT_ALLOC_LIMIT. But the core.bigfilethreshold check is
> what will make them binary, not the actual content. So a gigantic text
> file is arguably a better test of the feature in question.

Agreed. The files are text now.

 t/t1050-large.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f5a9119..f9f3d13 100755
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
+	printf "%2000000s" X >large1 &&
+	cp large1 large2 &&
+	cp large1 large3 &&
+	printf "%2500000s" Y >huge &&
 	GIT_ALLOC_LIMIT=1500k &&
 	export GIT_ALLOC_LIMIT
 '
@@ -61,7 +61,7 @@ test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
 	git checkout another &&
-	cmp large1 another ;# this must not be test_cmp
+	test_cmp large1 another
 '

 test_expect_success 'packsize limit' '
@@ -162,7 +162,7 @@ test_expect_success 'pack-objects with large loose
object' '
 	test_create_repo packed &&
 	mv pack-* packed/.git/objects/pack &&
 	GIT_DIR=packed/.git git cat-file blob $SHA1 >actual &&
-	cmp huge actual
+	test_cmp huge actual
 '

 test_expect_success 'tar achiving' '
-- 
2.0.0.12.gbcf935e
