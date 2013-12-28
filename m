From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/10] Add an "unsigned flags" parameter to
 sha1_object_info_extended()
Date: Sat, 28 Dec 2013 12:00:09 +0100
Message-ID: <20131228110016.2272.20738.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreE-0007rw-8w
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab3L1LBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:22 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:34573 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562Ab3L1LAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:48 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id CA34A5F;
	Sat, 28 Dec 2013 12:00:47 +0100 (CET)
X-git-sha1: f621b1381dac4f4bdabf3f2dbcaafee501ed757e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239778>

This parameter is not used yet, but it will be used to tell
sha1_object_info_extended() if it should perform object
replacement or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/cat-file.c | 2 +-
 cache.h            | 2 +-
 sha1_file.c        | 6 +++---
 streaming.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..b15c064 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -238,7 +238,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		return 0;
 	}
 
-	if (sha1_object_info_extended(data->sha1, &data->info) < 0) {
+	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
diff --git a/cache.h b/cache.h
index 563f85f..701e42c 100644
--- a/cache.h
+++ b/cache.h
@@ -1104,7 +1104,7 @@ struct object_info {
 		} packed;
 	} u;
 };
-extern int sha1_object_info_extended(const unsigned char *, struct object_info *);
+extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 4fb2f17..482037e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2443,7 +2443,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
+int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	struct cached_object *co;
 	struct pack_entry e;
@@ -2477,7 +2477,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		return sha1_object_info_extended(sha1, oi);
+		return sha1_object_info_extended(sha1, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
@@ -2499,7 +2499,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi) < 0)
+	if (sha1_object_info_extended(sha1, &oi, LOOKUP_REPLACE_OBJECT) < 0)
 		return -1;
 	return type;
 }
diff --git a/streaming.c b/streaming.c
index debe904..9659f18 100644
--- a/streaming.c
+++ b/streaming.c
@@ -113,7 +113,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = sha1_object_info_extended(sha1, oi);
+	status = sha1_object_info_extended(sha1, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
1.8.4.1.616.g07f5c81
