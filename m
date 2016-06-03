From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/38] resolve_ref_recursively(): new function
Date: Fri,  3 Jun 2016 23:03:50 +0200
Message-ID: <b4f93e572ad6567fd57841c18778c608a6eeaa7a.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHI-0000Yi-KW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbcFCVFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:04 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58635 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932943AbcFCVE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:56 -0400
X-AuditID: 1207440e-ef3ff700000008c5-91-5751f0f43b4b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CA.68.02245.4F0F1575; Fri,  3 Jun 2016 17:04:52 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcf003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:50 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvlQ2C4QcMsHov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGe03V3PWHCap+L0/6WsDYydXF2M
	nBwSAiYSnxrfM3cxcnEICWxllPjY/ZEJwjnOJHFt9iU2kCo2AV2JRT3NTCC2iECERMOrFkaQ
	ImaBOUwStx92MoMkhAXsJDo/7GYHsVkEVCV29OxkBbF5BaIkVnT/ZYRYJydxefoDsKGcAhYS
	LZ9XgdUICZhLNJ46zDKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJN
	jJCw49vB2L5e5hCjAAejEg9vwbPAcCHWxLLiytxDjJIcTEqivHvvAIX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8Ka8BsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
	F70HahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRUF8MTAOQFI8QHu5P4DsLS5I
	zAWKQrSeYlSUEucNBZkrAJLIKM2DGwtLJq8YxYG+FOZNBqniASYiuO5XQIOZgAYXPPIHGVyS
	iJCSamCUszCJ3fTG4qDUg8OcS/q1LnV1LBHdx92S8GeqsnIOo8hlzUwpV7l1p10zd2iJLpm0
	QG/15mMdNvb/p8XrGT9Ovr+m5XGPn/ELsdybKsJPNlxrCp/vw5Yy01lwtoUs0+Lw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296375>

Add a new function, resolve_ref_recursively(), which is basically like
the old resolve_ref_unsafe() except that it takes a (ref_store *)
argument and also works for submodules.

Re-implement resolve_ref_unsafe() as a thin wrapper around
resolve_ref_recursively().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9d36dfe..93f2e4d 100644
--- a/refs.c
+++ b/refs.c
@@ -1216,13 +1216,14 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *resolve_ref_recursively(struct ref_store *refs,
+					   const char *refname,
+					   int resolve_flags,
+					   unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
 	int symref_count;
-	struct ref_store *refs = get_ref_store(NULL);
 
 	if (!flags)
 		flags = &unused_flags;
@@ -1291,6 +1292,13 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return NULL;
 }
 
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	return resolve_ref_recursively(get_ref_store(NULL), refname,
+				       resolve_flags, sha1, flags);
+}
+
 static struct ref_store *main_ref_store = NULL;
 
 static struct ref_store *submodule_ref_stores = NULL;
-- 
2.8.1
