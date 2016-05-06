From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/33] ref_transaction_create(): disallow recursive pruning
Date: Fri,  6 May 2016 18:14:00 +0200
Message-ID: <e053eafabefce5e91ef00fa69f0ff33270507de2.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPE-0008Kk-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698AbcEFQPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:01 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63750 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755867AbcEFQO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:56 -0400
X-AuditID: 1207440d-bb3ff7000000090b-cd-572cc2ff0d89
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E2.48.02315.FF2CC275; Fri,  6 May 2016 12:14:55 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV1031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:53 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPv/kE64wY9v/BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oy1DfeZCh7yVdxY3sjcwNjE08XIySEhYCJxe9Y/
	xi5GLg4hga2MEifWX2KFcI4zSUx80M0KUsUmoCuxqKeZCcQWEYiQaHjVAtTBwcEs8JlRYiU3
	iCks4CexdaUjSAWLgKpEy657jCA2r0CUxNrt8xghdslJXJ7+gA3E5hSwkDjUexxsopCAuUTH
	2hvsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICS/eHYz/18kc
	YhTgYFTi4c04qR0uxJpYVlyZe4hRkoNJSZT3e4FOuBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3iv7gHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneoINAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg8I8vBkYASIoHaK88SDtvcUFiLlAUovUUoy7H
	kf331jIJseTl56VKifPOBSkSACnKKM2DWwFLJq8YxYE+Fua9DFLFA0xEcJNeAS1hAlryfq4m
	yJKSRISUVANj1y2W9Seb5m68mC04a93Xry5/4vb92/Hi45Zs5W0dbDIKO0uESkr8Ti1z1trN
	czTSbXlemuyvgL3uNfPnOi1+u9iG759VmknSCr61s0xfLos2ryi0miClPWORWoFr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293808>

It is nonsensical (and a little bit dangerous) to use REF_ISPRUNING
without REF_NODEREF. Forbid it explicitly. Change the one REF_ISPRUNING
caller to pass REF_NODEREF too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 3 +++
 refs/files-backend.c | 2 +-
 refs/refs-internal.h | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ba14105..5dc2473 100644
--- a/refs.c
+++ b/refs.c
@@ -790,6 +790,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
+	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
+		die("BUG: REF_ISPRUNING set without REF_NODEREF");
+
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5a597bb..7cc680a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2087,7 +2087,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, NULL, &err) ||
+				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index de7722e..1f94f7a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -15,7 +15,7 @@
 
 /*
  * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
+ * pruned. This flag must only be used when REF_NODEREF is set.
  */
 #define REF_ISPRUNING	0x04
 
-- 
2.8.1
