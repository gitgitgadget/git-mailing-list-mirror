Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B631DE2BE
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230645; cv=none; b=KiIPqyoscddpqg+JEqD95Ct1pRD46QCG1xLe0KFLXQowB7vGqSKF1aDELijgJeqM74QZaGwWsCSNSsePpZixqHAOPp8R1f82gkh2P8dykregWSxaBrYpqYSkuWKY97kF9eNf1VpZuF1ahsXOUBlqQx5QsIq53mC98ENej3QI2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230645; c=relaxed/simple;
	bh=RMD7ipS9Lrmi4Ok2gplebtj3G+YtrK8s8QrlTX0zITI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Hv4IQIsQiLNN4me+pKWJM5zttVbELgVXbtR6TPCfKHVbL07kMLug2CUKbSaD7hCKtQ9gPijRo1gw3PdTu7E78MfEOdWusKP8N0c9R1Wf2KA1DFEm3GSAMYD4Ck9pEH7Bsjr5PHGnBtgvEGGDBvIOhlGzVxXn3S1xXkiIUyjXck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=FNeA76Ea; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="FNeA76Ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=vexDFwDnzD51w1DUvKeAivKzWPFPoQ7ms9Bv5bu2X2E=;
 b=FNeA76EaJevZ+k4t+GPefQpwqUW8XvdOpoG8daZse9ZoFbGjsqcsPIKFDB18IWVQdsMB8he4d8DW
   Y7ltzpavcL8uCcIQ5enaoCnDfQ4IEsj7DawGFI3vmkumh5sA4XdUPepe1If5lSaWlrFWdlqnD9pl
   +0TxVP1gkl89W9MHnvsjw8v5DaNqrVZNpJo8p7R4jkaiO0Jx4BrepGh5QWXyDbcSGLTKhTlVtRDZ
   rRzXVKdEgbOBIUqOAI3FRQKWPs+IQ65SKIGHMYOUvmo4+f17qIv6BrK/Ew+3guy3HEOGMipd9lk3
   CAYP5N/Ch9kZp8k0XzVRp7+vd5Se7jtBl041Rw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00BTMPPS0770@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 08/10] refs: add create_only option to
 refs_update_symref_extended
Date: Thu, 21 Nov 2024 23:55:08 +0100
Message-id: <20241121225757.3877852-9-bence@ferdinandy.com>
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
 AAHhvjVTsuHmBCPUrQOL6MO+xdHx7LLWLQsTikv1tJ+ekdKIG5aMsXK/QPMYOoHV
 0/XbNXs+MVi+NbzsHfkdxHWW56COkth9Cg1Kte6beGiUhyxJjnJUdqBAPlugCqtt
 PjMINLV8Aixomxm8Fry5RFQCfLpQpU87BSyNfgIKeNw/OIzIQ6jh8uMyPW1xGlIE
 tToojkR4yQJEKBwslKgRFzK/TDEWHqjNIPnOLDAkeLwaRA4ERCDS94K5y8mipScB
 eeZDCjYZpAmVVQHN9AXEMJkZCluV/VJ13TVhL6jYz5HV3LI4E4CrsGoWE7pw87Nn
 TrE1NPfhLkrKl7+srn4tAMTMoCMGdRutqo7gDXCQmVFFOuBmq8yLRc1Qge6NUn5o
 2U+RTWciDpqCOLt3WL58ZY2VE/AHFQkXJe0nlszbujakb80Yxgrpt9ifbg193ZOD
 5paESco7OGNl954GZCQuafUwsoYao/54mHFTX5OLHWYwoXN/Ud9KxTg=

Allow the caller to specify that it only wants to update the symref if
it does not already exist. Silently ignore the error from the
transaction API if the symref already exists.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    
    v6: - switched from bool to int for create_only
        - refactored logic in refs_update_symref with goto as layed out by
          Junio
    
    v7: - change commit prefix to be more in line with project standards
        - refactored code to accommodate changes in the first patch, but
          otherwise no change
    
    v8: no change
    
    v9: - no change (except for following through the
          refs_update_symref_extended refactoring)
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: changes only due to changes in previous patch
    
    v14: no change

 builtin/remote.c |  2 +-
 refs.c           | 33 ++++++++++++++++++++++++---------
 refs.h           |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6d659d63ca..3dc1135b5c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1476,7 +1476,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-			"remote set-head", &b_local_head);
+			"remote set-head", &b_local_head, 0);
 	if (was_detached == -1) {
 		result |= error(_("Could not set up %s"), b_head.buf);
 		goto cleanup;
diff --git a/refs.c b/refs.c
index d80efd58f0..2efa6bcc5c 100644
--- a/refs.c
+++ b/refs.c
@@ -2116,26 +2116,38 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg)
 {
-	return refs_update_symref_extended(refs, ref, target, logmsg, NULL);
+	return refs_update_symref_extended(refs, ref, target, logmsg, NULL, 0);
 }
 
 int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent)
+		       struct strbuf *referent, int create_only)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
+	int ret = 0, prepret = 0;
 
 	transaction = ref_store_transaction_begin(refs, &err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-	    ref_transaction_prepare(transaction, &err)) {
+	if (!transaction) {
+	error_return:
 		ret = error("%s", err.buf);
 		goto cleanup;
 	}
+	if (create_only) {
+		if (ref_transaction_create(transaction, ref, NULL, target,
+					   REF_NO_DEREF, logmsg, &err))
+			goto error_return;
+		prepret = ref_transaction_prepare(transaction, &err);
+		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
+			goto error_return;
+	} else {
+		if (ref_transaction_update(transaction, ref, NULL, NULL,
+					   target, NULL, REF_NO_DEREF,
+					   logmsg, &err) ||
+			ref_transaction_prepare(transaction, &err))
+			goto error_return;
+	}
+
 	if (referent && refs_read_symbolic_ref(refs, ref, referent) == NOT_A_SYMREF) {
 		struct object_id oid;
 		if (!refs_read_ref(refs, ref, &oid)) {
@@ -2144,8 +2156,11 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		}
 	}
 
+	if (prepret == TRANSACTION_CREATE_EXISTS)
+		goto cleanup;
+
 	if (ref_transaction_commit(transaction, &err))
-		ret = error("%s", err.buf);
+		goto error_return;
 
 cleanup:
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index b243739e4b..be38377b1f 100644
--- a/refs.h
+++ b/refs.h
@@ -586,7 +586,7 @@ int refs_update_symref(struct ref_store *refs, const char *refname,
 
 int refs_update_symref_extended(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent);
+		       struct strbuf *referent, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
-- 
2.47.0.298.g52a96ec17b

