From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] name-hash: refactor polymorphic index_name_exists()
Date: Tue, 17 Sep 2013 03:06:14 -0400
Message-ID: <1379401577-36799-2-git-send-email-sunshine@sunshineco.com>
References: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 09:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpN5-0002AT-KU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab3IQHGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:06:44 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40622 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab3IQHGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:06:42 -0400
Received: by mail-oa0-f48.google.com with SMTP id i10so926237oag.35
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7XR0+xF4SVa0zVzPKSVBDIBGSbvXUtKolZVVXOtwGek=;
        b=KkVF8lZt+dfk5n4uuXmxo3eTx05AwaWyG4UjpPsDHp6gbAn5yV501rnxfVkuBW0alC
         Zn8QE1X32sWPUVFLrm3hX4GMfAmFp8gSvQDv6LuGty9XSWi07UQYS+HBISaKfyvPQtB8
         2mvhXFY8XCFBphb5HVnaVgOpIrdXVHzXHlMcreyhkeG4LB9xSusanX5zz60DlBP8O99o
         33rkUUKmkelc5RzrdnAGqeu2gRWOWd0rGSlaPx+xNwPwWfYgL31YXSBqyNf4o2TBcxea
         KWY0OhQ5XvBAwDw+62jf3EteVLryDe588hPvyumi3a0WBBBbORw1rfxEDblVyMBs3YyQ
         vO6Q==
X-Received: by 10.60.59.99 with SMTP id y3mr405603oeq.70.1379401602198;
        Tue, 17 Sep 2013 00:06:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm37304079oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 00:06:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
In-Reply-To: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234854>

Depending upon the absence or presence of a trailing '/' on the incoming
pathname, index_name_exists() checks either if a file is present in the
index or if a directory is represented within the index. Each caller
explicitly chooses the mode of operation by adding or removing a
trailing '/' before invoking index_name_exists().

Since these two modes of operations are disjoint and have no code in
common (one searches index_state.name_hash; the other dir_hash), they
can be represented more naturally as distinct functions: one to search
for a file, and one for a directory.

Splitting index searching into two functions relieves callers of the
artificial burden of having to add or remove a slash to select the mode
of operation; instead they just call the desired function. A subsequent
patch will take advantage of this benefit in order to eliminate the
requirement that the incoming pathname for a directory search must have
a trailing slash.

(In order to avoid disturbing in-flight topics, index_name_exists() is
retained as a thin wrapper dispatching either to index_dir_exists() or
index_file_exists().)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 cache.h     |  4 ++++
 name-hash.c | 54 ++++++++++++++++++++++++++++++------------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index a47b9c0..038afe1 100644
--- a/cache.h
+++ b/cache.h
@@ -314,6 +314,8 @@ extern void free_name_hash(struct index_state *istate);
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
+#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
+#define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
@@ -463,6 +465,8 @@ extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
+extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
+extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
diff --git a/name-hash.c b/name-hash.c
index 617c86c..f06b049 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -222,7 +222,29 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, len);
 }
 
-struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
+struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen)
+{
+	struct cache_entry *ce;
+	struct dir_entry *dir;
+
+	lazy_init_name_hash(istate);
+	dir = find_dir_entry(istate, name, namelen);
+	if (dir && dir->nr)
+		return dir->ce;
+
+	/*
+	 * It might be a submodule. Unlike plain directories, which are stored
+	 * in the dir-hash, submodules are stored in the name-hash, so check
+	 * there, as well.
+	 */
+	ce = index_file_exists(istate, name, namelen - 1, 1);
+	if (ce && S_ISGITLINK(ce->ce_mode))
+		return ce;
+
+	return NULL;
+}
+
+struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	unsigned int hash = hash_name(name, namelen);
 	struct cache_entry *ce;
@@ -237,32 +259,16 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 		}
 		ce = ce->next;
 	}
-
-	/*
-	 * When looking for a directory (trailing '/'), it might be a
-	 * submodule or a directory. Despite submodules being directories,
-	 * they are stored in the name hash without a closing slash.
-	 * When ignore_case is 1, directories are stored in a separate hash
-	 * table *with* their closing slash.
-	 *
-	 * The side effect of this storage technique is we have need to
-	 * lookup the directory in a separate hash table, and if not found
-	 * remove the slash from name and perform the lookup again without
-	 * the slash.  If a match is made, S_ISGITLINK(ce->mode) will be
-	 * true.
-	 */
-	if (icase && name[namelen - 1] == '/') {
-		struct dir_entry *dir = find_dir_entry(istate, name, namelen);
-		if (dir && dir->nr)
-			return dir->ce;
-
-		ce = index_name_exists(istate, name, namelen - 1, icase);
-		if (ce && S_ISGITLINK(ce->ce_mode))
-			return ce;
-	}
 	return NULL;
 }
 
+struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
+{
+	if (namelen > 0 && name[namelen - 1] == '/')
+		return index_dir_exists(istate, name, namelen);
+	return index_file_exists(istate, name, namelen, icase);
+}
+
 static int free_dir_entry(void *entry, void *unused)
 {
 	struct dir_entry *dir = entry;
-- 
1.8.4.535.g7b94f8e
