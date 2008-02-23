From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] Use helper function for copying index entry
 information
Date: Fri, 22 Feb 2008 20:41:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802222039250.21332@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802222029180.21332@woody.linux-foundation.org> <alpine.LFD.1.00.0802222033570.21332@woody.linux-foundation.org> <alpine.LFD.1.00.0802222037560.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSmDT-0000qy-9i
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbYBWElw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYBWElv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:41:51 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57620 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbYBWElv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 23:41:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4fI0m017645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2008 20:41:19 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4fHhu012687;
	Fri, 22 Feb 2008 20:41:17 -0800
In-Reply-To: <alpine.LFD.1.00.0802222037560.21332@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.562 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74798>



From: Linus Torvalds <torvalds@linux-foundation.org>

We used to just memcpy() the index entry when we copied the stat() and
SHA1 hash information, which worked well enough back when the index
entry was just an exact bit-for-bit representation of the information on
disk.

However, these days we actually have various management information in
the cache entry too, and we should be careful to not overwrite it when
we copy the stat information from another index entry.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
It's still not the prettiest function ever, but I think it's obvious 
enough what it does. And the call-site is prettier.

 cache.h        |   18 +++++++++++++++++-
 unpack-trees.c |    2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 88d3b92..fa5a9e5 100644
--- a/cache.h
+++ b/cache.h
@@ -110,7 +110,6 @@ struct ondisk_cache_entry {
 };
 
 struct cache_entry {
-	struct cache_entry *next;
 	unsigned int ce_ctime;
 	unsigned int ce_mtime;
 	unsigned int ce_dev;
@@ -121,6 +120,7 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned char sha1[20];
+	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -138,6 +138,22 @@ struct cache_entry {
 #define CE_UNHASHED  (0x200000)
 
 /*
+ * Copy the sha1 and stat state of a cache entry from one to
+ * another. But we never change the name, or the hash state!
+ */
+#define CE_STATE_MASK (CE_HASHED | CE_UNHASHED)
+static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry *src)
+{
+	unsigned int state = dst->ce_flags & CE_STATE_MASK;
+
+	/* Don't copy hash chain and name */
+	memcpy(dst, src, offsetof(struct cache_entry, next));
+
+	/* Restore the hash state */
+	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
+}
+
+/*
  * We don't actually *remove* it, we can just mark it invalid so that
  * we won't find it in lookups.
  *
diff --git a/unpack-trees.c b/unpack-trees.c
index ec558f9..07c4c28 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -590,7 +590,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		 * a match.
 		 */
 		if (same(old, merge)) {
-			memcpy(merge, old, offsetof(struct cache_entry, name));
+			copy_cache_entry(merge, old);
 		} else {
 			verify_uptodate(old, o);
 			invalidate_ce_path(old);
