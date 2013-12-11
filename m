From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/10] Introduce lookup_replace_object_extended() to pass
 flags
Date: Wed, 11 Dec 2013 08:46:06 +0100
Message-ID: <20131211074614.11117.57158.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWP-0007lg-Th
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab3LKHrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:47:51 -0500
Received: from [194.158.98.45] ([194.158.98.45]:37577 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751183Ab3LKHrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:48 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 74D2860;
	Wed, 11 Dec 2013 08:47:27 +0100 (CET)
X-git-sha1: 723d0efc21fc38c6279d4e9cb26f5192ed30f71e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239172>

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
1.8.5.1.102.g090758b
