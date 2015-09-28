From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 31/43] refs.c: add method for initial ref transaction commit
Date: Mon, 28 Sep 2015 18:02:06 -0400
Message-ID: <1443477738-32023-32-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWv-0001ti-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbbI1WDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:31 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36105 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbbI1WD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:28 -0400
Received: by qgx61 with SMTP id 61so133700480qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xsbkMxdItSiMKaQ7lNcslhScWQC46vQaUgHTMQTNAE=;
        b=Qf2OxG7HXGKWZJRE9jP2WZ5cXhYbgILVhD6nGwYXNpTul2jMxq8fy2vSwYtCiE8ZNY
         ofDdrcmWDP8uYfLjrE9tIyla4Jv1ktNfHFxffMErMjGfFHKTfXVlfbkBDcgB33yxG2XF
         gvwgVe8KpFJdBGIzgDKH5UdwCwgcBk1XvEE3X6NLAtGwlz/zP/dgTIONDitxYOCPqpUf
         nXqtrXI/MVj5xt+yUc9A+ENkGTTSlbNwcueWuz2yQcVZ2dUid5TqwDaVWUEsz9+7cShH
         8kC5cCYgpb1BzsVeZl3Y0os8E/RyXSncIxM2KgssFxQh1kxmL6pYnFFvnsO6uXjmtIxW
         BQXQ==
X-Gm-Message-State: ALoCoQmgmIgMJD/61OLcaFCqfeVzfcxlcky94M3gDvaw9AEH2EvYfJw2N2u+WXgmiMpE8jxYQmZG
X-Received: by 10.140.93.53 with SMTP id c50mr25158000qge.59.1443477807827;
        Mon, 28 Sep 2015 15:03:27 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278779>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 5 +++--
 refs.c          | 6 ++++++
 refs.h          | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 93a5a33..ea91afd 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3517,8 +3517,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3748,6 +3748,7 @@ struct ref_be refs_be_files = {
 	files_transaction_delete,
 	files_transaction_verify,
 	files_transaction_commit,
+	files_initial_transaction_commit,
 	files_transaction_free,
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs.c b/refs.c
index 96fa699..530edcf 100644
--- a/refs.c
+++ b/refs.c
@@ -1201,3 +1201,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 06089f8..bd46d0f 100644
--- a/refs.h
+++ b/refs.h
@@ -672,6 +672,7 @@ struct ref_be {
 	ref_transaction_delete_fn transaction_delete;
 	ref_transaction_verify_fn transaction_verify;
 	ref_transaction_commit_fn transaction_commit;
+	ref_transaction_commit_fn initial_transaction_commit;
 	ref_transaction_free_fn transaction_free;
 	for_each_reflog_ent_fn for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
-- 
2.4.2.644.g97b850b-twtrsrc
