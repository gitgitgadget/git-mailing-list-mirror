From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] Add an "unsigned flags" parameter to
 sha1_object_info_extended()
Date: Sat, 30 Nov 2013 14:51:21 +0100
Message-ID: <20131130135124.2697.9050.chriscool@tuxfamily.org>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 14:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmkyB-0004gz-4T
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 14:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3K3NwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 08:52:23 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:45366 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab3K3NwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 08:52:08 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 86A7C158;
	Sat, 30 Nov 2013 14:52:07 +0100 (CET)
X-git-sha1: 631b74c17abb6aba1f7e311648eaaef1b7167212 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238563>

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
index b2ca775..a2d3a9b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -238,7 +238,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		return 0;
 	}
 
-	if (sha1_object_info_extended(data->sha1, &data->info) < 0) {
+	if (sha1_object_info_extended(data->sha1, &data->info, READ_SHA1_FILE_REPLACE) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
diff --git a/cache.h b/cache.h
index b845485..3be03dc 100644
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
index b0a3964..09e56ef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2514,7 +2514,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
+int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	struct cached_object *co;
 	struct pack_entry e;
@@ -2548,7 +2548,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		return sha1_object_info_extended(sha1, oi);
+		return sha1_object_info_extended(sha1, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
@@ -2570,7 +2570,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi) < 0)
+	if (sha1_object_info_extended(sha1, &oi, READ_SHA1_FILE_REPLACE) < 0)
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
1.8.4.1.561.g12affca
