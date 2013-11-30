From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] introduce lookup_replace_object_extended() to pass flags
Date: Sat, 30 Nov 2013 14:51:20 +0100
Message-ID: <20131130135124.2697.42059.chriscool@tuxfamily.org>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 14:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmkxy-0004XU-SU
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 14:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab3K3NwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 08:52:11 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:60489 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3K3NwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 08:52:08 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 20CE565;
	Sat, 30 Nov 2013 14:52:07 +0100 (CET)
X-git-sha1: 53b297ff8911cfed002e13b471bdbb6b6acbcb35 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238559>

Currently, there is only one caller to lookup_replace_object()
that can benefit from passing it some flags, but we expect
that there could be more.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 6 ++++++
 sha1_file.c | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..b845485 100644
--- a/cache.h
+++ b/cache.h
@@ -773,6 +773,12 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
+{
+	if (! (flag & READ_SHA1_FILE_REPLACE))
+		return sha1;
+	return lookup_replace_object(sha1);
+}
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/sha1_file.c b/sha1_file.c
index 7dadd04..b0a3964 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2662,8 +2662,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	void *data;
 	char *path;
 	const struct packed_git *p;
-	const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
-		? lookup_replace_object(sha1) : sha1;
+	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
 
 	errno = 0;
 	data = read_object(repl, type, size);
-- 
1.8.4.1.561.g12affca
