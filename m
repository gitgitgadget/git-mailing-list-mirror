From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/21] resolve_ref_unsafe(): ensure flags is always set
Date: Wed, 23 Mar 2016 11:04:25 +0100
Message-ID: <5e6741bb89307d74231c70079c6fbf1efa1af1be.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmj-0001Ah-C2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbcCWKM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49321 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754709AbcCWKMm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:42 -0400
X-AuditID: 12074411-fe7ff700000071cf-e3-56f26a4bee65
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.17.29135.B4A62F65; Wed, 23 Mar 2016 06:04:59 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1D018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:58 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOuf9SnMYPpJHYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZvbMOshQ8kqxY9eEvewPjR+EuRk4OCQETiXdbFjB3MXJxCAlsZZRY
	ePkEI4Rzkkli/bwPrCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBRYwSmxcvJgZJCEs4C4xec11
	FhCbRUBV4vPp34wgNq9AlMTVrkVsEOuUJDY8uAA2iFPAQuLkyaVgNUIC5hLbH6xlmsDIs4CR
	YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSEAJ7mCccVLuEKMAB6MSD2/h
	uY9hQqyJZcWVuYcYJTmYlER5zwd9ChPiS8pPqcxILM6ILyrNSS0+xCjBwawkwhuSAZTjTUms
	rEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwXksHahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHRUF8MTAOQFI8QHsjwfYWFyTmAkUhWk8xKkqJ82qAJARAEhml
	eXBjYWniFaM40JfCvPUgVTzAFAPX/QpoMBPQ4IU+YINLEhFSUg2MKtzx896yxb6blL8yX3N/
	utt7ufwn61x38Uv9lp60vTSxw6V5yhIzz9n37puHvdw0TyxM5HOYD+ML6Rtxi++KZq37tJNv
	ygy1W127TVTW8mq+CHcOX9zuceOf+PdlmlKz2tn83jMV8k4/qJAuUPH58flAoXMP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289635>

If the caller passes flags==NULL, then set it to point at a local
scratch variable. This removes the need for a lot of "if (flags)" guards
in resolve_ref_1() and resolve_missing_loose_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 101abba..067ce1c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1383,8 +1383,7 @@ static int resolve_missing_loose_ref(const char *refname,
 	entry = get_packed_ref(refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
-		if (flags)
-			*flags |= REF_ISPACKED;
+		*flags |= REF_ISPACKED;
 		return 0;
 	}
 	/* refname is not a packed reference. */
@@ -1403,12 +1402,10 @@ static const char *resolve_ref_1(const char *refname,
 	int bad_name = 0;
 	int symref_count;
 
-	if (flags)
-		*flags = 0;
+	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |= REF_BAD_NAME;
+		*flags |= REF_BAD_NAME;
 
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
@@ -1458,8 +1455,7 @@ static const char *resolve_ref_1(const char *refname,
 			}
 			if (bad_name) {
 				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 			}
 			return refname;
 		}
@@ -1478,8 +1474,7 @@ static const char *resolve_ref_1(const char *refname,
 			    !check_refname_format(sb_contents->buf, 0)) {
 				strbuf_swap(sb_refname, sb_contents);
 				refname = sb_refname->buf;
-				if (flags)
-					*flags |= REF_ISSYMREF;
+				*flags |= REF_ISSYMREF;
 				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 					hashclr(sha1);
 					return refname;
@@ -1526,20 +1521,17 @@ static const char *resolve_ref_1(const char *refname,
 			 */
 			if (get_sha1_hex(sb_contents->buf, sha1) ||
 			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
 			if (bad_name) {
 				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 			}
 			return refname;
 		}
-		if (flags)
-			*flags |= REF_ISSYMREF;
+		*flags |= REF_ISSYMREF;
 		buf = sb_contents->buf + 4;
 		while (isspace(*buf))
 			buf++;
@@ -1551,8 +1543,7 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flags)
-				*flags |= REF_ISBROKEN;
+			*flags |= REF_ISBROKEN;
 
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(buf)) {
@@ -1573,8 +1564,12 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
+	int unused_flags;
 	const char *ret;
 
+	if (!flags)
+		flags = &unused_flags;
+
 	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
 			    &sb_refname, &sb_path, &sb_contents);
 	strbuf_release(&sb_path);
-- 
2.8.0.rc3
