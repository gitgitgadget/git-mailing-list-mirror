From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 08/27] refs: add method for initial ref transaction commit
Date: Thu, 18 Feb 2016 00:17:31 -0500
Message-ID: <1455772670-21142-9-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzE-0001D0-2N
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424839AbcBRFSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:39 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35108 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424573AbcBRFSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:37 -0500
Received: by mail-qg0-f45.google.com with SMTP id y89so29369340qge.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7KsoTlA5nwWlp3RRhfv/cXQTkpgd+Ck76T8NdTf2Lc=;
        b=Ril/NJ5qs3nMgVD+U6h7LV5dO5LK32t/NAA72BEnJb/k6gC7Sth2Fr4Y8S2nKuGoaK
         kcVTCHvdpIbSuc32CQYh9usk7vs/18ZcEAJBY/z4Uxvl2PY2p6+4eHJFCl/3Xunhm/du
         vWjKcvdG63EAwoKtV/JGscqDl8y2L3XKXb18I5JhE40QsMV7ZhhJkzjRs85fAoffD5SK
         p6a60fzW3+Nv+r6GUdOg2RInXD5e3Uiao67tnbFX/VMa4RIVhYNdjCtCrY5GNxseY2ZI
         k1nIMti+Ee/XNYpwg0bUv6PlhVobgUnBxcbOd0zlcC/QVjfdFvRAqMi9K/F3flQSfKeH
         X+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C7KsoTlA5nwWlp3RRhfv/cXQTkpgd+Ck76T8NdTf2Lc=;
        b=HJGtXMdmsqsQyUVwg4fZQPSpncUZI3daisjXNiRqzk9mHVwy7VdydE2jr3c1w111Of
         naSZN11uwrpwDnMxUG5n90gCdqYocMXYqghO+i0hGFXNI3kysZyWsRPLanKf8rVLBqr1
         YbQ9xHTDHAJCSSeDZNCdB43PXD1kNvDwLSUWsweg/hK7Lr55TL6cwZqApPnek2z1yD4L
         yO/LbaibjUj6mbG/fXVluuKEBtLsHaEnCyg7m37npxZp6FXtbB2dqb5a9a+FnJXGdgQm
         H6NQlgpyn5H+OypB52jZV4vILd+78sFRBbvSB37DtP5nqcVr7HJmsg6gLLBNEDWRx5lf
         26Ag==
X-Gm-Message-State: AG10YOSnMQitZ1iJ9wl7DdkZLJAPcc1KZKORMxmRx1W26VTaFpn5C/bu5Kq2X56gqjzpBw==
X-Received: by 10.140.101.201 with SMTP id u67mr6705057qge.33.1455772716585;
        Wed, 17 Feb 2016 21:18:36 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286576>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4733935..970729c 100644
--- a/refs.c
+++ b/refs.c
@@ -1287,3 +1287,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 149f6a2..2a663af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3259,8 +3259,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3484,6 +3484,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8b5bbdf..f9acd36 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -258,6 +258,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.767.g62658d5-twtrsrc
