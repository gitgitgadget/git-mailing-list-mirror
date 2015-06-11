From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 01/12] for-each-ref: extract helper functions out of grab_single_ref()
Date: Thu, 11 Jun 2015 21:39:52 +0530
Message-ID: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z353a-0006Di-C5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbbFKQKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:10:13 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:32771 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbFKQKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:10:12 -0400
Received: by pdev10 with SMTP id v10so2169124pde.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gYDqTJX7ufvA5+uB/mPfXr0yx+2gZLviWYjIwc7JKYY=;
        b=QTlyLi1xUDCcAoZTtAo0dyeONPz63sxjMrr9y1PNm8/UURGSjlVHlxw5agP8lhW9KW
         5uv7ugCI8B2QU3KaZuILbMvvZE47EVFT3eCh+onLH4Qt0wpMceWe1LA2BlrL9tGZ8dq1
         H6DYGaOPh3g+hYi7gYjqSihigan8WTKqV3RvbkeRUtrXbTdNVOPwTUzKhpuRRjbwGyQ+
         tWGMLQtx8ZA49URDpovTlvG+p0ChVCyDoixrLspPRZpDddx95ToamyiUaHOgmq2bLvub
         R3QXWbolU14piJlterdNEwQASdsdG0KbPEALEKAKQ85h7XofGrsrttVQJmNeeNpXZ9I8
         I0UQ==
X-Received: by 10.70.95.170 with SMTP id dl10mr15939919pdb.64.1434039011954;
        Thu, 11 Jun 2015 09:10:11 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5579B253.4020804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271426>

Extract two helper functions out of grab_single_ref(). Firstly,
new_refinfo() which is used to allocate memory for a new refinfo
structure and copy the objectname, refname and flag to it.
Secondly, match_name_as_path() which when given an array of patterns
and the refname checks if the refname matches any of the patterns
given while the pattern is a pathname, also supports wildcard
characters.

This is a preperatory patch for restructuring 'for-each-ref' and
eventually moving most of it to 'ref-filter' to provide the
functionality to similar commands via public API's.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 64 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f7e51a7..67c8b62 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -851,6 +851,44 @@ struct grab_ref_cbdata {
 };
 
 /*
+ * Return 1 if the refname matches with one of the patterns,
+ * otherwise 0.  The patterns can be literal prefix (e.g. a
+ * refname "refs/heads/master" matches a pattern "refs/heads/")
+ * or a wildcard (e.g. the same ref matches "refs/heads/m*",too).
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
@@ -866,35 +904,15 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
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
 
 	/*
 	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = xcalloc(1, sizeof(*ref));
-	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, oid->hash);
-	ref->flag = flag;
+	ref = new_refinfo(refname, oid->hash, flag);
 
 	cnt = cb->grab_cnt;
 	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-- 
2.4.2
