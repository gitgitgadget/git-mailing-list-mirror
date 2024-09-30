Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38B18873D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735305; cv=none; b=f46FM4nzeoqiUPno43oH/qhb2S22k9AXHeXvvW+ZzAyqKALC10my7Hn95FXvg5wQQUm2j9+j0EgUpvnFguJeJSGyKQWIXHNIEUx5//BAp5tOAB3aP6fppjOpXp7eRAD7VWzX8eIk+YhwFphg2AxoL0xLB1Q6hOJm4ogU5NWZCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735305; c=relaxed/simple;
	bh=bO7Ym1HJQChGt9kASgp5o774YCXD1/X0iIVzEGKYGmo=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=puaEHb/MjXh8fMJL9Kg02Z+x66RWpQs9CBuGWO5yewNzYjGo4oC3wfjGE7fVDGDSZ0WRJHlDSbJitZ2kcY0+InQvDZ/4urnS+CO+UdLOiAUupsWLBXsC3qEDq0Mla45hioiBbVN4gMhfkXZy1H5nyg6xQC5+UCMIyTUQllslCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IEdR/oWD; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IEdR/oWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=A1MJxE9+f6ZF3lBQXzDDsPuU8z4LDlPG/IOmXg+5QbM=;
 b=IEdR/oWD6/LgGTMiLLlpsUnFo9aeiReBF3K20j8ruk3VZ+SqfmeK9EM37QEyFXNzaUC7dVmjYmRD
   4E7zkLY+7F/JxdREy++CVYEdNHCQYl2gXIMiZGct8Y4trPUJponEs0hG6sX2KMP7dp2vn60bTf9p
   dnYCUElHgM/5cyT7OiljBSrjVP9l6EPWGhFNkhFOkJOtgodNjDs7p3xq2SnLR8LZr8Eqw95d+tvx
   /XKUgNBUqtBNbNraBlTqpIEl1tdwnubK1QOMiYTW4kl89L+y5wHCFiw5lZ8ADVXFUPKSEw9mJyMW
   NRR85YnMkk67TAkcsKZptd0zC480SVVgmYqWsQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN003BRCURCN50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:23:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 3/5] transaction: add TRANSACTION_CREATE_EXISTS error
Date: Tue,  1 Oct 2024 00:19:53 +0200
Message-id: <20240930222025.2349008-4-bence@ferdinandy.com>
In-reply-to: <20240930222025.2349008-1-bence@ferdinandy.com>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
 <20240930222025.2349008-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHyeI1GC1WEq4rT6PdihqO8P/mfN0dkRFH643wIUILRJE9M1SidZS4CDd3XE2nQ
 kt2nhmTIBMHS8zWb9GN4jObAD0bgyHTbzQ4aYhml5q35dkSKm6SrYGgxcTmFF2IW
 x4WkqbbKiYSQg/brXhzGW/MEYAq+R1OkqEV2Cwx9lp1ZCMGAgBfz62qVmP/Wwhn/
 ghVprFRx5mYnisWNXtorXVX1zED1CfjU0Np867X0+YlwsM4yXTGPB5Z0XfnMY3wc
 fx+GThzGH9L0k+exJLNQZZOkYYVkbzbbMMn3LKkx9GP+hPNbTfoR7mJdpCCi718X
 26MItoSx54B+wdce/7ExJrfGXMZfaTj9mlmH8f+RLwqvUJjJXAO7EMW3+2hrOIqP
 7NwXZJ/6iHPfNpyDMMid4+uWrAC2XY4nwSTBqK80TPSevra0SFpvctUWl+vkyPJH
 O3hvCr56fMAAzGnqYw4mNqRFjb+Bzn9Tg47ZebQEehUMp0UA7zDUINc=

Currently there is only one special error for transaction, for when
there is a naming conflict, all other errors are dumped under a generic
error. Add a new special error case for when the caller requests the
reference to be updated only when it does not yet exist and the
reference actually does exist.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch

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
index f5f957e6de..f66bbf5d49 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1197,10 +1197,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -1212,7 +1215,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
-			ret = -1;
 			goto done;
 		}
 
-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

