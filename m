Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC41A0B00
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944033; cv=none; b=ogzS6GJZxrcIekFIZLl+bYW3WliW0gi+pVLdfnhY3k0yZp2MhCGpfdmmEbP0RC1l315H2sD2lZN/s+FvfiEaTWIRSDdfccip5XZQ/tdX1wHePK7sp9X3+1fc9BSHt3ZS+JorakyiJkQni6ecoDJ2m0M4FvfIIuFH5VuxXs1CO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944033; c=relaxed/simple;
	bh=ipmhKXBp3jD9Wy9+SsbeZEJ/N0ufwSSJ35MDNwxRdRY=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=SRTsJk9nzvl28PaLURBruXO8zUfIEFLR2I334AK8uqv6wWshWfmyf94bbsLb+FMgA6FKf/PUA38gvLvHR6EJPhsg8RI7rrN8MmK9EqoWvZl5V8roLLSF0PQNJ+EJ43OWqjJvvGIA4adCUrsjGKJr47O+WFZQoFJii3k1NNVI2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=llSqhJRG; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="llSqhJRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=aEgZivTNeYyss/tXH9MLRLuGAvBoQ+7YOrdIurX3tdg=;
 b=llSqhJRGCPvEdL0+dSkI9G5Kep2sOMepU1UOYempvHk0HLEEifP1/efsrgX8x4JzfXtUQszhyioa
   kPoIii3ss8c45ReY99jCNcW/QU+x4oqD1hHZuOA+MJJg03LBZ4Y1j0Zp/lQ5eWKzrZghFOsOF9TW
   Nsl0jgM6JV8CGJREYh1D1NLfCeXHKaf4gY4AQ8bCNMaSetA6WwxrTPF8ugppthIUu0fKtWYh1DeR
   Sz4F5MXEgJcHjiUpsNTYmagFRtVkPU3GtMUBiNhwDXl+cJr6KeUibWaIqMKlOlKYVZQKX/xcDATL
   3G8GCyHS5McInyINJuVZuMqxGz5SqFE9gD9lVw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500N9ZKKD6H50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:33:49 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 3/9] refs: atomically record overwritten ref in
 update_symref
Date: Mon, 18 Nov 2024 16:09:22 +0100
Message-id: <20241118151755.756265-4-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFvTuQ4QnxnNFVnn7+iC2xfXYfLionyixwsJlGteyHBnL0/Z3kkHEL/JVBOjy1C
 YIE7yhfq6ogUbW6gQDklAhqB5i6nsjAkPr9rD13w+tPVxbknrqy8GbvRf+jcMW86
 J5KtVR9gwyn8IdKa7DUoxC1bhw+2ePjSI/CkIKZFu7gPPy4mEj4dpHU/VAUafMAM
 0NVZDukL4PN36RXjVljkgCvOPe3z4w52LGQIrSLdEgBnZj821tlouqSUpDDfgBGb
 ilk5DVpLQkSwVHiw1lesw46lgkSa2mnK/wSWDAER/zc12McPnkZfJgwyaGLUOzvr
 Qm7Tz012czAdbGMXg/SpNleN9xEgu0ht2DyJEzE4r3gFipMKHyOFRLTFeIWgH0+C
 vBgAJxDvLcSJ6FzgzjfnBcvqhRBA9RHDdCnn6A4TitIeZMDkJKLzJSwhPV8SBlZl
 ATpdFGvywewWuHynupGmjrGlUYZIN0f8+F+tSmhIBwIgTaIcb0jM23ir

When updating a symref with update_symref it's currently not possible to
know for sure what was the previous value that was overwritten. Extend
refs_update_symref under a new function name, to record the value after
the ref has been locked if the caller of refs_update_symref_extended
requests it via a new variable in the function call. Keep the original
refs_update_symref function with the same signature, but now as
a wrapper around refs_update_symref_extended.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    
    v5: - added before_target to reftables backend
        - added an extra safety check for transaction's existence in refs.c
    
    v6: - no change
    
    v7: - remove the whole before_target concept from the backends and
          handle checking it in refs.c instead (thanks Karthik)
        - rename the before_target to referent which is how the same concept
          is called in the backends
        - change commit prefix to be more in line with project standards
    
    v8: no change
    
    v9: - instead of adding parameters to refs_update_symref, rename what
          was in v8 as refs_update_symref_extended and make refs_update_symref
          a wrapper for that. This significantly reduces the number of files
          that need to be touched, and avoids adding a lot of dummy NULL-s
          in unrelated places.
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: if referent is a non-symbolic ref, record the hash in referent and
        signal this with a return value of -1

 refs.c | 24 ++++++++++++++++++++++--
 refs.h |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5f729ed412..c4500a7582 100644
--- a/refs.c
+++ b/refs.c
@@ -2115,6 +2115,13 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg)
+{
+	return refs_update_symref_extended(refs, ref, target, logmsg, NULL);
+}
+
+int refs_update_symref_extended(struct ref_store *refs, const char *ref,
+		       const char *target, const char *logmsg,
+		       struct strbuf *referent)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2125,10 +2132,24 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 	    ref_transaction_update(transaction, ref, NULL, NULL,
 				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    ref_transaction_prepare(transaction, &err)) {
 		ret = error("%s", err.buf);
+		goto cleanup;
+	}
+	if (referent && refs_read_symbolic_ref(refs, ref, referent) == -2) {
+		struct object_id oid;
+		if (!refs_read_ref(refs, ref, &oid)) {
+			strbuf_addstr(referent, oid_to_hex(&oid));
+			ret = -1;
+		} else {
+			ret = 1;
+		}
 	}
 
+	if (ref_transaction_commit(transaction, &err))
+		ret = error("%s", err.buf);
+
+cleanup:
 	strbuf_release(&err);
 	if (transaction)
 		ref_transaction_free(transaction);
@@ -2948,4 +2969,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
-
diff --git a/refs.h b/refs.h
index f8b714ca1d..92622e807d 100644
--- a/refs.h
+++ b/refs.h
@@ -579,6 +579,10 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
 
+int refs_update_symref_extended(struct ref_store *refs, const char *refname,
+		       const char *target, const char *logmsg,
+		       struct strbuf *referent);
+
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
-- 
2.47.0.296.gda1ecfef29.dirty

