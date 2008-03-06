From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/5] Add 'df_name_compare()' helper function
Date: Wed, 5 Mar 2008 18:25:10 -0800
Message-ID: <b1cd18fa986c63bea6d0a20ac580b993e5fffaa2.1204777699.git.torvalds@linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rT-0003rr-RE
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYCFEg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbYCFEg6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:36:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59781 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753686AbYCFEg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:36:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264b65B006303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:37:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264akAN008859;
	Wed, 5 Mar 2008 20:36:46 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-3.934 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76322>

This new helper is identical to base_name_compare(), except it compares
conflicting directory/file entries as equal in order to help handling DF
conflicts (thus the name).

Note that while a directory name compares as equal to a regular file
with the new helper, they then individually compare _differently_ to a
filename that has a dot after the basename (because '\0' < '.' < '/').

So a directory called "foo/" will compare equal to a file "foo", even
though "foo.c" will compare after "foo" and before "foo/"

This will be used by routines that want to traverse the git namespace
but then handle conflicting entries together when possible.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 cache.h      |    1 +
 read-cache.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index e230302..6eb16cb 100644
--- a/cache.h
+++ b/cache.h
@@ -536,6 +536,7 @@ extern int create_symref(const char *ref, const char *refs_heads_master, const c
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
diff --git a/read-cache.c b/read-cache.c
index 657f0c5..bf649a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -351,6 +351,41 @@ int base_name_compare(const char *name1, int len1, int mode1,
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
 
+/*
+ * df_name_compare() is identical to base_name_compare(), except it
+ * compares conflicting directory/file entries as equal. Note that
+ * while a directory name compares as equal to a regular file, they
+ * then individually compare _differently_ to a filename that has
+ * a dot after the basename (because '\0' < '.' < '/').
+ *
+ * This is used by routines that want to traverse the git namespace
+ * but then handle conflicting entries together when possible.
+ */
+int df_name_compare(const char *name1, int len1, int mode1,
+		    const char *name2, int len2, int mode2)
+{
+	int len = len1 < len2 ? len1 : len2, cmp;
+	unsigned char c1, c2;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp)
+		return cmp;
+	/* Directories and files compare equal (same length, same name) */
+	if (len1 == len2)
+		return 0;
+	c1 = name1[len];
+	if (!c1 && S_ISDIR(mode1))
+		c1 = '/';
+	c2 = name2[len];
+	if (!c2 && S_ISDIR(mode2))
+		c2 = '/';
+	if (c1 == '/' && !c2)
+		return 0;
+	if (c2 == '/' && !c1)
+		return 0;
+	return c1 - c2;
+}
+
 int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
 {
 	int len1 = flags1 & CE_NAMEMASK;
-- 
1.5.4.3.452.g67136


