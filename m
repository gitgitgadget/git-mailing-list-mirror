From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v4] Replace memcpy with hashcpy when dealing hash copy globally
Date: Thu,  6 Mar 2014 17:11:24 +0800
Message-ID: <1394097084-3129-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, pclouds@gmail.com, gitster@pobox.com,
	Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 10:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLUMt-0006bH-H5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 10:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaCFJNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 04:13:25 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:51401 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaCFJNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 04:13:21 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so2297157pde.29
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 01:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=175ITCaTSip7yTZJczixFie2jK5anmWCMCaEMQ+jOxI=;
        b=ODpY2i2wkVqPo6IGwTRGfeHjXoqDLZEn+pSgu9jtMJWt2YIAWkBcXZNxUIPZJBiB3i
         pz+9p/zlRphxsrOA74zNah4zSwypNHo7tQ7F3MJ+LkeRMfFfOusJ1RrV31zMepzQ7kAY
         nxPVzYWU93mKXwlaJLDJjq9jitPIXr28Fd7/c/50WifufUawtTB0M1n4cse8J+ptGviK
         P9XLdN6Fy/ik+JElkyC7e9/CoKAe8VwfksmkSxMMdELVSMVSeNdd9Gqr9XpNNzwwVkdv
         Vma2t89aCxyfmaOuJ485wMGiXPubdxB56ZKXyy/QBqTTEx29BQvxYELR32jRy6ivLUyE
         stBg==
X-Received: by 10.68.171.229 with SMTP id ax5mr12854015pbc.125.1394097200190;
        Thu, 06 Mar 2014 01:13:20 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id hc4sm17513606pbc.29.2014.03.06.01.13.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 01:13:19 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243505>

hashcpy() can keep the abstraction of "object name" behind it.
Use it instead of memcpy() with hard-coded 20-byte length when
moving object names between pieces of memory.
We can benefit from it, when we switch to another hash algorithm,
eg. MD5, by just fixing the hashcpy().

Leave ppc/sha1.c as it is, because the function is about the
SHA-1 hash algorithm whose output is and will always be 20-byte.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sun He <sunheehnus@gmail.com>
---
PATCH v4 changed the reason why should take this patch as tutored by
Junio C Hamano.
 Thanks to Junio C Hamano

PATCH v3 delete the one-space indentation on each line of commit message
as is suggested by Eric Sunshine.
 Thanks to Eric Sunshine.

PATCH v2 leave ppc/sha1.c alone.

The general rule is if cache.h or git-compat-util.h is included,
it is the first #include, and system includes will be always in
git-compat-tuil.h.
       				via Duy Nguyen

The change in PATCH v1 is not proper because I placed cache.h
in the end.
And adding it to the head is not a good way to achieve the goal,
as is said above "---".
 Thanks to Duy Nguyen.

Find the potential places with memcpy by the bash command:
 $ git grep 'memcpy.*20'
 Thanks to Junio C Hamano

 bundle.c            | 2 +-
 grep.c              | 2 +-
 pack-bitmap-write.c | 2 +-
 reflog-walk.c       | 4 ++--
 refs.c              | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
