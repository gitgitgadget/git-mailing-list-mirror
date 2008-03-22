From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/7] Make hash_name_lookup able to do case-independent
 lookups
Date: Sat, 22 Mar 2008 10:30:31 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7ZO-0004eA-77
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbYCVRa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbYCVRa4
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:30:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37373 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817AbYCVRaz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:30:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHUX8m002253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:30:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHUVWA019543;
	Sat, 22 Mar 2008 10:30:32 -0700
In-Reply-To: <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77831>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Fri, 21 Mar 2008 15:55:19 -0700

Right now nobody uses it, but "index_name_exists()" gets a flag so
you can enable it on a case-by-case basis.

Signed-of-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Oooh.. We actually have some (admittedly stupid) case insensitivity code 
starting to appear. So we now hash the names insensitively, and we have 
the _capability_ to do case-insensitive lookups, but nobody actually uses 
that insensitive lookup capability yet.

But things are now starting to get interesting.

 cache.h        |    4 ++--
 dir.c          |    2 +-
 name-hash.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 unpack-trees.c |    2 +-
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 76d95d2..a9ddaa1 100644
--- a/cache.h
+++ b/cache.h
@@ -264,7 +264,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_name_exists(name, namelen) index_name_exists(&the_index, (name), (namelen))
+#define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #endif
 
 enum object_type {
@@ -353,7 +353,7 @@ extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
-extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen);
+extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/dir.c b/dir.c
index edc458e..7362e83 100644
--- a/dir.c
+++ b/dir.c
@@ -371,7 +371,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len))
+	if (cache_name_exists(pathname, len, 0))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
diff --git a/name-hash.c b/name-hash.c
index 2678148..2253870 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,12 +8,25 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 
+/*
+ * This removes bit 5 if bit 6 is set.
+ *
+ * That will make US-ASCII characters hash to their upper-case
+ * equivalent. We could easily do this one whole word at a time,
+ * but that's for future worries.
+ */
+static inline unsigned char icase_hash(unsigned char c)
+{
+	return c & ~((c & 0x40) >> 1);
+}
+
 static unsigned int hash_name(const char *name, int namelen)
 {
 	unsigned int hash = 0x123;
 
 	do {
 		unsigned char c = *name++;
+		c = icase_hash(c);
 		hash = hash*101 + c;
 	} while (--namelen);
 	return hash;
@@ -54,7 +67,40 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 		hash_index_entry(istate, ce);
 }
 
-struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen)
+static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
+{
+	if (len1 != len2)
+		return 0;
+
+	while (len1) {
+		unsigned char c1 = *name1++;
+		unsigned char c2 = *name2++;
+		len1--;
+		if (c1 != c2) {
+			c1 = toupper(c1);
+			c2 = toupper(c2);
+			if (c1 != c2)
+				return 0;
+		}
+	}
+	return 1;
+}
+
+static int same_name(const struct cache_entry *ce, const char *name, int namelen, int icase)
+{
+	int len = ce_namelen(ce);
+
+	/*
+	 * Always fo exact compare (even if we want a case-ignoring comparison
+	 * we do the quick exact one first, because it will be the common case).
+	 */
+	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
+		return 1;
+
+	return icase && slow_same_name(name, namelen, ce->name, len);
+}
+
+struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	unsigned int hash = hash_name(name, namelen);
 	struct cache_entry *ce;
@@ -64,7 +110,7 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
-			if (!cache_name_compare(name, namelen, ce->name, ce->ce_flags))
+			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
 		ce = ce->next;
diff --git a/unpack-trees.c b/unpack-trees.c
index ca4c845..bf7d8f6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -582,7 +582,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		result = index_name_exists(&o->result, ce->name, ce_namelen(ce));
+		result = index_name_exists(&o->result, ce->name, ce_namelen(ce), 0);
 		if (result) {
 			if (result->ce_flags & CE_REMOVE)
 				return 0;
-- 
1.5.5.rc0.28.g61a0.dirty
