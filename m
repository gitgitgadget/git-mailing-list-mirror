Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649E1BD9F9
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944050; cv=none; b=QMeiw21yywNUmwo300RjDibiv3EB/i65tLyAfYYU6P/YHz5m9AjbMmRee62t1RzWvq5syvRV973XCQ1cmKdcNo6DiGA49kSvf282pfjmKhkG1y0eCx6ZlXjS6Ff9fB1P/hNbDeaCP+0SqRUpEUqjCPT1oeKWMkscDJ5UwXQALpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944050; c=relaxed/simple;
	bh=twJxpOquM4+tk/i9yGtG1vz+ijZR8lIWttyQFpXmhlc=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=C3Y70Re5G/ZRtsw+vuJ1u3abpu7MGr3MC9Kn5nrvaNhTewPpIYAiytSAPgR0ByYdCNdb3L187LmcTSs7f80Wzf3AUFfUNcd9OX2oUZKLFd0zVVVacVykar3gqcPIPG/sgV7o4LY8Qh1XssDwhf8ML+fWtVT7b5gXhjzxrAPUW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=LXejNqWg; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="LXejNqWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=4l8o8R38PEk7/NiajcXZi4lXnHS/keAUJzzBBG1mfsc=;
 b=LXejNqWge3jXzpww5WWqfwtfWZT1rAjOIm6JodJgbJ8Bxau55sk8snnmpxK8ndGlg8riX0hVZQXu
   VznoYziTaAHjWiZgaoyBjMGf4LCb/rKpTE6QZNt1RiXzPTKLdtZsZhfusZ4Q0WYwx8PhhySTAzAd
   NP8CxL22DxKebidfc+scrhi1E2kHrSC1pCqY2qzywv6Ok3HPPbVdSEL0bageTvW+hEFNFaMRc1U0
   fhofUXVVr0dA/h1c2XpL6qPDdv66CBMcVUCT8v7psyLPCQq9ro8II3z7MXVxYu/7vZeM2Xd7lMun
   3BVDhktYH3cLF4SNhuB1fbWvP91psN9SO7DTKQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500NAXKKV6H50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:34:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 7/9] refs: add create_only option to
 refs_update_symref_extended
Date: Mon, 18 Nov 2024 16:09:26 +0100
Message-id: <20241118151755.756265-8-bence@ferdinandy.com>
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
 AAEjJVsesN8odlnllSlE9F69lhtyb5Bp7GBDuxpwuovrMAl2gXGbuBYsm/tBvUoX
 4RKyQoY5ZHffuuMilFkUAyU7Qptmb/ZoUqlkNpwjzb1YOur4zXj+YChoDUdCrJZU
 J8qhDZHKkYNxPWNmsdGWRalNfsbHEYKWUn27iWbftYT0xLOcRSAXXD92s9IzyxvP
 F6xBCKHwNV+VUYtOKAu/TkcJjmH6iNK2zbEvjHofil1yf3n/vHesUsDW27lZ+LRT
 4b5WXdwvTdcmTaWw/tCm9GGj/SJeheRobjAhryTo1Owhd4dLTMIjdoyJFxaoA4BX
 VemnNghWg4AdIgk6bWZJ+/dBz14lWlU7S78D1CrGx7vNNZ0wN34RNEhNx7qihD84
 sihoZMK30IEt04xvm62OEdLtUAs53wJrROAOtgifPAW4Ii7s1Ssml1ndy6/bRtbn
 BdYmnxjiowe+ZHjNGcLwwXtx7aBQ+lov5kT+vcKxylPTTjxxywhchZwa

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

 builtin/remote.c |  2 +-
 refs.c           | 33 ++++++++++++++++++++++++---------
 refs.h           |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index a682ef5df2..7b4eb0e30b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1476,7 +1476,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	updateres = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-			"remote set-head", &b_local_head);
+			"remote set-head", &b_local_head, 0);
 	if (updateres == -2) {
 		result |= error(_("Could not setup %s"), b_head.buf);
 		goto cleanup;
diff --git a/refs.c b/refs.c
index c4500a7582..f4d8a8dcb1 100644
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
 	if (referent && refs_read_symbolic_ref(refs, ref, referent) == -2) {
 		struct object_id oid;
 		if (!refs_read_ref(refs, ref, &oid)) {
@@ -2146,8 +2158,11 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
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
index 6a32f82f8c..f131e89fe6 100644
--- a/refs.h
+++ b/refs.h
@@ -581,7 +581,7 @@ int refs_update_symref(struct ref_store *refs, const char *refname,
 
 int refs_update_symref_extended(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent);
+		       struct strbuf *referent, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
-- 
2.47.0.296.gda1ecfef29.dirty

