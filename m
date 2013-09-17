From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] name-hash: stop storing trailing '/' on paths in index_state.dir_hash
Date: Tue, 17 Sep 2013 03:06:16 -0400
Message-ID: <1379401577-36799-4-git-send-email-sunshine@sunshineco.com>
References: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 09:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpNB-0002IA-UG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3IQHGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:06:50 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62126 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab3IQHGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:06:46 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so4877050obb.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QPyG9IDO2a7vTK8NKDhfhwiODEV8kHPBR6tDAh8ANs=;
        b=M9gZd7aTPzmmP1/YUFQn6OyKwAuSIMRhDkmDuV+aAkl2mkdUapzihZt5wuayI2H+/m
         85gU+lGissoB2bpH8pUw0agAXOsroR5hWyUKmDRNIGP7i0XMJP0g2arLAKYpXlbRkXQV
         4umbGTBWEej516aIiq0I7pBQK86+zVmTlWAJRy5dxWw1TZXcT/3LcRQFR33JqmvgaJsp
         GG57JiG5PwC4M9XzZ8QA8iAd3wmafMDkoADYx3xOZBebYg3PVmuD22YxeJgWAcdIRkLQ
         +8IpsYGzvcvE3Mk20IRD60Y43mFKIO0/R5JiNveoA71u1kOPVqy7EIqYmdKwLBN6amIH
         l1xw==
X-Received: by 10.182.61.44 with SMTP id m12mr3452434obr.52.1379401605643;
        Tue, 17 Sep 2013 00:06:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm37304079oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 00:06:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
In-Reply-To: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234855>

When 5102c617 (Add case insensitivity support for directories when using
git status, 2010-10-03) added directories to the name-hash there was
only a single hash table in which both real cache entries and leading
directory prefixes were registered. To distinguish between the two types
of entries, directories were stored with a trailing '/'.

2092678c (name-hash.c: fix endless loop with core.ignorecase=true,
2013-02-28), however, moved directories to a separate hash table
(index_state.dir_hash) but retained the (now) redundant trailing '/',
thus callers continue to bear the burden of ensuring the slash's
presence before searching the index for a directory. Eliminate this
redundancy by storing paths in the dir-hash without the trailing '/'.

An important benefit of this change is that it eliminates undocumented
and dangerous behavior of dir.c:directory_exists_in_index_icase() in
which it assumes not only that it can validly access one character
beyond the end of its incoming directory argument, but also that that
character will unconditionally be a '/'. This perilous behavior was
"tolerated" because the string passed in by its lone caller always had a
'/' in that position, however, things broke [1] when 2eac2a4c (ls-files
-k: a directory only can be killed if the index has a non-directory,
2013-08-15) added a new caller which failed to respect the undocumented
assumption.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232727

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c        |  2 +-
 name-hash.c  | 11 ++++++-----
 read-cache.c |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index a8401b9..fccd479 100644
--- a/dir.c
+++ b/dir.c
@@ -889,7 +889,7 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	const struct cache_entry *ce = cache_dir_exists(dirname, len + 1);
+	const struct cache_entry *ce = cache_dir_exists(dirname, len);
 	unsigned char endchar;
 
 	if (!ce)
diff --git a/name-hash.c b/name-hash.c
index f06b049..e5b6e1a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -58,9 +58,9 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 {
 	/*
 	 * Throw each directory component in the hash for quick lookup
-	 * during a git status. Directory components are stored with their
+	 * during a git status. Directory components are stored without their
 	 * closing slash.  Despite submodules being a directory, they never
-	 * reach this point, because they are stored without a closing slash
+	 * reach this point, because they are stored
 	 * in index_state.name_hash (as ordinary cache_entries).
 	 *
 	 * Note that the cache_entry stored with the dir_entry merely
@@ -78,6 +78,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		namelen--;
 	if (namelen <= 0)
 		return NULL;
+	namelen--;
 
 	/* lookup existing entry for that directory */
 	dir = find_dir_entry(istate, ce->name, namelen);
@@ -97,7 +98,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		}
 
 		/* recursively add missing parent directories */
-		dir->parent = hash_dir_entry(istate, ce, namelen - 1);
+		dir->parent = hash_dir_entry(istate, ce, namelen);
 	}
 	return dir;
 }
@@ -237,7 +238,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 	 * in the dir-hash, submodules are stored in the name-hash, so check
 	 * there, as well.
 	 */
-	ce = index_file_exists(istate, name, namelen - 1, 1);
+	ce = index_file_exists(istate, name, namelen, 1);
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return ce;
 
@@ -265,7 +266,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	if (namelen > 0 && name[namelen - 1] == '/')
-		return index_dir_exists(istate, name, namelen);
+		return index_dir_exists(istate, name, namelen - 1);
 	return index_file_exists(istate, name, namelen, icase);
 }
 
diff --git a/read-cache.c b/read-cache.c
index b8d3759..e25de32 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -643,7 +643,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			if (*ptr == '/') {
 				struct cache_entry *foundce;
 				++ptr;
-				foundce = index_dir_exists(istate, ce->name, ptr - ce->name);
+				foundce = index_dir_exists(istate, ce->name, ptr - ce->name - 1);
 				if (foundce) {
 					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
 					startPtr = ptr;
-- 
1.8.4.535.g7b94f8e
