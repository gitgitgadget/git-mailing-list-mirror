From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/10] Introduce lookup_replace_object_extended() to pass
 flags
Date: Sat, 28 Dec 2013 12:00:08 +0100
Message-ID: <20131228110016.2272.47632.chriscool@tuxfamily.org>
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
	id 1VwreE-0007rw-QG
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab3L1LBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:23 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:34562 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab3L1LAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:48 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 61BA051;
	Sat, 28 Dec 2013 12:00:47 +0100 (CET)
X-git-sha1: 723d0efc21fc38c6279d4e9cb26f5192ed30f71e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239780>

Currently, there is only one caller to lookup_replace_object()
that can benefit from passing it some flags, but we expect
that there could be more.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 6 ++++++
 sha1_file.c | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 873a6b5..563f85f 100644
--- a/cache.h
+++ b/cache.h
@@ -773,6 +773,12 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
+{
+	if (! (flag & LOOKUP_REPLACE_OBJECT))
+		return sha1;
+	return lookup_replace_object(sha1);
+}
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/sha1_file.c b/sha1_file.c
index 76e9f32..4fb2f17 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2591,8 +2591,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	void *data;
 	char *path;
 	const struct packed_git *p;
-	const unsigned char *repl = (flag & LOOKUP_REPLACE_OBJECT)
-		? lookup_replace_object(sha1) : sha1;
+	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
 
 	errno = 0;
 	data = read_object(repl, type, size);
-- 
1.8.4.1.616.g07f5c81
