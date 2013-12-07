From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/10] sha1_file: perform object replacement in
 sha1_object_info_extended()
Date: Sat, 07 Dec 2013 17:21:01 +0100
Message-ID: <20131207162106.21478.38769.chriscool@tuxfamily.org>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:22:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKe2-0004xp-II
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab3LGQWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:22:06 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:44310 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758762Ab3LGQVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:21:50 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5079A47;
	Sat,  7 Dec 2013 17:21:49 +0100 (CET)
X-git-sha1: 988da9af9df106b28670183febbb605e673b4147 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238995>

sha1_object_info_extended() should perform object replacement
if it is needed.

The simplest way to do that is to make it call
lookup_replace_object_extended().

And now its "unsigned flags" parameter is used as it is passed
to lookup_replace_object_extended().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1_file.c        | 13 +++++++------
 t/t6050-replace.sh |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 482037e..ee224e4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2448,8 +2448,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
-	co = find_cached_object(sha1);
+	co = find_cached_object(real);
 	if (co) {
 		if (oi->typep)
 			*(oi->typep) = co->type;
@@ -2461,23 +2462,23 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		return 0;
 	}
 
-	if (!find_pack_entry(sha1, &e)) {
+	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(sha1, oi)) {
+		if (!sha1_loose_object_info(real, oi)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e))
+		if (!find_pack_entry(real, &e))
 			return -1;
 	}
 
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
-		mark_bad_packed_object(e.p, sha1);
-		return sha1_object_info_extended(sha1, oi, 0);
+		mark_bad_packed_object(e.p, real);
+		return sha1_object_info_extended(real, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index b90dbdc..bb785ec 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,7 +276,7 @@ test_expect_success '-f option bypasses the type check' '
 	git replace -f HEAD^ $BLOB
 '
 
-test_expect_failure 'git cat-file --batch works on replace objects' '
+test_expect_success 'git cat-file --batch works on replace objects' '
 	git replace | grep $PARA3 &&
 	echo $PARA3 | git cat-file --batch
 '
-- 
1.8.5.1.102.g090758b
