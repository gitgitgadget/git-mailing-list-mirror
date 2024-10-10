Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8401C9B93
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567137; cv=none; b=RAkyijAjxthQbFaWDuQ7cn5PLTsZCCVEFseNisTAUp0ykGzCeUiz5cdx9HmM/pU8JqpxDBfbIosi3TuYgFHQ4ClgNxPOCyUwP0fFxYnbTo6ttSFlbjuYO6mXKhxokNElD5f7Wdap6Qef98K3dxHjDxe7HKPRRyD0Rqmn3r6w3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567137; c=relaxed/simple;
	bh=43xQxz1mRyqodKszddgcIkO9uzCg+2dEQ4wqrzU25Ks=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=n9PtLPkkx25pPRsde+G8a2tKv4JwXm0O98n5iW7NvYFwFu/OBObLCJGccmksH9VChClXpwJjoUeUgmeWIh4yM81lQS+kdL7v3AZGr8W4szaize7hpq10Z9LKQBt6m3nt2vK4f2SjLo5iuQTKLvG7F3B90oaKucdfOt1GHQLWwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IYmfSmWj; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IYmfSmWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=waFNkvwRYA1coPqM/A4ZDfVLvvFkqO9yLi0FgXp178Q=;
 b=IYmfSmWjdAY9IADNseuV5mbS4SeWqTkytKOH8Omys6+aZGlnDhLMW1ne44xhPUjv4DBvSSMcMtxM
   55kDip/YxdQzSDHAku59nGTZUYYqChoVZ8Cm0gBkJ2FMzN7vhGpJ35UH9dRHoxPLEZNS8/qpQVll
   8Fy+Hxg4Nm9a0hFNpWyRM1oC7TNF0UpyW021c7DWgOv/Y3y+Ykg0qY5LC83/HQtuqRFdsp4qgJVW
   b+/y3AXIF4Bcc+0e7ghMqIlfBRtuVmakqU30gTUALKy9EnnpFDgWTiQtfmLdpvhZMg81r+3RjVQJ
   eNvMDTfS4F51IssIJh5Bh5lwHwdIOGTMwSb5uw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL50074Y6XPUMD0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 10 Oct 2024 13:32:13 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v6 4/6] transaction: add TRANSACTION_CREATE_EXISTS error
Date: Thu, 10 Oct 2024 15:29:59 +0200
Message-id: <20241010133022.1733542-4-bence@ferdinandy.com>
In-reply-to: <20241010133022.1733542-1-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFkClu7NkgDEEonQIdFjym5PUIXUg+VdM8Ay2cp+dCBY9xLP4cUVO/XMVf0/mOI
 U+17Ngn0FwXy+vKWWKdEFb+bdkNajqEU0GSe+pPEmrNYkM1cjbuxIVszbzUk6d9Q
 8MyIgi42rl2UyFugOA+jlvtLfg4PiZfVkPKY+3hEHo2CqG3H5teSvBIu+zTrsYPA
 09DJ+tNX/AhOwsQ8l8A8xKPq2uFwMFI2nIvOtHyPkmLFp9/9LDpQTUVZXpxwCB7D
 xvxBQ4hzgQkZ0bFvAqDXfyJjN4ElhGWGgi1HoTjUOQvR2ae9IlCwXujmm62RcWzN
 r0yWr9k/9DoxmgSsMCw9OrGo8H1rWh8s1jv6CApIU441u7d/5968xfGoYAA0wYsH
 RpHdNLWorkvZbItqaPxldgpFos3fYUhwGZKzVPhk5NcxEQvOWIeSW7+qtTWR8hJp
 2w8BZp7CA/rOqzL/fsxJUOP1aZ3CiLj6AtvSv3c0hWkzXksGjganVtM=

Currently there is only one special error for transaction, for when
there is a naming conflict, all other errors are dumped under a generic
error. Add a new special error case for when the caller requests the
reference to be updated only when it does not yet exist and the
reference actually does exist.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    v6: no change

 refs.h                  |  4 +++-
 refs/files-backend.c    | 28 ++++++++++++++++++++--------
 refs/reftable-backend.c |  6 ++++--
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index f38616db84..166affbc89 100644
--- a/refs.h
+++ b/refs.h
@@ -759,8 +759,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
 /* Naming conflict (for example, the ref names A and A/B conflict). */
 #define TRANSACTION_NAME_CONFLICT -1
+/* When only creation was requested, but the ref already exists. */
+#define TRANSACTION_CREATE_EXISTS -2
 /* All other errors. */
-#define TRANSACTION_GENERIC_ERROR -2
+#define TRANSACTION_GENERIC_ERROR -3
 
 /*
  * Perform the preparatory stages of committing `transaction`. Acquire
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8415f2d020..272ad81315 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2502,14 +2502,18 @@ static int split_symref_update(struct ref_update *update,
 static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			 struct strbuf *err)
 {
+	int ret = TRANSACTION_GENERIC_ERROR;
+
 	if (!(update->flags & REF_HAVE_OLD) ||
 		   oideq(oid, &update->old_oid))
 		return 0;
 
-	if (is_null_oid(&update->old_oid))
+	if (is_null_oid(&update->old_oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    ref_update_original_update_refname(update));
+		ret = TRANSACTION_CREATE_EXISTS;
+	}
 	else if (is_null_oid(oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
@@ -2522,7 +2526,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			    oid_to_hex(oid),
 			    oid_to_hex(&update->old_oid));
 
-	return -1;
+	return ret;
 }
 
 /*
@@ -2603,9 +2607,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
-			} else if  (check_old_oid(update, &lock->old_oid, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto out;
+			} else {
+				int checkret;
+				checkret = check_old_oid(update, &lock->old_oid, err);
+				if  (checkret) {
+					ret = checkret;
+					goto out;
+				}
 			}
 		} else {
 			/*
@@ -2636,9 +2644,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    update->old_target);
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
-		} else if  (check_old_oid(update, &lock->old_oid, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
-			goto out;
+		} else {
+			int checkret;
+			checkret = check_old_oid(update, &lock->old_oid, err);
+			if  (checkret) {
+				ret = checkret;
+				goto out;
+			}
 		}
 
 		/*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 32330b6bc6..c6b25ebac4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				goto done;
 			}
 		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
-			if (is_null_oid(&u->old_oid))
+			ret = TRANSACTION_NAME_CONFLICT;
+			if (is_null_oid(&u->old_oid)) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "reference already exists"),
 					    ref_update_original_update_refname(u));
+				ret = TRANSACTION_CREATE_EXISTS;
+			}
 			else if (is_null_oid(&current_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "reference is missing but expected %s"),
@@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
-			ret = -1;
 			goto done;
 		}
 
-- 
2.47.0.6.g07cb02250a

