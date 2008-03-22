From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/7] Make branch merging aware of underlying case-insensitive
 filsystems
Date: Sat, 22 Mar 2008 10:38:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7h5-0007D6-0P
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYCVRjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbYCVRjF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:39:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45395 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115AbYCVRjE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:39:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHcRVr002764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:38:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHcP10019828;
	Sat, 22 Mar 2008 10:38:26 -0700
In-Reply-To: <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77834>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Sat, 22 Mar 2008 09:35:59 -0700

If we find an unexpected file, see if that filename perhaps exists in a
case-insensitive way in the index, and whether the file matches that. If
so, ignore it as a known pre-existing file of a different name.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

All right, this is *it*. This is the actual core code that does something 
interesting.

I've tried to explain the behaviour in the comment, and let's face it, the 
patch is really really simple (yeah, 26 new lines but they are all really 
trivial and over half of them of them are actually the comments about 
what is going on).

The core of the code itself is just two lines, really, but it's all 
wrapped in a helper function and I tried to make it be really really 
obvious what is going on!

The reason why "src_index" had to become non-const is stupid: it's not 
because we actually do anything that really writes to the index, but the 
lazy index name hashing code means that even just a name lookup will 
possibly create the name hash in the index.

Oh well.

 unpack-trees.c |   26 ++++++++++++++++++++++++++
 unpack-trees.h |    2 +-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf7d8f6..95d3413 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -521,6 +521,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 }
 
 /*
+ * This gets called when there was no index entry for the tree entry 'dst',
+ * but we found a file in the working tree that 'lstat()' said was fine,
+ * and we're on a case-insensitive filesystem.
+ *
+ * See if we can find a case-insensitive match in the index that also
+ * matches the stat information, and assume it's that other file!
+ */
+static int icase_exists(struct unpack_trees_options *o, struct cache_entry *dst, struct stat *st)
+{
+	struct cache_entry *src;
+
+	src = index_name_exists(o->src_index, dst->name, ce_namelen(dst), 1);
+	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID);
+}
+
+/*
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
@@ -540,6 +556,16 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		int dtype = ce_to_dtype(ce);
 		struct cache_entry *result;
 
+		/*
+		 * It may be that the 'lstat()' succeeded even though
+		 * target 'ce' was absent, because there is an old
+		 * entry that is different only in case..
+		 *
+		 * Ignore that lstat() if it matches.
+		 */
+		if (ignore_case && icase_exists(o, ce, &st))
+			return 0;
+
 		if (o->dir && excluded(o->dir, ce->name, &dtype))
 			/*
 			 * ce->name is explicitly excluded, so it is Ok to
diff --git a/unpack-trees.h b/unpack-trees.h
index ad8cc65..d436d6c 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -31,7 +31,7 @@ struct unpack_trees_options {
 	void *unpack_data;
 
 	struct index_state *dst_index;
-	const struct index_state *src_index;
+	struct index_state *src_index;
 	struct index_state result;
 };
 
-- 
1.5.5.rc0.28.g61a0.dirty
