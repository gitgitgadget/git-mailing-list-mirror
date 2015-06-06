From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 01/11] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sat,  6 Jun 2015 19:18:06 +0530
Message-ID: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ESa-0004a8-NP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbFFNsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:48:25 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:35271 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFFNsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:48:23 -0400
Received: by pdbht2 with SMTP id ht2so12409624pdb.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZvrjlVlgvbqPIPwH8PYRBxKjNf9I8zxLFEjbq4ZbmLc=;
        b=dkgEesiSS24qoNRw5sgcHpex4ZQaiN8i9BgvHyNiMOv+AbUvxKc6YX5B2OC8qBlUWY
         4lj2lKakJDP4RriJJrzy+jWicQE3hYh8HN2HZZwcvWSCukpBK756EW4kNDnqS86fbOc3
         Bj+5goPml23i5Bh453V5WTP3fZFikEsMGD/yDiWe3IpyMH9cDNe+WpDeybi79TmbhqCY
         WPMQc6dUjlcs0Jz/SQo+YO9D3A+66zJkkaXhYSW0584NLKAQEVJD2c+ixoLjD39OyFPY
         kWeAUjJpoj/CIJIN9sdQlsDSmmpIfzxb+e86ijTKz7qawJkFdOTOeD/CPGD0x41qYcPU
         t2og==
X-Received: by 10.68.68.193 with SMTP id y1mr6677338pbt.169.1433598502806;
        Sat, 06 Jun 2015 06:48:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5572F904.1080608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270923>

Extract two helper functions out of grab_single_ref(). Firstly,
new_refinfo() which is used to allocate memory for a new refinfo
structure and copy the objectname, refname and flag to it.
Secondly, match_name_as_path() which when given an array of patterns
and the refname checks if the refname matches any of the patterns
given while the pattern is a pathname, also while supporting wild
characters.

This is a preperatory patch for restructuring 'for-each-ref' and
eventually moving most of it to 'ref-filter' to provide the
functionality to similar commands via public API's.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 63 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f7e51a7..f939fd3 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -851,6 +851,43 @@ struct grab_ref_cbdata {
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
@@ -866,35 +903,15 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
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
