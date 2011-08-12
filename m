From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 50/56] t3030: fix accidental success in symlink rename
Date: Thu, 11 Aug 2011 23:20:23 -0600
Message-ID: <1313126429-17368-51-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD4-0005ix-5t
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab1HLFW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:27 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab1HLFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:23 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=llxsttEIgJROkl4Gk7Vfj4ajA9CdjTF9uZemz3EXQQE=;
        b=xb26HuJmFO6tAkTJi6titeEs7M2SMejOKcqO29216WwE0PxBWVqIiNI5PoH6Ry+vPJ
         H6s8EpvFpw6xsu4ZRzmTzjbVYxDO8k3+3nNato1SGRP+XKub6onR2eM2470ly5w+KyMR
         DmhogFunI9koEUovatbb1dsbKXB9legv2gSvY=
Received: by 10.42.19.74 with SMTP id a10mr508273icb.423.1313126543566;
        Thu, 11 Aug 2011 22:22:23 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.21
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179202>

From: Jeff King <peff@peff.net>

In this test, we have merge two branches. On one branch, we
renamed "a" to "e". On the other, we renamed "a" to "e" and
then added a symlink pointing at "a" pointing to "e".

The results for the test indicate that the merge should
succeed, but also that "a" should no longer exist. Since
both sides renamed "a" to the same destination, we will end
up comparing those destinations for content.

But what about what's left? One side (the rename only),
replaced "a" with nothing. The other side replaced it with a
symlink. The common base must also be nothing, because any
"a" before this was meaningless (it was totally unrelated
content that ended up getting renamed).

The only sensible resolution is to keep the symlink. The
rename-only side didn't touch the content versus the common
base, and the other side added content. The 3-way merge
dictates that we take the side with a change.

And this gives the overall merge an intuitive result.  One
side made one change (a rename), and the other side made two
changes: an identical rename, and an addition (that just
happened to be at the same spot). The end result should
contain both changes.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
This patch was not part of v1, but Junio pulled it out of a separate
series and combined it.

 t/t3030-merge-recursive.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 0c02d56..55ef189 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -267,7 +267,8 @@ test_expect_success 'setup 8' '
 		ln -s e a &&
 		git add a e &&
 		test_tick &&
-		git commit -m "rename a->e, symlink a->e"
+		git commit -m "rename a->e, symlink a->e" &&
+		oln=`printf e | git hash-object --stdin`
 	fi
 '
 
@@ -630,16 +631,18 @@ test_expect_success 'merge-recursive copy vs. rename' '
 
 if test_have_prereq SYMLINKS
 then
-	test_expect_success 'merge-recursive rename vs. rename/symlink' '
+	test_expect_failure 'merge-recursive rename vs. rename/symlink' '
 
 		git checkout -f rename &&
 		git merge rename-ln &&
 		( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 		(
+			echo "120000 blob $oln	a"
 			echo "100644 blob $o0	b"
 			echo "100644 blob $o0	c"
 			echo "100644 blob $o0	d/e"
 			echo "100644 blob $o0	e"
+			echo "120000 $oln 0	a"
 			echo "100644 $o0 0	b"
 			echo "100644 $o0 0	c"
 			echo "100644 $o0 0	d/e"
-- 
1.7.6.100.gac5c1
