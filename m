From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Mon, 16 Jun 2014 11:04:18 -0700
Message-ID: <1402941859-29354-48-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:04:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbH7-0003dl-E6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbaFPSEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:45 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62676 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so765812vcb.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNjrJdSUqGyS+RjgpB0yMy0cgWr5pNM3D8XvbGa0pn8=;
        b=G6fSHK+Owt8/U05YOoqBQH7F1ZjFE8oqV/D+ZpU8EhZaHkrdEjfcMLKLsVeFZbw7HX
         uzcfKfb1nh3b153RBr+sXRek6U5EWfaU713T9i20U9Eo/enskTwaR5M7HBqhOumIdGe5
         d2OlCLUwtruOjjEJMftXzIZBGbLFGhuM5KLKC/Ofbk9dzl2UbroyhFyhEGlOLzfJY5Gd
         w87Nj+IY2j80ptn9C4Fbo4DgBjFQsBOqqjahRJOy96HviUfJE7z6qBcZg/gg6lxJ98fZ
         5BlxmFyParIf0kMRLGVeGY0AuSsSS3s37VYiOX5QMd9jxgNmPOh9NhL+8y0GzfnApozV
         90WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNjrJdSUqGyS+RjgpB0yMy0cgWr5pNM3D8XvbGa0pn8=;
        b=kkRTpyUSF7W2Gwdpj66sL+IQ9je/KpHOQRX+VYVQRfRCUKPGfPNQeVrQ9N0MEO3P9+
         7u31Sy6STUNFiHSUMeYetTqI0A8B04aWPenjIoACAnv3bKhyEbSfoW5gbltgkG9JsS9h
         AoiX2XGNbkBYdjbRuF0hjpW75gj0I3JSZo4a+ZW3mZWJFXwebX0ehNsV08p6lM/17fD8
         tFaQ32bOw2rNgXftA2oGGb/g75EbLG8n3g024gLNaNzCH8AL/t1BO8lqdgY0AXUsIM77
         J9dc7VB/qpPzOeFf95077UUvELELEiG4qZd940t4/UpVoYCZE5yGK7rKnFqBzxJXJKcK
         WTDQ==
X-Gm-Message-State: ALoCoQluk8pRhpagUzopcBYEz+A8ocvUXdaWOgoajt1Lj4W8+8chd6k7C9nC3oA1vwYV2v5NYDKY
X-Received: by 10.236.141.11 with SMTP id f11mr2714046yhj.54.1402941864160;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si998240yhe.1.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0AE7E5A4912;
	Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DB7D1E0D03; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251744>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,36 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
-- 
2.0.0.282.g3799eda.dirty
