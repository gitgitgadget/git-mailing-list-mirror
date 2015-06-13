From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 01/11] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sun, 14 Jun 2015 01:07:19 +0530
Message-ID: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rFc-0001uO-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbbFMThn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:37:43 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35809 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbFMThh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:37:37 -0400
Received: by pdbnf5 with SMTP id nf5so44714687pdb.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abDGSDGboJvlMTiyrg/wYG5w3oOShUtYQwww4fngE3E=;
        b=sJ1CSUEZvx5h+MEi9MiudEaAPsPIdb9z8n+Zv+ZB+bD35IU+PvPVMmqMBxd3VzSS5/
         69seBYAZ27H5LKVIj1YLse5AKRdE4S0FoY1kCDpU6AeNai48Y9HiJaCZI5wg7o+diz68
         sxYmhUrZERqprKBAUQAyEX/VnWv/Ylz2AZrytVBu2KTln7Ym7oF8BZ4MVA1Lm28nYCIA
         6KUOq5atBXpSDu0jpeftez9FRaPyHR+OZLGNuxnBJ93EsYtPLyjFIW5A5/o6knzZqtuM
         F2c3kgIX9EuwO6+SC4pLJxK3SHmeZIoKqyXSIY3UVbKr47uqTTW8uKygYiDrC1iaghSR
         XxCg==
X-Received: by 10.70.54.164 with SMTP id k4mr34310867pdp.61.1434224257003;
        Sat, 13 Jun 2015 12:37:37 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.37.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271564>

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
index f7e51a7..cc65620 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -851,6 +851,44 @@ struct grab_ref_cbdata {
 };
 
 /*
+ * Return 1 if the refname matches one of the patterns, otherwise 0.
+ * A pattern can be path prefix (e.g. a refname "refs/heads/master"
+ * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
+ * matches "refs/heads/m*",too).
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
2.4.3.435.g2403634.dirty
