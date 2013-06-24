From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 02/16] sha1_file: refactor into `find_pack_object_pos`
Date: Tue, 25 Jun 2013 01:22:59 +0200
Message-ID: <1372116193-32762-3-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG6z-00037D-N2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab3FXXXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:45 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46040 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab3FXXXm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:42 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so9000547wgh.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=in8rRefxeGN7YU8Lz5SajX1G4A/hVu65BknC1vT2P18=;
        b=ZMazmh2HqBDoPi4TP5BNdZgqvqmKI1bY9tWwq3Aa9kihPoIoOEMQLLbi582Dgssi4z
         G4qPCrYN7E+n7/wcn13U+r7taXcz5+Gf5vltYc+B+ilnBJGXtEk1EGP3GfhYsxjfJoEr
         DtMsg6vwDx2j2h0qGyrNTbZ5KAbIgL2Qfposu8WXc9A5HBTcmN0Fed75snj/zAfk9q/e
         3HtGXmpbO2haq37H3/9uFLepB/lZNS5bMCHrFPiYJjOT+HbpJAnmqS1ck9frfs4pfgzp
         zf4KgYfnBm2gm7L781uO0emfeH83J+2VtQovM/hS0MoYumv66yki1sGR502Cup8Tcx3R
         Px9Q==
X-Received: by 10.180.206.70 with SMTP id lm6mr7441564wic.50.1372116221519;
        Mon, 24 Jun 2013 16:23:41 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228920>

Looking up the offset in the packfile for a given SHA1 involves the
following:

	- Finding the position in the index for the given SHA1
	- Accessing the offset cache in the index for the found position

There are cases however where we'd like to find the position of a SHA1
in the index without looking up the packfile offset (e.g. when accessing
information that has been indexed based on index offsets).

This refactoring implements `find_pack_object_pos`, returning the
position in the index, and re-implements `find_pack_entry_one`(returning
the actual offset in the packfile) to use the new function.
---
 cache.h     |    1 +
 sha1_file.c |   27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index ec8240f..a29645e 100644
--- a/cache.h
+++ b/cache.h
@@ -1101,6 +1101,7 @@ extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
+extern int find_pack_entry_pos(const unsigned char *sha1, struct packed_git *p);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
diff --git a/sha1_file.c b/sha1_file.c
index 0af19c0..371e295 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2205,8 +2205,7 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+int find_pack_entry_pos(const unsigned char *sha1, struct packed_git *p)
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
@@ -2219,7 +2218,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 
 	if (!index) {
 		if (open_pack_index(p))
-			return 0;
+			return -1;
 		level1_ofs = p->index_data;
 		index = p->index_data;
 	}
@@ -2243,12 +2242,9 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 
 	if (use_lookup < 0)
 		use_lookup = !!getenv("GIT_USE_LOOKUP");
+
 	if (use_lookup) {
-		int pos = sha1_entry_pos(index, stride, 0,
-					 lo, hi, p->num_objects, sha1);
-		if (pos < 0)
-			return 0;
-		return nth_packed_object_offset(p, pos);
+		return sha1_entry_pos(index, stride, 0, lo, hi, p->num_objects, sha1);
 	}
 
 	do {
@@ -2259,13 +2255,24 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			printf("lo %u hi %u rg %u mi %u\n",
 			       lo, hi, hi - lo, mi);
 		if (!cmp)
-			return nth_packed_object_offset(p, mi);
+			return mi;
 		if (cmp > 0)
 			hi = mi;
 		else
 			lo = mi+1;
 	} while (lo < hi);
-	return 0;
+
+	return -1;
+}
+
+off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *p)
+{
+	int pos;
+
+	if ((pos = find_pack_entry_pos(sha1, p)) < 0)
+		return 0;
+
+	return nth_packed_object_offset(p, (uint32_t)pos);
 }
 
 int is_pack_valid(struct packed_git *p)
-- 
1.7.9.5
