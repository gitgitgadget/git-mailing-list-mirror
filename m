From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] parse_object: pass on the original sha1,
	not the replaced one
Date: Fri, 03 Sep 2010 22:51:53 +0200
Message-ID: <20100903205154.4894.4393.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 05:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orjmn-0007IT-Qd
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 05:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab0IDDvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 23:51:04 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58950 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab0IDDvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 23:51:03 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D66A7818050;
	Sat,  4 Sep 2010 05:50:56 +0200 (CEST)
X-git-sha1: 037997c5c2100718435bac664f14ef6091b15089 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155301>

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>

Commit 0e87c36 (object: call "check_sha1_signature" with the
replacement sha1) changed the first argument passed to
parse_object_buffer() from "sha1" to "repl". With that change,
the returned obj pointer has the replacement SHA1 in obj->sha1,
not the original one.

But when using lookup_commit() and then parse_commit() on a
commit, we get an object pointer with the original sha1, but
the commit content comes from the replacement commit.

So the result we get from using parse_object() is different
from the we get from using lookup_commit() followed by
parse_commit().

It looks much simpler and safer to fix this inconsistency by
passing "sha1" to parse_object_bufer() instead of "repl".

The commit comment should be used to tell the the replacement
commit is replacing another commit and why. So it should be
easy to see that we have a replacement commit instead of an
original one.

And it is not a problem if the content of the commit is not
consistent with the sha1 as cat-file piped to hash-object can
be used to see the difference.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The only change since previous version is that the test case
breakage in t6050 is fixed.

 object.c           |    2 +-
 t/t6050-replace.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 277b3dd..7adfda7 100644
--- a/object.c
+++ b/object.c
@@ -199,7 +199,7 @@ struct object *parse_object(const unsigned char *sha1)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(repl, type, size, buffer, &eaten);
+		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4185b7c..dd917d7 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -209,7 +209,7 @@ test_expect_success 'fetch branch with replacement' '
 
 test_expect_success 'bisect and replacements' '
      git bisect start $HASH7 $HASH1 &&
-     test "$S" = "$(git rev-parse --verify HEAD)" &&
+     test "$PARA3" = "$(git rev-parse --verify HEAD)" &&
      git bisect reset &&
      GIT_NO_REPLACE_OBJECTS=1 git bisect start $HASH7 $HASH1 &&
      test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
-- 
1.7.2.2.576.g2f52
