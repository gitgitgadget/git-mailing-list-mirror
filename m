From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/7] Make "index_name_exists()" return the cache_entry it
 found
Date: Sat, 22 Mar 2008 10:28:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7XV-0003x4-CS
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbYCVR3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYCVR3N
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:29:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39770 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbYCVR3M (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:29:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHSBkM002090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:28:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHS7Ln019484;
	Sat, 22 Mar 2008 10:28:10 -0700
In-Reply-To: <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77830>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Fri, 21 Mar 2008 15:53:00 -0700

This allows verify_absent() in unpack_trees() to use the hash chains
rather than looking it up using the binary search.

Perhaps more imporantly, it's also going to be useful for the next phase, 
where we actually start looking at the cache entry when we do 
case-insensitive lookups and checking the result.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
No real change, except verify_absent() can now use the name hashing rather 
than the binary search. But it's all still very much case-sensitive.

 cache.h        |    2 +-
 name-hash.c    |    6 +++---
 unpack-trees.c |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 2afc788..76d95d2 100644
--- a/cache.h
+++ b/cache.h
@@ -353,7 +353,7 @@ extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
-extern int index_name_exists(struct index_state *istate, const char *name, int namelen);
+extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/name-hash.c b/name-hash.c
index e56eb16..2678148 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -54,7 +54,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 		hash_index_entry(istate, ce);
 }
 
-int index_name_exists(struct index_state *istate, const char *name, int namelen)
+struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen)
 {
 	unsigned int hash = hash_name(name, namelen);
 	struct cache_entry *ce;
@@ -65,9 +65,9 @@ int index_name_exists(struct index_state *istate, const char *name, int namelen)
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
 			if (!cache_name_compare(name, namelen, ce->name, ce->ce_flags))
-				return 1;
+				return ce;
 		}
 		ce = ce->next;
 	}
-	return 0;
+	return NULL;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index a59f475..ca4c845 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -538,6 +538,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (!lstat(ce->name, &st)) {
 		int cnt;
 		int dtype = ce_to_dtype(ce);
+		struct cache_entry *result;
 
 		if (o->dir && excluded(o->dir, ce->name, &dtype))
 			/*
@@ -581,10 +582,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = index_name_pos(&o->result, ce->name, strlen(ce->name));
-		if (0 <= cnt) {
-			struct cache_entry *ce = o->result.cache[cnt];
-			if (ce->ce_flags & CE_REMOVE)
+		result = index_name_exists(&o->result, ce->name, ce_namelen(ce));
+		if (result) {
+			if (result->ce_flags & CE_REMOVE)
 				return 0;
 		}
 
-- 
1.5.5.rc0.28.g61a0.dirty
