From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 26/29] lock_ref_for_update(): don't re-read non-symbolic references
Date: Wed, 27 Apr 2016 18:57:43 +0200
Message-ID: <d49fab134766bd2e2d2592f5cfd7cd06d1182536.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSo0-00040G-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbcD0Q6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:51 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59417 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbcD0Q6s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:48 -0400
X-AuditID: 12074413-487ff700000008c7-7d-5720efc7043f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 80.68.02247.7CFE0275; Wed, 27 Apr 2016 12:58:47 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6d022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:46 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHv8vUK4wfRtOhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owTnTNZCrrEK5bMWMHWwDhTqIuRk0NCwERiwbUH
	zF2MXBxCAlsZJe5NOMMG4Rxnkjh64RA7SBWbgK7Eop5mJhBbRMBBYvnKX+wgRcwCTUwS35c3
	sYAkhAWCJRYvfQVWxCKgKnHg9WmwOK9AlMSdPetZIdbJSVye/oANxOYUsJD40vqWEcQWEjCX
	WPJgNfsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUKCTHgH466T
	cocYBTgYlXh4CyQUwoVYE8uKK3MPMUpyMCmJ8i45CxTiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wjv9DVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBe/QdUKNgUWp6
	akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KArii4FxAJLiAdpbCtLOW1yQmAsUhWg9xago
	Jc77GiQhAJLIKM2DGwtLHa8YxYG+FOa9AFLFA0w7cN2vgAYzAQ2+fEgWZHBJIkJKqoFRhDck
	ifn3V5FDlprMG3883S5w9VuNioO5NJ+f+v7S/mUf355++mB1+aZnB7YEm7U6285osWPYuGRt
	ilKm8RR1y4sPGZqe2iy6d+javL12vxU/iq0KnPFkVvv/fQ7W5zSYOxRXmyqr3Hyv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292757>

Before the previous patch, our first read of the reference happened
before the reference was locked, so we couldn't trust its value and had
to read it again. But now that our first read of the reference happens
after acquiring the lock, there is no need to read it a second time. So
move the read_ref_full() call into the (update->type & REF_ISSYMREF)
block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d0e932f..66ceb83 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3427,33 +3427,45 @@ static int lock_ref_for_update(struct ref_update *update,
 
 	lock = update->lock;
 
-	if (read_ref_full(update->refname,
-			  mustexist ? RESOLVE_REF_READING : 0,
-			  lock->old_oid.hash, NULL)) {
-		if (update->flags & REF_HAVE_OLD) {
-			strbuf_addf(err, "cannot lock ref '%s': can't resolve old value",
-				    update->refname);
-			return TRANSACTION_GENERIC_ERROR;
-		} else {
-			hashclr(lock->old_oid.hash);
-		}
-	}
-	if ((update->flags & REF_HAVE_OLD) &&
-	    hashcmp(lock->old_oid.hash, update->old_sha1)) {
-		strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
-			    update->refname,
-			    sha1_to_hex(lock->old_oid.hash),
-			    sha1_to_hex(update->old_sha1));
-		return TRANSACTION_GENERIC_ERROR;
-	}
-
 	if (update->type & REF_ISSYMREF) {
+		if (read_ref_full(update->refname,
+				  mustexist ? RESOLVE_REF_READING : 0,
+				  lock->old_oid.hash, NULL)) {
+			if (update->flags & REF_HAVE_OLD) {
+				strbuf_addf(err, "cannot lock ref '%s': can't resolve old value",
+					    update->refname);
+				return TRANSACTION_GENERIC_ERROR;
+			} else {
+				hashclr(lock->old_oid.hash);
+			}
+		}
+		if ((update->flags & REF_HAVE_OLD) &&
+		    hashcmp(lock->old_oid.hash, update->old_sha1)) {
+			strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+				    update->refname,
+				    sha1_to_hex(lock->old_oid.hash),
+				    sha1_to_hex(update->old_sha1));
+			return TRANSACTION_GENERIC_ERROR;
+		}
+
 		if (!(update->flags & REF_NODEREF)) {
 			ret = split_symref_update(update, referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
 				return ret;
 		}
+	} else if ((update->flags & REF_HAVE_OLD) &&
+		   hashcmp(lock->old_oid.hash, update->old_sha1)) {
+		if (is_null_sha1(update->old_sha1))
+			strbuf_addf(err, "cannot lock ref '%s': reference already exists",
+				    update->refname);
+		else
+			strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+				    update->refname,
+				    sha1_to_hex(lock->old_oid.hash),
+				    sha1_to_hex(update->old_sha1));
+
+		return TRANSACTION_GENERIC_ERROR;
 	}
 
 	if ((update->flags & REF_HAVE_NEW) &&
-- 
2.8.1
