From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sat, 30 May 2015 23:23:24 +0530
Message-ID: <1433008411-8550-1-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykxL-0005mu-3i
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbbE3Rxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:53:52 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33628 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbbE3Rxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:53:50 -0400
Received: by pdbqa5 with SMTP id qa5so76325963pdb.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5EODysjfP1pMG1JdIZF0sTQo7eYIEF6C6YcPPhZ4AE4=;
        b=oHlFSM0824EHNouCOTcLWEH3lr+1EOcLq1n7/WP0RonufRZst2eYBku15CAmpC1gwg
         VKh6igV6Ykawjft0D0MefClTQok3dMkkJ8y3sO5UOaqXQkHWCYxzgqzNGRqtbfLylb2w
         K5EO+9XnzmpPvYPwdBmyspZ317alnnbfi7DR7jHgPRby/iIy5F4LGeXLEG7IYydxgVms
         GQNsDD2us27yc2Og1JuSPZcBlld19nJbue64NBCLe2SdNd7u2iTSiVWUa7a5N8S6fohm
         xWuPizdemAkKMx5HRn6WpmeeCN7XIujqBlnOUtORuM2hdcI4MBzlwuRezt9i0OSTJXT3
         TkFA==
X-Received: by 10.68.131.196 with SMTP id oo4mr25247352pbb.119.1433008429880;
        Sat, 30 May 2015 10:53:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.53.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:53:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270294>

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
 builtin/for-each-ref.c | 69 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..b33e2de 100644
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
@@ -851,40 +888,16 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
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
 
 	cnt = cb->grab_cnt;
 	REALLOC_ARRAY(cb->grab_array, cnt + 1);
 	cb->grab_array[cnt++] = ref;
 	cb->grab_cnt = cnt;
+
 	return 0;
 }
 
-- 
2.4.2
