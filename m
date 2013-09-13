From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] name-hash: stop storing trailing '/' on paths in index_state.dir_hash
Date: Fri, 13 Sep 2013 07:15:42 -0400
Message-ID: <1379070943-36595-3-git-send-email-sunshine@sunshineco.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 13:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRMR-0000lU-J4
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3IMLQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:16:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57876 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3IMLQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:16:21 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so985629oag.5
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AvbY5dqX9cHl0MElq2puepmAZn0P7FBEMYAD/gjG2/M=;
        b=szO2xKRv8W+uOz40/+fzTI5aYpMuVHfv1HtG+5a6dPmQiSIALp6ewJiWpkOx5eZxqI
         WFsHTIuqZ6n9G9TZT2oootXuAK6rrif7QPjzwHmYsUP4xlMIpkj7J8h2jqMkQytjPto1
         C9Fb/YuR3yk9xJ5rQT62thToYjgJZuSGqYDGWhUs2xF+lubpvOBFMbeccjRP1hGVdEvK
         8EWvT82QeTaEoNEkhIbM3Z90A2oeqhWJk4a/KU1fte9UWTFy9B6qD9MIr34ESNbXjFJj
         jrenOPWbHksRL0UmX8iwP9kL7e/aBLchsyEHa7qY8KtL4Ui0tdRc69RyxiDj0Nay5Ovb
         QiLQ==
X-Received: by 10.60.63.68 with SMTP id e4mr11605955oes.23.1379070980354;
        Fri, 13 Sep 2013 04:16:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id it7sm13049040obb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 04:16:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.457.g424cb08
In-Reply-To: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234744>

When 5102c617 (Add case insensitivity support for directories when using
git status, 2010-10-03) added directories to the name-hash there was
only a single hash table in which both real cache entries and leading
directory prefixes were registered. To distinguish between the two types
of entries, directories were stored with a trailing '/'.

2092678c (name-hash.c: fix endless loop with core.ignorecase=true,
2013-02-28), however, moved directories to a separate hash table
(index_state.dir_hash) but retained the now-redundant trailing '/', thus
callers still bear the burden of ensuring its presence before searching
via index_dir_exists(). Eliminate this redundancy by storing paths in
the dir-hash without the trailing '/'.

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
 dir.c        | 2 +-
 name-hash.c  | 9 +++++----
 read-cache.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 0080673..69d04a0 100644
--- a/dir.c
+++ b/dir.c
@@ -890,7 +890,7 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	const struct cache_entry *ce = cache_dir_exists(dirname, len + 1);
+	const struct cache_entry *ce = cache_dir_exists(dirname, len);
 	unsigned char endchar;
 
 	if (!ce)
diff --git a/name-hash.c b/name-hash.c
index 5b01554..2bae75d 100644
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
-	ce = index_name_exists(istate, name, namelen - 1, 1);
+	ce = index_name_exists(istate, name, namelen, 1);
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return ce;
 
diff --git a/read-cache.c b/read-cache.c
index a59644a..8990b61 100644
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
1.8.4.457.g424cb08
