From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/13] ref_resolves_to_object(): new function
Date: Mon, 30 May 2016 09:55:29 +0200
Message-ID: <d7a116ad608aa733c712870c1d6759165811756f.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3c-0001Iq-BD
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbcE3H4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:11 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50408 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932508AbcE3Hz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:59 -0400
X-AuditID: 1207440e-ef3ff700000008c5-d6-574bf20f328c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F6.F7.02245.F02FB475; Mon, 30 May 2016 03:55:59 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRx032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:57 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqMv/yTvc4PxjTov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M17ceste8Ji34uuTZ4wNjH+5uhg5OSQETCSmTNzD3sXIxSEksJVR
	4tPW44wgCSGBk0wSM++GgdhsAroSi3qamUBsEYEIiYZXLYwgDcwC+xglTq6bzwKSEBawlXjf
	3w6U4OBgEVCV+PjUDSTMKxAl8eDtcRaIZXISl6c/YAOxOQUsJCbOescEsctcYtnMk8wTGHkW
	MDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJJ74djO3rZQ4xCnAwKvHw
	Fmh6hwuxJpYVV+YeYpTkYFIS5XXjAArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4X37GCjHm5JY
	WZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgbfoA1ChYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPioD4YmAMgKR4gPbuB2nnLS5IzAWKQrSeYtTlOLL/3lomIZa8
	/LxUKXFee5AiAZCijNI8uBWw5PGKURzoY2HeEyBVPMDEAzfpFdASJqAlZue8QJaUJCKkpBoY
	J5oKsofPbbzjHCJxUGvT4W8Kq3Weh1yzXHexONnl6/9e//WLZy1OlDB9vfpOqXDvoc3/dkqI
	xhZX3/65cXG8NVNI1NJ7PiflH1muPvtTZvFeL0eRK2UzNB/EXvk//dm23k0Ns/9p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295862>

Extract new function ref_resolves_to_object() from
entry_resolves_to_object(). It can be used even if there is no ref_entry
at hand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1a46f32..8ab4d5f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -513,19 +513,32 @@ static void sort_ref_dir(struct ref_dir *dir)
 }
 
 /*
- * Return true iff the reference described by entry can be resolved to
- * an object in the database.  Emit a warning if the referred-to
- * object does not exist.
+ * Return true if refname, which has the specified oid and flags, can
+ * be resolved to an object in the database. If the referred-to object
+ * does not exist, emit a warning and return false.
+ */
+static int ref_resolves_to_object(const char *refname,
+				  const struct object_id *oid,
+				  unsigned int flags)
+{
+	if (flags & REF_ISBROKEN)
+		return 0;
+	if (!has_sha1_file(oid->hash)) {
+		error("%s does not point to a valid object!", refname);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Return true if the reference described by entry can be resolved to
+ * an object in the database; otherwise, emit a warning and return
+ * false.
  */
 static int entry_resolves_to_object(struct ref_entry *entry)
 {
-	if (entry->flag & REF_ISBROKEN)
-		return 0;
-	if (!has_sha1_file(entry->u.value.oid.hash)) {
-		error("%s does not point to a valid object!", entry->name);
-		return 0;
-	}
-	return 1;
+	return ref_resolves_to_object(entry->name,
+				      &entry->u.value.oid, entry->flag);
 }
 
 /*
-- 
2.8.1
