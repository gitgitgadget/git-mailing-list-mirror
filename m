From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v2 3/3] [RFC] Add a sorted-list API for use-cases that require to get the element index.
Date: Sat,  6 Nov 2010 22:00:35 +0100
Message-ID: <1289077235-3208-4-git-send-email-ydirson@altern.org>
References: <1289077235-3208-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 22:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEpt3-0001XF-MD
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 22:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0KFVAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 17:00:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:58166 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490Ab0KFVAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 17:00:49 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D6217D480E6;
	Sat,  6 Nov 2010 22:00:43 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PEpsO-0000qb-8l; Sat, 06 Nov 2010 22:00:40 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289077235-3208-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160859>

The idea was to replace index_name_pos(), but that would require a much
larger API change in callers.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 sorted-array.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sorted-array.h b/sorted-array.h
index 03d5d1e..df07687 100644
--- a/sorted-array.h
+++ b/sorted-array.h
@@ -1,7 +1,7 @@
 #define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST,CMP,INIT)	\
 MAYBESTATIC ELEMTYPE *LIST;						\
 MAYBESTATIC int LIST##_nr, LIST##_alloc;				\
-MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
+MAYBESTATIC int locate_##LIST##_idx(void *data, int insert_ok)		\
 {									\
 	int first, last;						\
 									\
@@ -12,7 +12,7 @@ MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
 		ELEMTYPE *nextelem = &(LIST[next]);			\
 		int cmp = CMP(data, nextelem);				\
 		if (!cmp)						\
-			return nextelem;				\
+			return next;					\
 		if (cmp < 0) {						\
 			last = next;					\
 			continue;					\
@@ -21,7 +21,7 @@ MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
 	}								\
 	/* not found */							\
 	if (!insert_ok)							\
-		return NULL;						\
+		return -first-1;					\
 	/* insert to make it at "first" */				\
 	if (LIST##_alloc <= LIST##_nr) {				\
 		LIST##_alloc = alloc_nr(LIST##_alloc);			\
@@ -32,5 +32,12 @@ MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
 		memmove(LIST + first + 1, LIST + first,			\
 			(LIST##_nr - first - 1) * sizeof(*LIST));	\
 	INIT(&LIST[first], data);					\
-	return &(LIST[first]);						\
+	return first;							\
+}									\
+MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
+{									\
+	int idx = locate_##LIST##_idx(data, insert_ok);			\
+	if (idx < 0)							\
+		return NULL;						\
+	return &(LIST[idx]);						\
 }
-- 
1.7.2.3
