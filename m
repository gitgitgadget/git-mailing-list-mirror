From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 12/31] refs.c: track the refnames we are deleting in the transaction structure
Date: Wed, 14 May 2014 15:13:11 -0700
Message-ID: <1400105610-21194-13-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRS-0007Kl-1A
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbaENWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:17 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:38437 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbaENWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:37 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so56764obc.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhBN6oOPWheLjKK0Si5jEtCXTguAlH7TxHKljyxQD+A=;
        b=XOo4Nbp6eptOMuVLh9DuoM6SW82zITmFr7Zzh2clm6yB+82anlTkErHo/h+lyQBy/h
         IqjEr/BNEEmOmn+7ae+EBfslkvIhnb5vU9DbcO92CVNaWSg9t8+0IEYlgzIjAbUFfOgE
         xWt6P2+z+eoVvnVCIPnTFRc3asM4bgtWVC1AiEOrgPA70u9DfLDDdFVb9ptd+7+YQrVj
         Lhv1SWsHL/lSGow3DpDsI3zXKuMgs13/GfNRa7xXVNVsNlKbnPkRgljm9avjeJSv1zk6
         pYnXHOeJ+TdzXgxImCAqYd32ps1dNnSam+SrfXi3WYa6mOUF4snn5opchdfCf0NuqtQY
         5enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhBN6oOPWheLjKK0Si5jEtCXTguAlH7TxHKljyxQD+A=;
        b=I1pd1+g8aDTNxGRtzRL+UlFAtDOvDouKjwye/JNKyU++eLjwVf348RlD6QmHwWgAsk
         6mjRz5b6rXNES5SCx5bPfL5YvNKLWWvmHW53yuv3z8ELLv2oQsR5+4AFpkQs3wTL/RFc
         kWdMMycCf5cnsU1oeg4pteD34nv6dMmkBfrcup5Sl08GacQdcHK+KWdHa2Kh7fjQYLTp
         269qHD7EQSNotAHepC5LMEmVyGKveiGutaCgdJyUgccGYPU/cWUh+eAUqLwMZfVJ1REb
         sCJ8p9o6LfK0mhsoDt3OAbvHoXABNgxjA85lO1c4a1QUfHfsTZCYUhaxJ+zHiuv7M7Uv
         u/XA==
X-Gm-Message-State: ALoCoQl6QGtxqkL0QRw623I7ReuLSjWmWnUfLOmVazMY3b/Yim26jQYDUYuWTurM4GcxWhf8F7eI
X-Received: by 10.42.229.194 with SMTP id jj2mr2840582icb.18.1400105616613;
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si78040yhj.5.2014.05.14.15.13.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5A63C31C1F8;
	Wed, 14 May 2014 15:13:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1F40AE038E; Wed, 14 May 2014 15:13:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249021>

Track the names of the refs we are deleting in the ref_transaction structure
instead of building an array of names during _commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 58bbf1b..cc31efe 100644
--- a/refs.c
+++ b/refs.c
@@ -3299,6 +3299,8 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_status status;
+	const char **delnames;
+	int delnum;
 };
 
 struct ref_transaction *transaction_begin(void)
@@ -3306,6 +3308,15 @@ struct ref_transaction *transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
+static void add_delname(struct ref_transaction *transaction,
+			const char *refname)
+{
+	transaction->delnames = xrealloc(transaction->delnames,
+					 ++transaction->delnum *
+					 sizeof(const char *));
+	transaction->delnames[transaction->delnum - 1] = xstrdup(refname);
+}
+
 void transaction_free(struct ref_transaction *transaction)
 {
 	int i;
@@ -3319,6 +3330,9 @@ void transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
+	for (i = 0; i < transaction->delnum; i++)
+		free((char *)transaction->delnames[i]);
+	free((char *)transaction->delnames);
 	free(transaction);
 }
 
@@ -3518,8 +3532,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
-	const char **delnames;
+	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
@@ -3531,9 +3544,6 @@ int transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	ret = ref_update_reject_duplicates(updates, n, err);
@@ -3546,7 +3556,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		if (update->update_type != UPDATE_SHA1)
 			continue;
 		if (update->flags & REF_ISPACKONLY)
-			delnames[delnum++] = update->refname;
+			add_delname(transaction, update->refname);
 	}
 
 	/* Acquire all ref locks while verifying old values */
@@ -3564,7 +3574,8 @@ int transaction_commit(struct ref_transaction *transaction,
 						    NULL),
 						   update->flags,
 						   &update->type,
-						   delnames, delnum);
+						   transaction->delnames,
+						   transaction->delnum);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3631,7 +3642,8 @@ int transaction_commit(struct ref_transaction *transaction,
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type);
 			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
+				add_delname(transaction,
+					    update->lock->ref_name);
 		}
 	}
 
@@ -3677,9 +3689,9 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	ret |= repack_without_refs(transaction->delnames, transaction->delnum);
+	for (i = 0; i < transaction->delnum; i++)
+		unlink_or_warn(git_path("logs/%s", transaction->delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
@@ -3701,7 +3713,6 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(delnames);
 	return ret;
 }
 
-- 
2.0.0.rc3.506.g3739a35
