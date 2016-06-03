From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/13] get_ref_cache(): only create an instance if there is a submodule
Date: Fri,  3 Jun 2016 14:33:46 +0200
Message-ID: <3d6c93bd7907f3e6c34787a47b1d75c5cca52a1b.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIv-0005Ac-9g
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbcFCMeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45414 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932360AbcFCMeM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:12 -0400
X-AuditID: 12074414-63fff700000008e6-5b-575179437d38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 59.8C.02278.34971575; Fri,  3 Jun 2016 08:34:11 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtiq005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:09 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqOtcGRhu8LtPyWL+phOMFl1Xupks
	GnqvMFvcXjGf2aJ7yltGix8tPcwWM69aW5x508jowOHx9/0HJo+ds+6yezzr3cPocfGSssf+
	pdvYPBY/8PJY8Pw+u8fnTXIBHFHcNkmJJWXBmel5+nYJ3Bmvt81lKzggVHH/9naWBsYO/i5G
	Tg4JAROJDS+OsXcxcnEICWxllHg4+zsbhHOcSeLB1D+sIFVsAroSi3qamUBsEYEIiYZXLYwg
	RcwCc5gkbj/sZAZJCAtESRy738YIYrMIqEpceToRrJkXKP7w1zlGiHVyEpenP2ADsTkFLCT6
	7v1gB7GFBMwlHs7ZzT6BkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJN
	jJCwE9nBeOSk3CFGAQ5GJR7eFQsCwoVYE8uKK3MPMUpyMCmJ8p4/CxTiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwvunIDBciDclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJ
	gte8AqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQF8cXAOABJ8QDtrQBp5y0u
	SMwFikK0nmJUlBLnFQZJCIAkMkrz4MbCkskrRnGgL4V5w8qBqniAiQiu+xXQYCagwQWP/EEG
	lyQipKQaGLvt73jWOfU8lLjD+GZK6c0zRuERTjxJatUzz6T3G2ldibGRUQsW2mGwIMb1qo/S
	8nnKbGVKgls4Eno05LUDsjvkIstnievnpEruXlTosc1xw8Oaw4wbly2PUPqx+Mur 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296317>

If there is not a nonbare repository where a submodule is supposedly
located, then don't instantiate a ref_cache for it.

The analogous check can be removed from resolve_gitlink_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a0d09f4..142c977 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -954,15 +954,26 @@ static struct ref_cache *lookup_ref_cache(const char *submodule)
 
 /*
  * Return a pointer to a ref_cache for the specified submodule. For
- * the main repository, use submodule==NULL. The returned structure
- * will be allocated and initialized but not necessarily populated; it
- * should not be freed.
+ * the main repository, use submodule==NULL; such a call cannot fail.
+ * For a submodule, the submodule must exist and be a nonbare
+ * repository, otherwise return NULL.
+ *
+ * The returned structure will be allocated and initialized but not
+ * necessarily populated; it should not be freed.
  */
 static struct ref_cache *get_ref_cache(const char *submodule)
 {
 	struct ref_cache *refs = lookup_ref_cache(submodule);
-	if (!refs)
-		refs = create_ref_cache(submodule);
+
+	if (!refs) {
+		struct strbuf submodule_sb = STRBUF_INIT;
+
+		strbuf_addstr(&submodule_sb, submodule);
+		if (is_nonbare_repository_dir(&submodule_sb))
+			refs = create_ref_cache(submodule);
+		strbuf_release(&submodule_sb);
+	}
+
 	return refs;
 }
 
@@ -1341,13 +1352,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 		return -1;
 
 	strbuf_add(&submodule, path, len);
-	refs = lookup_ref_cache(submodule.buf);
+	refs = get_ref_cache(submodule.buf);
 	if (!refs) {
-		if (!is_nonbare_repository_dir(&submodule)) {
-			strbuf_release(&submodule);
-			return -1;
-		}
-		refs = create_ref_cache(submodule.buf);
+		strbuf_release(&submodule);
+		return -1;
 	}
 	strbuf_release(&submodule);
 
@@ -1885,6 +1893,9 @@ int do_for_each_ref(const char *submodule, const char *prefix,
 	struct ref_cache *refs;
 
 	refs = get_ref_cache(submodule);
+	if (!refs)
+		return 0;
+
 	data.prefix = prefix;
 	data.trim = trim;
 	data.flags = flags;
-- 
2.8.1
