From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/WIP v3 1/4] for-each-ref: extract helper functions out of grab_single_ref()
Date: Thu, 28 May 2015 23:13:42 +0530
Message-ID: <1432835025-13291-1-git-send-email-karthik.188@gmail.com>
References: <5567527A.6090607@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 19:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1qf-0005J5-3U
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbbE1RoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:44:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35107 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbE1Rn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:43:59 -0400
Received: by pacwv17 with SMTP id wv17so28584561pac.2
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gNTVdkY/NorjEQdl3pCz2ZQkZlCOfqX7GSNgFOgHSM=;
        b=WBMfpGRBQqCLfD12xtuQmd1pRQEcFf7JGDCH5U2IFMvGgRfrrvlxy1Lq/36IjDlIcC
         Sz4zXhr90Ns8vgY2gUpkMfRap2ZxLgw9dLq6KFjRm4gn/pj2esO+F2dbXpN/AAhAHWwm
         pHKP+BvEbWyfw3mxE2FJDKm8+TmY2tAiJl3yK0c5SHivvONGC+u7Y4LvedDnbSymTfra
         WoVlttto/4S06L/Cj7llQ+lyoDB6nGe8xAlh5POM7gzhJK+RQdmyDd9oKC0KS/MJrWkV
         pkgfUBzRAtEWFqMKpKHcFbneWWLE72kZrdlA1DKcku/rlRgi9eACDSNlVopi7fYXypwG
         xnuw==
X-Received: by 10.66.63.41 with SMTP id d9mr7761655pas.47.1432835038635;
        Thu, 28 May 2015 10:43:58 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id k13sm3003649pbq.79.2015.05.28.10.43.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 May 2015 10:43:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <5567527A.6090607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270165>

Extract two helper functions out of grab_single_ref(). Firstly,
new_refinfo() which is used to allocate memory for a new refinfo
structure and copy the objectname, refname and flag to it.
Secondly, match_name_as_path() which when given an array of patterns
and the refname checks if the refname matches any of the patterns
given while the pattern is a pathname, also while supporting wild
characters.

This is a preperatory patch for restructuring 'for-each-ref' and
evntually moving most of it to 'ref-filter' to provide the
functionality to similar commands via public API's.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 76 ++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..919d45e 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -837,6 +837,43 @@ struct grab_ref_cbdata {
 };
 
 /*
+ * Given a refname, return 1 if the refname matches with one of the patterns
+ * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
+ * and so on, else return 0. Supports use of wild characters.
+ */
+static int match_name_as_path(const char **pattern, const char *refname)
+{
+	int namelen = strlen(refname);
+	for (; *pattern; pattern++) {
+		const char *p = *pattern;
+		int plen = strlen(p);
+
+		if ((plen <= namelen) &&
+		    !strncmp(refname, p, plen) &&
+		    (refname[plen] == '\0' ||
+		     refname[plen] == '/' ||
+		     p[plen-1] == '/'))
+			return 1;
+		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+/* Allocate space for a new refinfo and copy the objectname and flag to it */
+static struct refinfo *new_refinfo(const char *refname,
+				   const unsigned char *objectname,
+				   int flag)
+{
+	struct refinfo *ref = xcalloc(1, sizeof(struct refinfo));
+	ref->refname = xstrdup(refname);
+	hashcpy(ref->objectname, objectname);
+	ref->flag = flag;
+
+	return ref;
+}
+
+/*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
@@ -844,47 +881,20 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
 		  return 0;
 	}
 
-	if (*cb->grab_pattern) {
-		const char **pattern;
-		int namelen = strlen(refname);
-		for (pattern = cb->grab_pattern; *pattern; pattern++) {
-			const char *p = *pattern;
-			int plen = strlen(p);
-
-			if ((plen <= namelen) &&
-			    !strncmp(refname, p, plen) &&
-			    (refname[plen] == '\0' ||
-			     refname[plen] == '/' ||
-			     p[plen-1] == '/'))
-				break;
-			if (!wildmatch(p, refname, WM_PATHNAME, NULL))
-				break;
-		}
-		if (!*pattern)
-			return 0;
-	}
+	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
+		return 0;
 
-	/*
-	 * We do not open the object yet; sort may only need refname
-	 * to do its job and the resulting list may yet to be pruned
-	 * by maxcount logic.
-	 */
-	ref = xcalloc(1, sizeof(*ref));
-	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, sha1);
-	ref->flag = flag;
+	ref = new_refinfo(refname, sha1, flag);
+
+	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
+	cb->grab_array[cb->grab_cnt++] = ref;
 
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
 	return 0;
 }
 
-- 
2.4.1
