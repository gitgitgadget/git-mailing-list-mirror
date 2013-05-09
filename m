From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] t5004: avoid using tar for checking emptiness of archive
Date: Thu, 09 May 2013 15:13:47 +0200
Message-ID: <518BA10B.2080003@lsrfire.ath.cx>
References: <518BA058.6050300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	BJ Hargrave <bj@bjhargrave.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 09 15:14:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaQfT-0003Mu-BY
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 15:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab3EINNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 09:13:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:51320 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3EINNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 09:13:50 -0400
Received: from [192.168.2.105] (p4FFD9FB6.dip0.t-ipconnect.de [79.253.159.182])
	by india601.server4you.de (Postfix) with ESMTPSA id 193574B9;
	Thu,  9 May 2013 15:13:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518BA058.6050300@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223730>

Test 2 of t5004 checks if a supposedly empty tar archive really
contains no files.  24676f02 (t5004: fix issue with empty archive test
and bsdtar) removed our commit hash to make it work with bsdtar, but
the test still fails on NetBSD and OpenBSD, which use their own tar
that considers a tar file containing only NULs as broken.

Here's what the different archivers do when asked to create a tar
file without entries:

	$ uname -v
	NetBSD 6.0.1 (GENERIC)
	$ gtar --version | head -1
	tar (GNU tar) 1.26
	$ bsdtar --version
	bsdtar 2.8.4 - libarchive 2.8.4

	$ : >zero.tar
	$ perl -e 'print "\0" x 10240' >tenk.tar
	$ sha1 zero.tar tenk.tar
	SHA1 (zero.tar) = da39a3ee5e6b4b0d3255bfef95601890afd80709
	SHA1 (tenk.tar) = 34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c

	$ : | tar cf - -T - | sha1
	da39a3ee5e6b4b0d3255bfef95601890afd80709
	$ : | gtar cf - -T - | sha1
	34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c
	$ : | bsdtar cf - -T - | sha1
	34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c

So NetBSD's native tar creates an empty file, while GNU tar and bsdtar
both give us 10KB of NULs -- just like git archive with an empty tree.
Now let's see how the archivers handle these two kinds of empty tar
files:
	
	$ tar tf zero.tar; echo $?
	tar: Unexpected EOF on archive file
	1
	$ gtar tf zero.tar; echo $?
	gtar: This does not look like a tar archive
	gtar: Exiting with failure status due to previous errors
	2
	$ bsdtar tf zero.tar; echo $?
	0

	$ tar tf tenk.tar; echo $?
	tar: Cannot identify format. Searching...
	tar: End of archive volume 1 reached
	tar: Sorry, unable to determine archive format.
	$ gtar tf tenk.tar; echo $?
	0
	$ bsdtar tf tenk.tar; echo $?
	0

NetBSD's tar complains about both, bsdtar happily accepts any of them
and GNU tar doesn't like zero-length archive files.  So the safest
course of action is to stay with our block-of-NULs format which is
compatible with GNU tar and bsdtar, as we can't make NetBSD's native
tar happy anyway.

We can simplify our test, however, by taking tar out of the picture.
Instead of extracting the archive and checking for the non-presence of
files, check if the file has a size of 10KB and contains only NULs.
This makes t5004 pass on NetBSD and OpenBSD.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Fixes a failure of a test added after v1.8.2.

 t/t5004-archive-corner-cases.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index ddf6e35..8d1bbd3 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -29,9 +29,8 @@ check_dir() {
 
 test_expect_success 'tar archive of empty tree is empty' '
 	git archive --format=tar HEAD: >empty.tar &&
-	make_dir extract &&
-	"$TAR" xf empty.tar -C extract &&
-	check_dir extract
+	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
+	test_cmp 10knuls.tar empty.tar
 '
 
 test_expect_success 'tar archive of empty tree with prefix' '
-- 
1.8.2.1
