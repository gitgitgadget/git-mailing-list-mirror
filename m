Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65966193071
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378461; cv=none; b=g7emaFPJfgG2rSB4rxH2kq2EoKxorTPBLJ6z8VYOqN4d1N5kXUTAfGVnJjwLPMMxYiSy1lK1U9rsAU9KrNTCcR+8cPSyo+s44zF0ydnyvb6KNWI14EnIrtM4JEpu36B3yMv08RZu8ZfwqqLUqKfqqwVCDsCQUA/3RT4ObWShmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378461; c=relaxed/simple;
	bh=FnxGgNiDwgZd72c0sN9vmEydkdwK4sWkUSWR9I3xiF4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=nxIs3IatSKIDlDjDaSuex0mSQzcQYFXCylCi4OYfBB1R/L8tpxOOuleMVvuN98NmspRMIWwzALwmUpX3LkUu4x4qWwnNZZ0rjMZUxUUtRmUJAwWlJPpHqO4ne/bNAV12QuhLw34k8MVC1t2gIh+QDyzT+UvXHrotHOoiXh4UIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=cBy/0PfH; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="cBy/0PfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=8owQW0rvZHjOBrV0W1XeNVff3rTdLJ9cbhuC0LhDQZg=;
 b=cBy/0PfHpbXIOcZi6MfK2KLnv83l3CLRO8aQfavfoYm+yBnGkzLmBpq0zcna+eLpDrillPo2o1+Y
   fFykeJr4E2dXdBXWAU+Q4rKamvYMfCliy5UZrN4cKSrUNZVseklXa0TWiBPz7nak7kvi843HkVf0
   jC42qjHMscrHTAfXKB2N6zNzE5dGSLMz9Rn+gzaodO726+GnDUzVlzVY46MO44E/DwuYe/Bd0/am
   kQY+69nVzb0GWLncg5v7+lMNq0hnYq0THITOq4PCz4I0g1Ue0/+OYjjZmVE1zPvYpHD9npy9F/yN
   PrFy/w62QUysxrKkx9g8/jruW9Lum91qKoPzEQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM003MUKYBA110@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:11 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 2/7] refs: atomically record overwritten ref in update_symref
Date: Sun, 20 Oct 2024 00:53:09 +0200
Message-id: <20241019225330.4001477-3-bence@ferdinandy.com>
In-reply-to: <20241019225330.4001477-1-bence@ferdinandy.com>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
 <20241019225330.4001477-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG5c+B7OrMmi4a7Ddn1G66z4zyF1/W3ghMBkREf/BIoKsu7XPz8tQlXhYV+JvqZ
 aYRnLBZkHkQCRaZVkpONY5GW0wI/MaiSXAQW3rY7hLJY2zi2qOalUqSBIJjYc9Sr
 ysrFZkM+5LKJQtK8dwee9AAAestAO8Z32s6aFEbUihxml6XUk56et3bpphaEZmO5
 1sHfy6Kda83Qi66ZXzs2KCN9agaiz0lzjiMAAQ2OIxKqF4rztgmyxCmYrbhpq8kj
 Z3Kl2qlZZyy/+3rdGbdX6f0mgP9SRpvPNqbAcYEinWptK5BLkDso2UikZphkFVa1
 ij+YKT66T3QcrwpZv8ayHbuzA7/lv7ADROgPKWtZJCztI/hh/wJrVZrt9a/ZhNSl
 2aJGCcQNl+wqjiRSsy8soXmazP6kA3qC5+DNk3xKzcKXu/xPsVJKVjzY3FXOsQ/r
 HVOpXyzXwh8bexsZPeqH6daCVn0fN3fMczBc27sNpKKYKnHhTr+CJxop

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
2.47.0.92.g83fdbe24c3.dirty

