From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/22] resolve_ref(): expand documentation
Date: Thu, 15 Sep 2011 23:10:42 +0200
Message-ID: <1316121043-29367-22-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKd-0000xN-4P
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934972Ab1IOVSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:46 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40160 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934922Ab1IOVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:46 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J96-00019o-29; Thu, 15 Sep 2011 23:06:56 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181508>

Record information about resolve_ref(), hard-won via reverse
engineering, in a comment for future spelunkers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |   34 +++++++++++++++++++++++++++++++++-
 refs.c  |   12 ------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 607c2ea..aea8685 100644
--- a/cache.h
+++ b/cache.h
@@ -822,7 +822,39 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
-extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+
+/*
+ * Resolve a reference, recursively following symbolic refererences.
+ *
+ * Store the referred-to object's name in sha1 and return the name of
+ * the non-symbolic reference that ultimately pointed at it.  The
+ * return value, if not NULL, is a pointer into either a static buffer
+ * or the input ref.
+ *
+ * If the reference cannot be resolved to an object, the behavior
+ * depends on the "reading" argument:
+ *
+ * - If reading is set, return NULL.
+ *
+ * - If reading is not set, clear sha1 and return the name of the last
+ *   reference name in the chain, which will either be a non-symbolic
+ *   reference or an undefined reference.  If this is a prelude to
+ *   "writing" to the ref, the return value is the name of the ref
+ *   that will actually be created or changed.
+ *
+ * If flag is non-NULL, set the value that it points to the
+ * combination of REF_ISPACKED (if the reference was found among the
+ * packed references) and REF_ISSYMREF (if the initial reference was a
+ * symbolic reference).
+ *
+ * If ref is not a properly-formatted, normalized reference, return
+ * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
+ * give up and return NULL.
+ *
+ * errno is sometimes set on errors, but not always.
+ */
+extern const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag);
+
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, struct strbuf *);
diff --git a/refs.c b/refs.c
index 0baa500..096b42c 100644
--- a/refs.c
+++ b/refs.c
@@ -482,18 +482,6 @@ static int get_packed_ref(const char *ref, unsigned char *sha1)
 	return -1;
 }
 
-/*
- * If the "reading" argument is set, this function finds out what _object_
- * the ref points at by "reading" the ref.  The ref, if it is not symbolic,
- * has to exist, and if it is symbolic, it has to point at an existing ref,
- * because the "read" goes through the symref to the ref it points at.
- *
- * The access that is not "reading" may often be "writing", but does not
- * have to; it can be merely checking _where it leads to_. If it is a
- * prelude to "writing" to the ref, a write to a symref that points at
- * yet-to-be-born ref will create the real ref pointed by the symref.
- * reading=0 allows the caller to check where such a symref leads to.
- */
 const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
-- 
1.7.6.8.gd2879
