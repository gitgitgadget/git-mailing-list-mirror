From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/22] resolve_ref(): extract a function get_packed_ref()
Date: Thu, 15 Sep 2011 23:10:35 +0200
Message-ID: <1316121043-29367-15-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKw-00016R-K9
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019Ab1IOVS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:59 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40189 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934995Ab1IOVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:56 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8w-00019o-FY; Thu, 15 Sep 2011 23:06:46 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181512>

Making it a function and giving it a name makes the code clearer.  I
also have a strong suspicion that the function will find other uses in
the future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   47 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 79ab0eb..473f7f6 100644
--- a/refs.c
+++ b/refs.c
@@ -466,6 +466,23 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 }
 
 /*
+ * Try to read ref from the packed references.  On success, set sha1
+ * and return 0; otherwise, return -1.
+ */
+static int get_packed_ref(const char *ref, unsigned char *sha1)
+{
+	struct ref_list *list = get_packed_refs(NULL);
+	while (list) {
+		if (!strcmp(ref, list->name)) {
+			hashcpy(sha1, list->sha1);
+			return 0;
+		}
+		list = list->next;
+	}
+	return -1;
+}
+
+/*
  * If the "reading" argument is set, this function finds out what _object_
  * the ref points at by "reading" the ref.  The ref, if it is not symbolic,
  * has to exist, and if it is symbolic, it has to point at an existing ref,
@@ -497,22 +514,26 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			return NULL;
 
 		git_snpath(path, sizeof(path), "%s", ref);
-		/* Special case: non-existing file. */
+
 		if (lstat(path, &st) < 0) {
-			struct ref_list *list = get_packed_refs(NULL);
-			while (list) {
-				if (!strcmp(ref, list->name)) {
-					hashcpy(sha1, list->sha1);
-					if (flag)
-						*flag |= REF_ISPACKED;
-					return ref;
-				}
-				list = list->next;
+			if (errno != ENOENT)
+				return NULL;
+			/*
+			 * The loose reference file does not exist;
+			 * check for a packed reference.
+			 */
+			if (!get_packed_ref(ref, sha1)) {
+				if (flag)
+					*flag |= REF_ISPACKED;
+				return ref;
 			}
-			if (reading || errno != ENOENT)
+			/* The reference is not a packed reference, either. */
+			if (reading) {
 				return NULL;
-			hashclr(sha1);
-			return ref;
+			} else {
+				hashclr(sha1);
+				return ref;
+			}
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-- 
1.7.6.8.gd2879
