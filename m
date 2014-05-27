From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 40/41] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 27 May 2014 13:25:59 -0700
Message-ID: <1401222360-21175-41-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxW-0002p8-4V
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbaE0U0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:31 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:51555 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1645405yhl.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=goT6ZaosAflQ30oJ/x7/tyF1VD6WzKEIzXLVRqTBn34=;
        b=DqrKACxl1G718ONMRAwCe3MKwy0UtCtvHR53W3VpAb9Xgj+g6w2JjldSO5x0RBelqG
         cZ6Otxu25q09p/Dl+28pHGKEgKHz+p4teZ2v7a1pp1Uvb42UJS+A7PE8JvSeJrQw+/jC
         SRprC7TWcHWVQn1YnnISt7MdkBDQDf+SxsGYZmVURXEtS4MgzfefbNndeujK83GWYkyy
         fpzrEYnYhhYlRw2ZGz6by/q8rsG+BrbozcOT/BKKB/SL4XNz8mQBzoBc+WvuBKrp4cK8
         knZ/o3cpMMZKeZRe9IylypnPr+rKoQdKmNbGynS8Ptgqw1h2ciXP/BWTQ7RMthUd57JZ
         cT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=goT6ZaosAflQ30oJ/x7/tyF1VD6WzKEIzXLVRqTBn34=;
        b=a4zbuFZo1AOkmd4zBhs9wM0FCLBZ9XM9BPvqECvk8gKCAhFIytyQ+IfbMcn/UbPlEe
         T8GjT8/ZsGZVYw8dGaUb7RGdTr53lGRz3FppjsuyZP40nGBxPAvKuOHGR1ZZXCwQEUVG
         8clLUS26heYeR0T7hb/5gbfKPrUHkciL689GR7gVwyn/m4W6v9v5IJohpOSTrVHF1KWF
         Worjhgryxbu2qu3pFvcfOlqs/WSwrR0UoZCJKaufStcKJD7c8i9zCFIyWmZAjwu7OToB
         yRKL/bBLnxiBJawse5+5bzoKlJoolXoTmXU9ilnMnqreIRy5Ywtc4vDabSQQ1yOFtMfs
         Emqg==
X-Gm-Message-State: ALoCoQnkSh22EFEy0HzCwShKgVupF2KQccn63NPnW6lfm+iFZKQtFv2YUr6acM3w1NWvD8/KTw5u
X-Received: by 10.58.227.10 with SMTP id rw10mr13810528vec.39.1401222365568;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1573755yhl.7.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6AD3A370577;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B026E14EA; Tue, 27 May 2014 13:26:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250207>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..c46ccd9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -45,6 +45,7 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 static int shown_url = 0;
+static struct strbuf err = STRBUF_INIT;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -375,22 +376,27 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
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
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.474.g0203784
