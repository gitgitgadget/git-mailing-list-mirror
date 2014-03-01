From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat,  1 Mar 2014 09:07:04 +0800
Message-ID: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 02:08:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJYPo-0005OJ-3E
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 02:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbaCABI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 20:08:27 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40704 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbaCABI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 20:08:26 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so1473488pab.34
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 17:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LpBZbje6z4bpueRN2LqHbQi0bHYAPPlL6mp3tKB7l/Q=;
        b=kVVkpyZNXrB++1cZ3c11R37Qc4PmTnjqzNXghia3495EoKmQm0OrPwruEFmWfEKsaf
         zHegYMjytHuZVTjtRpFWmlSFMm+bur6VnFsHjWjvr3oVKgeMsLuUROyxiXq9YzhcqNP0
         UybP620Q0TDwcNmj1LpzGMJs51BCwXgpXOKNCcrZ6bMhTjTmeuLU46erqcFcYJlDH02M
         FvhyInc1cgM5I68dprxHG8QuwKGwslZuOx7XgdOtkplTO1H+3BrE7i8z/HJW5qoJ+byB
         nqfl+gYWz5qomWoPFXvKVfCh3+ru3dOagzLJGWwKIGKXcZvTRFqOynoDs4ju9xW0cb4B
         lqsQ==
X-Received: by 10.66.136.229 with SMTP id qd5mr6922171pab.118.1393636106413;
        Fri, 28 Feb 2014 17:08:26 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id hb10sm10509755pbd.1.2014.02.28.17.08.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 17:08:25 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243034>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 Find the potential places with memcpy by the bash command:
   $ find . | xargs grep "memcpy.*\(.*20.*\)"

 Helped-by: Michael Haggerty<mhagger@alum.mit.edu>

 bundle.c            | 2 +-
 grep.c              | 2 +-
 pack-bitmap-write.c | 2 +-
 ppc/sha1.c          | 3 ++-
 reflog-walk.c       | 4 ++--
 refs.c              | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/bundle.c b/bundle.c
index e99065c..7809fbb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		list->list = xrealloc(list->list,
 				list->alloc * sizeof(list->list[0]));
 	}
-	memcpy(list->list[list->nr].sha1, sha1, 20);
+	hashcpy(list->list[list->nr].sha1, sha1);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
 }
diff --git a/grep.c b/grep.c
index c668034..f5101f7 100644
--- a/grep.c
+++ b/grep.c
@@ -1650,7 +1650,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		break;
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
-		memcpy(gs->identifier, identifier, 20);
+		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1218bef..5f1791a 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -530,7 +530,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	header.version = htons(default_version);
 	header.options = htons(flags | options);
 	header.entry_count = htonl(writer.selected_nr);
-	memcpy(header.checksum, writer.pack_checksum, 20);
+	hashcpy(header.checksum, writer.pack_checksum);
 
 	sha1write(f, &header, sizeof(header));
 	dump_bitmap(f, writer.commits);
diff --git a/ppc/sha1.c b/ppc/sha1.c
index ec6a192..8a87fea 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <string.h>
 #include "sha1.h"
+#include "cache.h"
 
 extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
 			  unsigned int nblocks);
@@ -67,6 +68,6 @@ int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
 		memset(&c->buf.b[cnt], 0, 56 - cnt);
 	c->buf.l[7] = c->len;
 	ppc_sha1_core(c->hash, c->buf.b, 1);
-	memcpy(hash, c->hash, 20);
+	hashcpy(hash, c->hash);
 	return 0;
 }
diff --git a/reflog-walk.c b/reflog-walk.c
index b2fbdb2..d490f7d 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -32,8 +32,8 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 			sizeof(struct reflog_info));
 	}
 	item = array->items + array->nr;
-	memcpy(item->osha1, osha1, 20);
-	memcpy(item->nsha1, nsha1, 20);
+	hashcpy(item->osha1, osha1);
+	hashcpy(item->nsha1, nsha1);
 	item->email = xstrdup(email);
 	item->timestamp = timestamp;
 	item->tz = tz;
diff --git a/refs.c b/refs.c
index 89228e2..f90b7ea 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,7 +1222,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	if (ref == NULL)
 		return -1;
 
-	memcpy(sha1, ref->u.value.sha1, 20);
+	hashcpy(sha1, ref->u.value.sha1);
 	return 0;
 }
 
-- 
1.9.0.138.g2de3478.dirty
