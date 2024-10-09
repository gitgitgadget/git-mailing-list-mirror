Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B814199FAC
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482758; cv=none; b=A0szE7BBYRowEhnIiYToUxD4A4eGFl1kTFqMQmKsHJGrgng8jMljkAMJ8pVy+4p7OkvvN5HbV/UMkqm93PfZLp6nMkn3FT34FZ68Z9tDuBTak4QtG+LkvMu7E9HG/0JZdAjMlQPDfTZTOvSsAO7G2RyAgIMra9i2MauZpkznhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482758; c=relaxed/simple;
	bh=o3TzEuAYG/rcTD1T8TMtnp6I0wK+fQfkBw21SNRTbMc=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=TLXM5yENtQffdMx3X2q9tN7p/Opogz3mzHvsRzBpvz+Km2fRrUXyROPmaFYOxZ6ixHr8MQaq5d0G9JH2IQdlORVSUPYTvpzkVFlMETlmWt1TXuGhfTmNpGfU8dIUW3BmJfCZPvh2j9su9aa1h4hXHNt/5YPe3qXuWl2/9I97kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=J6zkEfGt; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="J6zkEfGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=YyWeleKbIS1jz+5Ur+FH5SOmHuatqI3t0Hk3gNPJ7SM=;
 b=J6zkEfGtWU18gR0wTblfTb7J3izic7DnI+xmAOKwUQ6rC5BDPP/ildQk+KTYuz49xh/FX8wllSzw
   jWFsTH9pSXda8f5nivDpMcexBCBhP8hga7QfiuHoy4GZraF1TEaKXEswzKg+nO2sUlzgYpMVxvMl
   29496eQVwqqIaMyjH7oauNF3TTO0rUDs0ep5I8g5ssHKWqgzNRzSnCcQKGQvI4hbX67LDkNF8y+K
   Q0xVohgZ+z2Xfdin6EoseSfb2LMWA5Q/rFhlALIT6X95D6dmA3TfBYWcPLDkuu5B08qLuj212asi
   44J1Iq3JHY5XFxUjiuKdIje45IO9qFqi0A8cVw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL300K4YDLBP040@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 09 Oct 2024 14:00:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v5 4/6] transaction: add TRANSACTION_CREATE_EXISTS error
Date: Wed,  9 Oct 2024 15:57:26 +0200
Message-id: <20241009135747.3563204-4-bence@ferdinandy.com>
In-reply-to: <20241009135747.3563204-1-bence@ferdinandy.com>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHkcqwu5eXCKRcX3QCQukZZlHSRKXeMrP4nk/eEFybetXYoxFqeSVN5Cyo/Ag1p
 RanNwRfDEH3/veonTI9sR5LzT/yQeOeKdz1VziAgC3QqmNjrqHC2phrb/bK2RcL2
 yEjbryk+fYpjewUV1wF4wPDNRSZY+KG19D0mzD3a1nbRoiGDo/tm7HQQWwfomzml
 rK6DjFArRvrkqZNjTH7GqYQ+o6BdoJlL0bUtEHjYN9V1tGrNjiMOPmtZxNQiv6wT
 zwDxUk0Oa7qQeXXRRLkgma50n4E0EdZ4YSrID2r6UZcRkomuH7YBYFLt4AwqS5AV
 1Eg63SBb40IcOc6iuf9sPj8dwV7BwFnxlJ9vVaWsWWbBX+64h9f7QI5nn3WbDvc6
 tc8xC/GYCyLOIxEVTTT9jusuPUBawwBk7Nk7G8bQFX9Bnf3wKUDQU3k39jTlYjnf
 e1ipUZO3OkrpUsJBiKLUJv6FNIvpCoAdOqSQ+qxmMur17D+l9leayxQ=

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
2.47.0.6.g9542df9767

