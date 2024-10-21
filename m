Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B461FA26D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518288; cv=none; b=etBBJ3Tj1krjgustm8GlmxyuiEqNCEpnqmBvedd2K5En1zCQC8V4c3m8cBZXltYhZ6vpGl3GLMjqNGgIIF1jPhUGqYVV77C2RBVScpuECVWU37RaWQUiBQNSK3fxZzDvM1GBnkN5eOxWEYqd0f5BzmNZvzr9NjbCGyN4v4QzU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518288; c=relaxed/simple;
	bh=NXpTnTRn28vKTmbWWmXvRaNPTwlBbtLcTo7Xczf5tlk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=rcylZR93MXoASTiEvb5UWbcnTiJLQ6owxgZgGB24BQyr5vsEwCb/Pt6KXoiQrQcP0gw52mCeBYUEx2mmJUmlSt/E3bVa7/ErFaOCepYC+RK5GtwTnClGDAy+V7mmxlFdoZrE9u7WUXsiRC0dyqdyP1xjebV+fG0ACJ4F1pY28ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=D4Ilbn10; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="D4Ilbn10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Bf6Nz1x7eiUzmV4fsarqH1orb9BSX9OXdCDvuSQ59dA=;
 b=D4Ilbn10tIiK7biLag82u8tT+XjoaG0T0405nArQcxWxJwzW9BykZ9kUJABmmJaD/8P+ZWhvamYs
   PzF9v6Q8IrAtMMaWhTJKJyie7IcPwQlnlzjfGzGouIIAn6A7ZJASSdbHGjf1umZeARVRgLK6tE6W
   mlNah+F2oiGgTX+YggtzwWL4UtiB6rGgWv9cvsIjxi/FEUiyj+rD1Cor03aEubq9Xey5WqKHOYhw
   atUWjHbUCy42Xm7wSW4wo8Dmrk9FoCjkN58rFkJrG5sGp7S8c+irVmGeHdtloVW8J1mGoLhubC1h
   cX4BSYNB6voftcnveTnyyRHwUyP3VUIYvLfxCg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP0072CKUJRM00@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:44:43 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 2/8] refs: atomically record overwritten ref in
 update_symref
Date: Mon, 21 Oct 2024 15:36:59 +0200
Message-id: <20241021134354.705636-3-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGKQKp0eSHkB/MBfNPQLYFnMiOGBdGLhzF7U4/j75BiK9nU/kpGSfTnKXbeOE3M
 ++x4+j0FghhrTN7ScZ0Q+hHho01Zki0BZtS1wzkeHZw1940J2Sg727FPMWn+ih4f
 9MkSwO3UxunOIxZZoSBS54q1Rl/VR1DGmNeSAyLPqGGiPA7t42jQzCXXJ05jwLPC
 d8TABs0bfHOnasv3bSDdFw31c4Zgpxq/XMTYtvcANzAjNX+lLqp2lZwR0Mo3fu78
 2SfpGVRM3ZMY8Yf75UWECKLoKqPu/bvcBDwbpieJg+rpDKNfb1Uh8WkQNYCETNvk
 zruTMYx2OupNzYF7fzn99EQAxIAbzxrkvPCzGXTRPivP7FjgI2484OM1gM52sZ/P
 mGxmeLQnUC5H8JKiBmbagyYkzsnrPWr0QxxjVp4bBQKE3ZmR+5J7nB7iwzuCnJrj
 FxQMa8wHcMcsV/b4l1XL1KFIGWeY0KngxmaKGmUDIw1W/+oxXjiqzlk=

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
2.47.0.94.g8861098b6d

