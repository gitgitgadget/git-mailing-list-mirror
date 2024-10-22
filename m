Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A11CB328
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626525; cv=none; b=b7pHjDJgPVjpI67xYTw+jIY7Cw+V2+gpiTb4He/9Xgu33DGsrxtpqcPR+4Lk8e7FXXu9BLLp08zKvH6tWQoN+uUuYpuHM35WGqUhOs0uXQ5ZyQVNJFGMoFgnW0BfZjYjP1X1dsuIdHyfrvt42lEPlBdgz9lNotaZFA6v2aXYd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626525; c=relaxed/simple;
	bh=VTygttXscxWFz7ZWLZTX0/AbSUWJswHu7dHLPY6K9fQ=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=OKNpnkgcO9KukwBbjZfebxXJ+ZzfVm3YFG+gHYqbxgHKLjU0kup0AX/CNaIfn+MzssEwz3NbisB2x7p9OXAk3ocWY61sFE9d5ZTn6E4jonoYHn0tcbFCX6mjta8JT37XTTkMqX/DoYK+ydRtJLTZgbSbylXup1DBLaCTS5tY1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bGl6MAXq; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bGl6MAXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Jc+LeolyUGuhhyqYfKhY2crtD6ChCc9pWY10P8TLfRc=;
 b=bGl6MAXqUKNUy8lizR/0j/rB2LJuQmRv5UkrduQuYIo95KLtGvVL4zhSJlOBhHzcDaCil2KiR6ie
   wa+n5mSfKwc58+yS0F6xNdpjl92zb3aFZcILCUw5Rsg6Oje0ledEDXsAW7PQ48qDjwwsbzE4OB17
   zu2AbK37459nSIFiXNWe2TqD8aohxZwqG/EW4b4/JK/VDm9qpKLy8JyTDZlMeSEQb5jDLYP/f19c
   gNgjYnwU44MrSBMRUg5+6rM1PFasQh8sD8cGWb3wxkM3KFvkAVUs0ypyq3JuhMDSVTHGwTZ7qgwN
   CqH0/lFkoxX6wlQ78tWyjqNthfhgAHt58woWNQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00K1GWD46930@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:48:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 2/8] refs: atomically record overwritten ref in
 update_symref
Date: Tue, 22 Oct 2024 21:45:39 +0200
Message-id: <20241022194710.3743691-3-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG656Mgg8rkdVTkhA9mTB/tlXmcC2Vv9h4yPU9dKJPc5HdMkMGX4ZKUOB6YvE+z
 l01DlZftdJvDV31NUU8L4CQpbNnTHNWvBZg7iNIQOO66hrz7MgiaY3u70agZch96
 a/XDj/1D+Nm2j8IDVM4SV1Zbtsnzc6IinnQxHgS4hCg/YAcnEZMJnxoUTiFqX9kl
 Y1/bJgOaqJTiL02cjkhxATga4sssrIflLgDsuH9lTZDUsrTIiRoEpkRWzNYarcqW
 bMMI/jtuNXS8xr+tZ7GPO7klEaxpTk9pu2OXK1LM/otXh+8l/ZrU4XvIDZiwzjqM
 6/gzhIaSRDxpLlVEvQBMWNHxPsw2I+aAlMrB7UBqiOYP4ZQB+MYn6YZvnKVYF8rd
 xfcMxsgnWcgo6ybnJ4RLq/72pei5/g7GPB/1/FGDWw9+pq+4n1dKkKx9ZtOrByif
 kOoqOHhaZlIdI0A7+HWPe297k0eJH4gJ4x3Bh17dxEGAuBaOA2TRdRos

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
2.47.0.94.gb64850d498

