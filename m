From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 30/33] lock_ref_for_update(): don't re-read non-symbolic references
Date: Fri,  6 May 2016 18:14:11 +0200
Message-ID: <bb0e9b5dd81738f584d3e0b11907345721b0ed2e.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPU-00005T-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731AbcEFQPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58926 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758725AbcEFQPP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:15 -0400
X-AuditID: 1207440f-8bbff700000008e4-22-572cc312f386
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F6.D5.02276.213CC275; Fri,  6 May 2016 12:15:14 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHVC031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:13 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqCt0WCfcYMV9DYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aEF1PZC7rEK66taGdqYJwp1MXIySEhYCKx4Pwx
	9i5GLg4hga2MEnPv3WCDcI4zSUx585UdpIpNQFdiUU8zE4gtIhAh0fCqhbGLkYODWeAzo8RK
	bpCwsECYRO+x66wgNouAqsT9e5NYQGxegSiJZ1d/MkEsk5O4PP0BG4jNKWAhcaj3OFhcSMBc
	omPtDfYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQEGP8Oxq71
	MocYBTgYlXh4M05qhwuxJpYVV+YeYpTkYFIS5f1eoBMuxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYT3yj6gHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgvfQQaBGwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAExBcDYwAkxQO0Vx6knbe4IDEXKArReopR
	l+PI/ntrmYRY8vLzUqXEeeeCFAmAFGWU5sGtgKWTV4ziQB8L83IfAqriAaYiuEmvgJYwAS15
	P1cTZElJIkJKqoEx3vZasJTGhx4vA4cqw/1GG8/viNhz/iCTrOXdO8t6l6jMtZG1DmBumFS6
	eO/+58xlRU+ytybe3fXCysiYfc/7QkfR4D8F53Kftuv2LzXiSXu2x22lfuPUmK1V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293814>

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
index 799866f..a9066ba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3430,33 +3430,45 @@ static int lock_ref_for_update(struct ref_update *update,
 
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
