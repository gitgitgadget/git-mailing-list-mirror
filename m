From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] teach ce_compare_gitlink() about OBJ_LINK
Date: Fri,  5 Apr 2013 00:00:39 +0530
Message-ID: <1365100243-13676-4-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNov1-0007TW-1h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764542Ab3DDS3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:22 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64836 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764537Ab3DDS3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1614048pab.38
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pEiBeq0ZH/tZBRhjGZEM88LlzzTlGnuMTiW5rIq0kZg=;
        b=iwcxxxJxToeCBFVS07uS0iHs24cbQkKOse4zV0MZ23Y8LVbumJH9mLDoGAlL5o9RTi
         c/xkwh2p0E5b+JF6BVK8ThJLe8lmIydxQxBcdlcNhqOYxq3pxIXGkWOpuTH/cMRT9f5N
         Eugmgh3y1llcdOeK192xJA9Yt+yCK+fPJ2LuiCkJk670XvwdNGuysYk3DhgqHCCswXxJ
         SDjZEC9hx7mtJRqUxGnMjGHaZxGYFIRo6dipPQDHSSTCl5aVRnpFoI+jV/A0Y47jJcp6
         oZfp4X31An8rxa/aOm0Buxpu8ze3qlAF0U5srDnmIB12NgW9vKra2lRghfsbEsgElUV9
         FndA==
X-Received: by 10.68.59.199 with SMTP id b7mr10392299pbr.167.1365100159983;
        Thu, 04 Apr 2013 11:29:19 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220048>

This simply requires parsing out the checkout_rev from the link
object, and comparing its SHA-1 with that of HEAD.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 read-cache.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5a9704f..f22c1c0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -11,6 +11,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
+#include "link.h"
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
@@ -128,19 +129,31 @@ static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
 
 static int ce_compare_gitlink(struct cache_entry *ce)
 {
-	unsigned char sha1[20];
+	unsigned char checkout_rev_sha1[20], head_sha1[20];
+	void *buffer;
+	unsigned long size;
+	enum object_type type;
+	struct link link;
 
-	/*
-	 * We don't actually require that the .git directory
-	 * under GITLINK directory be a valid git directory. It
-	 * might even be missing (in case nobody populated that
-	 * sub-project).
-	 *
-	 * If so, we consider it always to match.
+	buffer = read_sha1_file(ce->sha1, &type, &size);
+
+	/* For compatibility with an older version: earlier, gitlinks
+	 * were represented as commit SHA-1s (that wouldn't resolve)
+	 * in the cache.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
+	if (!buffer) {
+		if (resolve_gitlink_ref(ce->name, "HEAD", head_sha1) < 0)
+			return 0;
+		return hashcmp(head_sha1, ce->sha1);
+	}
+
+	memset(&link, 0, sizeof(struct link));
+	if (parse_link_buffer(&link, buffer, size) < 0)
+		die("Cannot continue.");
+	if (resolve_gitlink_ref(ce->name, link.checkout_rev, checkout_rev_sha1) < 0 ||
+		resolve_gitlink_ref(ce->name, "HEAD", head_sha1) < 0)
 		return 0;
-	return hashcmp(sha1, ce->sha1);
+	return hashcmp(head_sha1, checkout_rev_sha1);
 }
 
 static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
-- 
1.8.2.380.g0d4e79b
