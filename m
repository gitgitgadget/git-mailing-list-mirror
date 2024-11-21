Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62221DDC32
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230627; cv=none; b=ebL0P5QNyPe2EHHD9fzDDIhIkY8UMceObdO3HLvCqswnoxdKLlzUPGDcjoUiMrh1osT6AvJ2zAiidVzLQkk5JE0b0OoGj45HSbsrK3Z4tNxeAMnrSr5mgtrybiqgXrxRnvO9OcX5r6TW4ELqIK9E/663uY0GX5Jr+gse/fLI7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230627; c=relaxed/simple;
	bh=ah1K43U4f/hyrgeXRIHKHQ689TLTPHB2aRF1mrW2hRM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=OWV4dJYXL2umEdsJJIj0jZHt3F/PoEuCGBbJMfD9tvjRJdrnb7hwsuLJ9BG4e5e+DjIwf21Aog+hrqWzM0VmH6zRHmuTL/dVe6EpEN7hDSO/qA3XlfVyJYgtoFDbmCwe6DXhlyiAzPQCbCnPXl2jY7CPpH/V2GRl4ClezIdXgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=XyNbvDNF; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="XyNbvDNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=k7Y0Uv/+c4AmjL6gWztEvG26P7yAMkDB0uPscSMsBhQ=;
 b=XyNbvDNFKmWfVtgNpSAySwkk6LRlWaxXBFhIkYzTmacDyxbPHIGXEg8Ku/Bog+viSVWJKt+JZbxQ
   1eTcW6RIFljMTtk7lsWi2BdHHE+47/WJ88EIG98V0nhf9s5TQtBKM8nFRalcM27fICrufS9zU2cK
   TjUIkSCpsjwlWKDy/lkyQ+kmQ/kww55hZb/3HGsgJZRIuRcp3YQlgG9PKE9q8D75uAHbeJbxSDRY
   cxy3mRI1cc+EUiQCpq4m2NfUiQD6/Dj3eP55I3zCWMCZcU57KMTXIG+LGS/0ihM1+OtCgP2wYQq4
   46kZZMLciwAB7v+sn5tc4cCI0zoCKi4TkihtCg==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00MKTPP57J50@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 04/10] refs: atomically record overwritten ref in
 update_symref
Date: Thu, 21 Nov 2024 23:55:04 +0100
Message-id: <20241121225757.3877852-5-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHd84Hzpuqkwcc35CxQIH07TVs1gyHKWGJbWSYW9PUVbdWjPAD9MsAm+uD4T00S
 KKfP9LBszRWf7ki3EBKSu86foe85HPzO9kvmAlx5cFVWOkSJxIrVxMorV8wfh6V9
 8QqGybvbd2w7VgL/v2baIKVaLoumFK0j5aZTjcvVpao44MR0MuPu/aS06uWujWPb
 K5F9+9DaLBBTnOff+gHSQTPnO/Mg335zSZOHDzdKtRUBfw3dquOJ8K+pwEgAHMO/
 WaTdh9v7NGHP1/wQIBbV6ybQkRENDAJlLsUVuEqwu5LQzR1VrLQyKhwyGgjpV0WI
 129LdPHRslihdC0QABJXUKsakI+bHYcdq32J/urc088w9RX3y6OaUjvkp7qa0Wka
 IRBX1rirtPleS+yVJhEQanevHBcOBIg32Kv9VhXkPIu2uxosyW+duU3KOluU1Xmh
 xQ95PaWdopyUHZm9tGK7n+96Q9cZlgTDKiRtlF1S/JLTkhUUqm3inmDf

When updating a symref with update_symref it's currently not possible to
know for sure what was the previous value that was overwritten. Extend
refs_update_symref under a new function name, to record the value after
the ref has been locked if the caller of refs_update_symref_extended
requests it via a new variable in the function call. Make the return
value of the function notify the caller, if the previous value was
actually not a symbolic reference. Keep the original refs_update_symref
function with the same signature, but now as a wrapper around
refs_update_symref_extended.

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
    
    v14: - mistakes were made: trying to read the referent should NOT lead to
         an actual error, even if it doesn't work out in the end, that part of
         the code should only set the return to -2 or not touch it
         - the returned error code by the above was also incorrect and now
           is -2 (and uses NOT_A_SYMREF now)

 refs.c | 22 ++++++++++++++++++++--
 refs.h |  4 ++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5f729ed412..d80efd58f0 100644
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
@@ -2125,10 +2132,22 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 	    ref_transaction_update(transaction, ref, NULL, NULL,
 				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    ref_transaction_prepare(transaction, &err)) {
 		ret = error("%s", err.buf);
+		goto cleanup;
 	}
+	if (referent && refs_read_symbolic_ref(refs, ref, referent) == NOT_A_SYMREF) {
+		struct object_id oid;
+		if (!refs_read_ref(refs, ref, &oid)) {
+			strbuf_addstr(referent, oid_to_hex(&oid));
+			ret = NOT_A_SYMREF;
+		}
+	}
+
+	if (ref_transaction_commit(transaction, &err))
+		ret = error("%s", err.buf);
 
+cleanup:
 	strbuf_release(&err);
 	if (transaction)
 		ref_transaction_free(transaction);
@@ -2948,4 +2967,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
-
diff --git a/refs.h b/refs.h
index 22c2b45b8b..5c46ac9f34 100644
--- a/refs.h
+++ b/refs.h
@@ -584,6 +584,10 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
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
2.47.0.298.g52a96ec17b

