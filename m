From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: tar on Mac does not like empty tar from git archive
Date: Wed, 10 Apr 2013 19:00:20 +0200
Message-ID: <51659AA4.80203@lsrfire.ath.cx>
References: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPyO0-0006sk-78
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987Ab3DJRA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 13:00:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:47523 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab3DJRA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:00:26 -0400
Received: from [192.168.2.105] (p4FFD9211.dip.t-dialin.net [79.253.146.17])
	by india601.server4you.de (Postfix) with ESMTPSA id C064C1E5;
	Wed, 10 Apr 2013 19:00:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220705>

Am 08.04.2013 20:36, schrieb BJ Hargrave:
> Git 1.8.2.1 includes commit bd54cf17 - archive: handle commits with
> an empty tree
> 
> Test 2 of t5004-archive-corner-cases, "tar archive of empty tree is
> empty", fails on Mac OS X 10.8.3 (with XCode 4.6.1) since the tar
> command exits with return code 1 on the generated tar file.
> 
> expecting success:
> 	git archive --format=tar HEAD >empty.tar &&
> 	make_dir extract &&
> 	"$TAR" xf empty.tar -C extract &&
> 	check_dir extract
> 
> tar: Damaged tar archive
> tar: Error exit delayed from previous errors.
> not ok 2 - tar archive of empty tree is empty
> 
> tar tf "trash directory.t5004-archive-corner-cases/empty.tar"; echo $?
> tar: Damaged tar archive
> tar: Error exit delayed from previous errors.
> 1
> 
> tar --version
> bsdtar 2.8.3 - libarchive 2.8.3
> 
> It appears that bsdtar does not like the empty tar files created by
> git archive. An empty tar file created by bsdtar is accepted.
> 
> tar cT /dev/null | tar t; echo $?
> 0

I've opened an issue for libarchive for that behaviour:
http://code.google.com/p/libarchive/issues/detail?id=314

We can work around bsdtar's dislike of not-quite-empty tar archives by
leaving out the comment that contains the commit hash.

-- >8 --
Subject: t5004: fix issue with empty archive test and bsdtar

bsdtar, which is the default tar on Mac OS X, handles empty archives
just fine but reports archives containing only a pax extended header
comment as damaged.  Work around the issue by explicitly generating
the archive for the tree and not the commit, which causes git archive
to omit the commit hash comment record from the tar file.

Reported-by: BJ Hargrave <bj@bjhargrave.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5004-archive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index cdb7d7a..bfdb56a 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -28,7 +28,7 @@ check_dir() {
 }
 
 test_expect_success 'tar archive of empty tree is empty' '
-	git archive --format=tar HEAD >empty.tar &&
+	git archive --format=tar HEAD: >empty.tar &&
 	make_dir extract &&
 	"$TAR" xf empty.tar -C extract &&
 	check_dir extract
-- 
1.8.2.1
