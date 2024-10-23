Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303A1C830E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697941; cv=none; b=DQioJzWv85D80Y7kH5PMgyqsJd2L3McSusPZ8HixfdWHE73v3jZweNv9Wssz8nYdfSraq5cWoBbRsmpCky1SB+/qZ5L2fVgxCvPK7z2sliuQqhDuEQGLV6zFg20jfHWaLLTjzjF4hO+0rCZxZayS031torBKkdce0DZUuISlARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697941; c=relaxed/simple;
	bh=bXvTZQGeUwj9IMtvaSAroD86iaieS3fX5TW8vkmZ+Vs=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=qyh9NsmmlMgTQpxDDcxL8RTE/Xp9+y/ZnGydgq+MRFmdiFxMc1UhGfXczxv/H1eFJdI1ZaWfRg9SHX+QCMO4u+U3Tbr/2MXwY2Aj8IThqRFYOcpbacg/1S8Mcq3sXB2ilazGXm8YZ0uEGX+uJgDsZYXN8mL4dQZJBDWBuXGym6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=i2iehEZD; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="i2iehEZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=r3YzIas3hXmT+W7GTGOkWh6FYVNENTVws6l8XQ3OJsw=;
 b=i2iehEZDBM+ePzOiikHd+ZyH85GO3t02n/8vVDc/oEsv9FPmypsvtrU/zl/0qRjrRb1kBR3V7XFX
   9N+2/ciY6tgmYcqRtt8io6SQjAv58Qu7ctPqoZpypFVyKnsVMabl/jz79oqY3aIeOswgKC0lloKQ
   TzWOnuCv+e6KBQlA5CNMGRuN7QNtZhqmB5dIw4O983gNl7SyBGM47p/5idovSu3elhMEO5cEXTtr
   6iwe+WoNYjRsBGROCSYB7I+qxo3zYSjs1NDgIElkgN1+gJaRhxkSYcCrsc/zqf3uJdXW47/oOlHG
   vP68YFaaxiaqYAgibehQAUkRdUBOOWgxFVlRSQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00GJJFGX6310@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:38:57 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Date: Wed, 23 Oct 2024 17:36:36 +0200
Message-id: <20241023153736.257733-3-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHga5qOGorNuvmHmhapyIDcER9Z6VndegMy0EomVTfTJBTnv46W0LD2/CSnIxbl
 ivQOw8xmxZNpKyrgDZOWgjztUU8wcwrPJFhKnBnVQc2nq7Ns7g52CvnvqoPSKbn5
 Yp64hgkuFxkixlWyejjPR7Wdy1spP6taVZwhFdQD6K0TFwO5FOyyrrlI773+xxof
 UTjj3m34jL2PardQrkaarLudkpKXkxQ3zH0vs5FFChArdALf819HzH1Eo98lBjd/
 1DTd2biMZGL4GdVjmIEL9phy4SgUdxWUlc3gwiq8kG5RqxHpgg81XAXfP2zNgM0S
 G3YWo+972+4XmmdAHNKroD0yeu2e1dAdSV5Igdm6VDR42G4N4czCp8NPVV91rXNo
 03gRT1FYm0ToeYk5YC9JNK8PudmbmP1OldaStg/lopBRY8wRhXCb2IBiLkM0NgB6
 v08cm8PXZq8xAV8WLGMOIUKnx02vgfyjNZI7w2DLaCoMGYnTi422Kss=

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

 refs.c | 19 ++++++++++++++++---
 refs.h |  4 ++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 5f729ed412..24a4172cd2 100644
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
@@ -2122,13 +2129,20 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, NULL, NULL,
+		ref_transaction_update(transaction, ref, NULL, NULL,
 				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_prepare(transaction, &err)) {
 		ret = error("%s", err.buf);
+		goto cleanup;
 	}
+	if (referent)
+		refs_read_symbolic_ref(refs, ref, referent);
 
+	if (ref_transaction_commit(transaction, &err))
+		ret = error("%s", err.buf);
+
+cleanup:
 	strbuf_release(&err);
 	if (transaction)
 		ref_transaction_free(transaction);
@@ -2948,4 +2962,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
-
diff --git a/refs.h b/refs.h
index 108dfc93b3..259191a485 100644
--- a/refs.h
+++ b/refs.h
@@ -573,6 +573,10 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
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
2.47.0.94.g1247fb88fd.dirty

