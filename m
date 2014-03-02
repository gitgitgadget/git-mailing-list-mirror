From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v2] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sun,  2 Mar 2014 17:37:24 +0800
Message-ID: <1393753044-6232-1-git-send-email-sunheehnus@gmail.com>
Cc: pclouds@gmail.com, mhagger@alum.mit.edu,
	Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 10:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK2rm-0005Po-FS
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 10:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbaCBJiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 04:38:50 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34409 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaCBJiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 04:38:46 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so2558380pbb.22
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lfg/S6ODMNoKxxF6Zvj4BkNayVJ3YlSUo5DSU/9e8xQ=;
        b=Ci4M5CVy8CVPCv1O0RPogIz7tCD0v6ydNUGNQffLcrQe3MBBB7ofkWiE0Haqt4a0fn
         LEFTXC9O7wqeQY34MnRhPuiXD7eFW+0GiRsh6v9+S2K2/BMKrQsz3I+WBdvzlOyIc3wM
         /HGz86QcBrvFu+JGHAhpsrOsH9kNZOJlGnryaoneRztosHXpbI3wNkBKuM524PFbbzSj
         aMlBX82Z2t52bmFJZCPgaF3e7YFg2YNLintBaH1kT5TuBFKepzhlwQKL/FmdS6EYL5gC
         fyvppo7zXCjfJ9aNVkKrYirqgqF7yirlvew/uY+Sqh7J6VkuSX0wlFKdYEiqHHYIwlgr
         /ygw==
X-Received: by 10.66.118.71 with SMTP id kk7mr13359638pab.14.1393753125923;
        Sun, 02 Mar 2014 01:38:45 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id om6sm23823622pbc.43.2014.03.02.01.38.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Mar 2014 01:38:44 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243146>

 Replacing memcpy with hashcpy is more directly and elegant.

 Leave ppc/sha1.c alone, as it is an isolated component.
 Pull cache.h(actually ../cache.h) in just for one memcpy
 there is not proper.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Sun He <sunheehnus@gmail.com>
---

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
  $ find . | xargs grep "memcpy.*\(.*20.*\)"


 ppc/sha1.c doesn't include cache.h and it cannot use 
 So just leave memcpy(in ppc/sha1.c) alone

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
